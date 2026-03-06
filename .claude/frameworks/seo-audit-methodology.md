# SEO Audit Methodology

## Purpose
This document defines the master methodology for conducting comprehensive SEO audits. It establishes the standard audit sequence, scoring framework, priority classification, deliverable structure, and tooling requirements. All audit skills and agents reference this framework to ensure consistency across engagements.

---

## 1. Audit Sequence (8 Steps)

Audits follow a fixed order. Each step builds on findings from the previous step. Do not skip steps or reorder them.

### Step 1: Crawlability
- Verify robots.txt configuration and directives
- Check XML sitemap presence, validity, and completeness
- Identify crawl errors in Google Search Console (GSC)
- Assess crawl budget allocation and waste (parameter URLs, duplicate paths, soft 404s)
- Review server log files for bot activity patterns
- Check HTTP status codes for key pages
- **Agent**: technical-seo-agent handles this dimension
- **Tool commands**: `screaming-frog --crawl [domain]`, GSC > Settings > Crawl Stats, `curl -I [URL]` for header checks

### Step 2: Indexation
- Compare pages crawled vs pages indexed (GSC Index Coverage)
- Identify pages excluded from indexing and the reason codes
- Verify noindex directives are intentional
- Check for orphan pages (pages not linked internally)
- Review index bloat (low value pages consuming index quota)
- Validate canonical tag implementation
- **Agent**: technical-seo-agent handles this dimension
- **Tool commands**: GSC > Indexing > Pages, `site:[domain]` operator in Google, Screaming Frog > Directives report

### Step 3: Technical SEO
- Audit site architecture and URL structure
- Review HTTPS implementation and mixed content
- Evaluate redirect chains and loops (max 2 hops recommended)
- Check hreflang implementation for multilingual/multiregional sites
- Validate structured data (schema.org) using Google Rich Results Test
- Assess mobile friendliness and responsive design
- Review pagination implementation (rel=prev/next or load more patterns)
- **Agent**: technical-seo-agent handles this dimension
- **Tool commands**: Screaming Frog > Redirect Chains report, Chrome DevTools > Security panel, Google Rich Results Test URL, Screaming Frog > Structured Data > Validation

### Step 4: Content Analysis
- Evaluate title tags and meta descriptions (uniqueness, length, keyword inclusion)
- Assess heading hierarchy (H1 through H6 structure)
- Identify thin content pages (under 300 words with no unique value)
- Detect duplicate content (internal and cross domain)
- Review E-E-A-T signals: author bios, citations, credentials, transparency pages
- Evaluate content freshness and last updated dates
- **Agent**: content-seo-agent handles this dimension
- **Tool commands**: Semrush > Site Audit > Content issues, Screaming Frog > Page Titles/Meta Descriptions, Copyscape batch search

### Step 5: Link Profile
- Analyze backlink quality using Domain Rating, Trust Flow, and relevance
- Identify toxic or spammy backlinks
- Review anchor text distribution
- Assess internal linking structure and depth
- Identify broken internal and external links
- Compare backlink profile against top 3 competitors
- **Agent**: link-profile-agent handles this dimension
- **Tool commands**: Semrush > Backlink Audit > Start, Ahrefs > Site Explorer > Backlinks, Screaming Frog > Internal linking > All Inlinks

### Step 6: User Experience (UX) and Core Web Vitals
- Measure LCP, INP, and CLS (lab and field data)
- Evaluate mobile usability issues from GSC
- Review above the fold content and layout stability
- Assess navigation clarity and information architecture
- Check for intrusive interstitials
- Reference cwv-remediation.md for detailed CWV triage
- **Agent**: cwv-performance-agent handles this dimension
- **Tool commands**: PageSpeed Insights API `https://pagespeed.web.dev/analysis?url=[URL]`, CrUX API query, Lighthouse CLI `lighthouse [URL] --output json`

### Step 7: Local SEO (if applicable)
- Audit Google Business Profile completeness and accuracy
- Review NAP consistency across citations
- Evaluate local schema markup (LocalBusiness, Organization)
- Check local landing page optimization
- Assess review profile (quantity, quality, response rate)
- Review local link building opportunities
- **Agent**: local-seo-agent handles this dimension
- **Tool commands**: BrightLocal Citation Tracker, Moz Local search, manual GBP audit checklist

