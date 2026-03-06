---
name: quarterly-seo-review
description: >
  Use when someone asks for a quarterly review, QBR, quarterly SEO strategy review, or
  quarter review. Trigger on: "quarterly review", "QBR", "quarterly SEO", "quarter review",
  "Q1 review", "Q2 review", "Q3 review", "Q4 review", "quarterly strategy",
  "quarterly business review", "90 day SEO review", "quarterly performance review",
  "end of quarter report". This is the most strategic SEO deliverable, combining 90 days of
  performance data with technical health assessment, content performance analysis, link profile
  changes, competitive landscape shifts, and forward looking strategy planning.
disable-model-invocation: true
argument-hint: "[client-name] [quarter: Q1/Q2/Q3/Q4] [year]"
allowed-tools: Read, Glob, Grep, Bash, WebFetch, WebSearch, Agent, Write
---

# Quarterly SEO Strategy Review

Comprehensive quarterly strategy review combining 90 days of performance data with technical health assessment, content performance analysis, link profile changes, competitive landscape shifts, and forward looking strategy planning.

## Context

The user wants a full quarterly SEO review for a specific client. This is the most strategic SEO deliverable OFM produces, aggregating monthly performance data into trend analysis, assessing the overall health of the organic search program, and producing a detailed strategy for the upcoming quarter. This workflow orchestrates all relevant specialist agents to produce a client facing quarterly review document.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Quarter being reviewed (required, e.g., "Q1" or "Q4")
- Year (required, e.g., "2026")
- Significant events during the quarter (optional, e.g., "site migration in February," "Google core update in March," "launched new product line")
- Budget or resource constraints for next quarter (optional, helps inform realistic planning)

## Instructions

### Step 0: Initialize Review Tracking

Use TaskCreate to set up the review task list:
- Create a parent task: "[Client] Q[X] [Year] SEO Strategy Review" with description of scope
- Create subtasks: Monthly Aggregation, Trend Analysis, Technical Health, Content Performance, Link Profile, Competitive Shifts, Strategy Planning, Report Compilation, Michael Review
- Update each task status as you progress through phases

### Step 1: Aggregate Monthly Reports

Read the three monthly reports from the quarter:

1. Load all monthly SEO reports from `clients/{client-name}/reports/` for the quarter period
2. Read the client's full `history.md` to understand everything that happened during the quarter
3. Read `open-items.md` to check which action items from each month were completed vs outstanding
4. Read any previous quarterly reviews to track long term trends
5. Compile aggregate metrics: total clicks, impressions, average CTR, average position across the full quarter
6. Calculate quarter over quarter and year over year comparisons

### Step 2: Mini Technical Audit

Deploy the Technical SEO Auditor for a focused health check on new issues:

- Read `.claude/agents/technical-seo-auditor.md` for methodology
- Check for new crawl errors or indexation issues that emerged during the quarter
- Verify that technical fixes implemented during the quarter are holding
- Check robots.txt and sitemap for any changes or issues
- Run a quick rendering check on key page templates
- Review GSC index coverage report for quarter over quarter trend
- Flag any new technical debt accumulated during the quarter

### Step 3: Content Performance Review

Deploy the Content Strategist for a content effectiveness assessment:

- Read `.claude/agents/content-strategist.md` for methodology
- Evaluate the performance of content published during the quarter (rankings achieved, traffic generated)
- Identify the highest and lowest performing content pieces
- Assess whether the content strategy is building topical authority
- Review content freshness across the site (content aging without updates)
- Check for new content cannibalization issues
- Evaluate progress on content gap closure from previous recommendations

### Step 4: Link Profile Changes

Deploy the Link Strategist for a link profile trend analysis:

- Read `.claude/agents/link-strategist.md` for methodology
- Compare referring domain count at quarter start vs quarter end
- Identify significant new backlinks acquired during the quarter
- Check for any toxic or spammy links that appeared
- Assess internal linking improvements implemented during the quarter
- Compare link velocity to competitors
- Evaluate the effectiveness of any link building activities conducted

### Step 5: Competitive Landscape Shifts

Deploy the Competitor Intelligence agent for a competitive position assessment:

