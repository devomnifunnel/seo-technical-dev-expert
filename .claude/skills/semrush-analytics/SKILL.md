---
name: semrush-analytics
description: "Semrush platform for position tracking, site audits, and competitive intelligence. Use when pulling Semrush data, running site audits, or tracking keyword positions. Trigger on: Semrush, position tracking, site audit, keyword tracking, backlink analytics, domain overview."
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch
argument-hint: "[domain to analyze]"
---

# Semrush Analytics Platform Usage

## Position Tracking

### Setup Process

1. **Create project**: Projects > Add New Project > enter domain
2. **Configure tracking**:
   - Select search engine: Google (default), Bing if needed
   - Select target location: country, state, city, or zip code level
   - Select device: Desktop, Mobile, or both (track both for comprehensive data)
3. **Import keywords**:
   - Manual entry for small sets
   - CSV import for large keyword lists
   - Import from Semrush tools (Keyword Magic, Organic Research)
   - Target: 100 to 500 keywords per project for meaningful tracking
4. **Add competitors**: Enter 3 to 5 SERP competitor domains
5. **Set tracking frequency**: Daily tracking recommended for active SEO campaigns

### Keyword Groups and Tags

Organize tracked keywords into logical groups:

```
Tag Structure Example:
├── Brand Keywords
├── Product Categories
│   ├── Category A
│   ├── Category B
│   └── Category C
├── Informational Content
│   ├── How To Guides
│   └── Industry Topics
├── Local Keywords
└── Competitor Brand Keywords
```

**Benefits of tagging**:
- Filter reports by keyword group
- Track SOV per topic cluster
- Identify which content areas are gaining or losing
- Prioritize optimization efforts by category performance

### SERP Features Tracking

Position Tracking monitors these SERP features automatically:
- Featured Snippets (paragraph, list, table)
- People Also Ask
- Local Pack
- Knowledge Panel
- Image Pack
- Video Carousel
- Shopping Results
- Sitelinks
- Reviews
- AI Overviews

**Key report**: SERP Features tab shows which features appear for your keywords and who owns them.

### Key Reports in Position Tracking

**Landscape tab**: Overall visibility trend, SOV comparison, position distribution
**Overview tab**: Keyword level positions with change tracking
**Pages tab**: Which pages rank for which keywords, pages with multiple rankings
**Competitors tab**: Head to head position comparison
**Cannibalization tab**: Keywords where multiple pages from your domain compete

## Site Audit

### Configuration

1. **Create project** (or use existing)
2. **Configure crawl settings**:
   - Crawl scope: Entire domain, subdomain, or subfolder
   - Page limit: Set based on known site size (start with 5,000 to 20,000)
   - Crawl source: Website (follow links) or Sitemap (crawl sitemap URLs)
   - User agent: Semrush Bot (default) or Googlebot
   - Crawl delay: 1 to 5 seconds (be respectful of server resources)
   - Allow/disallow URL patterns for focused audits
3. **Schedule**: Weekly recrawls recommended for active sites
4. **Notifications**: Set up email alerts for new critical issues

### Issue Prioritization

Semrush categorizes issues into three severity levels:

**Errors (Critical)**: Issues that significantly impact SEO performance
- Broken internal links (4xx status)
- Pages with 5xx server errors
- Pages with duplicate title tags
- Pages not accessible by HTTPS
- Redirect chains and loops
- Pages returning incorrect status codes
- Orphan pages (no internal links)

**Warnings (High/Medium)**: Issues that may impact performance
- Missing or duplicate meta descriptions
- Missing alt attributes on images
- Low word count (thin content)
- Multiple H1 tags on a page
- Slow page load time (>3 seconds)
- Missing hreflang attributes (if international)
- Broken external links

**Notices (Low)**: Best practice recommendations
- Pages blocked from crawling but linked internally
- External links with nofollow
- Permanent redirects (may be intentional)
- Pages with excessive URL parameters

### Fixing Common Audit Errors

**Duplicate title tags**:
1. Filter: Issues > "X pages have duplicate title tags"
2. Click to see grouped duplicates
3. Write unique, keyword targeted titles for each page
4. If pages genuinely cover the same topic, consolidate them

**Redirect chains**:
1. Filter: Issues > "X redirect chains and loops"
2. View the full redirect path
3. Update the initial redirect to point directly to the final destination
4. Reduce all chains to a single hop

**Crawl depth issues**:
1. Filter: Issues > "X pages are too deep in site architecture"
2. Target: All important pages within 3 clicks of homepage
3. Add internal links from higher level pages
4. Review navigation structure and add category links

## Keyword Research

### Keyword Magic Tool Workflow

1. Enter a seed keyword
2. Select target country and database
3. Use the left sidebar for subtopic groups (auto clustered)
4. Apply filters:
   - Volume: minimum 10 (B2B niche) to 100 (B2C broad)
   - KD%: filter based on your domain authority
   - Intent: filter by search intent type
   - SERP Features: filter for keywords with featured snippets or PAA
