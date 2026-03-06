---
name: link-building
description: "Link acquisition, backlink audits, and internal linking architecture. Use when auditing backlinks, planning outreach, or optimizing internal links. Trigger on: link building, backlinks, disavow, anchor text, internal linking, outreach, digital PR, toxic links, domain authority."
disable-model-invocation: true
---

# Link Building and Management

## Backlink Profile Audit Methodology

### Data Collection

Pull backlink data from multiple sources to ensure completeness:

1. **Google Search Console:** Links report provides Google's own view of your backlink profile.
2. **Ahrefs:** Export the full backlink report (Referring Domains view and Backlinks view).
3. **SEMrush:** Backlink Analytics export for cross referencing.
4. **Majestic:** Trust Flow and Citation Flow metrics add another quality dimension.

Merge datasets and deduplicate by referring domain. A complete audit examines unique referring domains, not individual backlinks.

### Quality Scoring Framework

Score each referring domain on a 1 to 10 scale using these criteria:

| Factor | Weight | Scoring Criteria |
|--------|--------|-----------------|
| Domain Authority/Rating | 25% | DR 0 to 20 = 2 pts, DR 21 to 40 = 4 pts, DR 41 to 60 = 6 pts, DR 61 to 80 = 8 pts, DR 81+ = 10 pts |
| Topical Relevance | 30% | Is the linking site in a related industry or niche? |
| Traffic | 15% | Does the linking site receive organic traffic? |
| Link Placement | 15% | Editorial/contextual = 10, sidebar = 5, footer = 2 |
| Anchor Text | 15% | Natural and relevant = 10, generic = 6, spammy = 2 |

**Score thresholds:**

- 7.0 to 10.0: High quality link. Protect and nurture this relationship.
- 4.0 to 6.9: Moderate quality. Acceptable but not a priority to replicate.
- 2.0 to 3.9: Low quality. Monitor for potential issues.
- Below 2.0: Potentially toxic. Investigate and consider for disavow.

### Toxicity Assessment

Flag a backlink as potentially toxic if it exhibits two or more of these characteristics:

1. Referring domain has zero organic traffic.
2. The linking page contains 50+ external links.
3. The site is in an unrelated language or niche with no logical connection to yours.
4. The anchor text is exact match for a money keyword and the link is from a low quality source.
5. The referring domain is a known PBN (private blog network) or link farm.
6. The link was placed in auto generated or spun content.
7. The referring domain has been penalized (check for sudden traffic drops in Ahrefs).

## Competitor Backlink Gap Analysis

### Process

**Step 1: Identify competitors.**

Select 3 to 5 direct competitors who rank for your target keywords. Include both domain level competitors and page level competitors.

**Step 2: Extract competitor backlinks.**

Pull the referring domain lists for each competitor from Ahrefs or SEMrush.

**Step 3: Run the gap analysis.**

Using Ahrefs Link Intersect or SEMrush Backlink Gap tool:

1. Enter your domain and up to 4 competitor domains.
2. Filter for domains that link to at least 2 competitors but not to you.
3. Sort by Domain Rating (highest first).
4. Export the results.

**Step 4: Qualify opportunities.**

For each gap domain, evaluate:

- Is the site topically relevant?
- What type of content did they link to (resource page, guest post, editorial mention)?
- Can you create something comparable or superior?
- Is the linking page still active and indexed?

**Step 5: Prioritize outreach.**

Rank opportunities by: (1) relevance, (2) domain authority, (3) feasibility. Target 50 to 100 domains per quarter for outreach.

## Link Building Techniques

### Digital PR

Create newsworthy content assets that attract editorial links:

1. **Original research and data studies.** Survey your audience, analyze industry data, or publish benchmarks. Example: "State of Ecommerce SEO 2026: Analysis of 10,000 Product Pages."
2. **Expert roundups with a unique angle.** Curate insights from industry leaders on a timely topic.
3. **Interactive tools and calculators.** Build free tools that serve your audience (ROI calculator, SEO audit tool).
4. **Data visualizations and infographics.** Transform complex data into shareable visual formats.

**Success metrics:** Target 10 to 30 referring domains per campaign from DR 40+ sites.

### Guest Posting

Write high quality articles for relevant industry publications:

**Qualification criteria for target sites:**

- Domain Rating 40 or above.
- Active blog with regular publishing schedule.
- Engaged audience (comments, social shares).
- Editorial standards that match your quality expectations.
- No "write for us" pages that attract mass submissions (these are often low value).

**Pitch structure:**