### Step 8: AI Search Readiness
- Evaluate content structure for AI citation eligibility
- Check entity presence in Knowledge Graph and Wikidata
- Review structured data completeness for AI consumption
- Assess conversational content formatting
- Reference aeo-methodology.md for detailed AEO analysis
- **Agent**: aeo-agent handles this dimension
- **Tool commands**: Manual queries in ChatGPT, Perplexity, and Gemini for brand and topic terms; schema validator for completeness

---

## 2. Scoring Methodology

Each of the 8 audit dimensions receives a score from 0 to 100.

| Score Range | Rating     | Interpretation                                      |
|-------------|------------|------------------------------------------------------|
| 90 to 100   | Excellent  | Best in class, minor refinements only                |
| 70 to 89    | Good       | Solid foundation, targeted improvements needed       |
| 50 to 69    | Fair       | Notable gaps requiring structured remediation        |
| 30 to 49    | Poor       | Significant issues limiting organic performance      |
| 0 to 29     | Critical   | Fundamental problems blocking organic visibility     |

### Scoring Weights for Overall Score

| Dimension      | Weight |
|----------------|--------|
| Crawlability   | 15%    |
| Indexation      | 15%    |
| Technical SEO   | 15%    |
| Content         | 20%    |
| Link Profile    | 15%    |
| UX / CWV        | 10%    |
| Local SEO       | 5%     |
| AI Search       | 5%     |

**Weighted Overall Score Formula**:

```
Overall Score = (Crawlability * 0.15) + (Indexation * 0.15) + (Technical * 0.15) + (Content * 0.20) + (Links * 0.15) + (UX_CWV * 0.10) + (Local * 0.05) + (AI_Search * 0.05)
```

If Local SEO is not applicable (no physical location or service area), redistribute the 5% weight to Content (now 25%) and recalculate.

### Sub-Scores Per Dimension

Each dimension score is itself composed of sub-scores. The sub-scores are averaged equally within each dimension unless otherwise noted.

**Crawlability Sub-Scores** (6 sub-scores, equal weight):
1. Robots.txt correctness (0 to 100): Are critical paths accessible? Are non-essential paths blocked?
2. XML sitemap quality (0 to 100): Present, valid XML, includes all indexable URLs, excludes non-indexable URLs, submitted in GSC
3. Crawl error rate (0 to 100): Percentage of URLs returning errors. 0 errors = 100, more than 5% error rate = 0
4. Crawl budget efficiency (0 to 100): Percentage of crawl budget spent on valuable pages vs. wasted on parameters, duplicates, facets
5. Log file bot coverage (0 to 100): Percentage of important pages receiving Googlebot visits within 30 days
6. HTTP status health (0 to 100): Percentage of key pages returning 200 status codes cleanly

**Indexation Sub-Scores** (6 sub-scores, equal weight):
1. Index coverage ratio (0 to 100): Indexed pages / total indexable pages * 100
2. Excluded page justification (0 to 100): Percentage of excluded pages that are intentionally excluded
3. Noindex accuracy (0 to 100): Are noindex tags applied correctly and only to pages that should not appear in search?
4. Orphan page count (0 to 100): 0 orphans = 100, deduct 5 points per orphan page (minimum 0)
5. Index bloat ratio (0 to 100): Percentage of indexed pages that are high value vs. low value
6. Canonical implementation (0 to 100): Correct self-referencing canonicals, no conflicting signals, cross-domain canonicals valid

**Technical SEO Sub-Scores** (7 sub-scores, equal weight):
1. Site architecture depth (0 to 100): Key pages reachable in 3 clicks or fewer = 100, deduct per additional level
2. HTTPS implementation (0 to 100): Full HTTPS, no mixed content, valid certificate, proper redirects
3. Redirect chain health (0 to 100): No chains exceed 2 hops, no redirect loops
4. Hreflang accuracy (0 to 100): Correct implementation, reciprocal tags present, valid language/region codes (N/A if monolingual, score 100)
5. Structured data validity (0 to 100): Valid JSON-LD, no errors in Rich Results Test, covers key page types
6. Mobile readiness (0 to 100): Passes mobile friendly test, responsive design, no mobile usability errors in GSC
7. Pagination handling (0 to 100): Proper implementation of paginated series or infinite scroll with crawlable links

