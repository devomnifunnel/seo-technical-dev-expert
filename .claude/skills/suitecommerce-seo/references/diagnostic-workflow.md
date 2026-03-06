# SuiteCommerce Audit Diagnostic Workflow

Run these steps in order. Do not skip ahead to front-end optimization before completing
the server-side and architecture steps. The most common waste of time on SuiteCommerce
audits is optimizing JavaScript and images on a site where CDN caching is disabled.

---

## Step 1 — SEO Page Generator Debug Check

Before running any audit tool, verify what Google actually sees.

While logged into NetSuite as an administrator, open three pages with ?nsgdebug=T appended:
- Homepage: [client-domain].com/?nsgdebug=T
- A category page with products listed
- A specific product page

On each page, review the debug output for:
- JavaScript errors during SSR execution
- Missing content blocks (navigation, product data, meta tags)
- Rendering failures or incomplete HTML

If any page shows errors or missing content, this is a Critical finding. Document the
exact error messages before proceeding. These pages are not being indexed correctly.

---

## Step 2 — Sitemap and Faceted Navigation Audit

Open the XML sitemap directly: [client-domain].com/sitemap.xml

Count the total number of URLs. Compare against the number of indexed pages shown in
Google Search Console Coverage > Indexed.

If GSC shows significantly more indexed URLs than sitemap entries, run this check:
Go to GSC > Coverage > Indexed and export the full URL list. Scan for URL parameter
patterns (typically ?facet, ?N=, or similar query strings). The presence of facet URLs
in the indexed page list confirms duplicate content bleed.

Also inspect the sitemap content for any URLs containing query parameters — these should
not be present and indicate a sitemap configuration issue.

Document: total sitemap URLs, total GSC indexed URLs, whether facet URLs are present,
and the specific URL parameter patterns found.

---

## Step 3 — PageSpeed Insights Baseline

Run PageSpeed Insights (pagespeed.web.dev) on:
- Homepage
- Primary category page (highest traffic if available from GSC)
- Best-selling product page

For each page, record:
- Overall Performance score (mobile and desktop separately)
- TTFB value (shown in Diagnostics section as "Server response time")
- LCP value and the LCP element identified
- CLS score
- INP score if shown
- Total blocking time

If TTFB on any page type exceeds 600ms, CDN caching investigation (Step 4) is the
highest priority action. All other optimization work is secondary until TTFB is resolved.

---

## Step 4 — CDN Cache Verification

In Chrome DevTools (F12), go to the Network tab and reload the page with cache disabled
(Ctrl+Shift+R). Click the first request (the HTML document).

In the Response Headers section, look for the cache status header. Depending on the CDN:
- Fastly: x-cache: HIT or MISS
- Cloudflare: cf-cache-status: HIT or MISS  
- AWS CloudFront: x-cache: Hit from cloudfront or Miss from cloudfront
- Generic: cache-control header shows max-age value

If the header shows MISS on multiple reloads of the same page, CDN caching is not
functioning. This is a Critical finding — document it and flag for developer review of
the CDN configuration in NetSuite website setup before proceeding further.

If the header shows HIT, CDN is functioning. Note the max-age value to understand how
long pages are cached before the SSR layer must regenerate them.

---

## Step 5 — NetSuite APM Review

Log into NetSuite admin and navigate to Setup > Performance > Application Performance Manager.

Pull data for the last 7 days. Review:
- Slowest routes by average execution time
- Routes with execution time above NetSuite's performance standards
- Individual SuiteScript execution times by script ID
- API call counts per page type

Any SuiteScript appearing consistently in the slowest routes is a performance investigation
target. Document the script ID, average execution time, and which routes it appears on.

Check SuiteScript log levels: Setup > SuiteCloud > Script Deployments. Filter by the
web store context. Any script with log level set to Debug or Info in production should
be flagged as an immediate fix — change to Error only.

---

## Step 6 — Schema and Rich Results Verification

Run Google Rich Results Test (search.google.com/test/rich-results) on:
- The homepage (check Organization schema)
- A product page (check Product schema)
- A category page (check BreadcrumbList schema)

For each product page test, compare:
- Price in schema output vs price visible on the page (must match exactly)
- Availability in schema vs actual stock status
- All required Product schema fields present (name, image, description, offers)
- Any validation errors or warnings in the test output

Document all errors and warnings with the specific field and the required fix.

---

## Step 7 — Canonical Tag Verification

On a category page, apply 2 or 3 different filters. For each filtered URL, use
Chrome DevTools to view the page source (not the rendered DOM — right-click > View Page Source).

In the source, search for <link rel="canonical". Verify:
- The canonical tag is present in the source (SSR output), not only in the rendered DOM
- The canonical URL points to the base category page, not the filtered URL
- The canonical URL matches exactly — no trailing slash discrepancy, no www/non-www mismatch

Also check product variant URLs if the client uses item matrix products. Navigate to
a product with color or size variants, switch to a variant URL, and verify the canonical
points to the parent product page.

---

## Step 8 — Image Audit

In Chrome DevTools Network tab, filter by Img and reload a category page showing multiple
products. For each product image visible above the fold:
- Check the Size column (bytes transferred)
- Right-click the image and Inspect to see the rendered dimensions
- Check whether width and height attributes are present in the img tag
- Check whether loading="lazy" is absent (above-fold images should not be lazy loaded)

For images below the fold on the same page, verify loading="lazy" is present.

Flag any image where the intrinsic dimensions are more than 2x the display dimensions —
this indicates the image is being delivered at unnecessarily large size.

---

## Step 9 — GTM Tag Audit

Open GTM Preview mode (tagmanager.google.com > your container > Preview) and load the
client site. In the preview panel, review all tags that fired on page load.

Identify and flag:
- Any large third-party script loading synchronously (chat widgets, video players,
  review widgets) — these should be deferred or moved to server-side
- Any tags firing on every page that could be triggered conditionally instead
- Tags with no recent conversions or data that may be dead code

For OFM server-side tracking setups: confirm the Stape.io data collection tag is the
primary client-side tag and that conversion signals are routing through the server-side
container rather than firing redundant client-side conversion tags.

---

## Step 10 — Compile Findings Report

Organize all findings using the OFM standard audit format:

**Executive Summary**: One paragraph, overall health assessment, most critical finding,
estimated impact of top recommendation.

**Score Snapshot**: PageSpeed scores, TTFB values, GSC indexed page count, Rich Results
test status.

**Issue Inventory by Priority Tier**:
- Critical: Issues causing active indexation failure, rich result suspension risk,
  or measurable revenue impact (500 errors, CDN disabled, canonical at scale, price
  schema mismatch)
- High: Issues causing ranking suppression or significant performance degradation
  (facet duplicate content, TTFB above thresholds, Debug log level in production)
- Medium: Issues causing suboptimal performance or missed opportunities (image sizing,
  missing schema types, meta description quality)
- Low: Incremental improvements with minor expected impact

**Detailed Findings**: Each issue with Finding, Root Cause, Evidence, Impact, Fix Instructions.

**Recommended Action Plan**: Prioritized sequence of fixes with estimated developer hours
and expected measurable outcome for each.

For Fix Instructions format, see references/developer-handoff.md.
