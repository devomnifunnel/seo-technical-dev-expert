---
name: content-optimization
description: "On page SEO and content quality optimization. Use when reviewing title tags, meta descriptions, heading structure, E-E-A-T scoring, or content freshness. Trigger on: on page SEO, title tag, meta description, headings, E-E-A-T, content quality, thin content, content decay, featured snippets."
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch, mcp__google-search-console__, mcp__google-analytics__
argument-hint: "[URL or page to optimize]"
---

# On Page SEO and Content Optimization

## Title Tag Optimization

### Length Guidelines

- **Optimal length:** 50 to 60 characters (approximately 580 pixels wide).
- **Maximum display width:** Google truncates titles beyond ~580 pixels.
- **Minimum recommended length:** 30 characters. Shorter titles miss keyword opportunities.

### Keyword Placement

Place the primary keyword as close to the beginning of the title as possible. Front loading keywords improves both relevance signaling and click through rates.

**Effective patterns:**

```
Primary Keyword: Secondary Modifier | Brand Name
Primary Keyword for [Audience/Use Case] | Brand Name
How to [Primary Keyword]: Step by Step Guide | Brand Name
```

**Examples:**

```
Technical SEO Checklist: 47 Point Audit for 2026 | Example Agency
NetSuite SuiteCommerce SEO: Complete Optimization Guide | ExampleCo
Core Web Vitals Optimization for Ecommerce Sites | Example Agency
```

### CTR Optimization

Incorporate these elements to improve click through rate:

1. **Numbers:** "15 Proven Strategies" outperforms "Strategies for Success."
2. **Current year:** Including "2026" signals freshness.
3. **Power words:** "Complete," "Ultimate," "Proven," "Essential."
4. **Parenthetical clarifiers:** "(With Examples)" or "(Free Template)."
5. **Question format:** Matches conversational search intent.

**Testing methodology:** Use Google Search Console to identify pages with high impressions but low CTR (below 3%). Rewrite titles and monitor CTR changes over 4 weeks.

## Meta Description Writing

### Length Guidelines

- **Optimal length:** 150 to 160 characters.
- **Maximum display length:** Google truncates at approximately 920 pixels (desktop).
- **Mobile display:** Often shorter, around 120 characters. Front load the value proposition.

### Writing Framework

Follow this structure for every meta description:

1. **Hook (first 80 characters):** State the primary benefit or answer the implied question.
2. **Value proposition (next 40 characters):** Differentiate your content from competitors.
3. **Call to action (final 40 characters):** Direct the reader to click.

**Template:**

```
[Direct answer or benefit statement]. [Unique differentiator or specific detail]. [Call to action].
```

**Examples:**

```
Learn how to optimize crawl budget for sites with 100K+ pages. Includes a free
audit template and SuiteScript examples. Start your technical SEO audit today.

Improve Core Web Vitals scores with 12 proven techniques. Real before and after
case studies from ecommerce sites. Get actionable fixes you can deploy this week.
```

### Keyword Inclusion

Google bolds query matches in meta descriptions, which draws the eye. Include the primary keyword naturally and consider secondary keywords if they fit without forcing.

## Heading Structure

### H1 Tag Rules

- **One H1 per page.** This is the page's primary heading and should contain the primary target keyword.
- **Match search intent.** The H1 should clearly communicate what the page is about.
- **Differentiate from the title tag.** The H1 can be longer and more descriptive than the title tag.

### H2 through H6 Hierarchy

Maintain a logical outline structure. Never skip heading levels (e.g., jumping from H2 to H4).

```html
<h1>Complete Guide to Technical SEO</h1>
    <h2>Crawl Optimization</h2>
        <h3>robots.txt Configuration</h3>
        <h3>XML Sitemap Structure</h3>
        <h3>Crawl Budget Management</h3>
    <h2>Indexation Control</h2>
        <h3>Canonical Tags</h3>
        <h3>Noindex Directives</h3>
    <h2>Site Architecture</h2>
        <h3>URL Structure</h3>
        <h3>Internal Linking</h3>
            <h4>Contextual Links</h4>
            <h4>Navigation Links</h4>
```

