# SuiteCommerce Developer Handoff Reference

Every fix recommendation for a SuiteCommerce site must be written so a NetSuite developer
can execute it without a follow-up call. This means exact navigation paths, specific field
names, precise code instructions, and clear verification steps.

---

## Handoff Document Structure Per Issue

Use this structure for every issue in the Fix Instructions section of an audit report:

**Issue**: One-sentence description of the problem.

**Root Cause**: What is actually causing it at the technical level.

**Evidence**: What was observed during the audit (URL tested, screenshot reference,
specific error message, metric value).

**Priority**: Critical / High / Medium / Low with one-sentence justification.

**Fix Instructions**: Complete step-by-step instructions — see format below.

**Verification Steps**: How to confirm the fix worked after implementation.

**Estimated Developer Time**: Honest estimate based on complexity.

---

## Fix Instruction Formats by Issue Type

### SuiteScript Log Level Change

Fix Instructions:
1. Log into NetSuite as Administrator
2. Navigate to Setup > SuiteCloud > Script Deployments
3. Filter the list by Deployed = Yes and Context includes Shopping (or the relevant context)
4. For each deployment, click Edit and set Log Level to Error
5. Save each record
6. Repeat for any other relevant contexts (Cart, Checkout, My Account)

Verification: Reload the site and navigate through several pages. Open APM and confirm
execution times have decreased. Check the SuiteScript log (Setup > SuiteCloud > Script
Execution Log) and confirm no Debug or Info level entries are being written.

Estimated developer time: 30 minutes to audit and update all deployments.

---

### CDN Caching Configuration

Fix Instructions:
1. Log into NetSuite as Administrator
2. Navigate to Setup > SuiteCommerce > [Website Name] > Hosting Files > CDN Settings
   (exact path varies by SCA version — may be under Commerce > Websites > [Site] > CDN)
3. Enable CDN caching for each page type: Homepage, Category, Product Detail, Content Pages
4. Set cache duration — recommend 1 hour (3600 seconds) for product pages, 24 hours
   for content pages, 30 minutes for category pages
5. Ensure checkout (/checkout) and My Account (/my-account) paths are excluded from caching
6. Save and publish the configuration change

Verification: Navigate to the site and open Chrome DevTools Network tab. Reload the
page twice. On the second load, the HTML document response headers should show a cache
HIT value. If still showing MISS, confirm with the NetSuite developer that the CDN
provider is configured and the DNS is pointing correctly.

Estimated developer time: 1 to 2 hours including testing and verification.

---

### Faceted Navigation Canonical Tags

Fix Instructions:
1. Identify the exact URL parameter names used by facet filters. Navigate to a category
   page and apply a filter — the URL parameter name is in the resulting URL (example: ?N=,
   ?facet=, or custom parameters depending on SCA configuration).
2. In NetSuite, navigate to Commerce > Websites > [Site] > SEO > URL Rules
   (or the equivalent path in the client's SCA version)
3. Configure canonical rules to strip facet parameters from canonical URLs. The canonical
   for all facet combinations of /category/example should be /category/example
4. For robots.txt, navigate to Commerce > Websites > [Site] > Hosting Files or the file
   cabinet path for robots.txt and add Disallow rules for the facet parameter patterns.
   Example: Disallow: /*?N= and Disallow: /*?facet=
5. Regenerate the XML sitemap after saving changes
6. Submit the updated sitemap to Google Search Console

Verification: Apply filters on a category page and use View Page Source to confirm the
canonical tag in the HTML source (not the rendered DOM) points to the base category URL
without query parameters. Confirm the updated robots.txt is accessible at /robots.txt.

Note for developer: Test canonical changes in a staging environment first. Incorrect
canonical configuration at scale is a Critical SEO incident.

Estimated developer time: 2 to 4 hours including testing, depends on how facets are
implemented in the specific SCA version.

---

### Product Schema Price Fix

Fix Instructions:
1. Identify which SCA module generates the Product schema JSON-LD. Search the SCA theme
   or extensions for the template file containing "offers" and "price" in JSON-LD context.
   Common location: Modules > [theme]/Templates/ or Extensions > [custom-extension]/Templates/
2. Identify which NetSuite item record field the price is currently being pulled from
   (likely the base sales price field)
3. Identify whether the displayed price uses SCA pricing rules, promotion pricing, or
   group-specific pricing that differs from the item record base price
4. Update the schema template to use the same pricing API call that the visible price
   display uses, so both pull from the same source
5. If real-time pricing is enabled, the schema template must also use the real-time
   pricing response rather than the static item record field

Verification: After deployment, run Google Rich Results Test on a product page. Confirm
the price value in the schema output exactly matches the price shown on the page. Test
across multiple product types including any promotional or sale items.

Estimated developer time: 2 to 6 hours depending on complexity of pricing rules.

---

### Image Resizing Configuration

Fix Instructions:
1. Identify the product image dimensions displayed by the SCA theme on category and
   product pages. This requires inspecting the rendered image dimensions in Chrome DevTools.
2. In the NetSuite file cabinet (Documents > Files > SuiteScripts or the theme files
   directory), locate the image configuration file for the SCA theme
3. Configure the image resizing service to deliver images at the display dimensions
   identified in step 1. Consult the SCA developer documentation for the specific
   configuration format for the client's SCA version
4. Ensure img tags in the theme templates include explicit width and height attributes
   matching the configured delivery dimensions — this prevents CLS
5. For above-fold images (hero images, first row of category products), ensure loading
   attribute is absent or set to eager. For below-fold images, set loading="lazy"

Verification: After deployment, reload a category page in Chrome DevTools Network tab
and compare the intrinsic dimensions of product images (right-click > Inspect) against
the Size column in the Network tab. The transferred size should match the display size
within 20 percent.

Estimated developer time: 2 to 4 hours including cross-device testing.

---

### GTM Synchronous Tag Deferral

Fix Instructions:
These changes are made in the GTM container, not in SCA directly.

1. Open GTM > Container > Tags
2. Identify each third-party script tag loading on all pages (chat widget, review widget,
   social scripts)
3. For each tag, evaluate whether it can be deferred:
   - Chat widgets: delay trigger to 3 to 5 seconds after page load using a custom timer
     trigger rather than Window Loaded or DOM Ready
   - Review widgets: fire only on product pages and only after user interaction or scroll
   - Video players: fire only on pages where video content exists using URL-based triggers
4. For any script that was previously loading synchronously in the document head outside
   of GTM, move it into GTM with an async trigger
5. Publish the container after changes

Verification: Run PageSpeed Insights before and after the changes. Check Total Blocking
Time metric specifically — this is the most direct measure of JavaScript execution impact
on page load. Run GTM Preview mode after publishing to confirm all tags still fire
correctly on the intended pages.

Estimated developer time: 1 to 3 hours depending on number of tags to update.

---

## What to Always Include in Handoff Documents

NetSuite navigation paths. Never say "go to the settings area" — give the exact menu path.

SCA version context. Configuration paths vary between SCA versions. If the client's SCA
version is known, note it on the handoff document so the developer knows which
documentation to reference.

Staging environment testing requirement. Any change that affects canonical tags, sitemap,
or robots.txt must be tested on staging before production deployment. Include this as an
explicit step for those fix types.

Rollback instructions for Critical changes. For canonical and sitemap changes, include
instructions for reverting if the change causes unexpected indexation behavior.

Expected timeline for results. After canonical fixes, full Google reprocessing typically
takes 2 to 8 weeks. After sitemap changes, resubmit to GSC and allow 1 to 2 weeks for
recrawl. Set these expectations in the handoff document so the client understands the
timeline for measurable improvement.
