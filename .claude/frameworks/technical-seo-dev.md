# Developer Handoff and SEO Implementation Standards

## Purpose
This framework defines the standards for handing off SEO requirements to developers, reviewing code for SEO impact, managing deployments with SEO safeguards, and avoiding common developer mistakes that harm organic search performance. It serves as the bridge between SEO strategy and technical implementation.

---

## 1. Developer Handoff Standards for SEO Fixes

### Handoff Document Structure
Every SEO task handed to a developer must include:

#### Clear Specification
- **What needs to change**: Specific element, tag, attribute, or behavior to modify
- **Where it needs to change**: Exact URL(s), page template(s), or component(s) affected
- **Current state**: What the element looks like or does now (include a screenshot or code snippet)
- **Desired state**: What the element should look like or do after the fix (include the exact HTML, attribute value, or behavior expected)

#### Acceptance Criteria
Write testable, binary acceptance criteria for each task:
- [ ] The title tag on product pages follows the pattern: `[Product Name] | [Key Attribute] | [Brand]`
- [ ] The canonical URL on filtered pages points to the base category URL without parameters
- [ ] The 301 redirect from `/old-url` to `/new-url` returns a 301 status code, not a 302
- [ ] JSON-LD Product schema is present on all product detail pages and validates in Google Rich Results Test

#### Testing Steps
Provide explicit steps the developer (or QA) can follow to verify the fix:
1. Navigate to [specific URL] on staging
2. View page source (or inspect element)
3. Verify [specific element] matches the desired state
4. Test on mobile and desktop
5. Validate structured data at https://search.google.com/test/rich-results
6. Check the redirect using curl or an HTTP header checker tool

### Priority and Context
- Reference the priority tier from seo-audit-methodology.md (Critical, High, Medium, Low)
- Explain why this change matters for SEO in 1 to 2 sentences (helps developers understand the impact and avoid breaking the fix later)
- Include the expected SEO outcome: "This fix will resolve the duplicate content issue affecting 2,400 product URLs"

### Handoff Checklist
- [ ] Specification is unambiguous and includes exact values (not "optimize the title tag" but "change the title tag to [exact text]")
- [ ] Acceptance criteria are written as binary pass/fail conditions
- [ ] Testing steps are specific enough for someone unfamiliar with SEO to follow
- [ ] Priority tier and business impact are documented
- [ ] Affected URLs or page templates are listed
- [ ] Any dependencies on other tasks are noted

---

## 2. Code Review Checklist for SEO Impact

When reviewing pull requests or code changes, check for these SEO concerns:

### Meta Tags
- [ ] Title tags are present and unique per page
- [ ] Title tags are under 60 characters
- [ ] Meta descriptions are present and unique per page
- [ ] Meta descriptions are under 155 characters
- [ ] Meta robots tags are correct (no accidental noindex on pages that should be indexed)
- [ ] Open Graph and Twitter Card tags are present for social sharing

### Canonical URLs
- [ ] Every indexable page has a self referencing canonical tag
- [ ] Canonical URLs use the preferred URL format (HTTPS, www or non www, trailing slash consistency)
- [ ] Canonical URLs do not include query parameters (unless intentionally indexable)
- [ ] Canonical tags point to the correct page (not a redirect target or different page)

### Redirects
- [ ] Redirects use 301 (permanent) status codes, not 302 (temporary), unless the redirect is genuinely temporary
- [ ] No redirect chains are created (A redirects to B which redirects to C; should be A redirects to C)
- [ ] No redirect loops exist
- [ ] Redirects are implemented at the server level, not via JavaScript or meta refresh
- [ ] Redirect mapping covers all known old URLs

### Structured Data (Schema)
- [ ] JSON-LD schema is present on relevant pages (Product, Article, FAQ, BreadcrumbList, LocalBusiness, Organization)
- [ ] Schema validates without errors in Google Rich Results Test
- [ ] Schema data matches the visible page content (no hidden or misleading data)
- [ ] Required schema properties are populated (e.g., Product schema must include name, offers, image)

### Robots Directives
- [ ] robots.txt is not blocking important pages or resources (CSS, JS, images needed for rendering)
- [ ] Meta robots tags match intent (noindex only on pages that should not be indexed)
- [ ] X-Robots-Tag HTTP headers are not inadvertently set
- [ ] Nofollow is used appropriately (login pages, user generated content links, paid links)