**Content Sub-Scores** (6 sub-scores, equal weight):
1. Title tag optimization (0 to 100): Unique, correct length (50 to 60 chars), includes primary keyword, compelling
2. Meta description quality (0 to 100): Unique, correct length (140 to 160 chars), includes call to action, keyword present
3. Heading structure (0 to 100): Single H1 per page, logical hierarchy, keywords in headings
4. Content depth (0 to 100): No thin pages, comprehensive coverage vs. top ranking competitors
5. E-E-A-T signals (0 to 100): Author bios present, credentials visible, citations included, about/contact pages robust
6. Freshness (0 to 100): Content updated within appropriate timeframes, last modified dates present and accurate

**Link Profile Sub-Scores** (6 sub-scores, equal weight):
1. Backlink quality (0 to 100): Average DR/TF of linking domains, relevance of linking sites
2. Toxic link ratio (0 to 100): Percentage of backlinks flagged as toxic. 0% = 100, more than 10% = 0
3. Anchor text distribution (0 to 100): Natural distribution, no over-optimization of exact match anchors
4. Internal link structure (0 to 100): Logical internal linking, important pages receive proportionally more internal links, no orphans
5. Broken link count (0 to 100): 0 broken links = 100, deduct per broken link as percentage of total
6. Competitive gap (0 to 100): Backlink volume and quality relative to top 3 SERP competitors

**UX / CWV Sub-Scores** (5 sub-scores, equal weight):
1. LCP score (0 to 100): Under 2.5s = 100, 2.5 to 4.0s = 50, over 4.0s = 0 (interpolate within ranges)
2. INP score (0 to 100): Under 200ms = 100, 200 to 500ms = 50, over 500ms = 0 (interpolate within ranges)
3. CLS score (0 to 100): Under 0.1 = 100, 0.1 to 0.25 = 50, over 0.25 = 0 (interpolate within ranges)
4. Mobile usability (0 to 100): No mobile usability errors in GSC = 100, deduct per error type
5. Navigation and interstitials (0 to 100): Clear navigation, no intrusive interstitials, logical information architecture

**Local SEO Sub-Scores** (6 sub-scores, equal weight):
1. GBP completeness (0 to 100): All fields filled, photos uploaded, business hours set, categories selected
2. NAP consistency (0 to 100): Consistent across all citations checked
3. Local schema (0 to 100): LocalBusiness or Organization schema present and valid
4. Local landing pages (0 to 100): Dedicated pages for service areas, unique content per location
5. Review profile (0 to 100): Volume relative to competitors, average rating, response rate
6. Local link presence (0 to 100): Links from local directories, chambers of commerce, local publications

**AI Search Readiness Sub-Scores** (4 sub-scores, equal weight):
1. Content citation structure (0 to 100): Clear, quotable paragraphs; direct answers to questions; authoritative tone
2. Entity recognition (0 to 100): Brand/entity found in Knowledge Graph, Wikidata entries exist, sameAs links configured
3. Structured data for AI (0 to 100): Comprehensive schema covering FAQs, HowTo, Organization, key entities
4. Conversational formatting (0 to 100): Content structured for voice/conversational queries, concise answers, supporting detail

---

## 3. Risk Assessment Matrix

Every issue identified during the audit is assessed for both likelihood of negative impact and severity of that impact. These two dimensions create a risk classification.

### Likelihood Scale

| Level | Description | Criteria |
|-------|-------------|----------|
| 5 (Almost Certain) | Issue will cause harm if not addressed | Active crawl/index blocking, current revenue impact visible |
| 4 (Likely) | Issue will probably cause harm within 1 to 3 months | Degrading trends visible in GSC/analytics data |
| 3 (Possible) | Issue may cause harm depending on external factors | Algorithm updates, competitor movements could trigger impact |
| 2 (Unlikely) | Issue has a small chance of causing measurable harm | Edge case scenarios, low traffic pages affected |
| 1 (Rare) | Issue is theoretical, minimal real world risk | Best practice deviation with no demonstrated impact |

### Impact Scale

| Level | Description | Criteria |
|-------|-------------|----------|
| 5 (Severe) | Major revenue or traffic loss, sitewide ranking drops | More than 30% organic traffic at risk, critical conversion paths affected |
| 4 (Major) | Significant section of site affected, notable traffic loss | 10 to 30% of organic traffic at risk, important pages impacted |
| 3 (Moderate) | Measurable impact on specific pages or keyword groups | 5 to 10% of traffic at risk, secondary pages impacted |
| 2 (Minor) | Limited impact, affects only a small number of pages | Less than 5% of traffic at risk, low priority pages |
| 1 (Negligible) | No measurable traffic or revenue impact expected | Cosmetic or marginal improvements only |

