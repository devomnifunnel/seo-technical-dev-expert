# SuiteCommerce Architecture Reference

## The SPA Foundation

SuiteCommerce Advanced is a Single Page Application built on Backbone.js. When a human
visitor loads the site, a single HTML shell downloads and JavaScript builds the entire
storefront in the browser. All subsequent page navigation happens inside that JS application
with no full page reloads — only data for each view is fetched from the NetSuite backend
via REST API calls.

This is good for perceived browsing performance but creates two problems: first page load
is heavy because the full JS application must initialize, and search crawlers that skip
JavaScript execution see an empty shell with no content.

## The Three Rendering Modes

Every audit finding must be interpreted against which rendering mode is active. Getting
this wrong means recommending fixes for problems that do not exist.

### Mode 1 — SSR Uncached (Slowest)
Who experiences it: Search crawlers on first visit to a page, or any cached page that
has expired. Also what PageSpeed Insights and Lighthouse measure most of the time.

What happens: The SEO Page Generator (NetSuite's server-side rendering layer) receives
the request, spins up a virtual browser, executes the full SPA JavaScript, renders the
complete HTML, and sends it to the requester. This is expensive. TTFB on uncached SSR
can easily exceed 2 to 4 seconds on complex pages.

Implication: Poor PageSpeed scores on SuiteCommerce almost always reflect Mode 1 TTFB,
not front-end code quality. The fix is CDN caching configuration, not JS optimization.

### Mode 2 — SSR Cached (Fast)
Who experiences it: Crawlers requesting pages that are already in the CDN cache.

What happens: The CDN serves the prerendered HTML immediately without invoking the SEO
Page Generator. TTFB drops to under 200ms.

This is the target state for all crawler-facing page delivery. Cache hit rate should be
as close to 100% as possible for high-traffic page types.

### Mode 3 — Client-Side SPA (Fast After Initial Load)
Who experiences it: Human visitors after the initial JS bundle has loaded.

What happens: Navigation between pages uses the already-loaded Backbone application.
Only API data for the new view is fetched. Page transitions feel nearly instant.

Implication: Real users on their second and subsequent pages experience very fast
navigation that Lighthouse never measures. CrUX data in Google Search Console reflects
real user experience and is the more honest performance signal for SCA sites.

## The SEO Page Generator in Detail

The SEO Page Generator is NetSuite's SSR layer. It uses user-agent detection to determine
whether the requester is a crawler. When it identifies a bot, it prerenders the page
and returns complete HTML. When it identifies a human, it returns the lightweight SPA shell
and lets the browser build the page.

Key behaviors to know for audits:

CDN caching integration: When CDN caching is enabled, prerendered pages are stored briefly
so subsequent crawler requests get the cached version without triggering SSR again. This
is the most important performance optimization available on SCA.

Authentication bypass: The page generator does not run for logged-in users or recognized
user states. This includes checkout and My Account pages by default.

APM exclusion: The NetSuite Application Performance Manager (APM) library is not loaded
during SSR. This means APM data reflects human visitor sessions only, not crawler sessions.

Debug access: Append ?nsgdebug=T to any URL while logged into NetSuite as an admin to
see exactly what the page generator rendered, what scripts executed, and what errors
occurred. This is ground truth for any crawl or indexing discrepancy.

## How This Affects Audit Tools

Lighthouse / PageSpeed Insights: Measures Mode 1 or Mode 2 depending on CDN cache state
at time of test. Does not measure Mode 3 at all. Scores reflect crawler experience, not
human visitor experience.

CrUX / Google Search Console CWV: Reflects real human visitor experience (Mode 3 after
initial load). More meaningful for understanding actual user impact.

Google Search Console Coverage: Reflects what the SEO Page Generator delivered to
Googlebot. If pages show as indexed with wrong content, check the debug log.

Chrome DevTools on a real browser session: Reflects Mode 3 after initial JS load. Use
this to understand what real users experience, not what crawlers see.

NetSuite APM: Server-side only. Shows SuiteScript execution time, API call volume, and
route-level performance. The only tool that shows what is happening on the NetSuite backend.

## NetSuite Backend Architecture

SCA communicates with NetSuite via SuiteScript — NetSuite's proprietary server-side
JavaScript API. SuiteScript runs on NetSuite's application server and handles data
retrieval, pricing, inventory, cart operations, and checkout.

Performance is influenced simultaneously by front-end factors (JS bundle size, images,
third-party scripts) and back-end factors (SuiteScript execution time, API call volume,
caching configuration). Standard web performance tools only see the front-end half.

SuiteScript log levels in production must be set to Error. Debug or Info logging writes
to the NetSuite execution log on every script execution and adds measurable latency.
Path: Setup > SuiteCloud > Script Deployments > [individual script] > Log Level.
