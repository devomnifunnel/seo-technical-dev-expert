---
name: competitor-seo
description: "Systematic competitor analysis for SEO strategy. Use when identifying competitors, analyzing keyword gaps, comparing backlink profiles, or benchmarking rankings. Trigger on: competitor analysis, keyword gap, content gap, share of voice, SERP overlap, competitive audit."
context: fork
agent: Explore
---

# Competitive SEO Analysis

## Competitor Identification

### Three Types of Competitors

**Direct Competitors**: Businesses offering the same products or services in the same market.
- Identified through business knowledge, industry directories, client input
- May not overlap heavily in organic search if their SEO is weak

**SERP Competitors**: Domains that rank for the same keywords, regardless of business model.
- Identified by analyzing who ranks in the top 10 for your target keyword clusters
- Often includes publishers, directories, aggregators, and informational sites
- These are your true SEO competitors even if they do not sell competing products

**Aspirational Competitors**: Domains with significantly higher authority that represent the benchmark.
- DA/DR 2x or more above your domain
- Useful for understanding what "great" looks like in your vertical
- Study their content strategy, site architecture, and link profile for long term planning

### Competitor Discovery Process

1. Export your top 50 target keywords from Semrush Position Tracking
2. For each keyword, record the top 5 ranking domains
3. Tally domain frequency: the domains appearing most often are your SERP competitors
4. Select 3 to 5 primary SERP competitors for ongoing tracking
5. Add 1 to 2 aspirational competitors for benchmarking

## Keyword Overlap Analysis

### Semrush Keyword Gap Workflow

1. Navigate to Keyword Gap tool
2. Enter your domain in the first field
3. Enter 2 to 4 competitor domains in the remaining fields
4. Select organic keywords, target country

**Key views to analyze**:

**Shared**: Keywords all domains rank for. Compare positions to find where you are underperforming.
- Filter for keywords where competitor position < your position by 5+ spots
- These are improvement opportunities on existing content

**Missing**: Keywords at least one competitor ranks for but you do not.
- Sort by volume descending
- Filter by KD < 50 (or appropriate threshold for your DA)
- These are content creation opportunities

**Weak**: Keywords where you rank but competitors rank higher.
- Focus on keywords where you are position 5 to 20 and competitors are position 1 to 5
- These are content optimization and link building priorities

**Strong**: Keywords where you outrank all competitors.
- Protect these positions with regular content refreshes and internal linking
- Monitor for competitor movement

**Untapped**: Keywords only one competitor ranks for.
- May indicate emerging topics or niche opportunities
- Evaluate business relevance before pursuing

### Keyword Overlap Visualization

Create a keyword overlap matrix:

```
                Your Domain  Comp A  Comp B  Comp C
Total Keywords:    1,200      3,400   2,800   1,900
Shared (all):        340        340     340     340
Unique to you:       280         --      --      --
Missing from you:     --      1,640   1,180     820
```

## Content Gap Analysis

### Process

1. **Export competitor top pages**: Semrush > Organic Research > Pages > sort by traffic
2. **Categorize by topic**: Group competitor pages into topic clusters
3. **Map against your content**: Identify topics competitors cover that you do not
4. **Assess opportunity**: For each gap, evaluate volume, difficulty, and business relevance
5. **Prioritize creation**: Score each gap using the keyword prioritization framework

### Content Gap Categories

**Topic gaps**: Entire subject areas you have not covered.
- Example: Competitor has a comprehensive guide on "warehouse management systems" and you have nothing on the topic
- Resolution: Create pillar content targeting the topic cluster

**Depth gaps**: You cover the topic but competitors go significantly deeper.
- Example: Your page is 500 words, competitor page is 3,000 words with tables, images, and expert quotes
- Resolution: Expand existing content with additional sections, data, examples

**Format gaps**: Competitors use content formats you do not.
- Example: Competitor has comparison tables, interactive tools, video walkthroughs
- Resolution: Add the missing format to your existing content

**Freshness gaps**: Your content is outdated while competitors have current information.
- Example: Your guide references 2024 data, competitor updated with 2026 statistics
- Resolution: Refresh content with current data, update timestamps

## SERP Feature Mapping

### Tracking Featured Snippet Ownership

For each target keyword cluster, document:

```
Keyword: "how to optimize meta descriptions"
Featured Snippet Owner: competitor-a.com
Snippet Type: Paragraph
Snippet Content: [first 160 characters]
Your Position: 4
Action: Restructure H2 + concise answer format, target snippet takeover
```

### SERP Feature Inventory

Track which competitors own which SERP features:

| Feature | Your Domain | Comp A | Comp B | Comp C |
|---------|------------|--------|--------|--------|
| Featured Snippets | 3 | 12 | 8 | 5 |
| PAA Appearances | 7 | 22 | 15 | 11 |
| Knowledge Panel | No | Yes | No | Yes |
| Image Pack | 2 | 8 | 5 | 3 |
| Video Carousel | 0 | 4 | 1 | 6 |
| FAQ Rich Results | 5 | 9 | 12 | 4 |
| Sitelinks | Yes | Yes | Yes | Yes |

### Action Items from SERP Feature Mapping

- If a competitor owns a featured snippet for a keyword you rank in the top 10 for, restructure your content to capture it
- If competitors appear in PAA and you do not, add FAQ sections with schema markup
- If competitors dominate image packs, invest in original image creation and optimization
- If competitors have video carousels, create video content for those topics

## Backlink Comparison

### Referring Domain Analysis

Pull backlink data for each competitor using Semrush Backlink Analytics:

```
Metric              Your Domain  Comp A    Comp B    Comp C
Referring Domains:     450       2,100     1,400      890
Backlinks (total):   3,200      28,000    15,000    7,500
Authority Score:        35          62        54       44
Follow %:              72%         78%       75%      70%
```

### Link Velocity Comparison

Track new referring domains per month for the past 12 months:

1. Semrush > Backlink Analytics > enter domain > Referring Domains tab
2. Set to "New" referring domains, monthly view
3. Export data for each competitor
4. Chart the trend lines to see who is acquiring links fastest

**Interpretation**:
- Steady growth (10 to 30 new RDs per month): Healthy, organic link acquisition
- Sudden spikes: Likely a viral piece of content or a link building campaign
- Declining trend: Content strategy may be stalling, opportunity to overtake

### Anchor Text Distribution

Compare anchor text profiles to identify strategies and risks:

| Anchor Type | Healthy Range | Your Site | Comp A | Comp B |
|-------------|--------------|-----------|--------|--------|
| Branded | 30 to 50% | 42% | 38% | 25% |
| Naked URL | 15 to 25% | 20% | 18% | 30% |
| Exact Match | 5 to 15% | 8% | 22% | 12% |
| Partial Match | 10 to 20% | 15% | 12% | 18% |
| Generic | 5 to 15% | 10% | 7% | 10% |
| Other | 5 to 10% | 5% | 3% | 5% |

If a competitor has >20% exact match anchors, they may be using aggressive link building tactics that carry risk.

### Backlink Gap Analysis

Semrush Backlink Gap tool:
1. Enter your domain and up to 4 competitors
2. Filter for referring domains that link to competitors but not to you
3. Sort by Authority Score descending
4. Evaluate each referring domain for outreach potential
5. Categorize opportunities: guest post, resource page, directory, editorial mention

## Technical SEO Comparison

### Page Speed Comparison

Test the homepage and top 5 pages of each competitor through PageSpeed Insights:

```
Metric          Your Site  Comp A  Comp B  Comp C
Mobile Score:      45        72      58      65
Desktop Score:     68        89      75      80
LCP (mobile):   4.2s      2.1s    3.0s    2.5s
INP (mobile):   280ms     150ms   200ms   180ms
CLS (mobile):   0.15      0.05    0.08    0.12
TTFB:           1.2s      0.4s    0.6s    0.8s
```

### Structured Data Comparison

For each competitor, audit structured data on key page types:

1. Product pages: Product schema, Review schema, Offer/AggregateOffer
2. Category pages: BreadcrumbList, ItemList
3. Blog/articles: Article schema, FAQPage, HowTo
4. Homepage: Organization, WebSite, SearchAction
5. Contact/about: LocalBusiness, Person

### Mobile Experience Comparison

Evaluate using Chrome DevTools mobile emulation:
- Responsive design quality
- Touch target sizing (minimum 48x48px)
- Font readability without zooming (minimum 16px body text)
- Intrusive interstitial usage (impacts mobile ranking)

## Share of Voice Calculation

### Methodology