### URLs and Navigation
- [ ] URLs are clean, descriptive, and lowercase
- [ ] Internal links use standard `<a href>` tags, not JavaScript navigation
- [ ] Breadcrumb navigation reflects the site hierarchy
- [ ] Pagination is implemented correctly (rel=prev/next or canonical to page 1)

### Images
- [ ] All images have descriptive alt attributes
- [ ] Image file names are descriptive (not auto generated hashes)
- [ ] Images use modern formats (WebP with fallback)
- [ ] Lazy loading is not applied to above the fold or LCP images
- [ ] Width and height attributes are set to prevent CLS

---

## 3. Deployment SEO Checklist

### Pre Launch Checklist (Staging Environment)

#### Technical Verification
- [ ] Crawl the staging site with Screaming Frog; compare to production crawl
- [ ] Verify all meta tags (title, description, canonical, robots) on key page templates
- [ ] Validate all structured data on key page templates
- [ ] Test all redirects from the redirect map; verify 301 status codes
- [ ] Check robots.txt; ensure it allows crawling of all intended pages and resources
- [ ] Verify XML sitemap is valid, complete, and accessible
- [ ] Run Lighthouse on 5 to 10 key pages; compare CWV scores to production baseline
- [ ] Test mobile rendering on key page templates
- [ ] Verify hreflang implementation if applicable

#### Content Verification
- [ ] Title tags are unique and follow the defined pattern on all page templates
- [ ] Meta descriptions are populated on all key page templates
- [ ] H1 tags are present and unique on all pages
- [ ] Internal links resolve correctly (no broken links to staging URLs)
- [ ] Images have alt text and load correctly

#### Redirect Map
- [ ] All URL changes have corresponding 301 redirects documented
- [ ] Redirect map has been tested (spot check 10% of entries)
- [ ] High traffic and high backlink pages have verified redirects
- [ ] Redirect map is ready for implementation at launch

### Post Launch Checklist (Production)

#### Immediate (Within 2 Hours of Launch)
- [ ] Verify robots.txt is serving the production version (not the staging noindex version)
- [ ] Verify XML sitemap is accessible and valid
- [ ] Spot check 10 key pages for correct meta tags, canonical URLs, and structured data
- [ ] Test 10 redirects from the redirect map
- [ ] Verify HTTPS is enforced across the entire site
- [ ] Check GSC for any immediate crawl errors

#### Day 1 (Within 24 Hours)
- [ ] Run a full site crawl with Screaming Frog
- [ ] Compare crawl results to the pre launch staging crawl
- [ ] Check GSC for new crawl errors or coverage issues
- [ ] Monitor server logs for increased 404 rates
- [ ] Run Lighthouse on key pages; compare to pre launch baseline
- [ ] Verify Google is crawling the new site (check server logs for Googlebot activity)

#### Week 1
- [ ] Monitor GSC Index Coverage daily for unexpected changes
- [ ] Monitor organic traffic in GA4 for unexpected drops
- [ ] Check for CWV regressions in GSC
- [ ] Verify all redirects are being followed by crawlers (check GSC for 404s on old URLs)
- [ ] Submit updated sitemap in GSC if not already done
- [ ] Request indexing of key new or updated pages via GSC URL Inspection

#### Week 2 to 4
- [ ] Compare organic traffic to the pre launch baseline (allow for normal fluctuation)
- [ ] Monitor keyword rankings for target keywords
- [ ] Check that redirects are being resolved (old URLs dropping from index, new URLs appearing)
- [ ] Address any crawl errors or CWV issues identified in Week 1
- [ ] Conduct a mini audit focusing on any pages with unexpected traffic drops

---

## 4. A/B Testing SEO Changes Safely

### Split URL Testing
When testing significant SEO changes (title tag patterns, content structure, schema additions):

- Use a controlled set of pages (test group) and a comparable set of pages (control group)
- Ensure both groups are large enough for statistical significance (minimum 50 pages per group, ideally 200+)
- Change only one variable at a time (e.g., title tag pattern, not title tag and content simultaneously)
- Measure organic traffic, impressions, CTR, and average position for both groups
- Run the test for a minimum of 4 weeks to account for ranking fluctuation
- Use GSC Performance data filtered by page group for analysis

### Server Side Rendering Differences
If testing SSR vs client side rendering:
- Serve consistent content to users and crawlers (do not cloak)
- Test on a subset of pages before rolling out sitewide
- Monitor indexing behavior (are SSR pages indexed faster or more completely?)
- Compare CWV metrics between SSR and CSR page groups