### Risk Matrix

|                    | Impact 1 (Negligible) | Impact 2 (Minor) | Impact 3 (Moderate) | Impact 4 (Major) | Impact 5 (Severe) |
|--------------------|-----------------------|-------------------|----------------------|--------------------|--------------------|
| Likelihood 5       | Medium                | High              | Critical             | Critical           | Critical           |
| Likelihood 4       | Low                   | Medium            | High                 | Critical           | Critical           |
| Likelihood 3       | Low                   | Medium            | Medium               | High               | Critical           |
| Likelihood 2       | Low                   | Low               | Medium               | Medium             | High               |
| Likelihood 1       | Low                   | Low               | Low                  | Medium             | Medium             |

Use this matrix to assign each issue its Priority Tier (see Section 4). Issues landing in the "Critical" cells map to Priority Tier Critical, "High" cells map to High, and so on.

---

## 4. Priority Tier System

Every issue found during an audit is assigned a priority tier.

### Critical
- Blocks crawling, indexing, or renders the site inaccessible
- Directly impacts revenue (e.g., checkout pages returning 500 errors)
- Risk matrix placement: Likelihood 3+ and Impact 4+, or Likelihood 4+ and Impact 3+
- Examples: robots.txt blocking entire site, sitewide noindex, HTTPS failures, canonical loops

### High
- Significant negative impact on organic visibility or rankings
- Risk matrix placement: Likelihood 3+ and Impact 3, or Likelihood 2 and Impact 4+
- Examples: missing title tags on key pages, orphan landing pages, redirect chains exceeding 3 hops, missing schema on product pages

### Medium
- Optimization opportunities that improve performance when addressed
- Risk matrix placement: Likelihood 2 to 3 and Impact 2 to 3
- Examples: image alt text gaps, meta description duplication, suboptimal internal linking, heading hierarchy issues

### Low
- Best practice alignment and polish items
- Risk matrix placement: Likelihood 1 to 2 and Impact 1 to 2
- Examples: Open Graph tag refinement, minor anchor text adjustments, adding last modified dates, favicon optimization

---

## 5. Audit Deliverable Structure

Every audit report follows this five section structure. Content requirements for each section are detailed below.

### Section 1: Executive Summary
- One page overview written for non technical stakeholders
- Highlight the 3 most impactful findings with brief plain language explanations
- State the overall weighted score and the biggest risk area
- Provide a high level recommendation summary (3 to 5 bullet points)
- Include a "what this means" paragraph translating the score into business terms
- **Content requirements**: 300 to 500 words, no technical jargon, focus on business impact and next steps
- **Visual elements**: Overall score gauge/dial, top 3 issues callout boxes

### Section 2: Score Snapshot
- Visual scorecard showing all 8 dimension scores with sub-scores visible
- Overall weighted score prominently displayed
- Comparison to vertical benchmarks (reference vertical-seo-benchmarks.md)
- Trend data if this is a recurring audit (score comparison to prior audit)
- Color coded heat map: green for 70+, yellow for 50 to 69, red for below 50
- **Content requirements**: Primarily visual with brief annotations per dimension (1 to 2 sentences explaining each score)
- **Visual elements**: Radar/spider chart of 8 dimensions, score trend line (if recurring), benchmark comparison bar chart

### Section 3: Issue Inventory
- Table of all issues found, each with: issue title, dimension, priority tier, risk score (likelihood x impact), estimated effort (hours), page or URL affected
- Sorted by priority tier (Critical first) then by risk score descending
- Include count summary at top: X Critical, Y High, Z Medium, W Low
- Each issue should have a unique identifier (e.g., CRAWL-001, INDEX-003) for tracking
- **Content requirements**: Structured table format, one row per issue, effort estimates in hours, hyperlinked URLs
- **Visual elements**: Priority distribution pie chart, issues by dimension bar chart

### Section 4: Detailed Findings
- One subsection per audit dimension (8 subsections total)
- Each finding includes: description, evidence (screenshots, data), impact assessment, risk matrix placement, and recommended fix with implementation specifics
- Include relevant URLs and specific data points
- Code examples for technical fixes (e.g., corrected robots.txt lines, schema JSON-LD, meta tag HTML)
- Before/after comparison where applicable
- **Content requirements**: 500 to 2,000 words per dimension depending on issue count, every recommendation must be actionable and specific
- **Visual elements**: Screenshots of issues, annotated diagrams, data tables