Share of Voice (SOV) measures your organic visibility relative to competitors across a defined keyword set.

**Calculation**:

```
SOV = (Sum of your estimated clicks for tracked keywords) /
      (Sum of all estimated clicks for tracked keywords across all competitors) * 100
```

**Estimated clicks** depend on position and CTR:

| Position | Estimated CTR |
|----------|--------------|
| 1 | 28 to 32% |
| 2 | 15 to 18% |
| 3 | 10 to 12% |
| 4 | 7 to 8% |
| 5 | 5 to 6% |
| 6 to 10 | 2 to 4% |
| 11 to 20 | 0.5 to 1.5% |

### Semrush Position Tracking SOV

1. Set up Position Tracking with your target keywords and competitors
2. Navigate to the "Landscape" tab
3. Review "Visibility %" for each domain (Semrush's SOV equivalent)
4. Track monthly changes in visibility share
5. Export trend data for reporting

### SOV Tracking Cadence

- Weekly: Check for significant position changes (5+ position shifts)
- Monthly: Full SOV calculation for reporting
- Quarterly: Recalculate with updated keyword universe (add new, remove irrelevant)

## Ranking Velocity Analysis

### Tracking Who Is Gaining vs Losing

**Monthly ranking movement analysis**:

1. Export Semrush Position Tracking data for the current month and previous month
2. Calculate position change per keyword per domain
3. Aggregate: total keywords gained (improved 3+ positions) vs lost (dropped 3+ positions)
4. Calculate net position change across the full keyword set

**Velocity indicators**:

```
Domain    Keywords Up  Keywords Down  Net Change  New Rankings  Lost Rankings
You:          45           22           +23            8             3
Comp A:       30           38            -8            5            12
Comp B:       52           15           +37           15             2
Comp C:       25           28            -3            4             6
```

**Interpretation**:
- Comp B is gaining aggressively. Investigate: new content? link building campaign? site redesign?
- Comp A is declining. Opportunity to capture their positions with targeted content
- Your positive velocity (+23) is healthy but Comp B is outpacing you

### New Content Detection

Monitor competitors for new content publication:
1. Use `site:competitor.com` in Google, filter to "Past month"
2. Check competitor sitemaps for recently added URLs
3. Use Semrush Organic Research > Pages > sort by traffic change to find new pages gaining traction
4. Subscribe to competitor RSS feeds or use change detection tools

## AI Search Visibility Comparison

### Monitoring AI Citations

Track which competitors get cited by AI search engines (ChatGPT, Perplexity, Gemini, Google AI Overviews):

1. Query your target keywords in each AI platform
2. Record which domains are cited in the responses
3. Note the frequency and context of citations
4. Track over time to identify trends

### AI Visibility Factors to Compare

- **Entity authority**: Which competitors have Wikipedia pages, knowledge panels, strong brand mentions?
- **Content structure**: Which competitors use clear, structured, factual content that AI systems prefer to cite?
- **Topical authority**: Which competitors have the deepest content coverage on specific topics?
- **Schema markup**: Which competitors have the most comprehensive structured data?
- **Direct answers**: Which competitors provide concise, quotable answers that AI systems extract?

## Competitive Intelligence Report Template

### Executive Summary (1 page)
- Overall competitive position (SOV ranking among tracked competitors)
- Key wins and losses since last report period
- Top 3 threats and top 3 opportunities

### Keyword Landscape (2 to 3 pages)
- Keyword overlap matrix
- Missing keyword opportunities (top 20 by volume)
- Weak keyword positions (top 20 improvement opportunities)
- Share of voice trend chart

### Content Analysis (2 pages)
- Content gap inventory with prioritized recommendations
- Competitor content publishing velocity (pages per month)
- SERP feature ownership comparison

### Backlink Analysis (1 to 2 pages)
- Referring domain comparison chart
- Link velocity trends
- Top backlink gap opportunities (10 to 15 actionable targets)
- Anchor text health comparison

### Technical Comparison (1 page)
- Page speed scorecard
- Structured data comparison
- Mobile experience comparison

### AI Search Visibility (1 page)
- Citation frequency by AI platform
- Entity authority comparison
- Recommendations for improving AI visibility

### Action Plan (1 page)
- Prioritized list of 10 to 15 recommended actions
- Each action tied to competitive insight
- Estimated impact and effort level
- Suggested timeline