1. Personalize the opening with a specific reference to their recent content.
2. Propose 2 to 3 specific article ideas tailored to their audience.
3. Include a brief author bio demonstrating relevant expertise.
4. Mention one or two published examples of your previous work.
5. Keep the pitch under 150 words.

### Resource Page Link Building

**Process:**

1. Search for resource pages in your niche using queries like:
   - `"useful resources" + [your topic]`
   - `"helpful links" + [your industry]`
   - `intitle:"resources" + [your keyword]`
2. Evaluate each resource page for quality and relevance.
3. Create or identify content on your site that deserves inclusion.
4. Contact the page owner with a concise email explaining why your resource adds value.

### Broken Link Building

**Process:**

1. Use Ahrefs Broken Backlinks report on competitor domains.
2. Identify 404 pages on competitor sites that have backlinks pointing to them.
3. Check the Wayback Machine to understand what the dead page contained.
4. Create equivalent (or better) content on your own site.
5. Contact each site linking to the dead page and suggest your content as a replacement.

**Typical conversion rate:** 5 to 15% of outreach emails result in a link placement.

### HARO (Help a Reporter Out) and Journalist Platforms

**Process for HARO, Connectively, Qwoted, and similar services:**

1. Sign up as a source and set category filters for your expertise.
2. Monitor queries 3 times daily (queries are time sensitive).
3. Respond within 2 hours of a relevant query being posted.
4. Keep responses concise (under 200 words), include a specific data point or unique insight.
5. Include your full name, title, company, and a link to your bio page.

**Response template:**

```
Hi [Reporter Name],

[Direct answer to their question in 1-2 sentences.]

[Supporting detail, statistic, or example in 2-3 sentences.]

[Brief expert insight or unique angle they won't get from other sources.]

Happy to provide additional context or data if helpful.

[Your Name]
[Title], [Company]
[Bio URL]
```

## Outreach Email Templates

### Guest Post Pitch

```
Subject: Content idea for [Publication Name]

Hi [Name],

I enjoyed your recent article on [specific article topic]. The section about
[specific detail] was particularly useful because [genuine compliment or insight].

I have a couple of content ideas that I think would resonate with your audience:

1. [Article title]: [One sentence description of the value it provides]
2. [Article title]: [One sentence description of the value it provides]

I am [Your Name], [your role] at [Company]. I have previously published on
[Publication 1] and [Publication 2].

Would either of these be a good fit for your editorial calendar?

Best,
[Your Name]
```

### Broken Link Replacement

```
Subject: Broken link on your [Page Title] page

Hi [Name],

While reading your [page title/topic] resource page, I noticed that the link
to [dead page description] is returning a 404 error.

I recently published a comprehensive guide on the same topic:
[Your URL]

It covers [brief description of your content's scope and value].

If you find it useful, it could be a good replacement for the broken link.
Either way, I wanted to flag the broken link for you.

Cheers,
[Your Name]
```

### Resource Page Inclusion

```
Subject: Resource suggestion for your [topic] page

Hi [Name],

I found your [page title] resource page while researching [topic]. It is a
great collection. I noticed you include resources about [related subtopic].

We recently published [content title], which covers [brief value description].
I thought it might be a useful addition for your readers.

Here is the link: [Your URL]

Let me know if you have any questions or would like additional context.

Thanks,
[Your Name]
```

## Internal Linking Strategy

### Silo Structure

Organize content into thematic silos where pages within the same topic cluster link heavily to each other and to a central pillar page.

```
Pillar Page: /guides/technical-seo/
    ├── /guides/technical-seo/robots-txt/
    ├── /guides/technical-seo/xml-sitemaps/
    ├── /guides/technical-seo/canonical-tags/
    ├── /guides/technical-seo/redirect-management/
    └── /guides/technical-seo/crawl-budget/

Each supporting page links to:
  - The pillar page (upward link)
  - 2-3 sibling pages within the silo (lateral links)
  - 1-2 pages in related silos (cross-silo links)
```

### Contextual Link Implementation

Place internal links within the body content where they are contextually relevant. Aim for:

- **3 to 5 internal links per 1,000 words** of content.
- **At least 1 link in the first 200 words** pointing to the most important related page.
- **Natural distribution** throughout the content, not clustered in one section.

### Automated Internal Linking

For large sites, implement automated internal linking using keyword to URL mapping:

```javascript
// Internal linking configuration map
const internalLinkMap = {
    "crawl budget": "/guides/technical-seo/crawl-budget/",
    "canonical tags": "/guides/technical-seo/canonical-tags/",
    "core web vitals": "/guides/core-web-vitals/",
    "schema markup": "/guides/schema-markup/",
    "title tag optimization": "/guides/content-optimization/title-tags/"
};

// Rules:
// 1. Only link the first occurrence of each phrase per page.
// 2. Do not create self-referencing links.
// 3. Maximum 1 automated link per 200 words.
// 4. Do not link within headings or existing anchor tags.
// 5. Case-insensitive matching.
```

