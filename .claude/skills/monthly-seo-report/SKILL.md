---
name: monthly-seo-report
description: >
  Use when someone asks to generate a monthly report, SEO report, monthly SEO performance
  report, or client reporting deliverable. Trigger on: "monthly report", "SEO report",
  "monthly SEO", "performance report", "generate the monthly report", "client report",
  "monthly performance review", "organic performance report", "end of month report",
  "pull the monthly numbers". This is the full monthly SEO reporting workflow that pulls
  GSC performance data, analyzes ranking and traffic trends, reviews index coverage,
  checks Core Web Vitals status, and compiles a client ready report.
disable-model-invocation: true
argument-hint: "[client-name] [month-year]"
allowed-tools: Read, Glob, Grep, Bash, WebFetch, WebSearch, Agent, Write
---

# Monthly SEO Report

Monthly SEO reporting workflow that pulls Google Search Console performance data, analyzes ranking and traffic trends, reviews index coverage, checks Core Web Vitals status, and compiles a client ready report.

## Context

This command orchestrates the full monthly SEO reporting workflow for any OFM client. It follows the reporting structure defined in `.claude/frameworks/seo-reporting.md` and produces a draft report for Michael's review before client delivery. This is run at the end of each month or in the first few days of the following month.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Reporting period: month and year (required, e.g., "February 2026")
- Any significant events during the month (optional, e.g., "site migration completed," "new blog section launched," "Google core update rolled out")

## Instructions

### Step 0: Initialize Report Tracking

Use TaskCreate to set up the reporting task list:
- Create a parent task: "[Client] Monthly SEO Report [Month Year]" with description of scope
- Create subtasks: GSC Data Pull, Ranking Analysis, Index Coverage, CWV Status, Content Review, Report Compilation, Michael Review
- Update each task status as you progress through phases

### Step 1: Pull GSC Performance Data

Navigate to Google Search Console via Chrome or use GSC data sources for the client's property.

Pull the following performance data for the reporting month:

**Queries Report:** Top queries by clicks, impressions, CTR, and average position. Compare to the previous month and same month last year. Identify queries with significant position changes (up or down 5+ positions). Flag new queries appearing in the top 50 for the first time.

**Pages Report:** Top pages by clicks, impressions, CTR, and average position. Identify pages with traffic gains and losses. Flag pages that dropped out of the top 100.

**Countries Report:** Performance breakdown by country for international clients.

**Devices Report:** Performance split across desktop, mobile, and tablet. Note any device specific trends.

Save raw performance data to `clients/{client-name}/reports/{year-month}-raw-data/`

### Step 2: Analyze Ranking Changes and Traffic Trends

Process the GSC data to identify meaningful trends:

1. Calculate month over month change in total clicks, impressions, CTR, and average position
2. Calculate year over year change for the same metrics if historical data is available
3. Identify the top 10 queries that gained the most clicks
4. Identify the top 10 queries that lost the most clicks
5. Identify pages with the largest ranking improvements and declines
6. Check for any correlation between ranking changes and known algorithm updates during the month
7. Calculate organic conversion data from GA4 (sessions, goal completions, revenue from organic)

### Step 3: Review Index Coverage Changes

Check Google Search Console index coverage for the reporting month:

1. Note total indexed pages and change from prior month
2. Identify new indexing errors (Server error, Redirect error, Blocked by robots.txt, Soft 404, Not found)
3. Review pages in "Discovered, currently not indexed" and "Crawled, currently not indexed" status
4. Check for any new excluded pages and the exclusion reasons
5. Verify sitemap submission status and processing
6. Flag any sudden changes in indexed page count that could indicate a problem

### Step 4: Check Core Web Vitals Status

Review the CWV report in Google Search Console:

1. Note the current pass/fail status for mobile and desktop
2. Identify any URLs that moved from "Good" to "Needs Improvement" or "Poor"
3. Compare LCP, INP, and CLS distributions to the prior month
4. Flag any CWV regressions that need investigation
5. Cross reference with any site changes made during the month that could have impacted performance

### Step 5: Competitive Position Update

Deploy the Competitor Intelligence agent for a lightweight competitive check:

- Read `.claude/agents/competitor-intelligence.md` for methodology
- Check for significant ranking changes among known competitors
- Note any new competitors appearing for core keyword targets
- Identify any SERP feature changes (new featured snippets won or lost, AI Overview changes)
- Check share of voice trend for the target keyword set

Also deploy the Search Console Analyst agent:

- Read `.claude/agents/search-console-analyst.md` for methodology
- Run anomaly detection across all GSC data
- Flag any patterns that warrant deeper investigation

### Step 6: Compile Monthly Report

Assemble findings into the monthly SEO report following the template in `.claude/frameworks/seo-reporting.md`:

1. **Performance Summary** with key metrics scorecard showing current month, prior month, MoM change, and YoY change where available. Use green/yellow/red status indicators against targets.
2. **Traffic and Ranking Trends** with visualization descriptions of click and impression trends. Highlight the most significant query and page movements.
3. **Index Coverage Update** with any new issues and their resolution status.
4. **Core Web Vitals Status** with current pass/fail and any regressions.
5. **Key Wins** with specific accomplishments for the month (rankings gained, traffic milestones, new featured snippets captured).
6. **Issues and Concerns** with honest assessment of any negative trends, their likely causes, and recommended responses.
7. **Competitive Landscape** with brief update on competitive position changes.
8. **Next Month Priorities** with 3 to 5 specific recommendations based on the data.
9. **Action Items** listing all open tasks with owners and target dates.

Save the draft report to `clients/{client-name}/reports/{year-month}-monthly-seo-report-DRAFT.md`

Update `clients/{client-name}/open-items.md` with new action items.

Update `clients/{client-name}/history.md` with a session summary noting the monthly report was generated.

Present the draft to Michael with a brief summary: "Monthly SEO report for [Client Name] for [Month Year] is ready for review. Key highlights: [top 2 to 3 points]. Draft saved to [path]."

## Output

The final deliverable is a draft monthly SEO performance report saved to the client's reports directory, ready for Michael's review and approval before being finalized as a Word document for the client. The report covers organic performance metrics, ranking trends, index health, CWV status, competitive position, and prioritized next steps.

## Dependencies

- Requires Chrome browser access to navigate Google Search Console and GA4
- Requires the SEO reporting framework at .claude/frameworks/seo-reporting.md
- Requires an existing client profile at clients/{client-name}/