### Keyword Distribution Across Headings

- **H1:** Primary keyword, used once.
- **H2 headings:** Include secondary keywords and topic variations naturally.
- **H3 headings:** Use long tail variations and specific subtopics.
- **Avoid keyword stuffing in headings.** Each heading should read naturally and provide genuine organizational value.

## Content Quality Scoring: E-E-A-T Rubric

Score each piece of content on a 1 to 5 scale across these dimensions:

### Experience (Weight: 20%)

| Score | Criteria |
|-------|----------|
| 1 | No evidence of firsthand experience with the topic |
| 2 | Generic advice that could be written without experience |
| 3 | Some specific examples suggesting real experience |
| 4 | Detailed case studies or examples from direct experience |
| 5 | Rich firsthand accounts, original data, personal testing results |

### Expertise (Weight: 30%)

| Score | Criteria |
|-------|----------|
| 1 | Content contains factual errors or outdated information |
| 2 | Surface level treatment; lacks depth or nuance |
| 3 | Competent coverage with accurate, current information |
| 4 | Expert level depth with technical precision and insight |
| 5 | Industry leading analysis; cited as a reference by peers |

### Authoritativeness (Weight: 25%)

| Score | Criteria |
|-------|----------|
| 1 | No author attribution; unknown publisher |
| 2 | Author identified but no credentials or track record |
| 3 | Author has relevant credentials; site has moderate domain authority |
| 4 | Recognized expert author; authoritative publisher in the niche |
| 5 | Definitive authority; Knowledge Panel presence; widely cited |

### Trustworthiness (Weight: 25%)

| Score | Criteria |
|-------|----------|
| 1 | No sources cited; potential misinformation |
| 2 | Few or unreliable sources; lacks transparency |
| 3 | Sources cited; clear about limitations; contact info present |
| 4 | Primary sources used; transparent methodology; author bio |
| 5 | Impeccable sourcing; editorial standards documented; peer reviewed |

**Composite score calculation:** Multiply each dimension score by its weight and sum. A score of 4.0 or above indicates high quality content ready for publication. Scores below 3.0 require significant revision.

## Featured Snippet Optimization

Target formats: paragraph (40 to 60 words), ordered/unordered lists (5 to 8 items), tables (clear headers, concise cells). Place the direct answer immediately after the question heading.

For HTML code examples of paragraph, list, and table snippet formatting, see:
`$CLAUDE_SKILL_DIR/references/featured-snippet-examples.md`

## Image SEO

Key rules: descriptive alt text (5 to 15 words, keyword if natural, never "Image of"), descriptive filenames before upload, WebP/AVIF preferred formats, under 100KB standard / 200KB hero, lazy load below fold images only (never the LCP element).

For detailed alt text examples, compression guidelines, and lazy loading code patterns, see:
`$CLAUDE_SKILL_DIR/references/image-seo-reference.md`

## Internal Linking Within Content

### Contextual Relevance

Every internal link should connect topically related content. The linking sentence should provide context about why the linked page is relevant.

**Good example:**
```
To resolve crawl budget issues on large sites, start by auditing your
<a href="/guides/xml-sitemap-optimization">XML sitemap structure</a>
to ensure it only includes indexable, high value pages.
```

**Bad example:**
```
For more information, <a href="/guides/xml-sitemap-optimization">click here</a>.
```

### Anchor Text Best Practices

Maintain variety in anchor text to avoid over optimization:

