# Verification Comment Rules

## Standing Order (non negotiable, automatic)

Whenever a task or subtask is verified, validated, confirmed, checked, QA'd, tested, or proven complete through any available tool (MCP APIs, Chrome browser, direct API calls, file inspection, etc.), you MUST add an Asana comment to that subtask documenting the verification.

## What the Comment Must Include

1. **What was verified:** Clear statement of what the task required and what was checked
2. **How it was verified:** Which specific tool, MCP call, API endpoint, Chrome page, or inspection method was used
3. **Proof and evidence:** Concrete data points, status values, response codes, configuration values, or observed results that confirm correctness
4. **Confidence statement:** "Verified 100%" or explain any caveats if partial verification

## Example Comment Format

```
VERIFICATION: [Task Description]

Method: Used mcp__google-search-console__search_analytics to query ranking data for verocious.com
Evidence: 47 queries returned, top query "verocious motorsports" at position 1.2, 1,240 impressions last 28 days, CTR 32%
Result: Verified 100%. Search visibility confirmed active and healthy.
```

## When This Applies

This applies to ANY task where verification is requested or performed, including but not limited to:
- Technical SEO audit findings (crawl status, index coverage, canonical validation)
- Core Web Vitals verification (LCP, INP, CLS measurements against thresholds)
- Schema markup validation (rich results eligibility, structured data integrity)
- Tracking implementation checks (GTM tags firing, GA4 events registering)
- Content optimization verification (meta tags correct, headings structured, content live)
- Redirect chain resolution (chain collapsed, final destination returns 200)
- NetSuite/SuiteCommerce configuration checks (prerender active, seoSupport flag, theme settings)
- Asana board structure or task organization checks

## Tools Available for Verification

- Google Search Console MCP: search performance, index coverage, URL inspection, CWV data
- Semrush MCP: position tracking, site audit findings, backlink data, keyword rankings
- PageSpeed Insights MCP: CWV field data, performance scores, optimization suggestions
- Lighthouse MCP: lab data audits, accessibility, SEO score, best practices
- Google Analytics MCP: traffic data, event verification, conversion counts
- Google Ads MCP: campaign data, conversion tracking status
- Asana MCP: task status, subtask completion, project structure
- Chrome Browser: live page inspection, GTM preview, DevTools network/console, visual verification
- Chrome DevTools MCP: DOM inspection, performance traces, network requests, JavaScript evaluation

## This is Automatic

Do not wait to be asked. If you verify something, you comment it. Michael should never have to remind you.
