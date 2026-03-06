# SEO Reporting Structure and KPIs

## Purpose
This framework defines the standard structure, KPIs, data sources, and cadence for SEO reporting. It ensures consistent, actionable reporting that connects SEO activities to business outcomes. All reporting skills and agents reference this document.

---

## 1. Monthly SEO Reporting Structure

Every monthly SEO report follows this six section template:

### Section 1: Executive Summary
- 3 to 5 bullet point overview of the month's performance
- Highlight wins, setbacks, and key actions taken
- State the overall organic health status: On Track, Needs Attention, or At Risk
- Written for non technical stakeholders in clear, jargon free language

### Section 2: KPI Dashboard
- Visual dashboard showing all core KPIs (Section 2 definitions below)
- Month over month and year over year comparison for each KPI
- Trend arrows (up, down, flat) with percentage change
- Color coding: Green (improved or on target), Yellow (flat or slightly declining), Red (significant decline or off target)

### Section 3: Traffic and Ranking Analysis
- Organic sessions by device (mobile, desktop, tablet)
- Top 10 landing pages by organic sessions
- Keyword ranking distribution changes (top 3, top 10, top 20)
- New keywords entering the top 100
- Keywords that dropped out of the top 100
- Notable SERP feature changes (gained or lost featured snippets, PAA appearances)

### Section 4: Technical Health Summary
- Core Web Vitals status from GSC (pages passing Good threshold)
- Crawl errors and index coverage changes
- New technical issues identified and their priority tier (reference seo-audit-methodology.md)
- Status of previously identified technical issues (open, in progress, resolved)

### Section 5: Content and Link Activity
- Content published or updated this month
- Link building activity: outreach volume, links earned, average DR of linking domains
- Internal linking changes implemented
- Content performance: new content organic traffic within first 30 days

### Section 6: Action Items and Next Month Plan
- Prioritized list of actions for the coming month
- Status update on previous month's action items
- Upcoming content calendar highlights
- Any upcoming technical changes or site updates that may affect SEO

---

## 2. KPI Definitions

### Primary KPIs

#### Organic Sessions
- **Definition**: Total sessions from organic search traffic as reported by GA4
- **Source**: GA4 > Traffic Acquisition > Session source/medium = organic
- **Segments**: By device type, by landing page group, by geography
- **Cadence**: Monthly, with weekly monitoring

#### Keyword Rankings
- **Top 3 keywords**: Count of tracked keywords ranking in positions 1 through 3
- **Top 10 keywords**: Count of tracked keywords ranking in positions 1 through 10
- **Top 20 keywords**: Count of tracked keywords ranking in positions 1 through 20
- **Source**: Semrush Position Tracking or equivalent rank tracker
- **Cadence**: Weekly tracking, monthly reporting

#### Organic Visibility Score
- **Definition**: A composite score representing the overall organic search presence, accounting for keyword rankings weighted by search volume
- **Calculation**: Sum of (search volume x CTR estimate for each ranking position) across all tracked keywords
- **Source**: Semrush Visibility Index or custom calculation
- **Cadence**: Monthly

#### Organic Conversions
- **Definition**: Goal completions or key events attributed to organic search traffic
- **Source**: GA4 > Conversions filtered by organic traffic
- **Types**: Form submissions, phone calls, purchases, signups, downloads
- **Cadence**: Monthly

#### Organic Revenue
- **Definition**: Revenue directly attributed to organic search sessions (for ecommerce) or estimated value of organic leads (for lead generation)
- **Source**: GA4 ecommerce data filtered by organic, or CRM data tied to organic source
- **Cadence**: Monthly

### Secondary KPIs

#### Click Through Rate (CTR)
- **Definition**: Organic clicks divided by impressions, as reported by GSC
- **Segments**: By query group, by page, by device
- **Benchmark**: Varies by position (see vertical-seo-benchmarks.md for CTR by position data)

#### Impressions
- **Definition**: Total organic search impressions from GSC
- **Interpretation**: A leading indicator; impression growth precedes traffic growth
- **Cadence**: Weekly monitoring, monthly reporting