5. Use "Questions" tab to find question based keywords
6. Use "Related" tab for semantically related terms
7. Export selected keywords for content planning

### Keyword Gap Analysis

1. Navigate to Keyword Gap under Competitive Research
2. Enter your domain and up to 4 competitor domains
3. Select keyword type: Organic, Paid, or PLA

**Analysis tabs**:

| Tab | What It Shows | How to Use |
|-----|--------------|------------|
| Shared | Keywords all domains rank for | Find where competitors outrank you |
| Missing | Keywords competitors rank for, you do not | Content creation opportunities |
| Weak | Keywords where you rank lower | Content optimization priorities |
| Strong | Keywords where you outrank competitors | Positions to protect |
| Untapped | Keywords only one competitor ranks for | Niche opportunities |
| Unique | Keywords only you rank for | Your competitive advantage |

### Keyword Overview

For any individual keyword, Keyword Overview provides:
- Global and country specific volume
- Keyword difficulty score (0 to 100)
- Search intent classification
- CPC and competitive density
- SERP analysis (top 10 results with their metrics)
- Keyword variations, questions, and related keywords
- SERP feature presence
- Trend data (12 month volume trend)

## Backlink Audit

### Toxic Score Methodology

Semrush assigns a Toxic Score (0 to 100) based on:
- Link source quality (spam indicators, link farm patterns)
- Anchor text manipulation signals (exact match anchor overuse)
- Link network patterns (PBN indicators)
- Domain authority of linking site
- Relevance of linking site to your niche

**Score interpretation**:
| Score Range | Classification | Action |
|-------------|---------------|--------|
| 0 to 44 | Non toxic | No action needed |
| 45 to 59 | Potentially toxic | Review manually, investigate context |
| 60 to 100 | Toxic | Consider disavowing after manual review |

### Disavow List Generation

1. Run Backlink Audit for your domain
2. Review toxic and potentially toxic links
3. For each flagged link, evaluate manually:
   - Is the linking page real content or spam?
   - Is the anchor text manipulative?
   - Is the linking domain relevant to your industry?
4. Mark as "Toxic" (add to disavow) or "Non toxic" (whitelist)
5. Export disavow file in Google's required format:

```
# Disavow file generated from Semrush Backlink Audit
# Date: 2026-03-05
# Domain: example.com

# Individual URL disavows
https://spamsite1.com/link-page
https://spamsite2.com/directory/listing

# Domain-level disavows (for entirely spammy domains)
domain:spamlink-farm.com
domain:cheap-links-network.net
domain:article-spinner-site.org
```

6. Submit disavow file in Google Search Console > Disavow Links tool
7. Recheck in 2 to 3 months for new toxic links

### Competitor Backlink Comparison

Semrush Backlink Gap:
1. Enter your domain and up to 4 competitors
2. View referring domains linking to competitors but not you
3. Sort by Authority Score
4. Filter for follow links only
5. Evaluate each domain for outreach potential
6. Export opportunities into your link building pipeline

## Organic Research

### Domain Overview

Enter any domain to see:
- Total organic keywords and traffic estimate
- Traffic trend (12 month chart)
- Top organic keywords with positions
- Traffic distribution by country
- Branded vs non branded keyword split
- Top pages by estimated traffic

### Top Pages Analysis

1. Organic Research > Pages
2. Sort by traffic to find highest value pages
3. Click any page to see the keywords it ranks for
4. Compare competitor top pages to yours to identify content gaps
5. Track traffic changes month over month to spot trends

### Keyword Trends

1. Organic Research > Positions
2. Filter by position range (e.g., 1 to 3, 4 to 10, 11 to 20)
3. View position history for individual keywords (click the trend icon)
4. Set date range to 12 months to identify seasonal patterns
5. Filter by "New" to see recently acquired rankings
6. Filter by "Lost" to see rankings that disappeared
7. Filter by "Declined" to see positions that dropped

## Content Audit Integration

### Thin Content Identification

Using Site Audit data:
1. Site Audit > Issues > filter "Low word count"
2. Default threshold: pages with fewer than 200 words
3. Adjust threshold based on page type:
   - Blog posts/articles: minimum 800 words
   - Product pages: minimum 300 words unique description
   - Category pages: minimum 200 words descriptive text
   - Landing pages: minimum 500 words

### Content Scoring

Evaluate each page on a 1 to 5 scale:

| Score | Classification | Action |
|-------|---------------|--------|
| 5 | Performing well | Monitor and refresh annually |
| 4 | Good with minor gaps | Update and optimize |
| 3 | Average, needs improvement | Significant content enhancement |
| 2 | Underperforming | Major rewrite or consolidate |
| 1 | No value | Redirect, merge, or remove |

**Scoring criteria**:
- Organic traffic (GSC data)
- Keyword rankings (Semrush position data)
- Content quality (depth, uniqueness, accuracy)
- Engagement metrics (GA4 engagement rate, time on page)
- Backlinks (referring domains to the page)
- Freshness (last updated date vs topic volatility)

## Competitive Analysis

