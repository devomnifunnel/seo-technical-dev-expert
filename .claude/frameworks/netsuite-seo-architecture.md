# NetSuite SuiteCommerce SEO Architecture

## Purpose
This framework documents SEO patterns, challenges, and solutions specific to NetSuite SuiteCommerce and SuiteCommerce Advanced (SCA). SCA's single page application (SPA) architecture creates unique SEO challenges that require specialized approaches for crawlability, rendering, URL management, and content optimization.

---

## 1. SuiteCommerce Advanced SPA Architecture and SEO Implications

### Architecture Overview
SuiteCommerce Advanced is built on Backbone.js, a client side JavaScript framework. Pages are rendered in the browser rather than on the server. The application shell loads once, and subsequent navigation is handled by the Backbone.js router, updating the DOM via JavaScript without full page reloads.

### SEO Implications
- **Content is JavaScript dependent**: Search engine crawlers must execute JavaScript to see page content. While Googlebot renders JavaScript, it does so in a deferred rendering queue, which introduces delays.
- **Initial HTML is empty**: The server delivers a minimal HTML shell. All product descriptions, category content, pricing, and metadata are injected by JavaScript after page load.
- **Dynamic URL fragments**: Backbone.js historically used hash fragments (#) for routing. SCA supports HTML5 pushState, but this must be explicitly configured and tested.
- **Meta tag injection**: Title tags, meta descriptions, and canonical URLs are set via JavaScript, which means crawlers must render the page to discover them.
- **Structured data**: Schema markup is typically injected client side, requiring render dependent discovery by search engines.

### Key Risk Areas
- Pages may be indexed with missing or default meta tags if rendering fails
- Content changes may not be re crawled promptly due to rendering queue delays
- Faceted navigation can generate thousands of crawlable parameter URLs
- Internal linking via JavaScript events may not pass link equity if not implemented as standard anchor tags

---

## 2. Prerendering Strategy

Because SCA content is JavaScript dependent, a prerendering solution is essential for reliable SEO performance.

### Prerender.io (Recommended for Most Deployments)
- Cloud based prerendering service that serves cached, static HTML snapshots to search engine crawlers
- Integration: Configure the web server or CDN to detect bot user agents and route requests to Prerender.io
- Cache management: Set cache refresh intervals (recommended every 24 to 72 hours for product pages, weekly for static pages)
- Configure recaching triggers for price changes, stock status updates, and content edits

### Rendertron (Self Hosted Alternative)
- Google's open source headless Chrome based rendering solution
- Requires server infrastructure to host and maintain
- Better for organizations with strict data residency or compliance requirements
- Higher operational overhead than Prerender.io

### Custom Middleware
- Build a Node.js middleware layer that detects crawler user agents and serves pre rendered HTML
- Use Puppeteer or Playwright to generate static snapshots
- Store snapshots in a CDN or cache layer (Redis, Varnish)
- Implement cache invalidation hooks tied to NetSuite item record updates

### Prerender Verification Checklist
- [ ] Bot detection correctly identifies Googlebot, Bingbot, and other crawler user agents
- [ ] Pre rendered HTML includes complete meta tags (title, description, canonical)
- [ ] Pre rendered HTML includes structured data (JSON-LD schema)
- [ ] Pre rendered HTML includes full page content (product descriptions, reviews, specs)
- [ ] Cache refresh frequency aligns with content update frequency
- [ ] Pre rendered pages return 200 status codes (not soft 404s)
- [ ] Redirect logic is preserved in pre rendered responses
- [ ] Mobile and desktop versions are both pre rendered correctly

---

## 3. Server Side Rendering Considerations

### SSR Options for SCA
- SuiteCommerce Advanced does not natively support full server side rendering
- NetSuite's SuiteCommerce InStore and some newer SuiteCommerce builds offer improved SSR capabilities, but these are limited in scope
- Hybrid approaches work best: serve critical SEO content (title, meta, primary heading, first paragraph) from the server, then hydrate the full page client side

### Limitations
- SCA's Backbone.js architecture was not designed for SSR, making retrofitting complex
- Server side rendering of the full SCA application requires significant custom development
- Performance trade offs: SSR increases server response time (TTFB) but improves time to first meaningful paint
- SCA extensions and customizations may break under SSR if they rely on browser APIs

### Recommendation
For most SCA deployments, prerendering (Section 2) provides the best balance of SEO effectiveness, implementation complexity, and maintenance burden. Full SSR should only be pursued when rebuilding the storefront on a modern framework (React, Vue, Next.js).

---

## 4. URL Canonicalization for Faceted Navigation

### The Problem
SCA generates URLs with query parameters for filtering and sorting. A single category page can produce hundreds or thousands of URL variations:
```
/category/shoes
/category/shoes?color=red
/category/shoes?color=red&size=10
/category/shoes?sort=price_asc
/category/shoes?page=2&color=red&sort=price_asc
```

### Canonicalization Strategy

#### Filterable Facets (Do Not Index)
Facets that create thin or duplicate content should be blocked from indexing:
- Sort order parameters: always noindex, add canonical to the base category URL
- Pagination parameters: use rel=canonical pointing to the first page (or use rel=prev/next)
- Multi select filter combinations: canonical to the base category URL

#### Indexable Facets (Strategic Selection)
Some facets create pages with genuine search demand. Evaluate each facet:
- Does the facet combination have meaningful search volume? (e.g., "red running shoes")
- Does the filtered page have unique, sufficient content?
- If yes, allow indexing and create a self referencing canonical

#### Implementation
- Configure canonical tags in the SCA application to dynamically set based on URL parameters
- Add parameter handling rules in Google Search Console
- Use robots.txt or meta robots to block crawling/indexing of low value parameter combinations
- Implement a defined URL parameter whitelist for indexable facets

### URL Structure Best Practices
- Use clean, descriptive URLs: `/shoes/red-running-shoes` over `/category?id=123&color=red`
- Enable SCA's SEO friendly URL generation for categories and products
- Maintain a URL hierarchy that mirrors the site taxonomy
- Avoid session IDs, tracking parameters, or unnecessary query strings in crawlable URLs

---

## 5. Product Page SEO Template

### Title Tag Pattern
```
[Primary Keyword / Product Name] | [Key Attribute] | [Brand Name]
```
- Maximum 60 characters
- Include the primary keyword near the beginning
- Dynamically generated from the item record fields in NetSuite

### Meta Description Pattern
```
[Benefit statement including primary keyword]. [Key feature or differentiator]. [Call to action]. Shop [Brand Name] today.
```
- Maximum 155 characters
- Include a compelling reason to click
- Dynamically populated from the item record's SEO description field or storedescription

### Structured Data (JSON-LD)
Every product page must include:
- **Product schema**: name, description, image, sku, brand, offers (price, availability, currency), review, aggregateRating
- **BreadcrumbList schema**: full breadcrumb path from home to current product
- **Organization schema**: on the homepage, referenced via publisher

### Image Optimization
- Use descriptive file names: `red-running-shoe-nike-air-max.jpg` not `IMG_4532.jpg`
- Include alt text populated from the item record (storedisplayimage alt field)
- Serve images in WebP format with JPEG fallback
- Implement lazy loading for below the fold images
- Specify width and height attributes to prevent CLS

### Reviews and Ratings
- Display reviews on product pages and mark them up with Review schema
- Aggregate ratings should use AggregateRating schema
- If using a third party review provider (Yotpo, Bazaarvoice), ensure the review content is in the rendered HTML, not loaded via iframe

---

## 6. Category Page Optimization

### Content Requirements
- Each category page should include a unique introductory paragraph (minimum 100 words) above or below the product grid
- Include the primary keyword in the H1 heading
- Add supplementary content (buying guides, category FAQs) below the product listing

### Pagination
- Implement page 1 canonical for paginated series (preferred for SCA)
- Alternatively, use rel=prev/next across paginated pages
- Ensure paginated pages have unique title tags: "Running Shoes | Page 2 | Brand"
- Prevent infinite scroll from creating crawl traps; ensure paginated URLs are discoverable via internal links or sitemap

### Crawl Budget Management
- Limit the number of indexable filter combinations per category
- Use faceted navigation canonicalization rules (see Section 4)
- Monitor crawl stats in GSC for unusual spikes in crawled parameter URLs
- Prioritize high value category pages in the XML sitemap

---

## 7. NetSuite Specific Technical Debt and Common SEO Problems

### Common Issues
| Problem                                  | Impact                        | Solution                                            |
|------------------------------------------|-------------------------------|-----------------------------------------------------|
| Default SCA title tags ("Home | Site")   | Poor click through rate       | Customize title tag generation in SCA templates      |
| Missing canonical tags on filtered URLs  | Duplicate content, crawl waste| Implement dynamic canonical logic                    |
| Backbone.js hash URLs still active       | Content invisible to crawlers | Enable HTML5 pushState, 301 redirect hash URLs       |
| JavaScript rendered meta tags            | Delayed or missed indexing    | Implement prerendering (Section 2)                   |
| Missing structured data                  | No rich results               | Add JSON-LD templates to product and category pages  |
| Broken internal links after URL changes  | Lost link equity, 404 errors  | Implement redirect management via SuiteScript        |
| Session ID parameters in URLs            | Massive duplicate content     | Strip session parameters, set canonical tags         |
| Missing alt text on product images       | Accessibility and image SEO   | Populate alt fields in item records                  |
| Slow TTFB due to NetSuite server load    | CWV failures                  | CDN caching, prerendering, optimize SuiteScript      |
| Orphan product pages                     | Not discoverable by crawlers  | Ensure all products link from categories and sitemap |

---

## 8. SuiteScript Hooks for SEO Automation

### beforeLoad Hook (User Event Script)
Use beforeLoad to inject or modify SEO elements when a page is served:
- Dynamically set meta tags based on item record fields
- Generate canonical URLs based on the clean URL pattern
- Inject JSON-LD structured data
- Set response headers (X-Robots-Tag for noindex directives)

### afterSubmit Hook (User Event Script)
Use afterSubmit to trigger SEO related actions when records are saved:
- Regenerate sitemap entries when products are created, updated, or deactivated
- Create 301 redirects when URL slugs are changed
- Invalidate prerender cache for updated product pages
- Update canonical URLs when category assignments change

### Scheduled Scripts for SEO Maintenance
- **Sitemap generation**: Scheduled script that queries all active, published items and generates an XML sitemap, uploaded to the file cabinet
- **Redirect management**: Scheduled script that processes a redirect mapping CSV (old URL to new URL) and creates redirect records
- **Broken link detection**: Scheduled script that crawls internal links and logs 404 responses for review
- **SEO field validation**: Scheduled script that audits item records for missing title tags, meta descriptions, or alt text

### SuiteScript SEO Automation Patterns
```javascript
// Example: beforeLoad hook for meta tag injection
function beforeLoad(context) {
    if (context.type === context.UserEventType.VIEW) {
        var item = context.newRecord;
        var title = item.getValue('pagetitle') || item.getValue('displayname');
        var description = item.getValue('metadescription') || item.getValue('storedescription');
        // Set meta tags in the response
    }
}
```

---

## 9. Backbone.js Router and Virtual Pageview Handling

### Router SEO Configuration
- Ensure all routes use HTML5 pushState (not hash fragments)
- Verify that each route maps to a unique, crawlable URL
- Implement proper 404 handling for non existent routes (do not serve the homepage for all URLs)

### Virtual Pageview Tracking
- SCA page transitions do not trigger traditional pageviews since the browser does not reload
- Implement virtual pageview tracking in GA4 using the Backbone router's `route` event
- Ensure each virtual pageview sends the correct page title and URL to analytics
- This is critical for accurate organic traffic measurement and SEO reporting

### Link Implementation
- All internal links must use standard `<a href="...">` tags, not JavaScript click handlers
- Backbone.js can intercept anchor tag clicks for SPA navigation while still allowing crawlers to discover the link
- Avoid `onclick` navigation or `window.location` assignments for internal links
- Verify that the rendered HTML contains crawlable anchor tags by inspecting the pre rendered output