### SEO Testing Best Practices
- Never test by cloaking (serving different content to Googlebot vs users)
- Document the test hypothesis, methodology, start date, and end date before beginning
- If a test causes a significant negative impact (over 15% traffic decline in the test group), roll back immediately
- After a successful test, roll out the winning variation to all pages and monitor for 4 more weeks

---

## 5. Staging Environment SEO Verification Protocol

### Staging Environment Configuration
- Staging must be blocked from search engine indexing (use robots.txt disallow all, or HTTP authentication, or both)
- Staging URLs should not be in the XML sitemap
- Internal links on staging should use relative URLs or staging domain URLs (not production URLs)
- Staging should mirror the production environment as closely as possible (same CMS version, same plugins/extensions, same server configuration)

### SEO Verification on Staging
Before any deployment to production, verify the following on staging:

#### Crawl Comparison
1. Crawl staging with Screaming Frog
2. Export key metrics: URLs found, status codes, title tags, meta descriptions, canonical tags, H1 tags, word count
3. Compare to the most recent production crawl
4. Flag any pages where meta tags, canonical URLs, or status codes differ unexpectedly

#### Template Verification
For each page template (homepage, category, product, blog post, service page, location page):
- View the rendered HTML source
- Verify title tag, meta description, canonical URL, meta robots, and structured data
- Check heading hierarchy (H1, H2, H3)
- Verify internal links are functional
- Confirm breadcrumbs are correct

#### Performance Check
- Run Lighthouse on representative pages from each template
- Compare scores to production baseline
- Flag any CWV regressions before deployment

---

## 6. Git Workflow for SEO Changes

### Branch Naming Convention
Use a consistent branch naming pattern for SEO related changes:
```
seo/[ticket-number]-[brief-description]
```
Examples:
```
seo/1234-add-product-schema
seo/1235-fix-canonical-tags
seo/1236-redirect-map-migration
seo/1237-meta-description-template
```

### Pull Request Template for SEO Changes
```markdown
## SEO Change Description
[Brief description of what SEO element is being changed]

## Pages/Templates Affected
[List of page templates or specific URLs affected]

## SEO Impact
[1-2 sentences on why this change matters for organic search]

## Acceptance Criteria
- [ ] [Specific, testable criterion 1]
- [ ] [Specific, testable criterion 2]
- [ ] [Specific, testable criterion 3]

## Testing Steps
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Validation
- [ ] HTML validated (no tag errors)
- [ ] Schema validated in Rich Results Test
- [ ] Lighthouse run completed (no CWV regression)
- [ ] Staging crawl compared to production
- [ ] Mobile rendering verified

## Rollback Plan
[How to revert this change if issues are discovered post deployment]
```

### Review Requirements
- All SEO related PRs must be reviewed by at least one person with SEO knowledge
- SEO team should be tagged as reviewers on any PR that modifies: meta tags, canonical tags, robots directives, structured data, URL structure, redirects, sitemap generation, or rendering behavior
- Automated checks (if available) should validate structured data and meta tag presence

---

## 7. Common Developer Mistakes That Hurt SEO

### Client Side Rendering Without Prerendering
**The mistake**: Relying entirely on JavaScript to render page content without a prerendering or SSR solution.
**Why it hurts**: Search engines may not see the content, or may see it with significant delay. Critical for SPA frameworks (React, Vue, Angular, Backbone.js).
**The fix**: Implement prerendering (Prerender.io, Rendertron) or SSR (Next.js, Nuxt.js). Reference netsuite-seo-architecture.md for NetSuite specific guidance.
**Detection**: View the page source (not inspect element). If the content is missing from the source, it is JavaScript dependent.

### JavaScript Dependent Content
**The mistake**: Critical SEO content (product descriptions, category text, meta tags, headings) loaded via JavaScript after page load.
**Why it hurts**: Googlebot may not render the JavaScript correctly or may not re render after content changes.
**The fix**: Serve critical content in the initial HTML response. Use progressive enhancement: HTML first, then enhance with JavaScript.
**Detection**: Disable JavaScript in Chrome DevTools and reload the page. If critical content disappears, it is JavaScript dependent.

### Improper Canonical Usage
**The mistake**: Setting canonical URLs incorrectly, such as canonicalizing all pages to the homepage, setting canonical to HTTP instead of HTTPS, or canonicalizing paginated pages to each other in a loop.
**Why it hurts**: Tells search engines to ignore the target page in favor of the wrong page, causing deindexing of important content.
**The fix**: Every indexable page should have a self referencing canonical. Filtered/paginated pages should canonical to the clean base URL. Audit canonical tags in every code review.
**Detection**: Crawl the site with Screaming Frog and review the canonical tag report.