### Section 5: Action Plan
- Phased implementation roadmap: Phase 1 (Critical, 0 to 2 weeks), Phase 2 (High, 2 to 6 weeks), Phase 3 (Medium, 6 to 12 weeks), Phase 4 (Low, ongoing)
- Each action item includes: issue ID (from Section 3), owner (dev, content, SEO), level of effort (hours), expected impact (traffic/ranking lift estimate), dependencies on other items
- Quick wins section highlighting items completable in under 2 hours with high impact
- Resource requirements summary: total dev hours, total content hours, total SEO hours per phase
- Gantt style timeline or milestone chart showing the full remediation schedule
- **Content requirements**: Every item must have a clear owner and deadline, dependencies explicitly mapped, no vague recommendations
- **Visual elements**: Gantt chart or timeline, effort breakdown by owner pie chart, phase summary table

---

## 6. Time Estimates by Audit Type

### Summary Table

| Audit Type           | Estimated Hours | Notes                                      |
|----------------------|-----------------|--------------------------------------------|
| Full 8 Step Audit    | 20 to 40        | All dimensions, comprehensive deliverable  |
| Technical Only       | 8 to 15         | Steps 1 through 3                          |
| Content Audit        | 10 to 20        | Step 4, includes content inventory          |
| Link Audit           | 6 to 12         | Step 5, includes toxic link analysis        |
| CWV / Performance    | 4 to 8          | Step 6, lab and field data analysis         |
| Local SEO Audit      | 4 to 8          | Step 7, includes citation audit             |
| AI Search Readiness  | 3 to 6          | Step 8, includes entity audit               |
| Quick Health Check   | 3 to 5          | High level review of all dimensions         |

### Granular Breakdown: Full 8 Step Audit (20 to 40 hours)

**Pre-Audit Setup (2 to 3 hours)**:
- Confirm access to GSC, GA4, CMS, server logs (0.5 hours)
- Document client goals, KPIs, and target keywords (0.5 hours)
- Configure Screaming Frog crawl settings and initiate crawl (0.5 hours)
- Pull initial GSC and Semrush data exports (0.5 hours)
- Review prior audit reports if available (0.5 to 1 hour)

**Step 1: Crawlability (2 to 4 hours)**:
- Robots.txt review (0.25 hours)
- XML sitemap validation (0.5 hours)
- Crawl error analysis from GSC (0.5 hours)
- Crawl budget assessment from server logs (0.5 to 1.5 hours)
- Bot activity log analysis (0.5 to 1 hour)
- HTTP status code check for key pages (0.25 to 0.5 hours)

**Step 2: Indexation (2 to 3 hours)**:
- Index coverage report analysis (0.5 hours)
- Excluded pages review and categorization (0.5 to 1 hour)
- Noindex directive verification (0.25 hours)
- Orphan page identification (0.25 to 0.5 hours)
- Index bloat analysis (0.25 to 0.5 hours)
- Canonical tag audit (0.25 to 0.5 hours)

**Step 3: Technical SEO (2 to 5 hours)**:
- Site architecture mapping and depth analysis (0.5 to 1 hour)
- HTTPS and mixed content review (0.25 to 0.5 hours)
- Redirect chain and loop audit (0.5 to 1 hour)
- Hreflang audit if applicable (0.5 to 1 hour, or 0 if monolingual)
- Structured data validation (0.5 to 1 hour)
- Mobile friendliness testing (0.25 to 0.5 hours)
- Pagination review (0.25 to 0.5 hours)

**Step 4: Content Analysis (3 to 6 hours)**:
- Title tag and meta description audit (0.5 to 1 hour)
- Heading hierarchy analysis (0.5 hours)
- Thin content identification (0.5 to 1 hour)
- Duplicate content detection (0.5 to 1 hour)
- E-E-A-T signal review (0.5 to 1 hour)
- Content freshness assessment (0.5 to 1 hour)

**Step 5: Link Profile (2 to 4 hours)**:
- Backlink quality analysis (0.5 to 1 hour)
- Toxic link identification (0.5 to 1 hour)
- Anchor text distribution review (0.25 to 0.5 hours)
- Internal linking audit (0.5 to 1 hour)
- Broken link detection (0.25 to 0.5 hours)
- Competitor backlink comparison (0.5 to 1 hour)