## Anchor Text Optimization

### Natural Distribution Targets

| Anchor Type | Target Percentage | Description |
|-------------|-------------------|-------------|
| Branded | 30 to 40% | Company name, URL, brand variations |
| Naked URL | 10 to 15% | "www.example.com" or "example.com" |
| Exact match keyword | 5 to 10% | Exact target keyword as anchor text |
| Partial match | 15 to 20% | Contains the keyword with additional words |
| Generic | 10 to 15% | "click here," "learn more," "this guide" |
| Related/LSI terms | 10 to 15% | Synonyms and semantically related phrases |

**Warning signs of over optimization:**

- Exact match anchors exceed 15% of total anchors.
- Unnatural ratio of keyword rich anchors from low quality sites.
- Sudden spike in exact match anchors over a short period.

## Disavow File Creation and Management

### When to Disavow

Only disavow links when:

1. You have received a manual penalty notification in Google Search Console.
2. You have a documented history of participating in link schemes.
3. Obvious, large scale spam attacks are targeting your site with toxic links.

Do not proactively disavow links simply because they have low domain authority. Google's algorithms are generally capable of ignoring low quality links without manual intervention.

### Disavow File Format

```
# Disavow file for example.com
# Last updated: 2026-03-01
# Review quarterly

# Individual URLs to disavow
https://spamsite1.com/page-linking-to-us
https://spamsite2.com/another-page

# Entire domains to disavow
domain:spammy-directory.com
domain:link-farm-network.com
domain:cheap-seo-links.com
domain:auto-generated-blog.com

# Domains identified in spam attack (January 2026)
domain:attack-domain-1.com
domain:attack-domain-2.com
domain:attack-domain-3.com
```

### Disavow File Management Process

1. **Initial creation:** Export all toxic links identified in your audit. Group by domain. If all links from a domain are toxic, disavow the entire domain using the `domain:` prefix.
2. **Submission:** Upload via Google Search Console at `https://search.google.com/search-console/disavow-links`.
3. **Documentation:** Maintain a separate log documenting why each domain or URL was disavowed.
4. **Quarterly review:** Re audit disavowed domains. Remove entries for domains that no longer link to you. Add newly identified toxic domains.
5. **Impact monitoring:** Track organic traffic and ranking changes for 4 to 8 weeks after submitting an updated disavow file.

## Link Velocity Monitoring

### What Is Link Velocity

Link velocity measures the rate at which your site acquires new backlinks over time. Sudden spikes or drops can signal issues.

### Benchmarking

1. Calculate your average monthly new referring domains over the past 12 months.
2. Compare against your top 3 competitors' link velocity.
3. Set a target link velocity that aligns with your growth goals.

**Healthy link velocity indicators:**

- Steady growth of 5 to 20 new referring domains per month for small to mid size sites.
- Larger sites or active link builders may see 50 to 200+ per month.
- Spikes during content launches or PR campaigns are normal if they taper naturally.

**Warning signs:**

- A sudden spike of hundreds of new links from low quality domains (potential negative SEO).
- A sharp drop in link velocity (may indicate lost links or content deindexation).
- All new links have identical or very similar anchor text (unnatural pattern).

### Monitoring Setup

1. Set up weekly alerts in Ahrefs for new referring domains.
2. Create a monthly link velocity tracking spreadsheet with columns: Month, New Referring Domains, Lost Referring Domains, Net Change, Average DR of New Links.
3. Review quarterly to identify trends and adjust link building efforts.
4. Flag any month where new referring domains exceed 3x the trailing average for investigation.

## Implementation Priorities

### Quick Wins (Month 1)

1. Run a full backlink audit and identify toxic links.
2. Fix all broken internal links using Screaming Frog.
3. Add 3 to 5 internal links to your top 20 landing pages.
4. Set up link monitoring alerts.

### Foundation Building (Months 2 to 3)

1. Complete competitor gap analysis and prioritize 50 outreach targets.
2. Develop one link worthy content asset (original research or tool).
3. Begin guest post outreach to 10 to 15 qualified publications.
4. Implement silo internal linking structure.

### Ongoing Operations (Monthly)

1. Produce one new link worthy content asset.
2. Send 30 to 50 outreach emails targeting gap domains and resource pages.
3. Respond to 10+ HARO queries.
4. Audit and update internal links on newly published content.
5. Track link velocity and referring domain quality trends.
6. Review and update disavow file quarterly.
