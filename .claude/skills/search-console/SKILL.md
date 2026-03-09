---
name: search-console
description: "Google Search Console analysis and anomaly detection. Use when analyzing GSC data, investigating index coverage, or diagnosing ranking changes. Trigger on: Search Console, GSC, index coverage, URL inspection, search performance, impressions, clicks, CTR, ranking drop."
allowed-tools: Read, Glob, Grep, Bash, WebSearch, mcp__google-search-console__, mcp__google-analytics__
argument-hint: "[domain or property]"
---

# Google Search Console Data Analysis

## MCP Tools Available

Use these MCP tools for direct GSC API access (load via ToolSearch first):
- `mcp__google-search-console__list_sites`: List all verified properties
- `mcp__google-search-console__search_analytics`: Pull performance data (clicks, impressions, CTR, position)
- `mcp__google-search-console__enhanced_search_analytics`: Advanced query with filters and dimensions
- `mcp__google-search-console__detect_quick_wins`: Find striking distance keywords automatically
- `mcp__google-search-console__index_inspect`: Check URL indexing status
- `mcp__google-search-console__list_sitemaps` / `mcp__google-search-console__get_sitemap`: Sitemap status
- `mcp__google-search-console__submit_sitemap`: Submit sitemap (requires Michael's approval)

For cross referencing with traffic data, use `mcp__google-analytics__run_report` and `mcp__google-analytics__get_property_details`.

## Performance Report Analysis

### Query Analysis

**Key metrics**: Clicks, Impressions, CTR, Average Position

**Standard analysis workflow**:
1. Set date range to last 28 days, compare to previous 28 days
2. Sort by impressions descending to find highest visibility queries
3. Identify queries with high impressions but low CTR (title/description optimization candidates)
4. Identify queries with high CTR but low impressions (content expansion candidates)
5. Look for queries with declining position (defensive content refresh needed)

**Query segmentation**:
- Brand vs non brand: Filter queries containing brand name to isolate organic performance
- Question queries: Filter for "how," "what," "why," "when," "where" to find informational traffic
- Transactional queries: Filter for "buy," "price," "cost," "order" to find conversion traffic

**Striking distance keywords** (position 5 to 15, high impressions):
1. Filter: Position > 5 AND Position < 15
2. Sort by impressions descending
3. These queries need content optimization, internal linking, or link building to push into top 5
4. Cross reference with the page ranking to determine optimization approach

### Page Analysis

1. Switch to "Pages" tab in Performance report
2. Sort by clicks descending to identify top performing pages
3. Look for pages with declining clicks (content refresh candidates)
4. Identify pages with high impressions but few clicks (CTR optimization priority)
5. Cross reference with query data: click a page to see which queries drive traffic to it

**Page health indicators**:
- Healthy: CTR > 3%, stable or growing clicks, position improving
- At risk: CTR declining, position slipping 2+ spots, clicks dropping
- Underperforming: High impressions, CTR < 1.5%, position 4 to 10

### Country and Device Segmentation

**Device analysis**:
1. Compare mobile vs desktop performance
2. If mobile CTR is significantly lower, investigate mobile UX issues
3. If mobile position is lower than desktop, check mobile friendliness and CWV

**Country analysis**:
1. Identify countries driving meaningful traffic
2. If a non target country shows high impressions, consider creating localized content
3. Compare position by country to spot geo specific ranking issues

## Click Through Rate Optimization

### Identifying CTR Anomalies

**Expected CTR by position** (organic, non brand):

| Position | Expected CTR Range |
|----------|-------------------|
| 1 | 25 to 35% |
| 2 | 12 to 18% |
| 3 | 8 to 12% |
| 4 | 5 to 8% |
| 5 | 4 to 6% |
| 6 to 10 | 1.5 to 4% |

**Finding anomalies**:
1. Export performance data with pages and queries
2. Calculate expected CTR based on average position
3. Flag any query where actual CTR is less than 50% of expected CTR
4. These are title tag and meta description optimization candidates

### Title Tag Testing Methodology

1. **Identify target**: Select pages with CTR below expected range for their position
2. **Record baseline**: Document current title, description, position, CTR, clicks for 30 days
3. **Write new title**: Apply proven CTR formulas:
   - Include the primary keyword near the beginning
   - Add a compelling modifier (Updated 2026, Complete Guide, Free Template)
   - Use numbers when applicable (7 Steps, 15 Best, 2026 Guide)
   - Create urgency or value proposition
4. **Implement and wait**: Allow 2 to 4 weeks for Google to recrawl and data to accumulate
5. **Measure**: Compare CTR in the same position range (position may shift, isolate CTR change)
6. **Iterate**: If CTR improved, move to next page. If not, try another variation.

**Title tag formula examples**:
```
[Primary Keyword]: [Number] [Benefit/Action] [Modifier]
Example: "Technical SEO Audit: 12 Critical Checks for 2026"

[How to/What is] [Primary Keyword] ([Year] [Qualifier])
Example: "How to Fix Core Web Vitals (2026 Complete Guide)"

[Number] [Primary Keyword] [Action] to [Outcome]
Example: "9 Page Speed Fixes to Double Your Mobile Score"
```

## Index Coverage Report

### Status Categories

**Valid**:
- "Submitted and indexed": Pages in your sitemap that Google has indexed. Ideal state.
- "Indexed, not submitted in sitemap": Pages Google found and indexed but are not in your sitemap. Add them to sitemap or evaluate if they should be noindexed.

**Warning**:
- "Indexed, though blocked by robots.txt": Google indexed the page despite robots.txt blocking. Either remove the robots.txt block or add a noindex meta tag (not both).

**Error**:
- "Server error (5xx)": Server returned error when Googlebot crawled. Fix server stability.
- "Redirect error": Redirect chain too long (3+ hops), redirect loop, or redirect to error page.
- "Submitted URL blocked by robots.txt": URL in sitemap is blocked by robots.txt. Contradiction that must be resolved.
- "Submitted URL marked 'noindex'": URL in sitemap has noindex. Remove from sitemap or remove noindex.
- "Submitted URL has crawl issue": Generic crawl failure. Use URL Inspection for details.
- "Submitted URL not found (404)": URL in sitemap returns 404. Remove from sitemap or restore the page.

**Excluded**:
- "Excluded by 'noindex' tag": Working as intended if deliberate.
- "Blocked by robots.txt": Working as intended if deliberate.
- "Crawled, currently not indexed": Google crawled the page but chose not to index it. Content quality, thin content, or duplicate content issue.
- "Discovered, currently not indexed": Google knows the URL exists but has not crawled it yet. Possible crawl budget issue.
- "Duplicate without user selected canonical": Google found duplicates and chose a canonical on its own.
- "Duplicate, Google chose different canonical than user": Your canonical tag disagrees with Google's choice. Investigate.
- "Page with redirect": URL redirects to another page. Expected for redirects.
- "Soft 404": Page returns 200 status but Google considers it a soft 404 (empty or near empty content).

### Diagnosing Common Issues

**"Crawled, currently not indexed" (most common problem)**:
1. Check content quality: Is the page thin (< 300 words of unique content)?
2. Check for duplicate content: Are similar pages already indexed?
3. Check internal linking: Is the page orphaned (no internal links pointing to it)?
4. Check page load time: Does the page load slowly, causing Googlebot to abandon?
5. Check crawl depth: Is the page more than 3 clicks from homepage?

**Resolution steps**:
- Improve content depth and uniqueness
- Add internal links from relevant, authoritative pages
- Consolidate thin pages into comprehensive resources
- Request indexing through URL Inspection after improvements

## URL Inspection Tool

### Usage for Debugging

1. Enter the full URL in the inspection bar
2. Review the following sections:

**Presence on Google**:
- Is the URL indexed? If not, why?
- Which canonical did Google select?
- When was it last crawled?

**Coverage**:
- Crawl status (success/failure)
- Indexing status (indexed/not indexed)
- Any specific crawl or indexing issues

**Enhancements**:
- Mobile usability status
- Structured data validity
- Any enhancement errors or warnings

**Live Test**:
- Click "Test Live URL" to have Google recrawl in real time
- Compare live result to cached result to verify fixes
- View rendered HTML and screenshot to check JavaScript rendering

### Requesting Indexing

1. Inspect the URL
2. If the page is not indexed or has been updated, click "Request Indexing"
3. Google will prioritize recrawling this URL
4. Limit: approximately 10 to 12 requests per day per property
5. Do not abuse. Use for important pages after significant updates only.

## Core Web Vitals Report

### Interpreting CWV Data in GSC

GSC groups URLs by "similar URL groups" (pages with similar structure):

**Status classifications**:
- Good: LCP < 2.5s, INP < 200ms, CLS < 0.1
- Needs Improvement: LCP 2.5 to 4s, INP 200 to 500ms, CLS 0.1 to 0.25
- Poor: LCP > 4s, INP > 500ms, CLS > 0.25

**Analysis workflow**:
1. Check both Mobile and Desktop tabs (mobile is more critical)
2. Click each issue to see affected URL groups
3. Click a URL group to see example URLs
4. Test representative URLs in PageSpeed Insights for detailed diagnostics
5. Fix issues on template level (affects all pages using that template)

### Correlating with PageSpeed Insights

GSC CWV data is based on the Chrome User Experience Report (CrUX), which is real user data over a rolling 28 day window. PageSpeed Insights shows both:
- **Lab data**: Simulated, immediate, useful for diagnosing specific issues
- **Field data**: Real user data from CrUX, the same source as GSC

When GSC shows "Poor" CWV but PageSpeed lab data looks fine:
- Real users on slow devices/networks are having a different experience
- Check the 75th percentile in field data (Google uses p75, not median)
- Test on throttled connections in DevTools to simulate real conditions

## Sitemap Monitoring

### Submission and Status

1. Navigate to Sitemaps in GSC
2. Submit your sitemap URL (usually `/sitemap.xml` or `/sitemap_index.xml`)
3. Check status: "Success" means Google read it. Does not guarantee indexing.

**Key metrics to monitor**:
- Discovered URLs: How many URLs Google found in the sitemap
- Indexed URLs: How many of those are actually indexed (compare to discovered)
- Last read date: When Google last fetched the sitemap

**Red flags**:
- Large gap between discovered and indexed (many pages not being indexed)
- "Has errors" status (malformed XML, HTTP errors)
- Sitemap not being read for 7+ days

### Sitemap Best Practices for Monitoring

- Keep sitemap under 50,000 URLs and 50 MB uncompressed
- Use sitemap index file if you need multiple sitemaps
- Include `<lastmod>` tags and keep them accurate (only update when content genuinely changes)
- Remove 404, noindexed, redirected, and non canonical URLs from the sitemap
- Verify sitemap is referenced in robots.txt: `Sitemap: https://example.com/sitemap.xml`

## Search Appearance

### Rich Results Tracking

GSC reports on rich result types your site generates:

- **FAQ**: Pages with FAQPage schema generating FAQ rich results
- **HowTo**: Pages with HowTo schema generating step by step results
- **Product**: Product pages with Product schema generating product snippets
- **Review snippet**: Pages with review/rating schema generating star ratings
- **Breadcrumb**: Pages with BreadcrumbList schema generating breadcrumb display
- **Sitelinks searchbox**: Site level search box in branded SERP results
- **Video**: Pages with VideoObject schema generating video thumbnails

**Monitoring workflow**:
1. Check each enhancement type for errors and warnings
2. Click errors to see affected pages
3. Fix schema issues and validate using the "Validate Fix" button
4. Track valid items count over time to ensure growth

## Anomaly Detection

### Traffic Drop Diagnosis

When organic traffic drops suddenly:

1. **Check date correlation**:
   - Does the drop align with a known Google algorithm update?
   - Did a site deployment happen on or near that date?
   - Is it seasonal (compare year over year)?

2. **Segment the drop**:
   - Brand vs non brand: Brand drops may indicate brand reputation issue
   - Device specific: Mobile only drop suggests CWV or mobile usability issue
   - Country specific: Single country drop may be geo specific issue
   - Query specific: One topic dropping suggests content or SERP change
   - Page specific: Single page drop vs sitewide

3. **Check for technical issues**:
   - Index coverage: Any new errors or spikes in "Crawled, not indexed"?
   - Manual actions: Any new manual actions under Security & Manual Actions?
   - CWV: Any new CWV regressions?
   - Robots.txt: Was robots.txt accidentally changed?
   - Noindex: Were noindex tags accidentally added?

4. **Check SERP changes**:
   - Search the affected keywords manually
   - Has a new SERP feature (AI Overview, featured snippet) appeared, pushing organic results down?
   - Have new competitors entered the SERP?

### Ranking Shift Detection

Monitor for significant position changes:
- Filter Performance report by date comparison
- Sort queries by position change (biggest drops first)
- For each significant drop, investigate the landing page:
  - Has the content been changed recently?
  - Have backlinks been lost?
  - Has a competitor published superior content?
  - Has the search intent shifted (SERP now shows different content types)?

### CWV Regression Detection

1. Set up email alerts in GSC for CWV issues
2. Weekly check: Compare current CWV status to previous week
3. If URLs move from "Good" to "Needs Improvement" or "Poor":
   - Identify the template/page type affected
   - Check recent deployments for performance regressions
   - Run PageSpeed Insights on affected URLs
   - Correlate with real user monitoring (RUM) data if available

## GSC API

For Python code examples, query patterns, available dimensions, and date range limits, see:
`$CLAUDE_SKILL_DIR/references/gsc-api-examples.md`

## Manual Actions and Security Issues

### Identification

1. Navigate to Security & Manual Actions in GSC
2. Check "Manual actions" for any penalties
3. Check "Security issues" for malware, hacked content, or deceptive pages

### Common Manual Actions

- **Unnatural links to your site**: Backlink spam or paid links detected
- **Thin content with little or no added value**: Doorway pages, scraped content
- **User generated spam**: Forum/comment spam not being moderated
- **Spammy structured markup**: Schema that does not match page content
- **Cloaking/sneaky redirects**: Showing different content to Googlebot vs users

### Resolution Process

1. Identify all affected pages listed in the manual action notice
2. Fix the underlying issue on every affected page
3. Document all changes made
4. Submit a reconsideration request with detailed explanation of:
   - What caused the issue
   - What steps were taken to fix it
   - What preventive measures are in place
5. Wait 2 to 4 weeks for Google's review
6. If rejected, review their feedback, make additional fixes, and resubmit