| Anchor Type | Target Distribution | Example |
|-------------|-------------------|---------|
| Exact match keyword | 10 to 20% | "crawl budget optimization" |
| Partial match | 25 to 35% | "optimize your crawl budget" |
| Branded | 15 to 25% | "Example Agency's guide" |
| Natural/generic | 10 to 15% | "this comprehensive guide" |
| Long tail variation | 15 to 25% | "how to manage crawl budget for large ecommerce sites" |

### Internal Linking Targets

- Link to cornerstone/pillar pages from related blog posts and supporting content.
- Each new piece of content should include 3 to 5 internal links to relevant existing pages.
- After publishing, update 3 to 5 existing pages to link to the new content.
- Orphan pages (pages with zero internal links pointing to them) should be identified and linked monthly.

## Content Freshness Signals

### Publication Dates

Always display a visible publication date on content pages. Use ISO 8601 format in structured data.

```html
<time datetime="2026-03-01" itemprop="datePublished">March 1, 2026</time>
```

### Last Modified Dates

Show a "Last Updated" date when content is revised. Update the `dateModified` in Article schema.

```html
<p>Last updated: <time datetime="2026-03-04" itemprop="dateModified">March 4, 2026</time></p>
```

### Content Update Strategy

| Content Type | Recommended Update Frequency | Key Update Actions |
|--------------|-----------------------------|--------------------|
| Statistics pages | Quarterly | Refresh data, update sources |
| How to guides | Every 6 months | Verify steps, update screenshots |
| Tool reviews | Every 6 months | Check pricing, features, alternatives |
| Industry news | As events occur | Update with new developments |
| Evergreen guides | Annually | Review for accuracy, add new sections |

**Update process:**
1. Review content accuracy and completeness.
2. Update outdated statistics, screenshots, and references.
3. Add new sections covering recent developments.
4. Improve internal and external links.
5. Update the `dateModified` field in schema markup.
6. Resubmit the URL to Google Search Console for recrawling.

## Thin Content Identification and Remediation

### Identification Criteria

A page qualifies as thin content if it meets one or more of these conditions:

1. **Word count below 300** for informational pages (product pages may be shorter).
2. **Duplicate or near duplicate** of another page on the site (85%+ similarity).
3. **No unique value** beyond what is available on other indexed pages.
4. **Automatically generated** content with no editorial review.
5. **Boilerplate heavy** pages where template text exceeds original content.
6. **Low engagement metrics:** Average time on page under 10 seconds and bounce rate above 90%.
7. **Zero organic impressions** over 90 days (for pages that should attract search traffic).

### Remediation Strategies

For each thin content page, choose one of these approaches:

**1. Expand and improve (preferred for pages with ranking potential):**
- Add original research, examples, or analysis.
- Include images, tables, or videos that enhance the content.
- Target a minimum of 800 words for informational pages.
- Strengthen E-E-A-T signals with author attribution and sources.

**2. Consolidate (for pages covering overlapping topics):**
- Merge thin pages into a single comprehensive page.
- 301 redirect the deprecated URLs to the consolidated page.
- Update internal links to point to the new destination.

**3. Noindex (for necessary pages that should not rank):**
- Apply `<meta name="robots" content="noindex, follow" />` to pages like tag archives, author archives, or thin category pages.
- Keep the pages accessible for users but prevent them from diluting crawl budget.

**4. Remove (for pages with no value):**
- Delete the page and return a 410 (Gone) status code.
- Remove all internal links pointing to the deleted page.
- Add the URL to your disallow list in robots.txt as a secondary signal.

### Thin Content Audit Process

1. Crawl the full site with Screaming Frog. Export all HTML pages with word count data.
2. Filter pages with word count below 300.
3. Cross reference with Google Analytics for engagement metrics (time on page, bounce rate).
4. Cross reference with Google Search Console for impression and click data.
5. Categorize each thin page into one of the four remediation strategies.
6. Prioritize pages that are currently indexed and receiving impressions but no clicks.
7. Execute remediation in batches of 20 to 50 pages per month.
8. Monitor indexation changes in Search Console after each batch.