### Domain Comparison

1. Enter your domain and up to 4 competitors in Domain Overview
2. Compare key metrics:

```
Metric              You      Comp A    Comp B    Comp C
Authority Score:     35        58        47        42
Organic Keywords:  1,200     4,800     3,100     2,200
Organic Traffic:   5,400    28,000    15,000     9,800
Referring Domains:   320     1,800     1,100       680
```

3. Click "Compare" for side by side trend charts
4. Identify which metrics have the largest gap (focus area)

### Traffic Estimation Methodology

Semrush estimates organic traffic by:
1. Taking all keywords a domain ranks for
2. Applying position based CTR models
3. Multiplying by monthly search volume
4. Summing across all keywords

**Important caveat**: Semrush traffic estimates are directional, not exact. Use for relative comparison between domains, not as absolute traffic numbers. Actual traffic (from GA4/GSC) is typically 2 to 5x different from Semrush estimates.

## Reporting

### Dashboard Creation

1. Navigate to My Reports
2. Select "Start from scratch" or use a template
3. Drag and drop widgets:
   - Position Tracking overview (visibility trend)
   - Site Audit health score trend
   - Organic traffic trend
   - Top keyword positions table
   - Backlink growth chart
   - Competitor visibility comparison
4. Set date range and comparison period
5. Add custom branding (agency logo, colors)

### PDF Export and Scheduling

1. Configure report layout and widgets
2. Preview the report
3. Export as PDF for manual delivery
4. Or schedule automated delivery:
   - Frequency: daily, weekly, monthly
   - Recipients: enter email addresses
   - Format: PDF attachment or link

### Report Templates by Use Case

**Monthly SEO Report**:
- Executive summary widget (manual text)
- Organic visibility trend (Position Tracking)
- Traffic and ranking changes table
- Site health score (Site Audit)
- Backlink growth chart
- Competitor comparison
- Action items (manual text)

**Technical Audit Report**:
- Site Audit health score
- Error/warning/notice breakdown
- Top issues by impact
- CWV summary
- Crawlability metrics
- Page speed distribution

**Competitive Analysis Report**:
- Domain comparison table
- Keyword gap analysis
- Backlink gap analysis
- SOV trend chart
- SERP feature comparison
- Content gap opportunities

## API Usage

### Key Endpoints

| Endpoint | Purpose | Rate Limit |
|----------|---------|------------|
| Domain Overview | Domain metrics summary | 10 req/sec |
| Domain Organic Search | Organic keywords and positions | 10 req/sec |
| Keyword Overview | Keyword metrics | 10 req/sec |
| Keyword Magic Tool | Keyword suggestions | 10 req/sec |
| Backlinks Overview | Backlink summary metrics | 10 req/sec |
| URL Organic Search | Keywords for a specific URL | 10 req/sec |

### API Request Example

```python
import requests

API_KEY = 'your_semrush_api_key'
BASE_URL = 'https://api.semrush.com/'

# Domain organic search keywords
params = {
    'type': 'domain_organic',
    'key': API_KEY,
    'domain': 'example.com',
    'database': 'us',
    'display_limit': 100,
    'display_offset': 0,
    'display_sort': 'tr_desc',  # Sort by traffic descending
    'display_filter': '+|Po|Lt|10',  # Position less than 10
    'export_columns': 'Ph,Po,Nq,Cp,Ur,Tr'
    # Ph=Keyword, Po=Position, Nq=Volume, Cp=CPC, Ur=URL, Tr=Traffic%
}

response = requests.get(BASE_URL, params=params)
lines = response.text.strip().split('\n')
headers = lines[0].split(';')
for line in lines[1:]:
    values = line.split(';')
    print(dict(zip(headers, values)))
```

### Data Formats

- Default response format: semicolon separated values (CSV with semicolons)
- Add `&export=api` to get API optimized format
- Response encoding: UTF-8
- Rate limits: 10 requests per second per API key (varies by plan)
- Data freshness: most data updated daily, some weekly

### Common API Use Cases

**Automated ranking monitoring**:
```python
# Pull top 10 rankings daily, store in database, alert on drops
keywords = get_tracked_keywords()  # Your keyword list
for kw in keywords:
    params = {
        'type': 'phrase_organic',
        'key': API_KEY,
        'phrase': kw,
        'database': 'us',
        'display_limit': 10,
        'export_columns': 'Dn,Ur,Po'
    }
    response = requests.get(BASE_URL, params=params)
    # Parse and store results
    # Compare to yesterday's data
    # Alert if your domain dropped 3+ positions
```

**Bulk keyword difficulty check**:
```python
# Check KD for a list of keywords
keywords = ['seo tools', 'keyword research', 'backlink analysis']
for kw in keywords:
    params = {
        'type': 'phrase_all',
        'key': API_KEY,
        'phrase': kw,
        'database': 'us',
        'export_columns': 'Ph,Nq,Kd,Cp'
    }
    response = requests.get(BASE_URL, params=params)
    # Parse: Keyword, Volume, KD%, CPC
```