**Step 6: UX and CWV (1.5 to 3 hours)**:
- CWV measurement and analysis (0.5 to 1 hour)
- Mobile usability review (0.25 to 0.5 hours)
- Above the fold and layout stability check (0.25 to 0.5 hours)
- Navigation and IA assessment (0.25 to 0.5 hours)
- Interstitial check (0.25 hours)

**Step 7: Local SEO (1 to 3 hours, if applicable)**:
- GBP audit (0.25 to 0.5 hours)
- NAP consistency check (0.25 to 0.5 hours)
- Local schema review (0.25 hours)
- Local landing page audit (0.25 to 0.5 hours)
- Review profile analysis (0.25 to 0.5 hours)
- Local link opportunities (0.25 to 0.5 hours)

**Step 8: AI Search Readiness (1 to 2 hours)**:
- AI citation structure evaluation (0.25 to 0.5 hours)
- Knowledge Graph and entity check (0.25 to 0.5 hours)
- Structured data completeness for AI (0.25 to 0.5 hours)
- Conversational formatting review (0.25 to 0.5 hours)

**Report Assembly and QA (3 to 6 hours)**:
- Draft executive summary (0.5 to 1 hour)
- Build score snapshot visuals (0.5 to 1 hour)
- Compile issue inventory table (0.5 to 1 hour)
- Write detailed findings per dimension (1 to 2 hours)
- Create action plan with phasing and ownership (0.5 to 1 hour)
- QA review against quality checklist (0.5 to 1 hour)

---

## 7. Tool Requirements by Step

| Step             | Primary Tools                                      | Secondary Tools                    |
|------------------|----------------------------------------------------|------------------------------------|
| Crawlability     | Screaming Frog, GSC                                | Sitebulb, server logs              |
| Indexation       | GSC, Screaming Frog                                | site: operator, Bing Webmaster     |
| Technical SEO    | Screaming Frog, Chrome DevTools                    | Ahrefs Site Audit, Schema.org validator |
| Content          | Semrush Content Audit, Screaming Frog              | Copyscape, SurferSEO               |
| Link Profile     | Semrush Backlink Audit, Ahrefs                     | Majestic, GSC Links report         |
| UX / CWV         | PageSpeed Insights, WebPageTest, Chrome DevTools   | CrUX Dashboard, Lighthouse CI      |
| Local SEO        | Google Business Profile, BrightLocal               | Moz Local, Whitespark               |
| AI Search        | Manual AI engine queries, schema validators        | Brand mention monitoring tools      |

### Specific Tool Queries and Commands

**Screaming Frog**:
- Full crawl: File > New > enter domain > Start. Set crawl depth to 0 (unlimited). Configuration > Spider > check "Crawl All Subdomains" if needed.
- Redirect audit: Reports > Redirects > Redirect Chains. Export to CSV.
- Orphan pages: Crawl data combined with analytics integration. Configuration > API Access > connect GA4 and GSC.
- Structured data: Configuration > Spider > Extraction > check "JSON-LD," "Microdata," "RDFa."

**Google Search Console**:
- Index coverage: Indexing > Pages. Export all rows. Review "Why pages aren't indexed" section.
- Performance data: Performance > Search Results > set date range to last 16 months. Export by Queries, Pages, Countries, Devices.
- CWV data: Experience > Core Web Vitals. Toggle between Mobile and Desktop.
- Crawl stats: Settings > Crawl Statistics. Review crawl requests, response times, and host status.

**Semrush**:
- Site audit: Projects > [Project] > Site Audit > Rerun. Review Errors, Warnings, Notices tabs.
- Backlink audit: Projects > [Project] > Backlink Audit. Set toxic score threshold to 60+.
- Position tracking: Projects > [Project] > Position Tracking. Review Landscape, Pages, and Competitors tabs.

**PageSpeed Insights**:
- Run for both mobile and desktop on 5 to 10 representative page types (homepage, category, product, blog post, contact).
- Use API for batch testing: `https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=[URL]&strategy=mobile`
- Compare lab data vs. CrUX field data for accuracy assessment.

---

## 8. Agent Responsibility Matrix

This section maps each audit dimension to the responsible agent and outlines the handoff protocol.

