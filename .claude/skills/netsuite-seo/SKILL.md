---
name: netsuite-seo
description: "SEO implementation for NetSuite SuiteCommerce platforms. Use when working on SuiteCommerce URL optimization, prerendering, or meta tag generation. Trigger on: NetSuite SEO, SuiteCommerce, SCA, SuiteScript, prerender, Backbone.js, SC Advanced, faceted navigation SEO."
allowed-tools: Read, Write, Edit, Bash, Grep, Glob, WebFetch
argument-hint: "[SuiteCommerce URL or issue]"
---

# NetSuite SuiteCommerce SEO Implementation

## SuiteCommerce Advanced SPA Architecture Overview

SuiteCommerce Advanced (SCA) is a single page application built on Backbone.js:

1. **Backbone.js Router:** Client side URL routing without full page reloads
2. **Backbone Views and Models:** Dynamically render product, category, and content pages
3. **Three applications:** Shopping, My Account, Checkout (independent entry points)
4. **SuiteScript Backend:** Server side data retrieval, custom logic, API endpoints

The SPA architecture presents a fundamental SEO challenge: crawlers receive a minimal HTML shell with JavaScript that renders content client side. Without prerendering, crawlers see an empty or incomplete page.

## Prerendering Setup

### Prerender.io Integration

1. **Configure middleware** in SCA deployment (server.js or Express middleware):
   - Set prerenderToken, protocol, host
   - Blacklist non SEO pages: /checkout, /my-account, /cart
2. **User agent detection** for bots: Googlebot, Bingbot, Slurp, DuckDuckBot, facebookexternalhit, LinkedInBot, Twitterbot
3. **Validate prerendered output**: title tags, meta descriptions, canonical tags, schema markup, HTTP status codes

### Self Hosted Prerender Alternative

Run your own prerender server with Chrome headless. Configure: chromeLocation, port, pageDoneCheckInterval (500ms), pageLoadTimeout (20000ms), waitAfterLastRequest (500ms). Use sendPrerenderHeader, removeScriptTags, httpHeaders plugins.

For prerender middleware code and self hosted server config, load: ${CLAUDE_SKILL_DIR}/references/suitescript-examples.md

## URL Structure Optimization for SCA

### Removing Hash Fragments

SCA defaults to hash routing (`/#/products/widget`). Everything after hash is ignored by search engines. Enable HTML5 pushState:

```javascript
SC.Configuration = {
    defined: {
        'History.useHTML5': true
    }
};
```

### Clean URL Structure

Configure URL components in distro.json or ns.package.json to follow SEO best practices: `/products/:slug` for product detail, `/category/:path` for category browse.

## SuiteScript SEO Scripts

Three key SuiteScript implementations:

1. **Dynamic Meta Tag Generation (UserEvent beforeLoad):** Generates SEO title and meta description from NetSuite item fields (pagetitle, storedisplayname, metadescription, storedescription, custitem_brand) with fallback logic
2. **Automated Redirect Management (Scheduled Script):** Audits item URL changes weekly, creates 301 redirect records when urlcomponent changes
3. **XML Sitemap Generation (Suitelet):** Dynamically generates sitemap from active items and categories using paged search results

For complete SuiteScript code for all three scripts, load: ${CLAUDE_SKILL_DIR}/references/suitescript-examples.md

## Faceted Navigation SEO

Faceted navigation on category pages creates massive URL proliferation. A category with 5 facets, each with 10 options, can generate over 100,000 URL combinations.

### Strategies

1. **Noindex multi facet URLs:** Apply `noindex, follow` when more than 2 facets are active
2. **Canonical to base category:** Set canonical on all filtered pages to the parent category URL
3. **Filter URL configuration:** Define indexable filters (brand, size, color) vs noindex filters (price, rating, sort, display)
4. **Crawl budget protection:** Block faceted URLs in robots.txt (`Disallow: /*?facet=`), limit indexable combinations to high traffic patterns

For faceted navigation SCA modules (noindex, canonical, filter config), load: ${CLAUDE_SKILL_DIR}/references/suitescript-examples.md

## Product Page Optimization

### NetSuite Field to SEO Element Mapping

| NetSuite Field | SEO Element | Fallback |
|----------------|-------------|----------|
| `pagetitle` | Title Tag | `storedisplayname` + brand |
| `metadescription` | Meta Description | First 155 chars of `storedescription` |
| `storedisplayname` | H1 Heading | `itemid` |
| `storedetaileddescription` | Body Content | None |

### Product Page SEO Template

```html
<title>{{pageTitle}} | {{siteName}}</title>
<meta name="description" content="{{metaDescription}}" />
<link rel="canonical" href="https://www.example.com/products/{{urlComponent}}" />
<meta property="og:title" content="{{pageTitle}}" />
<meta property="og:description" content="{{metaDescription}}" />
<meta property="og:image" content="{{primaryImageUrl}}" />
<meta property="og:url" content="https://www.example.com/products/{{urlComponent}}" />
<meta property="og:type" content="product" />
```

## Category Page SEO

### Pagination Handling

Self referencing canonicals on paginated pages. Page 1 canonical is the base URL; page 2+ includes `?page=N`.

### Filter URL Management

Define indexable vs noindex filters. Only index single filter selections from the allowed list. Multi filter combinations always noindex.

For pagination canonical and filter config code, load: ${CLAUDE_SKILL_DIR}/references/suitescript-examples.md

## Backbone.js Router Integration for Analytics

### Virtual Pageview Tracking

SCA is an SPA, so traditional pageview tracking misses navigation. Integrate with Backbone router to fire virtual pageviews on route changes for both GA4 (gtag) and GTM (dataLayer push). Track initial page load separately.

For virtual pageview tracking module code, load: ${CLAUDE_SKILL_DIR}/references/suitescript-examples.md

## Implementation Checklist

1. Enable HTML5 pushState to eliminate hash fragment URLs
2. Configure Prerender.io or self hosted prerender for bot serving
3. Set up UserEvent scripts for dynamic meta tag generation
4. Create automated redirect management via scheduled scripts
5. Deploy Suitelet XML sitemap generator and submit to Search Console
6. Implement canonical tags on all product, category, and faceted pages
7. Apply noindex to multi facet filter combinations
8. Integrate Backbone.js virtual pageview tracking for GA4 and GTM
9. Map all critical NetSuite fields to SEO elements
10. Test prerendered output monthly via GSC URL Inspection
