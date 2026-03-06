# SuiteCommerce SEO Issues Reference

## 1. Faceted Navigation and Duplicate Content

This is the highest-impact SEO issue on high-SKU SuiteCommerce stores and the first thing
to check on any automotive, parts, or product-heavy ecommerce site.

### What happens
SCA generates crawlable URLs for every combination of facet filters a user can apply —
color, size, brand, category, price range. On a store with 500 products and 20 filter
options, this can produce tens of thousands of unique URLs with nearly identical content.
Google crawls and indexes all of them, which exhausts crawl budget, dilutes PageRank
across the site, and can trigger a duplicate content assessment that demotes all category
and product pages.

### How to diagnose
Navigate to a category page and apply 2 or 3 different filters. Copy each resulting URL.
Check whether Google Search Console Coverage shows these URLs as indexed. Open the
XML sitemap and search for URL parameter strings (typically ?facet= or similar query
parameters). Check the total indexed URL count in GSC against the number of pages in
the sitemap — a large surplus of indexed URLs signals facet bleed.

### The correct fix (three parts required)
Canonical tags must be configured to point all facet URL variations back to the base
category page. This tells Google which URL is authoritative without blocking crawl.

The robots.txt must disallow the specific URL parameter patterns used by facets. The
exact parameter names depend on the SCA configuration — get them from the developer.

The XML sitemap must be regenerated after configuration changes to exclude facet URLs.
The sitemap should contain only canonical base category URLs, not any filtered variants.

### What does not work
Robots.txt disallow alone without canonical tags leaves the signal ambiguous. Canonical
tags alone without robots.txt disallow allows Google to keep crawling and spending budget
even if it respects the canonical. Both are required.

---

## 2. SEO Page Generator Rendering Failures

### What happens
The page generator can fail silently — the site looks correct to human visitors but
Google sees an error page, an empty page, or a page with missing content. This causes
pages to be deindexed or indexed with no content.

### How to diagnose
Use the debug URL: append ?nsgdebug=T to any page URL while logged into NetSuite admin.
The debug output shows exactly what the page generator rendered, which JavaScript executed,
and any errors that occurred during SSR. This is the ground truth — if the debug output
does not contain the expected content, Google does not see it either.

Also check Google Search Console > URL Inspection > View Crawled Page for specific pages.
Compare the rendered HTML Google received against what a human browser sees.

### Common failure causes
Custom SCA extensions that use JavaScript features or APIs not available in the SSR
virtual browser environment. Third-party scripts that attempt to access browser APIs
(window, document) that behave differently during SSR. JavaScript errors in any code
that runs during the initial page render phase.

---

## 3. Canonical Tag Misconfiguration

### Common patterns
Item matrix products where each color/size variant has its own URL. Unless each variant
has meaningfully different content, all variants should canonical to the parent item page.
Check whether variant URLs appear independently in GSC Coverage.

Pagination where category page 2 and beyond are canonicalized back to page 1. This tells
Google not to index paginated content, which may be intentional or may be hiding products
from the index depending on how deep the catalog is. Verify this is deliberate.

Multiple homepage URLs being indexed — typically the root domain, /home, and /index all
resolve and each may have different canonical behavior. All three should resolve to one
canonical URL with 301 redirects or consistent canonical tags.

Search results pages being indexed. Internal search result URLs should be blocked via
robots.txt or noindexed via meta robots. They are never a valid landing page target.

### How to verify
Use Chrome DevTools to inspect the HTML source returned to crawlers — not the rendered
DOM, the actual page source. The canonical tag must be present in the SSR output, not
only in the client-side rendered DOM. If it is only in the DOM, crawlers may not see it.

---

## 4. Product Schema and Structured Data

SCA has built-in schema support but default implementation is frequently incomplete.

### Required schema types for ecommerce SCA
Product schema on all product pages: name, image, description, sku, brand, offers
(with price, priceCurrency, availability, url). AggregateRating if reviews are present.
Missing availability or price makes the rich result ineligible.

BreadcrumbList on all interior pages. SCA generates breadcrumbs but the JSON-LD
implementation frequently does not match the visible breadcrumb trail. Google will
suppress breadcrumb rich results when the schema and visible breadcrumbs conflict.

Organization and WebSite schema on the homepage with a Sitelinks Searchbox if applicable.

ItemList schema on category pages is optional but valuable for product listing rich results.

### The most common SCA schema error
Price mismatch: the JSON-LD is populated from the NetSuite item record base price, but
the visible page price reflects SCA-level pricing rules, group-specific pricing, or
promotional pricing that does not update the schema. Google's product rich result policy
requires schema prices to exactly match visible prices. A mismatch triggers a manual
action or automatic demotion of rich results for the entire domain.

How to check: use Google Rich Results Test on a product page. Compare the price value
in the schema output against the price visible on the page. They must be identical.

### How to verify schema is in SSR output
Use Google Rich Results Test with the live URL. Also run it with the ?nsgdebug=T URL
to confirm the schema is in the page generator output. Schema present only in the
client-side rendered DOM may not be processed by crawlers.

---

## 5. Meta Tags and Title Tag Generation

SCA generates meta content from NetSuite item record fields. Default behavior frequently
produces poor meta content that needs systematic remediation.

### Title tags
Default: pulls the item record Name field, which is often formatted as an internal SKU
reference rather than a customer-facing product name. Format: "[Item Name] | [Site Name]"
with no keyword consideration.

Target: keyword-relevant title at the product level, descriptive category titles with
location or category context, homepage with brand and primary value proposition.

### Meta descriptions
Default: first 160 characters of the item record Long Description field, which is often
structured as internal documentation, spec tables, or HTML markup remnants.

Target: unique compelling description for each page type written as marketing copy.
Note that SCA allows custom meta descriptions per item record — bulk updating them
requires either a NetSuite CSV import or a SuiteScript import utility.

### H1 tags
Common failure: category page templates placing the category name in an H2 and leaving
H1 either empty or containing a generic site-level heading. Each page should have exactly
one H1 containing the primary keyword target for that page.

### Open Graph tags
OG tags (og:title, og:description, og:image) directly affect how product URLs appear
when shared on Meta, LinkedIn, and other social platforms. This is directly relevant to
paid media landing page quality — if a product URL is used as a Meta Ads destination,
the OG image and title determine the link preview. Missing or incorrect OG tags on
SCA product pages are a paid media issue as well as an SEO issue.

---

## 6. XML Sitemap Configuration

SCA generates sitemaps automatically but default configuration frequently includes pages
that should be excluded and excludes pages that should be included.

Pages that should always be excluded from the sitemap:
- Faceted navigation URLs
- Internal search result pages  
- Cart, checkout, and My Account URLs
- Any URL returning a non-200 status code
- Noindexed pages

Pages that must be included:
- All canonical product URLs (not variant URLs if they canonical to parent)
- All base category URLs (not filtered variants)
- CMS content pages and blog posts if present
- The homepage

Verify after any sitemap configuration change by fetching the sitemap URL directly and
scanning for excluded URL patterns before resubmitting to Google Search Console.