- Read `.claude/agents/competitor-intelligence.md` for methodology
- Compare share of voice at quarter start vs quarter end
- Identify competitors that gained or lost significant ground
- Check for new competitors entering the space
- Note any competitor content, technical, or link building initiatives observed
- Assess SERP feature ownership changes (featured snippets, AI Overviews, knowledge panels)
- Evaluate AI search visibility changes for both the client and key competitors

### Step 6: Strategy Adjustment Recommendations

Based on findings from Steps 1 through 5, develop strategic recommendations:

**What Worked:** Identify the top 3 to 5 wins for the quarter with specific data. Tie each win to the action that created it. Recommend how to protect and build on these gains.

**What Did Not Work:** Honest assessment of strategies or actions that underperformed expectations. Analyze why and recommend whether to adjust, persist, or abandon.

**Emerging Opportunities:** Identify new opportunities discovered during the quarter (new keyword targets, content format opportunities, technical improvements, competitive weaknesses to exploit).

**Risk Assessment:** Flag any risks to organic performance (algorithm update vulnerability, technical debt accumulation, competitive threats, content aging).

### Step 7: Next Quarter Planning

Produce a detailed plan for the upcoming quarter:

1. **Technical SEO Priorities:** Critical fixes, performance improvements, and infrastructure upgrades
2. **Content Strategy:** Topics to create, content to refresh, pages to consolidate or remove
3. **Link Building Plan:** Target domains, outreach strategies, internal linking improvements
4. **AEO and AI Search Initiatives:** Actions to improve AI search visibility and citation rate
5. **Schema and Structured Data:** New markup opportunities, existing markup improvements
6. **Monitoring and Reporting:** KPIs to track, alerts to configure, reporting cadence
7. **Resource Requirements:** Estimated hours by activity type, any external vendor needs
8. **Quarterly Targets:** Specific, measurable goals for clicks, impressions, rankings, and conversions

### Step 8: Produce Quarterly Review Document

Compile all findings into a client facing quarterly review document:

1. **Executive Summary (1 page):** Overall quarter assessment in plain language. Lead with results vs targets. Highlight top 3 wins and top 3 priorities for next quarter.
2. **Performance Dashboard:** Organic metrics scorecard with green/yellow/red status vs targets. Quarter over quarter and year over year comparisons. Month by month trend within the quarter.
3. **Technical Health Update:** Current state of technical SEO with issues addressed and any new concerns.
4. **Content Performance:** Content strategy results, top performing content, and content roadmap progress.
5. **Link Profile Update:** Backlink growth, quality trends, and link building activity results.
6. **Competitive Position:** Share of voice changes, competitive gap closure, and market position trend.
7. **AI Search Visibility:** AEO progress, AI citation trends, and entity authority development.
8. **What Worked and What We Learned:** Honest assessment with data driven insights.
9. **Next Quarter Strategy:** Detailed plan with priorities, targets, and resource requirements.
10. **Appendix:** Raw data tables, ranking snapshots, index coverage data, and supporting analysis.

Save the draft report to `clients/{client-name}/reports/{year}-Q{quarter}-quarterly-seo-review-DRAFT.md`

Update `clients/{client-name}/open-items.md` with all action items for the upcoming quarter.

Update `clients/{client-name}/history.md` with a session summary noting the quarterly review was completed.

Present the draft to Michael with a brief summary: "Quarterly SEO review for [Client Name] for [Quarter Year] is ready for review. Key highlights: [top 3 points]. Draft saved to [path]."

## Output

The final deliverable is a comprehensive client facing quarterly SEO strategy review document saved to the client's reports directory, ready for Michael's review and approval before being finalized as a Word document. The document includes an executive summary, performance dashboard, technical health assessment, content and link profile updates, competitive positioning, AI search visibility progress, and a complete strategy for the upcoming quarter with specific targets and resource requirements.

## Dependencies

- Requires Chrome browser access to navigate GSC, GA4, and other platforms
- Requires the SEO reporting framework at .claude/frameworks/seo-reporting.md
- Requires an existing client profile at clients/{client-name}/ with at least one quarter of monthly reports
- Requires all specialist agents in .claude/agents/ for parallel deployment