### Redirect Loops and Chains
**The mistake**: Creating redirect chains (A to B to C to D) or loops (A to B to A) when implementing URL changes.
**Why it hurts**: Redirect chains dilute PageRank with each hop and slow down crawling. Loops prevent the page from loading at all.
**The fix**: Always redirect directly to the final destination URL. When adding new redirects, check if the source URL is already a redirect target. Maintain a centralized redirect map.
**Detection**: Test redirects using curl with the follow redirects flag: `curl -IL [url]`. Check for chains longer than 2 hops.

### Accidental Noindex on Production
**The mistake**: Deploying a staging robots meta tag (`<meta name="robots" content="noindex">`) or robots.txt disallow to production.
**Why it hurts**: Causes rapid deindexing of the entire site or affected pages. Can take weeks to recover.
**The fix**: Include a deployment checklist item that explicitly verifies robots.txt and meta robots tags on production after every deployment. Use environment variables to control robots directives (staging = noindex, production = index).
**Detection**: Check robots.txt immediately after deployment. Search `site:domain.com` in Google within 24 hours of deployment.

### Removing Pages Without Redirects
**The mistake**: Deleting pages or changing URLs without implementing 301 redirects from the old URLs.
**Why it hurts**: Existing backlinks and bookmarks now point to 404 pages. All accumulated link equity and ranking signals are lost.
**The fix**: Before removing or renaming any URL, check its backlink profile and organic traffic. Implement 301 redirects to the most relevant replacement page.
**Detection**: Monitor GSC for new 404 errors. Run a broken link check after any URL changes.

### Blocking CSS and JavaScript in robots.txt
**The mistake**: Adding robots.txt rules that block Googlebot from accessing CSS or JavaScript files.
**Why it hurts**: Googlebot cannot render the page properly, leading to incorrect content assessment and potentially poor mobile usability evaluation.
**The fix**: Allow crawling of all CSS and JS resources. Only block files that contain no rendering related code and are truly unnecessary for page display.
**Detection**: Use GSC URL Inspection tool to see how Google renders the page. Compare the rendered screenshot to the actual page.

### Session IDs and Tracking Parameters in Crawlable URLs
**The mistake**: Including session IDs, user tracking parameters, or sort/filter parameters in URLs without canonical tags or parameter handling.
**Why it hurts**: Creates massive duplicate content. A single page can appear as thousands of unique URLs to search engines, wasting crawl budget.
**The fix**: Use cookies instead of URL parameters for session tracking. Implement canonical tags on all parameterized URLs pointing to the clean version. Configure parameter handling in GSC.
**Detection**: Crawl the site and check for URLs with session or tracking parameters. Review GSC Index Coverage for unexpectedly high page counts.

### Infinite Scroll Without Pagination URLs
**The mistake**: Implementing infinite scroll that loads content via JavaScript without corresponding paginated URLs.
**Why it hurts**: Search engines cannot discover content beyond the initial load. Products or articles loaded via infinite scroll are invisible to crawlers.
**The fix**: Implement "load more" with corresponding paginated URLs (`?page=2`, `?page=3`). Include paginated URLs in the sitemap. Ensure each paginated page has proper canonical and pagination markup.
**Detection**: View page source and check if all products/content items are present. If only the first batch appears, infinite scroll content is JavaScript dependent.

---

## 8. Emergency SEO Issue Response

### Severity Levels

| Severity | Definition                                          | Response Time |
|----------|------------------------------------------------------|---------------|
| P0       | Entire site deindexed or blocked from crawling       | Immediate (within 1 hour) |
| P1       | Major section of site affected (e.g., all product pages noindexed) | Within 4 hours |
| P2       | Individual important pages affected                  | Within 24 hours |
| P3       | Minor issues with limited SEO impact                 | Within 1 week |

### P0 Response Protocol
1. Verify the issue (check robots.txt, meta robots, GSC for manual actions)
2. Identify the root cause (recent deployment, configuration change, server issue)
3. Roll back the offending change immediately
4. Verify the fix is live (check robots.txt, meta robots on production)
5. Request recrawl of affected URLs via GSC URL Inspection
6. Monitor GSC Index Coverage daily for 2 weeks
7. Document the incident: root cause, timeline, impact, resolution, prevention measures