#### Backlink Metrics
- **Referring domains**: Total number of unique domains linking to the site
- **New referring domains per month**: Net new domains acquired
- **Domain Rating/Authority**: Overall site authority score trend
- **Source**: Ahrefs or Semrush Backlink Analytics

#### Core Web Vitals Pass Rate
- **Definition**: Percentage of URLs passing CWV Good thresholds in GSC
- **Segments**: Mobile and desktop
- **Source**: GSC Core Web Vitals report
- **Cadence**: Monthly

#### Pages Indexed
- **Definition**: Total pages indexed as reported by GSC Index Coverage
- **Monitor**: Unexpected increases (index bloat) or decreases (deindexing issues)
- **Cadence**: Monthly

---

## 3. Trend Analysis Methodology

### Month over Month (MoM) Analysis
- Compare current month to the previous month for all KPIs
- Calculate absolute change and percentage change
- Flag any KPI with a decline greater than 10% for investigation
- Account for seasonal patterns and calendar differences (e.g., February has fewer days)

### Year over Year (YoY) Analysis
- Compare current month to the same month last year
- YoY is the more reliable trend indicator because it normalizes for seasonality
- Use YoY as the primary trend metric in executive reporting
- Flag any KPI with a YoY decline for investigation, regardless of MoM performance

### Rolling Averages
- Calculate 3 month and 6 month rolling averages for organic sessions and visibility
- Rolling averages smooth out short term volatility and reveal true trends
- Use rolling averages to set realistic growth targets
- Report both the current month value and the rolling average in dashboards

### Trend Investigation Framework
When a KPI declines unexpectedly:
1. Check for Google algorithm updates in the same timeframe (use Semrush Sensor, MozCast, or industry news)
2. Check for technical issues: crawl errors, server downtime, CWV regressions, accidental noindex
3. Check for content changes: pages removed, content modified, internal links broken
4. Check for competitor movements: new competitors ranking, competitor content improvements
5. Check for external factors: seasonal decline, industry news affecting search behavior

---

## 4. Competitive Benchmarking

### Share of Voice (SOV)
- **Definition**: The percentage of total organic visibility for a defined keyword set that belongs to your site vs competitors
- **Calculation**: Your visibility score / total visibility score of all tracked competitors
- **Source**: Semrush Position Tracking competitive landscape report
- **Target**: SOV should grow quarter over quarter
- **Reporting**: Include top 5 competitors in the monthly report

### Keyword Overlap Analysis
- Compare your keyword portfolio to top 3 competitors
- Identify keywords where competitors rank and you do not (competitor gap)
- Identify keywords where you rank and competitors do not (competitive advantage)
- Track gap closure month over month
- **Source**: Semrush Keyword Gap tool

### Domain Authority Trend
- Track your Domain Rating (Ahrefs) or Authority Score (Semrush) alongside competitors
- Report the trend over time, not just the current value
- Significant changes in competitor authority may signal new link building activity

### Competitive Content Analysis
- Track the number of new pages published by competitors monthly
- Identify new content topics competitors are targeting
- Monitor competitor SERP feature ownership (featured snippets, PAA)
- Report notable competitor content investments or campaigns

---

## 5. ROI Attribution for SEO

### Organic Traffic Value
- **Definition**: The estimated cost to acquire the same traffic through paid search (Google Ads)
- **Calculation**: Sum of (monthly organic clicks per keyword x estimated CPC for that keyword) across all ranking keywords
- **Source**: Semrush or Ahrefs traffic value metric
- **Use**: Demonstrates the equivalent paid media cost that organic search offsets

### Incremental Revenue
- **Definition**: Revenue attributable to organic traffic growth beyond the baseline
- **Calculation**: (Current month organic revenue) minus (baseline organic revenue from the same month last year, adjusted for natural growth)
- **Attribution model**: Use GA4's data driven attribution or last click attribution for organic
- **For lead generation**: Assign a lead value based on close rate and average deal size. Organic lead value = (organic leads x close rate x average deal value)

