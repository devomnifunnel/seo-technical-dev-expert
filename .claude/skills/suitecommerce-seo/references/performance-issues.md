# SuiteCommerce Performance Issues Reference

## 1. TTFB — The Primary Lever

Time to First Byte is the single most impactful performance metric on SuiteCommerce.
Before investigating any front-end optimization, verify CDN caching is active and
working. Front-end changes have marginal impact when TTFB is 2 to 4 seconds.

### Acceptable TTFB thresholds (NetSuite performance standards)
Homepage: under 1.5 seconds on first load, under 500ms cached
Category pages: under 2 seconds uncached, under 500ms cached
Product pages: under 2 seconds uncached, under 500ms cached
Checkout: under 3 seconds (more complex due to real-time pricing and inventory)

### Diagnosing TTFB
In Chrome DevTools Network tab, click the HTML document request and check the Waiting
(TTFB) value in the Timing tab. Values above 600ms on a cached page indicate CDN is
not working correctly. Values above 600ms on an uncached page indicate SSR performance
problems or SuiteScript issues that need APM investigation.

Check the x-cache response header on the HTML document request. Expected values for
a working CDN vary by provider: Fastly shows HIT/MISS, Cloudflare shows HIT/MISS in
cf-cache-status, AWS CloudFront shows Hit from cloudfront / Miss from cloudfront.
If every request shows MISS, CDN caching is not functioning.

### CDN caching configuration
Location in NetSuite: Setup > SuiteCommerce > Website > CDN Settings

The most common misconfiguration: CDN caching is enabled globally but specific page
types (product pages, category pages) have cache-control headers that prevent caching.
Checkout and My Account are excluded from caching by default and this is correct —
they contain session-specific data. All other page types should be cached.

CDN caching for checkout: Checkout is configurable for CDN caching. Enabling this
reduces TTFB on checkout entry pages significantly but requires careful configuration
to ensure session-specific content (cart contents, pricing) is not incorrectly cached.
This is a developer configuration task, not a settings-only change.

---

## 2. SuiteScript Performance

SuiteScript is the hidden driver of most SuiteCommerce performance problems that are
not explained by CDN configuration. Every SuiteScript execution adds server-side latency
before the page can be delivered.

### NetSuite APM — The Correct Diagnostic Tool
Path: Setup > Performance > Application Performance Manager

APM shows route-level execution time, individual SuiteScript performance by script ID,
rendering delays, and API call volumes broken down by request. This is the server-side
profiler for SuiteCommerce. Any performance engagement that does not include APM review
is incomplete.

What to look for in APM:
- Routes with execution time consistently above the performance standards above
- Scripts appearing in multiple routes with high execution times
- High API call counts on product and category pages (real-time inventory/pricing lookups)
- Any script with execution time above 1 second on a per-request basis

### SuiteScript log level — Immediate fix, measurable impact
All SuiteScript log levels in production should be set to Error. Debug and Info logging
writes entries to the NetSuite execution log on every script run and adds overhead
to every request. This is the easiest and fastest performance win on any SCA site that
has been actively developed.

How to fix: Setup > SuiteCloud > Script Deployments > filter by web store context > 
set Log Level to Error on each deployment. This requires admin access in NetSuite.

### Scriptable Cart
The Scriptable Cart feature allows SuiteScript to execute on shopping cart events.
If enabled, every cart interaction (add to cart, quantity change, coupon application)
triggers server-side script execution. Identify whether Scriptable Cart is in use and
audit the scripts configured to run. Any unnecessary synchronous operations in these
scripts directly delay cart interaction response time.

### Real-time pricing and inventory
SCA can be configured to fetch real-time pricing and inventory on every product page
load via synchronous API calls to the NetSuite backend. This is appropriate for B2B
scenarios with customer-specific pricing but adds significant latency for B2C stores
where pricing is static. Audit whether real-time fetching is necessary for each client's
business requirements before recommending caching changes.

---

## 3. Image Delivery

SCA includes a built-in image resizing service that serves product images from NetSuite's
CDN at requested dimensions. Misconfiguration here is a common and easily fixed
performance issue.

### Diagnosing image problems
In Chrome DevTools Network tab, filter by Img. Check the Size column against the visible
rendered dimensions of each product image. Any image being displayed at dimensions more
than 20% smaller than its intrinsic dimensions is being served at unnecessarily large
size and should have its delivery configuration corrected.

### Common image issues
Images uploaded at full resolution with CSS scaling them down in the browser. The NetSuite
image resizing service should be configured to deliver images at the display dimensions
required by the SCA theme, not at original upload resolution.

Missing width and height attributes causing layout shift (CLS). If product images load
without reserved space, the page reflows as they appear. CLS is a Core Web Vitals metric
that directly affects Google ranking. Fix: ensure the SCA theme templates include
explicit width and height attributes on all product image tags.

No lazy loading on below-fold images. Product listing pages load many images. Images
below the fold should use loading="lazy" to defer their download until the user scrolls
toward them. This is a theme template modification.

WebP delivery: SCA supports WebP image delivery but it requires configuration. WebP
files are typically 30 to 50 percent smaller than JPEG at equivalent quality.

---

## 4. JavaScript Bundle and Render Blocking

### Third-party scripts
Every tag in the client-side GTM container that fires on page load contributes to the
total JavaScript execution time that PageSpeed measures. This is the direct connection
between OFM's tracking implementation and the client's performance scores.

Tags with large payloads that should be evaluated for deferral:
- Full chat widget scripts (Intercom, Drift, Zendesk)
- Video embed players loaded on pages without video content
- Review platform widgets loading full SDK on every page
- Social sharing button scripts

The GTM container itself must load asynchronously. Verify the GTM snippet installed
on the SCA site uses the async/defer version, not the legacy synchronous snippet.

For OFM server-side tracking implementations via Stape.io: server-side tags do not
add to client-side JS execution time. The client-side GTM container should ideally
contain only the Stape.io data collection snippet and any tags that absolutely require
client-side execution. All conversion and analytics signals should route through the
server-side container.

### SCA extension bundle size
Custom SCA extensions and theme modifications are bundled into the SCA JavaScript
build at deployment. Inactive extensions that are disabled in configuration but still
included in the build add to bundle size without providing value. Work with the NetSuite
developer to confirm only active extensions are included in production builds.

---

## 5. Core Web Vitals — SuiteCommerce Specific Guidance

### LCP (Largest Contentful Paint)
The LCP element on SCA product pages is almost always the hero product image. Primary
interventions: CDN caching to reduce TTFB (most impactful), image sizing optimization,
and ensuring the hero image is not lazy-loaded (above-fold images should not be lazy).

### CLS (Cumulative Layout Shift)
Primary causes on SCA: product images without reserved dimensions, dynamic price blocks
that load asynchronously and push content down, third-party chat widgets that inject
elements after initial render. The Scriptable Cart can also cause CLS if it modifies
visible cart elements on load.

### INP (Interaction to Next Paint)
INP measures responsiveness to user interactions. On SCA, high INP is usually caused
by heavy JavaScript executing synchronously on interaction events — add to cart handlers
with synchronous SuiteScript calls, filter application triggering full page rerender,
or GTM event listeners with expensive callbacks.

CrUX data in Google Search Console reflects real user sessions (Mode 3 SPA navigation)
and is more meaningful for SCA than Lighthouse scores. Always pull CrUX field data
alongside Lighthouse lab data when reporting CWV status.