| Dimension       | Primary Agent            | Backup / Support Agent    | Handoff Trigger                              |
|-----------------|--------------------------|---------------------------|----------------------------------------------|
| Crawlability    | technical-seo-agent      | None                      | Issues identified go to issue inventory      |
| Indexation      | technical-seo-agent      | None                      | Orphan pages flagged to content-seo-agent    |
| Technical SEO   | technical-seo-agent      | cwv-performance-agent     | CWV overlap items handed to cwv agent        |
| Content         | content-seo-agent        | None                      | Thin content flagged for content gap analysis |
| Link Profile    | link-profile-agent       | None                      | Toxic links flagged for disavow review       |
| UX / CWV        | cwv-performance-agent    | technical-seo-agent       | Server side issues handed to technical agent |
| Local SEO       | local-seo-agent          | None                      | Schema issues shared with technical agent    |
| AI Search       | aeo-agent                | content-seo-agent         | Content structure issues shared with content agent |

All agents write findings in the standardized format: Issue ID, Description, Evidence, Impact, Risk Score, Recommended Fix. The lead auditor (senior SEO) synthesizes all agent outputs into the unified deliverable.

---

## 9. QA Checklist for Audit Quality Verification

Before any audit deliverable is finalized and shared with a client, it must pass this quality checklist. Every item must be confirmed.

### Data Integrity
- [ ] All GSC data exports cover the correct date range (minimum 3 months, recommended 16 months)
- [ ] Screaming Frog crawl completed without errors or premature termination
- [ ] Crawl settings matched the site (JavaScript rendering enabled if SPA, correct user agent)
- [ ] Semrush data is current (pulled within the last 7 days)
- [ ] PageSpeed Insights results are from the current week
- [ ] All URLs referenced in the report are valid and accessible
- [ ] Data points cited in findings match the source exports (spot check 10 data points minimum)

### Scoring Accuracy
- [ ] Each dimension score has been calculated from its sub-scores correctly
- [ ] Overall weighted score matches the formula output (manually verify calculation)
- [ ] Score ratings (Excellent/Good/Fair/Poor/Critical) match the score ranges defined in Section 2
- [ ] If Local SEO is marked N/A, the 5% weight has been redistributed to Content
- [ ] Sub-scores within each dimension are supported by specific evidence

### Issue Inventory Completeness
- [ ] Every issue has a unique ID following the naming convention (e.g., CRAWL-001)
- [ ] Every issue has a priority tier assigned using the risk matrix
- [ ] Every issue has an effort estimate in hours
- [ ] Every issue references specific URLs or page types affected
- [ ] Issues are sorted correctly: Critical first, then by risk score descending
- [ ] No duplicate issues (same issue listed twice under different names)
- [ ] Count summary matches actual issue counts in the table

### Deliverable Quality
- [ ] Executive summary is under 500 words and free of technical jargon
- [ ] Executive summary highlights exactly 3 top findings
- [ ] Score snapshot includes all 8 dimensions with visual representation
- [ ] Detailed findings include evidence (screenshots or data) for every issue
- [ ] Every recommendation includes specific implementation guidance, not generic advice
- [ ] Code examples are syntactically correct and tested where possible
- [ ] Action plan includes owner, effort, expected impact, and dependencies for every item
- [ ] Quick wins section is populated with at least 3 items under 2 hours each
- [ ] Phase timeline is realistic given the client's resource constraints

### Formatting and Presentation
- [ ] No spelling or grammatical errors
- [ ] Consistent formatting throughout (headings, tables, fonts)
- [ ] All charts and visuals render correctly
- [ ] File is in the correct format (.docx unless otherwise specified)
- [ ] Client name and date are correct on all pages
- [ ] Table of contents is present and page numbers match
- [ ] Hyperlinks in the document are functional

### Final Review
- [ ] Findings align with the client's stated goals and KPIs
- [ ] No recommendations contradict each other
- [ ] All critical and high priority items have clear, specific remediation steps
- [ ] The audit has been reviewed by a second person (or second pass by the author with fresh eyes)
- [ ] The deliverable is flagged as DRAFT until Michael approves for client delivery

---

## 10. Audit Governance

- All audits must be completed using this methodology to ensure consistency
- Findings must be supported by data, not assumptions
- Recommendations must include specific implementation guidance, not generic advice
- Audits should be repeated quarterly for ongoing clients
- Pre-audit data collection (GSC access, GA4 access, CMS access, server logs) must be confirmed before starting
- Client goals and KPIs should be documented before the audit begins to contextualize findings
- Every audit deliverable passes the QA checklist in Section 9 before delivery
- Audit methodology itself is reviewed and updated biannually to reflect algorithm changes and industry evolution