### Cost Per Acquisition (CPA) for Organic
- **Definition**: Total SEO investment (agency fees, tool costs, content costs, developer hours) divided by organic conversions
- **Calculation**: Total monthly SEO spend / organic conversions
- **Comparison**: Compare organic CPA to paid search CPA and other channel CPAs
- **Target**: Organic CPA should be lower than paid search CPA (typically 50% to 70% lower for mature SEO programs)

### ROI Calculation
```
SEO ROI = ((Organic Revenue - SEO Investment) / SEO Investment) x 100
```
- Report ROI on a rolling 12 month basis (SEO is a long term investment; monthly ROI fluctuates)
- Include both direct revenue and traffic value in the calculation for a complete picture
- Note: ROI for SEO often starts negative in months 1 through 6 and turns positive as rankings and traffic grow

---

## 6. Reporting Cadence

### Weekly Snapshot (Every Monday)
- Organic sessions for the past 7 days vs previous 7 days
- Keyword ranking changes (significant movers only: +/- 5 positions)
- Any critical technical alerts (server errors, crawl spikes, CWV failures)
- Action item status update
- **Format**: Email or Slack message, 5 to 10 bullet points
- **Audience**: SEO team, marketing manager

### Monthly Deep Dive (First Week of Each Month)
- Full report following the six section template (Section 1 of this document)
- Complete KPI dashboard with MoM and YoY trends
- Detailed traffic and ranking analysis
- Technical health review
- Content and link activity summary
- Action plan for the coming month
- **Format**: Slide deck or PDF report, 15 to 25 pages
- **Audience**: Marketing leadership, client stakeholders

### Quarterly Strategy Review (End of Each Quarter)
- Rolling 3 month and 6 month trend analysis
- Progress against annual SEO goals and targets
- Competitive landscape shifts
- Strategy adjustment recommendations based on performance data
- ROI analysis for the quarter
- Budget and resource allocation review
- Next quarter priorities and targets
- **Format**: Presentation with live walkthrough, 30 to 45 minutes
- **Audience**: Executive leadership, marketing leadership, client leadership

---

## 7. Data Sources and Configuration

### Google Search Console (GSC)
- **Data**: Queries, impressions, clicks, CTR, average position, index coverage, CWV, manual actions
- **Configuration**: Verify site ownership, submit XML sitemap, configure preferred domain
- **Access**: Ensure all reporting team members have read access
- **Limitations**: Data has a 2 to 3 day lag; historical data limited to 16 months

### Google Analytics 4 (GA4)
- **Data**: Organic sessions, engagement metrics, conversions, revenue, user behavior
- **Configuration**: Ensure proper organic traffic filtering, set up conversion events, configure ecommerce tracking if applicable
- **Custom reports**: Create an SEO landing page report and an organic conversion report
- **Limitations**: Sampling may occur on large data sets; use BigQuery export for full fidelity

### Semrush
- **Data**: Keyword rankings, visibility score, backlink profile, competitive analysis, site audit
- **Configuration**: Set up Position Tracking project with target keywords, configure competitive tracking
- **Reports**: Schedule automated weekly ranking reports and monthly visibility reports
- **Alternatives**: Ahrefs can be used for backlink analysis; Moz for DA tracking

### PageSpeed Insights / CrUX
- **Data**: Lab and field CWV metrics (LCP, INP, CLS, TTFB)
- **Configuration**: Use the PageSpeed Insights API for automated monitoring
- **Integration**: Pull CrUX data into the monthly report for CWV trend tracking
- **Reference**: cwv-remediation.md for interpretation and remediation

### Data Hygiene
- Audit tracking code quarterly to ensure no data gaps
- Verify GSC and GA4 data alignment (significant discrepancies indicate configuration issues)
- Document any tracking changes that may affect data continuity (e.g., GA4 migration, UTM changes)
- Maintain a data changelog noting any events that affect comparability (site launches, redesigns, tracking changes)
