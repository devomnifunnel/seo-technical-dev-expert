# Verocious Motorsports | Comprehensive SEO Audit
**Date:** March 17, 2026
**Domain:** https://www.verociousmotorsports.com/
**Platform:** NetSuite SuiteCommerce Standard (SCS) SC_2025.2.20 | Summit 4.0.0
**NetSuite Account:** 606473 | Website ID: 3
**Prepared by:** OmniFunnel Marketing

**Scope:** Full technical SEO, on page, content, schema, indexation, link profile, and competitive analysis. Performance/CWV issues are excluded (covered separately in cwv-top4-remediation.md and checkout-performance-optimization.md).

**Data Sources:** Google Search Console (live API, 28 day window Feb 17 to Mar 17 2026), Semrush (live API, US database), Lighthouse 13.0.3 (5 page types audited), existing live site inspection data.

---

## Executive Summary

VMS has 3,617 organic keywords but generates only an estimated 790 sessions/month (Semrush). Its closest competitor, aceraceparts.com, gets 27,650 sessions from 6,225 keywords on a nearly identical product set. The gap is not a link problem. It is a compounding stack of technical SEO failures, canonical misconfigurations, missing structured data, thin content, and crawlability issues that are all specific to the NetSuite SuiteCommerce platform.

The single most damaging issue is HTTP vs HTTPS canonicalization: Google is showing the HTTP version of the homepage with 35,273 impressions while the HTTPS version gets only 3,098. That 10x impression split means the site's entire authority is fractured across two protocol versions.

The second most damaging issue is the sitemap: 3,480 URLs submitted, **zero indexed** according to GSC. Google is not using the sitemap to discover pages.

Fixing the 7 Critical items below should produce measurable ranking improvements within 4 to 6 weeks after Google reprocesses the affected URLs. The High priority items represent the next wave of gains, primarily through schema markup (enabling rich results), content expansion (capturing striking distance keywords), and CTR optimization (title tags and meta descriptions).

### Score Snapshot

| Metric | Current | Target |
|--------|---------|--------|
| Semrush Authority Score | 19/100 | 25+ (6 month) |
| Organic Keywords | 3,617 | 5,000+ |
| Estimated Organic Traffic | 790/mo | 3,000+/mo |
| GSC Impressions (28d) | ~120,000 | Maintain |
| GSC Clicks (28d) | ~700 | 2,000+ |
| Sitemap URLs Indexed | 0 of 3,480 | 3,000+ |
| Rich Results (Product Snippets) | Warnings on all | Clean pass |
| Breadcrumb Rich Results | "Unnamed item" | Proper names |
| Lighthouse SEO Score (avg) | 93/100 | 98+ |
| Toxic Referring Domains | ~48% of 766 | Under 20% |

---

## Issue Inventory by Priority Tier

### CRITICAL (7 issues) — Blocks indexing, splits authority, or directly loses revenue

| # | Issue | Impact | Effort |
|---|-------|--------|--------|
| C1 | HTTP vs HTTPS canonicalization crisis | VERY HIGH | LOW |
| C2 | Sitemap: 3,480 submitted, 0 indexed | VERY HIGH | LOW |
| C3 | Broken canonical tags on high traffic pages | VERY HIGH | MEDIUM |
| C4 | ?page=1 pagination URLs indexed and competing | HIGH | MEDIUM |
| C5 | Non crawlable navigation links on homepage | HIGH | MEDIUM |
| C6 | seoSupport: false in SuiteCommerce config | HIGH | LOW (config change) |
| C7 | Product pages missing meta descriptions sitewide | HIGH | MEDIUM |

### HIGH (8 issues) — Significant ranking and CTR impact

| # | Issue | Impact | Effort |
|---|-------|--------|--------|
| H1 | Product schema incomplete (6 missing fields) | HIGH | MEDIUM |
| H2 | Breadcrumb schema showing "Unnamed item" | HIGH | MEDIUM |
| H3 | No Organization schema sitewide | MEDIUM | LOW |
| H4 | No Open Graph or Twitter Card tags | MEDIUM | LOW |
| H5 | Keyword cannibalization ("verocious" on 3 URLs) | HIGH | MEDIUM |
| H6 | Blog content dangerously thin (top post 410 words) | HIGH | MEDIUM |
| H7 | Title tags generic, not optimized for CTR | HIGH | MEDIUM |
| H8 | No Article or FAQPage schema on blog posts | MEDIUM | MEDIUM |

### MEDIUM (7 issues) — Optimization opportunities

| # | Issue | Impact | Effort |
|---|-------|--------|--------|
| M1 | Internal linking weak (5 to 12 links per page) | MEDIUM | ONGOING |
| M2 | 43% of homepage images missing alt text | MEDIUM | LOW |
| M3 | Blog listing page: 23 non descriptive links | LOW | LOW |
| M4 | Heading hierarchy violations sitewide | LOW | MEDIUM |
| M5 | 48% of referring domains are toxic (AS 0 to 2) | MEDIUM | ONGOING |
| M6 | Homepage title missing brand name | LOW | LOW |
| M7 | Color contrast failures on 3 of 5 page types | LOW | LOW |

---

## Detailed Findings

---

### C1: HTTP vs HTTPS Canonicalization Crisis

**What GSC shows:**

| Version | Impressions (28d) | Clicks | CTR | Avg Position |
|---------|-------------------|--------|-----|--------------|
| http://www.verociousmotorsports.com/ | 35,273 | 82 | 0.23% | 6.26 |
| https://www.verociousmotorsports.com/ | 3,098 | 59 | 1.90% | 4.34 |

The HTTP version gets 10x the impressions with terrible CTR. Google's URL Inspection shows http:// as "Page with redirect" with the correct googleCanonical pointing to https://. But the HTTP version is still generating massive search impressions, which means Google has not fully consolidated the two versions.

**Why this matters:** All link equity, click signals, and ranking authority are split between two protocol versions. The HTTP version's 0.23% CTR is dragging down the overall site quality signal. Users who do click the HTTP result experience a redirect, adding latency.

**Root cause:** Historical backlinks and internal references to the HTTP version. Google continues to show whichever version it first indexed, and with 35K impressions still flowing to HTTP, consolidation is incomplete.

**How to fix in NetSuite:**

1. **Verify 301 redirect chain.** Navigate to Setup > SuiteCommerce Advanced > Configuration > Verocious Motors > www domain. Under the Domain tab, confirm that the HTTP to HTTPS redirect is a 301 (permanent), not a 302 (temporary). If NetSuite's default redirect behavior is 302, this must be changed to 301.

2. **Check for internal HTTP links.** In the SuiteCommerce configuration, verify that all hardcoded URLs use https://. Check:
   - Commerce > SC Configuration > Verocious Motors > www domain > General: baseUrl must be https://
   - Website Setup > Verocious Motors > Domains tab: Primary domain must show https
   - Any CMS content blocks (homepage banners, about page content) that contain hardcoded links

3. **Update the sitemap.** The current sitemap at indexsitemap.xml must contain only https:// URLs. If any http:// URLs exist in the sitemap, they must be replaced.

4. **GSC property verification.** Confirm that the HTTPS property (https://www.verociousmotorsports.com/) is set as the preferred version in GSC. The sc-domain: property captures both, which is correct for monitoring, but Google needs a clear signal that HTTPS is canonical.

5. **Backlink audit.** The referring URLs shown in GSC for the HTTP homepage include links from grimmspeed.com, pinterest.com, and clubcav.com. These external links cannot be changed, but the 301 redirect passes their equity to HTTPS. The redirect itself is working. The issue is that Google has not yet fully deindexed the HTTP version.

6. **Request reindexing.** After verifying the 301 and sitemap, use GSC URL Inspection on http://www.verociousmotorsports.com/ and request indexing. This will prompt Google to recrawl and consolidate.

**Expected outcome:** 35K+ impressions consolidated to the HTTPS version. CTR should rise from the blended ~0.5% to 1.5%+ as the HTTP version drops out of the index. Timeline: 2 to 4 weeks after fixes are confirmed.

---

### C2: Sitemap — 3,480 Submitted, Zero Indexed

**What GSC shows:**

| Sitemap | Submitted | Last Download | URLs | Indexed |
|---------|-----------|---------------|------|---------|
| indexsitemap.xml | Feb 20, 2026 | Mar 15, 2026 | 3,480 | 0 |

Google downloaded the sitemap on March 15 but reports zero URLs as indexed through it. This does not mean the pages themselves are not indexed. It means Google is not using the sitemap as a discovery mechanism, relying instead on crawling and internal links.

**Why this matters:** A functioning sitemap is a direct signal to Google about which URLs you consider canonical and important. With zero sitemap indexed URLs, Google is making its own decisions about which pages to index and which to ignore. This contributes to the ?page=1 canonicalization problem, the HTTP/HTTPS split, and general index bloat.

**Root cause investigation:**

1. The sitemap was last submitted Feb 20, 2026. It has not been resubmitted since.
2. The VMS SEO Sitemap Generator script exists in NetSuite (found during March 6 backend exploration) but is in "Testing" status and NOT deployed.
3. The current sitemap may be the NetSuite default auto generated sitemap, which often includes non canonical URLs, parameter URLs, and HTTP versions.

**How to fix in NetSuite:**

1. **Audit the current sitemap.** Fetch https://www.verociousmotorsports.com/indexsitemap.xml and verify:
   - All URLs use https://www (not http://)
   - No ?page=1 parameter URLs are included
   - No URLs that redirect are included
   - No URLs that have a different canonical tag are included
   - lastmod dates reflect actual page modification, not a single static date

2. **Deploy the VMS SEO Sitemap Generator.** Navigate to Customization > Scripting > Script Deployments. Find the VMS SEO Sitemap Generator (currently in Testing status). Change status from Testing to Released. Configure the scheduled run (currently set to daily 3:00 AM). This custom script should generate a cleaner sitemap than the NetSuite default.

3. **Validate after deployment.** After the custom sitemap generator runs, download the new sitemap and verify it meets the criteria above. Then resubmit in GSC.

4. **Consider a sitemap index.** With 3,480 URLs, a single sitemap file is fine (under the 50,000 limit). But if the product catalog grows toward the 30,000 available products, implement a sitemap index with separate sitemaps for products, categories, and blog posts.

5. **robots.txt update.** The current robots.txt at /robots-verociousmotorsports.txt references `Sitemap: https://www.verociousmotorsports.com/indexsitemap.xml`. After deploying the custom generator, update this reference if the filename changes.

**Expected outcome:** Google begins using the sitemap for page discovery and canonical confirmation. Should see indexed count rise from 0 to 2,000+ within 2 to 3 weeks of resubmission.

---

### C3: Broken Canonical Tags on High Traffic Pages

**Confirmed broken canonicals from GSC and Semrush data:**

| Page | Issue | Impact |
|------|-------|--------|
| /blog/wastegate-sizing | Canonical reportedly points to /blog/choosing-wastegate-size (non existent slug) | 5,730 impressions, 127 clicks. #1 organic page. |
| /blog/turbo-screen-vs-air-filter | Canonical points to different slug | 1,590 impressions, 22 clicks |
| /about-verocious | Canonical points to homepage instead of itself | Indexed correctly per GSC, but canonical mismatch creates ambiguity |
| Category tubing pages | Canonicals may point to parent category instead of the specific subcategory | Multiple high impression pages affected |

**Note:** The GSC URL Inspection for /blog/wastegate-sizing shows googleCanonical matching userCanonical (both https://www.verociousmotorsports.com/blog/wastegate-sizing). This may mean Google is ignoring the incorrect canonical tag and choosing the correct one. But the mismatch between the declared canonical and the actual URL is still a problem because it sends a conflicting signal. Google could change its mind at any time.

**Why this matters:** A canonical tag pointing to a nonexistent URL tells Google that the current page is a duplicate of something that does not exist. Google is currently overriding this and indexing the page anyway, but this is fragile. Any algorithm update or reprocessing could cause Google to respect the broken canonical and deindex the page.

**How to fix in NetSuite:**

The canonical tag on SuiteCommerce pages is generated by the platform's SEO module combined with the CanonicalFix extension that is already deployed. The issue is likely in one of two places:

1. **CMS content pages (blog posts).** Blog posts in SuiteCommerce are typically CMS pages. Navigate to Commerce > CMS > Pages. Find the wastegate-sizing blog post. Check if there is a "Canonical URL" or "URL" field that has been set to a different slug. If the page was renamed or the URL was changed after initial publication, the old slug may be hardcoded in a canonical override field.

2. **CanonicalFix extension.** The Beautiful Canonical URLs extension (CanonicalFix) is deployed on the site. Review its configuration in Commerce > SC Configuration > Verocious Motors > www domain > Extensions > CanonicalFix. Check if there are any URL rewrite rules that are mapping blog slugs incorrectly.

3. **For category pages,** check the SuiteCommerce faceted navigation settings. If a subcategory page's canonical is being set to the parent category, this is likely a configuration issue in Commerce > SC Configuration > Facets section where the canonical URL generation logic strips subcategory identifiers.

4. **Full audit approach.** Crawl the site with the Semrush Site Audit tool (from the web UI) to get a complete list of canonical mismatches. The API does not expose this report, but the web interface shows all pages where the canonical URL differs from the page URL.

**Expected outcome:** Canonical alignment protects the site's highest traffic pages from deindexation risk and sends a clear signal to Google about the authoritative version of each page.

---

### C4: ?page=1 Pagination URLs Indexed and Competing

**Evidence from Semrush organic data:**

| Clean URL | ?page=1 URL | Keywords on ?page=1 | Example Keyword |
|-----------|-------------|---------------------|-----------------|
| tubing-stainless-mill-304-0275 | tubing-stainless-mill-304-0275?page=1 | 37 keywords | "2 3/4 exhaust pipe" pos 3 |
| vms-tubing-stainless-mill-304-0125 | vms-tubing-stainless-mill-304-0125?page=1 | 20 keywords | "1 1/4 exhaust tubing" pos 2 |
| vms-tubing-stainless-mill-304-0500 | vms-tubing-stainless-mill-304-0500?page=1 | 11+ keywords | "5 inch stainless steel exhaust pipe" pos 8 |

The ?page=1 versions are actually outranking the clean URLs for several high value queries. In the top 10 pages by Semrush traffic, position #4 and #5 are both ?page=1 URLs. This is a systemic SuiteCommerce pagination issue.

**Why this matters:** When Google indexes both /category and /category?page=1, it sees two URLs with identical or near identical content. This splits the ranking signals (links, clicks, engagement) between two URLs. It also wastes crawl budget on duplicate pages.

**How to fix in NetSuite:**

1. **Canonical tag on paginated URLs.** The ?page=1 URL must have a canonical tag pointing to the clean URL (without the parameter). In SuiteCommerce, this is controlled by the Backbone router and the canonical tag injection logic.

   Check Commerce > SC Configuration > Verocious Motors > www domain > Facets. Look for `facetsSeoLimits` and `facetDelimiters` settings. The `facetsAsUrlParameters` setting controls how facets (including pagination) appear in the URL.

2. **CanonicalFix extension.** The deployed CanonicalFix extension may already be attempting to handle this. Review its configuration to see if pagination parameter stripping is enabled. If not, this needs to be added.

3. **robots.txt.** The current robots.txt already contains `Disallow: /*?page=` rules. However, the disallow alone is not sufficient because Google may still index these URLs if they are linked internally or externally. The canonical tag is the authoritative signal.

4. **Sitemap exclusion.** Ensure the sitemap (C2 fix) does not include any ?page= URLs.

5. **If the CanonicalFix extension cannot handle pagination canonicals,** a custom SuiteScript client script or an extension modification is needed. The script should detect when the URL contains ?page=1 (specifically page=1, not page=2 or higher) and set the canonical to the parameterless URL. For page 2+, the canonical should either point to self (allowing pagination indexing) or point to page 1 (consolidating all pagination to the first page). The recommended approach for ecommerce is self referencing canonicals on page 2+ with rel=prev/next, and canonical to the clean URL on page=1.

**Expected outcome:** Authority consolidation on clean URLs. The 37 keywords currently split between tubing-304-0275 and tubing-304-0275?page=1 will consolidate, likely improving positions for the clean URL.

---

### C5: Non Crawlable Navigation Links on Homepage

**Lighthouse finding:** Both desktop and mobile audits flag "Links are not crawlable" on the homepage. The audit detects anchor elements without valid `href` attributes.

**Why this matters:** If the primary navigation links on the homepage are rendered as JavaScript click handlers without proper `href` attributes, Googlebot cannot follow them during its initial HTML parse. This means Google must execute JavaScript to discover category and product pages. With seoSupport: false (C6), this is an even bigger problem because the SPA rendering pipeline is not optimized for SEO.

**Root cause:** SuiteCommerce Standard uses Backbone.js with a Backbone Router. Navigation links are often rendered as `<a data-touchpoint="..." data-hashtag="...">` elements where the actual navigation is handled by JavaScript. The `href` attribute may be empty, set to `#`, or set to `javascript:void(0)`.

**How to fix in NetSuite:**

1. **Enable seoSupport (C6).** This is the primary fix. When seoSupport is true, SuiteCommerce generates proper server rendered HTML with valid href attributes on navigation links.

2. **If seoSupport cannot be enabled,** the Summit 4.0.0 theme templates need to be modified to include proper href attributes on all navigation anchor elements. This requires modifying the Header.Menu template in the theme:
   - File Cabinet > Web Site Hosting Files > Live Hosting Files > extensions > BluePoint > Summit > 4.0.0 > Modules
   - Find the Header.Menu template
   - Ensure all `<a>` elements include the full URL path in the href attribute, not just a data attribute

3. **Verify with a fetch.** Use GSC URL Inspection on the homepage. Click "Test Live URL." Check the rendered HTML to see if navigation links have proper href values after Google renders the page.

---

### C6: seoSupport: false in SuiteCommerce Configuration

**Current state:** SC.CONFIGURATION.seoSupport = false

This is the most fundamental SEO configuration issue on the site. When seoSupport is false, SuiteCommerce does not generate server rendered SEO content through its built in SEO module. The SPA relies entirely on client side JavaScript rendering for search engines.

**How to fix in NetSuite:**

1. Navigate to Commerce > SuiteCommerce Configuration (Suitelet script 1282, deploy 1)
2. Select Website: Verocious Motors, Domain: www.verociousmotorsports.com
3. Find the SEO section
4. Set seoSupport to true
5. Save and publish

**CAUTION:** Enabling seoSupport on SuiteCommerce Standard (SCS) may behave differently than on SuiteCommerce Advanced (SCA). On SCS, the seoSupport flag controls whether the platform generates meta tags, canonical tags, and structured data through its server side rendering pipeline. Before enabling in production:

1. Enable on the test deployment first (test.verociousmotorsports.com, currently in ERROR state, which needs to be fixed first)
2. Verify that enabling seoSupport does not break the existing CanonicalFix or CookieConsentCLSFix extensions
3. Check that product pages still render correctly with server side content
4. Monitor GSC for any crawl errors after enabling

**Expected outcome:** Proper server rendered HTML with valid navigation links, canonical tags, meta tags, and structured data generated by the platform. This addresses C5 (non crawlable links) and partially addresses C3 (canonical issues) and H1 (schema markup).

---

### C7: Product Pages Missing Meta Descriptions Sitewide

**Lighthouse confirmed:** The product page /jones-stainless-steel-exhaust-tip-dual-oval has no meta description on both desktop and mobile audits. This is the #1 product page by impressions (3,987 impressions, 10 clicks in GSC).

**The blog listing page /blog also has no meta description** (Lighthouse score 83, lowest of all page types).

**Why this matters:** Without a meta description, Google auto generates a snippet from page content. For product pages, this often results in price text, SKU numbers, or shipping information being shown as the snippet instead of a compelling product description. CTR on product SERPs without custom meta descriptions is typically 30 to 50% lower than pages with optimized descriptions.

**How to fix in NetSuite:**

For product pages, SuiteCommerce can generate meta descriptions from product data:

1. **SuiteCommerce meta description source.** When seoSupport is enabled (C6), SuiteCommerce generates meta descriptions from the item record's "Meta Description" field in NetSuite. Navigate to Lists > Web Site > Items. Open a product record. Look for the "Meta Tag HTML" or "Meta Description" field. If this field is empty on product records, SuiteCommerce has nothing to output.

2. **Bulk update approach.** For 3,480+ products, manually writing meta descriptions is not feasible. Instead:
   - Create a Saved Search in NetSuite that identifies all items where Meta Description is blank
   - Use a CSV import or SuiteScript mass update to populate meta descriptions using a template: "[Product Name] | [Key Feature] | [Material/Size]. Free shipping on orders over $500. Shop at Verocious Motorsports."
   - Prioritize the top 50 product pages by GSC impressions first (these are listed in the Striking Distance section below)

3. **For the blog listing page,** navigate to Commerce > CMS > Pages. Find the /blog page. Add a meta description in the SEO fields: "Expert tech articles on turbo setups, exhaust fabrication, fuel systems and more. Guides, FAQs, and sizing tools from Verocious Motorsports."

4. **For category pages,** check if the Category record in NetSuite has a meta description field. Navigate to Lists > Web Site > Categories. Open each top level category and verify the meta description is populated.

---

### H1: Product Schema Incomplete (6 Missing Fields)

**GSC URL Inspection for /jones-stainless-steel-exhaust-tip-dual-oval shows:**

Product Snippets detected with warnings:
- Missing field "review"
- Missing field "aggregateRating"
- Missing field "priceValidUntil"

Merchant Listings detected with warnings:
- No global identifier provided (gtin, brand)
- Missing field "shippingDetails"
- Missing field "hasMerchantReturnPolicy"

**Current schema present:** Product with name, image, offers (price, currency, availability), description. The structureddatamarkup.type is set to JSON-LD in SC Configuration (correct).

**How to fix in NetSuite:**

1. **brand:** Add the brand to the Product schema. In SuiteCommerce, the brand comes from the item record's "Manufacturer" or custom "Brand" field. If using the SC structured data module, check Commerce > SC Configuration > Structured Data Markup settings to see if brand mapping exists. If not, a custom extension or modification to the structured data template is needed to pull the brand from the item record.

2. **gtin/mpn/sku:** The item record in NetSuite has a UPC/GTIN field and an Item Name/Number field (SKU). These need to be mapped into the JSON-LD output. If the SC structured data module does not map these automatically, the extension template needs modification.

3. **aggregateRating/review:** SuiteCommerce has a Product Reviews module (productReviews is in SC.CONFIGURATION). If reviews exist, they should be included in the schema. If no reviews exist on most products, consider implementing a review collection strategy with Klaviyo or a dedicated review platform that provides schema compatible output.

4. **priceValidUntil:** Add an Offer.priceValidUntil date to the schema. This can be set to a rolling date (e.g., 30 days from today) or the end of the current pricing period.

5. **shippingDetails:** Add the Offer.shippingDetails property with shipping rate and delivery time information. This can reference the free shipping threshold ($500+) and standard ground shipping times (3 to 5 business days).

6. **hasMerchantReturnPolicy:** Add a MerchantReturnPolicy schema. Reference the site's return policy URL (/shipping-terms or a dedicated returns page).

**Implementation approach:** The cleanest way to implement this on SuiteCommerce is through a custom extension that overrides the default structured data output. The extension would:
- Read the item record fields (brand, UPC, SKU, reviews)
- Construct a complete Product JSON-LD object
- Inject it into the page head

**Expected outcome:** Product Snippets and Merchant Listings rich results in Google search. Based on the product page at position 8 for "tial 44mm wastegate" (720 monthly searches), adding price and availability rich results could increase CTR by 20 to 40%.

---

### H2: Breadcrumb Schema Showing "Unnamed Item"

**GSC URL Inspection confirms this on every page tested:**
- /blog/wastegate-sizing: Breadcrumbs rich result with "Unnamed item"
- /shop-by-category: Breadcrumbs rich result with "Unnamed item"
- /about-verocious: Breadcrumbs rich result with "Unnamed item"
- /jones-stainless-steel-exhaust-tip-dual-oval: Breadcrumbs rich result with "Unnamed item"

**Root cause:** The BreadcrumbList JSON-LD schema is present but the `name` property on one or more ListItem objects is empty or missing. The breadcrumb items likely have the `item` (URL) property but not the `name` property, or the name is being pulled from a DOM element that is empty at render time.

**How to fix in NetSuite:**

1. **Identify the breadcrumb template.** In the SuiteCommerce theme, breadcrumbs are rendered by the Global.Breadcrumb view. The JSON-LD for breadcrumbs is generated either by the SC structured data module or by a separate template.

2. **Check the structured data template.** Navigate to File Cabinet > Web Site Hosting Files > Live Hosting Files > extensions. Find the template that generates the BreadcrumbList JSON-LD. Each ListItem must have both:
   ```json
   {
     "@type": "ListItem",
     "position": 1,
     "name": "Home",
     "item": "https://www.verociousmotorsports.com/"
   }
   ```

3. **The fix is to ensure the `name` property is populated** from the breadcrumb text content, not from an empty attribute. If the template references a data attribute that is null, it will output the item URL but not the name.

4. **Test with Google Rich Results Test** after fixing. Navigate to search.google.com/test/rich-results and enter a page URL to validate the BreadcrumbList schema.

---

### H3: No Organization Schema Sitewide

No Organization JSON-LD exists on any page. This is the foundational entity schema that tells Google who the business is.

**How to fix in NetSuite:**

Add the following JSON-LD to the site header template (injected on all pages):

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Verocious Motorsports",
  "url": "https://www.verociousmotorsports.com/",
  "logo": "https://www.verociousmotorsports.com/[logo-url]",
  "description": "Race quality fabrication parts for custom automotive builds. Stainless steel tubing, exhaust tips, turbo accessories, intercoolers, and more.",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "818C South Heald Street",
    "addressLocality": "Wilmington",
    "addressRegion": "DE",
    "postalCode": "19801",
    "addressCountry": "US"
  },
  "parentOrganization": {
    "@type": "Organization",
    "name": "Vertex Industries"
  },
  "sameAs": [
    "https://www.facebook.com/verociousmotorsports",
    "https://www.instagram.com/verociousmotorsports",
    "https://www.youtube.com/verociousmotorsports",
    "https://www.linkedin.com/company/verociousmotorsports",
    "https://www.pinterest.com/verociousmotorsports"
  ],
  "contactPoint": {
    "@type": "ContactPoint",
    "telephone": "+1-302-472-0601",
    "contactType": "sales"
  }
}
```

This can be added via a custom SuiteCommerce extension that injects the script into the `<head>` of every page, or by adding it to the Addition to HEAD field in Website Setup > Verocious Motors > Analytics tab. However, the Analytics tab Addition to HEAD field currently contains only the Google site verification meta tag. Adding a large JSON-LD block there may hit character limits. A custom extension is the cleaner approach.

---

### H4: No Open Graph or Twitter Card Tags

**Confirmed missing on all page types.** No og:title, og:description, og:image, og:url, or twitter:card tags exist on any page.

**Why this matters:** When someone shares a VMS product page on Facebook, LinkedIn, Twitter, or any platform that reads OG tags, the preview will be generic or broken. This affects referral traffic and brand perception.

**How to fix in NetSuite:**

SuiteCommerce does not generate OG tags by default. A custom extension is needed that:

1. Injects `<meta property="og:title">` from the page title
2. Injects `<meta property="og:description">` from the meta description
3. Injects `<meta property="og:image">` from the primary product image (for PDPs) or the site logo (for other pages)
4. Injects `<meta property="og:url">` from the canonical URL
5. Injects `<meta property="og:type">` as "product" for PDPs and "website" for other pages
6. Injects `<meta name="twitter:card" content="summary_large_image">`

This extension can be built as a SuiteCommerce module that hooks into the page render lifecycle and reads the current page context (product data, CMS data, or category data) to populate the tags dynamically.

---

### H5: Keyword Cannibalization — "verocious" on 3 URLs

**Semrush data shows "verocious" (590 monthly searches) ranking on 3 different URLs:**

| URL | Position | Traffic % |
|-----|----------|-----------|
| / (homepage) | 2 | 6.07% |
| /shop-by-brand/verocious/verocious-exhaust-and-intake-tubing | 4 | 3.16% |
| /shop-by-brand/verocious/verocious-specialty-fittings | 15 | 0.12% |

**GSC confirms the same pattern:** "verocious" has 1,671 impressions but only 5 clicks (0.3% CTR) at position 2.5. Their own brand name is getting catastrophic CTR.

**Why this matters:** When Google sees three pages competing for the same branded query, it may rotate which one it shows, reducing the consistency of ranking and CTR. The homepage should own the branded query definitively at position 1.

**How to fix:**

1. Ensure the homepage has a strong, unique H1 and title tag that includes "Verocious Motorsports" prominently
2. The /shop-by-brand/verocious/ subpages should focus on non branded product terms in their title tags and meta descriptions. Change their titles from anything containing just "Verocious" to "Verocious Stainless Steel Exhaust Tubing" or "Verocious Specialty Fittings" respectively
3. Add internal links from the brand subpages back to the homepage using "Verocious Motorsports" as anchor text, reinforcing the homepage as the canonical page for the brand term

---

### H6: Blog Content Dangerously Thin

**The blog is the site's #1 organic traffic driver.** /blog/wastegate-sizing alone generates 5,730 impressions and 127 clicks (more than the homepage HTTPS version).

But the top blog posts are dangerously thin:
- /blog/wastegate-sizing: ~410 words (ranking #1 for "what size wastegate do i need" but competitors publish 1,500 to 3,000 word guides)
- /blog/turbo-screen-vs-air-filter: ~728 words
- Other blog posts: estimated 300 to 800 words each

**Expansion priorities (by GSC impressions):**

| Blog Post | Impressions | Clicks | Current Words | Target |
|-----------|-------------|--------|---------------|--------|
| /blog/wastegate-sizing | 5,730 | 127 | ~410 | 1,500+ |
| /blog/understanding-and-using-vacuum-boost | 2,586 | 19 | Unknown | 1,500+ |
| /blog/340-stealth-fuel-pump-faqs | 1,984 | 11 | Unknown | 1,000+ |
| /blog/fuel-pressure-gauges-liquid-filled-vs-dry | 1,789 | 12 | Unknown | 1,000+ |
| /blog/turbo-screen-vs-air-filter | 1,590 | 22 | ~728 | 1,500+ |
| /blog/troubleshooting-aeromotive-fuel-pump | 1,232 | 9 | Unknown | 1,000+ |
| /blog/silicone-hose-tips-and-tricks | 885 | 13 | Unknown | 1,000+ |
| /blog/selecting-the-correct-fuel-line-hose | 941 | 9 | Unknown | 1,000+ |
| /blog/wastegate-spring-selection | 559 | 8 | Unknown | 1,000+ |

**Each expanded post should include:**
- Comparison tables (sizes, specs, product pairings)
- FAQ section (target FAQPage schema)
- Internal links to relevant products on the site
- Publish date and author name with credentials
- Relevant images with alt text
- At least 1,000 words (1,500+ for the top 5 posts)

**How to edit in NetSuite:** Blog posts are CMS pages. Navigate to Commerce > CMS > Pages. Find each blog post and edit the content. Add the expanded text, tables, and FAQ sections. After saving, the page will update on the live site.

---

### H7: Title Tags Generic, Not Optimized for CTR

**GSC data reveals systematically poor CTR even on well positioned queries:**

| Query | Position | Impressions | CTR | Issue |
|-------|----------|-------------|-----|-------|
| "verocious" | 2.5 | 1,671 | 0.30% | Brand search with 0.3% CTR is catastrophic |
| "custom crimp" | 4.8 | 378 | 0.53% | Position 5 should get 5 to 8% CTR |
| "lps alphaloc" | 4.7 | 338 | 1.18% | Product query with very low CTR |
| "fuel pressure gauge" | 4.6 | 238 | 0% | Zero clicks from position 5 |
| "gesi catalytic converter" | 10 | 173 | 0% | Zero clicks |

**Current homepage title:** "Race Quality Fabrication Parts" (no brand name)

**Recommended title rewrites for top pages:**

| Page | Current Title Pattern | Recommended |
|------|----------------------|-------------|
| Homepage | Race Quality Fabrication Parts | Verocious Motorsports | Race Quality Exhaust, Turbo and Fabrication Parts |
| /blog/wastegate-sizing | [Current title] | Wastegate Sizing Guide and Calculator | 38mm vs 44mm vs 46mm | Verocious |
| /lps-alphalock-couplers | [Product name] | Verocious Motorsports | LPS AlphaLoc Couplers | Quick Release Exhaust Clamps | Verocious |
| /jones-stainless-steel-exhaust-tip-dual-oval | [Product name] | Verocious Motorsports | Jones Dual Oval Exhaust Tip | Stainless Steel, 3" to 4" | Verocious |

**How to edit in NetSuite:** Product page titles are generated from the item record's "Page Title" field. Navigate to Lists > Web Site > Items, open the item record, and edit the Page Title field. For CMS pages (blog, about), edit via Commerce > CMS > Pages.

---

### H8: No Article or FAQPage Schema on Blog Posts

No Article JSON-LD exists on any blog post despite the blog being the #1 traffic driver. No FAQPage schema exists on any page despite several blog posts containing FAQ content.

**How to fix:** Build a SuiteCommerce extension that injects Article schema on blog post pages, pulling headline, author, datePublished, dateModified, and image from the CMS page data. For blog posts that include FAQ sections (after content expansion per H6), add FAQPage schema alongside the Article schema.

---

## Striking Distance Opportunities (Positions 4 to 20, Sorted by Volume)

These are keywords where VMS already ranks but is not in the top 3. Moving these into positions 1 to 3 represents the fastest path to traffic growth without creating new content.

| Keyword | Current Pos | Monthly Vol | KD | Ranking URL | Action Needed |
|---------|-------------|-------------|----|----|------|
| stainless steel exhaust pipe | 10 | 4,400 | 8 | tubing-304-0213 | On page optimization, meta description, internal links |
| exhaust flex pipe | 19 | 2,900 | 22 | flex-pipe page | Content expansion on page, fix 143 keyword fragmentation |
| 2.5 exhaust pipe | 16 | 1,600 | 15 | /h-pipes | Content + internal linking |
| stainless exhaust pipe | 14 | 1,300 | 8 | tubing-304-0500 | On page optimization |
| tial wastegate | 15 | 1,300 | 11 | tial-mv-r-44mm | Product page optimization |
| 2 inch exhaust pipe | 19 | 1,300 | 16 | tubing-304-0275?page=1 | Fix pagination canonical (C4), optimize clean URL |
| stainless steel exhaust tubing | 11 | 1,000 | 15 | tubing-304-0213?page=1 | Fix pagination canonical (C4) |
| 3 exhaust tubing | 15 | 720 | 6 | tubing-304-0325 | On page + meta description |
| vacuum caps | 15 | 720 | 20 | silicone-vacuum-cap | Product page optimization |
| gesi catalytic converter | 10 | 480 | 8 | gesi-g-sport-uhp | Product page + schema |
| 2 inch exhaust tubing | 12 | 480 | 9 | tubing-304-0275?page=1 | Fix pagination canonical |
| exhaust hanger rod | 8 | 260 | 9 | verocious-exhaust-hangers | On page, already in striking range |
| vibrant clamps | 5 | 260 | 2 | vibrant-clamps | Almost there, add meta description |

**The "stainless steel exhaust pipe" opportunity is the single highest priority.** At position 10 with 4,400 monthly searches and a keyword difficulty of only 8, moving to position 3 to 5 could generate 200 to 400 clicks/month from this single keyword. The fix: optimize the ranking page's title tag, add a compelling meta description, ensure proper Product schema, and add internal links from related category and blog pages.

---

## Competitive Gap Analysis

| Metric | VMS | aceraceparts.com | stainlessworks.net | vibrantperformance.com |
|--------|-----|-------------------|-------------------|------------------------|
| Organic Keywords | 3,617 | 6,225 | 6,587 | 12,516 |
| Organic Traffic | 790 | 27,650 | 21,852 | 16,342 |
| Authority Score | 19 | Est. 30+ | Est. 35+ | Est. 40+ |
| Shared Keywords | — | 216 | 142 | 212 |
| Traffic per Keyword | 0.22 | 4.44 | 3.32 | 1.31 |

VMS generates 0.22 sessions per keyword. aceraceparts.com generates 4.44 sessions per keyword. This 20x efficiency gap is primarily caused by:

1. Missing meta descriptions killing CTR
2. Broken canonicals splitting authority
3. Thin content on high potential pages
4. No rich results (schema incomplete)
5. Pagination URLs diluting ranking signals

The competitors are not doing anything extraordinary. They simply have the basics right: proper canonical tags, meta descriptions on all pages, complete Product schema, and content pages with 1,000+ words. VMS can close this gap by fixing the issues in this audit.

---

## Backlink Profile Summary

| Metric | Value |
|--------|-------|
| Total Backlinks | 3,382 |
| Referring Domains | 766 |
| Follow / Nofollow | 2,810 (83%) / 575 (17%) |
| Authority Score | 19/100 |
| Toxic Domains (AS 0 to 2) | ~369 (48% of referring domains) |

**Top quality links:** sema.org (AS 40, industry authority), vibrantperformance.com (AS 71, brand partner), bobistheoilguy.com (AS 51, editorial), yellowpages.com (AS 56, citation), hptuners.com (AS 46, community)

**Toxic patterns requiring disavow:**
- 337 referring domains at AS 2 (automated link farm submissions)
- "visit verocious's homepage!" anchor: 425 links from 3 domains (sitewide footer spam)
- "here" anchor: 131 links from 3 domains
- 32 domains at AS 0 (confirmed spam)

**Recommendation:** Continue aggressive disavow file maintenance. Prioritize the AS 0 domains for immediate disavow. Evaluate the AS 2 bulk (337 domains) in batches. The sitewide footer links from the "visit verocious's homepage!" anchor should be added to the disavow file.

---

## GSC Quick Wins (26 Opportunities)

These queries have 100+ impressions, position 4 to 20, and CTR under 2%. Optimizing the title tag and meta description on the ranking page for each query can capture additional clicks without changing rankings.

| Query | Page | Position | Impressions | Current Clicks | Potential Clicks |
|-------|------|----------|-------------|----------------|-----------------|
| x exhaust tip | jones-dual-oval | 8.4 | 497 | 0 | 25 |
| x tip exhaust | jones-dual-oval | 10.5 | 398 | 0 | 20 |
| custom crimp | custom-crimp-machine | 4.8 | 378 | 2 | 19 |
| lps alphaloc | lps-alphalock-couplers | 4.7 | 338 | 4 | 17 |
| 6an fittings | homepage (HTTP!) | 6.0 | 253 | 0 | 13 |
| fuel pressure gauge | fuel-pressure-gauges blog | 4.6 | 238 | 0 | 12 |
| dual tip exhaust | jones-dual-oval | 4.9 | 196 | 0 | 10 |
| gesi catalytic converter | gesi-g-sport | 10.0 | 173 | 0 | 9 |
| an fitting | homepage (HTTP!) | 11.0 | 155 | 0 | 8 |
| gates barricade fuel hose | gates-barricade-mpi | 11.8 | 145 | 1 | 7 |
| jones max flow muffler | jones-max-flow | 7.9 | 137 | 1 | 7 |

Note that "6an fittings" and "an fitting" are both ranking on the HTTP homepage version, not the HTTPS version. Fixing C1 (HTTP/HTTPS canonicalization) would consolidate these to the correct page.

---

## Lighthouse SEO Audit Summary

| Page Type | Score | Failures |
|-----------|-------|----------|
| Homepage | 92 | Non crawlable links |
| Category (tubing) | 100 | None |
| Product (exhaust tip) | 92 | Missing meta description |
| Blog post (wastegate) | 100 | None |
| Blog listing | 83 | Missing meta description, 23 non descriptive links |

**Sitewide issues detected by Lighthouse:**
- Heading order violations on all 5 pages
- Structured data not evaluable (null) on all 5 pages
- Color contrast failures on 3 of 5 pages
- Image alt text not evaluable (null) on all 5 pages

---

## Action Plan — Prioritized Implementation Order

### Week 1: Critical Foundation Fixes

| # | Action | Issue | Est. Time |
|---|--------|-------|-----------|
| 1 | Verify HTTP to HTTPS 301 redirect is permanent, not 302 | C1 | 30 min |
| 2 | Audit sitemap for HTTP URLs and parameter URLs | C2 | 1 hour |
| 3 | Deploy VMS SEO Sitemap Generator (change from Testing to Released) | C2 | 15 min |
| 4 | Resubmit cleaned sitemap in GSC | C2 | 5 min |
| 5 | Fix wastegate-sizing canonical tag | C3 | 30 min |
| 6 | Fix turbo-screen-vs-air-filter canonical tag | C3 | 30 min |
| 7 | Fix about-verocious canonical tag | C3 | 15 min |
| 8 | Enable seoSupport: true (test environment first) | C6 | 2 hours |

### Week 2: Schema and Meta Description Sprint

| # | Action | Issue | Est. Time |
|---|--------|-------|-----------|
| 9 | Add Organization JSON-LD to site header | H3 | 1 hour |
| 10 | Fix BreadcrumbList schema "Unnamed item" | H2 | 2 hours |
| 11 | Write meta descriptions for top 20 pages by impressions | C7 | 3 hours |
| 12 | Rewrite homepage title tag to include brand name | M6 | 5 min |
| 13 | Add Open Graph tags (extension or template modification) | H4 | 4 hours |

### Week 3: Pagination and Product Schema

| # | Action | Issue | Est. Time |
|---|--------|-------|-----------|
| 14 | Implement canonical tag on ?page=1 URLs pointing to clean URL | C4 | 4 hours |
| 15 | Complete Product schema (brand, gtin, sku, priceValidUntil) | H1 | 8 hours |
| 16 | Add shippingDetails and hasMerchantReturnPolicy to Product schema | H1 | 2 hours |
| 17 | Add Article schema to blog post pages | H8 | 4 hours |

### Week 4: Content Expansion and CTR Optimization

| # | Action | Issue | Est. Time |
|---|--------|-------|-----------|
| 18 | Expand /blog/wastegate-sizing to 1,500+ words | H6 | 4 hours |
| 19 | Expand top 5 blog posts to 1,000+ words each | H6 | 15 hours |
| 20 | Rewrite title tags for top 50 pages by impressions | H7 | 5 hours |
| 21 | Resolve keyword cannibalization on "verocious" | H5 | 2 hours |
| 22 | Fix 23 non descriptive links on blog listing | M3 | 1 hour |
| 23 | Add alt text to all images missing it | M2 | 3 hours |

### Ongoing

| # | Action | Issue | Cadence |
|---|--------|-------|---------|
| 24 | Continue toxic backlink disavow | M5 | Weekly |
| 25 | Improve internal linking (blog to product, product to blog) | M1 | With each content update |
| 26 | Monitor GSC index coverage after sitemap resubmission | C2 | Weekly for 4 weeks |
| 27 | Monitor HTTP impressions decline after canonicalization fix | C1 | Weekly for 4 weeks |

---

## Appendix A: Full GSC Search Performance Data (28 Day Window)

### Top 10 Pages by Clicks

| Page | Clicks | Impressions | CTR | Avg Position |
|------|--------|-------------|-----|--------------|
| /blog/wastegate-sizing | 127 | 5,730 | 2.22% | 3.15 |
| http://www.verociousmotorsports.com/ | 82 | 35,273 | 0.23% | 6.26 |
| https://www.verociousmotorsports.com/ | 59 | 3,098 | 1.90% | 4.34 |
| /lps-alphalock-couplers | 38 | 1,311 | 2.90% | 4.47 |
| /gates-90-degree-fuel-fill-hose | 23 | 719 | 3.20% | 10.39 |
| /blog/turbo-screen-vs-air-filter | 22 | 1,590 | 1.38% | 5.58 |
| /blog/understanding-and-using-vacuum-boost | 19 | 2,586 | 0.73% | 10.19 |
| /speedy-all-metal-polish | 19 | 595 | 3.19% | 19.59 |
| tubing-stainless-mill-304-0325 | 19 | 934 | 2.03% | 12.34 |
| /verocious-304ss-v-band-clamp-kits | 17 | 434 | 3.92% | 11.36 |

### Top Branded Query Performance

| Query | Clicks | Impressions | CTR | Position |
|-------|--------|-------------|-----|----------|
| verocious motorsports | 63 | 476 | 13.2% | 1.69 |
| verocious | 5 | 1,671 | 0.30% | 2.55 |

The branded query "verocious" has 3.5x the search volume of "verocious motorsports" but generates 12x fewer clicks. This is the cannibalization and CTR problem in H5 and H7.

---

## Appendix B: GSC URL Inspection Results

| URL | Status | Coverage | Google Canonical | Last Crawl | Rich Results |
|-----|--------|----------|-----------------|------------|--------------|
| https://www.verociousmotorsports.com/ | PASS | Submitted and indexed | Correct (HTTPS) | Mar 14 | None |
| http://www.verociousmotorsports.com/ | NEUTRAL | Page with redirect | Correct (HTTPS) | Mar 13 | None |
| /blog/wastegate-sizing | PASS | Submitted and indexed | Correct | Mar 12 | Breadcrumbs: "Unnamed item" |
| /shop-by-category | PASS | Submitted and indexed | Correct | Feb 25 | Breadcrumbs: "Unnamed item" |
| /about-verocious | PASS | Submitted and indexed | Correct | Mar 7 | Breadcrumbs: "Unnamed item" |
| /jones-dual-oval-exhaust-tip | PASS | Submitted and indexed | Correct | Mar 13 | Product snippets (3 warnings), Merchant listings (3 warnings), Breadcrumbs: "Unnamed item" |

**Note:** /shop-by-category was last crawled Feb 25 (3 weeks ago). This is unusually infrequent for a top level category page and suggests crawl budget or priority issues.

---

## Appendix C: Semrush Organic Competitors

| Domain | Shared KW | Total KW | Traffic | Traffic Cost |
|--------|-----------|----------|---------|-------------|
| vibrantperformance.com | 212 | 12,516 | 16,342 | $10,249 |
| aceraceparts.com | 216 | 6,225 | 27,650 | $91,431 |
| stainlessheaders.com | 165 | 5,044 | 8,182 | $3,529 |
| tialsport-outlet.com | 48 | 483 | 4,789 | $2,895 |
| stainlessbros.com | 82 | 1,779 | 2,516 | $526 |
| burnsstainless.com | 119 | 3,708 | 12,077 | $7,448 |
| stainlessworks.net | 142 | 6,587 | 21,852 | $10,104 |
| totalflowusa.com | 87 | 3,671 | 4,228 | $1,558 |
| aeromotiveinc.com | 59 | 7,276 | 41,244 | $22,282 |

---

## Appendix D: Semrush Backlink Authority Distribution

| Authority Score Range | Referring Domains | % of Total |
|----------------------|-------------------|------------|
| 0 (confirmed spam) | 32 | 4.2% |
| 2 (bulk spam directories) | 337 | 44.0% |
| 3 to 10 | 157 | 20.5% |
| 11 to 20 | 68 | 8.9% |
| 21 to 30 | 99 | 12.9% |
| 31 to 40 | 65 | 8.5% |
| 41 to 50 | 13 | 1.7% |
| 51+ | 8 | 1.0% |
| **Total** | **766** | **100%** |

48% of referring domains score AS 0 to 2. These need ongoing disavow evaluation.
