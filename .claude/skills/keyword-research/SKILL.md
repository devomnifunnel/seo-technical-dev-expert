---
name: keyword-research
description: "Keyword discovery, intent classification, and content mapping. Use when building keyword lists, analyzing search intent, or planning content around keywords. Trigger on: keyword research, search intent, keyword clustering, keyword difficulty, search volume, topic mapping, content planning."
context: fork
agent: Explore
---

# Keyword Research and Strategy

## Keyword Research Process

### Step 1: Seed Keyword Generation

Start every keyword research project by building a seed list from multiple sources:

1. **Business terms**: Products, services, categories, brand names, industry jargon
2. **Customer language**: Support tickets, reviews, sales call transcripts, survey responses
3. **Existing rankings**: Pull current ranking keywords from GSC Performance report and Semrush Organic Research
4. **Competitor seeds**: Extract top keywords from 3 to 5 SERP competitors using Semrush Domain Overview
5. **Related searches**: Google autocomplete, People Also Ask, Related Searches at bottom of SERP
6. **Industry forums**: Reddit, Quora, niche forums for the language real users employ

Target: 50 to 200 seed keywords before expansion.

### Step 2: Keyword Expansion

Expand seeds using these tools and techniques:

**Semrush Keyword Magic Tool**:
1. Enter each seed keyword
2. Select "Broad Match" for maximum expansion
3. Filter by volume (minimum 10 per month for niche B2B, minimum 100 for B2C/ecommerce)
4. Export full list including volume, KD%, CPC, SERP features, and intent
5. Use the "Related" tab to find semantically connected terms that may not contain the seed word
6. Apply the "Questions" toggle to isolate question format keywords separately
7. Check the "SERP Features" filter to find keywords triggering featured snippets, PAA, or video carousels

**Google Search Console**:
1. Performance > Queries > sort by impressions descending
2. Filter for queries where position is 8 to 30 (striking distance opportunities)
3. Export queries where impressions are high but clicks are low (CTR optimization candidates)
4. Apply page filter to isolate queries for specific URL sections (e.g., /blog/ or /products/)
5. Compare date ranges (last 3 months vs. prior 3 months) to identify trending queries

**Google Autocomplete and PAA**:
1. Type each seed into Google and capture all autocomplete suggestions
2. Record every People Also Ask question that appears
3. Click PAA questions to trigger additional questions (cascade method, click 3 to 4 rounds)
4. Vary the seed with alphabet modifiers (e.g., "keyword a," "keyword b") to trigger more autocomplete variations
5. Use incognito mode to avoid personalization bias in autocomplete results

### Step 3: Keyword Clustering

Group expanded keywords into topic clusters using these methods:

**SERP Similarity Method** (most reliable):
1. Search each keyword in Google
2. If two keywords share 3+ of the same URLs in the top 10, they belong in the same cluster
3. One page can target the entire cluster

**Semantic Grouping**:
1. Group keywords with shared modifiers (e.g., "best," "how to," "vs," "near me")
2. Group keywords with shared head terms
3. Separate informational from transactional variations

**Cluster sizing targets**:
- Primary keyword: highest volume term in the cluster
- Secondary keywords: 3 to 8 related terms with meaningful volume
- Supporting keywords: long tail variations, question formats, synonyms

### Step 4: Prioritization

Score each keyword cluster on a 1 to 5 scale across four dimensions:

| Factor | Weight | Scoring Criteria |
|--------|--------|-----------------|
| Business Value | 35% | Revenue potential, conversion likelihood, client priority |
| Search Volume | 25% | Monthly search volume relative to market size |
| Keyword Difficulty | 25% | KD% score, SERP competition, content effort required |
| Quick Win Potential | 15% | Current ranking position, content gap size, technical barriers |

### Keyword Prioritization Scoring Formula

Each keyword cluster receives a composite priority score using weighted criteria scored on a 1 to 5 scale.

**Business Value (weight: 0.35)**:
- 5 = Directly tied to primary revenue product/service, high conversion rate keyword
- 4 = Related to secondary revenue stream or strong lead generation keyword
- 3 = Supports brand authority or top of funnel awareness for a revenue category
- 2 = Tangentially related to business, indirect revenue potential
- 1 = Minimal connection to revenue, purely educational or awareness play

**Search Volume Score (weight: 0.25)**:
- 5 = Top 10% volume in the keyword set (relative to market, not absolute)
- 4 = 60th to 89th percentile volume
- 3 = 30th to 59th percentile volume
- 2 = 10th to 29th percentile volume
- 1 = Bottom 10% volume (may still be valuable if business value is high)

**Inverse Difficulty Score (weight: 0.25)**:
- 5 = KD% 0 to 14 (very easy, new site can rank)
- 4 = KD% 15 to 29 (easy, minimal link building needed)
- 3 = KD% 30 to 49 (moderate, achievable with solid content and some authority)
- 2 = KD% 50 to 69 (difficult, requires strong authority and content investment)
- 1 = KD% 70 to 100 (very hard, only high authority domains compete)

**Quick Win Potential (weight: 0.15)**:
- 5 = Already ranking positions 4 to 10, minor optimization needed to move into top 3
- 4 = Ranking positions 11 to 20, existing content needs refresh or expansion
- 3 = Ranking positions 21 to 50, content exists but needs significant improvement
- 2 = Not ranking, but content exists that could be optimized
- 1 = No existing content, page must be created from scratch

**Priority formula**: `(Business Value * 0.35) + (Volume Score * 0.25) + (Inverse Difficulty * 0.25) + (Quick Win * 0.15)`

**Score interpretation**:
- 4.0 to 5.0 = Tier 1 priority. Pursue immediately. Allocate resources first.
- 3.0 to 3.9 = Tier 2 priority. Add to the next content sprint.
- 2.0 to 2.9 = Tier 3 priority. Queue for future planning.
- 1.0 to 1.9 = Tier 4 priority. Monitor only, revisit if conditions change.

## Search Intent Classification

Every keyword must be classified by intent before content mapping.

### Informational Intent
User wants to learn or understand something.

**Signals**: "what is," "how to," "why does," "guide," "tutorial," "examples," "definition," "explain," "meaning of"
**SERP indicators**: Featured snippets, PAA boxes, knowledge panels, video carousels
**Content format**: Blog posts, guides, tutorials, infographics, videos

**Examples**:
1. "what is schema markup" — user seeks a definition and explanation of a technical concept
2. "how to improve page speed" — user wants step by step instructions for a specific task
3. "SEO best practices 2026" — user seeks current guidance on a broad topic
4. "why is my website slow" — user is diagnosing a problem and wants educational content
5. "difference between SEO and SEM" — user wants a conceptual comparison, not a purchase decision
6. "what does bounce rate mean in analytics" — user needs a definition within a specific context

### Navigational Intent
User wants to find a specific website or page.

**Signals**: Brand names, product names, "login," "pricing," "contact," "support," "app," "download"
**SERP indicators**: Sitelinks, knowledge panel for the brand, official site dominates position 1
**Content format**: Landing pages, homepage, product pages

**Examples**:
1. "Semrush login" — user knows the product and wants to access their account
2. "Google Search Console" — user wants to navigate to a specific tool
3. "Shopify pricing" — user wants a specific page on a known brand's site
4. "HubSpot CRM free" — user seeks a specific product variant from a known brand
5. "Ahrefs blog" — user wants to find a specific section of a known website
6. "Nike store near me" — user wants to locate a specific brand's physical presence

### Transactional Intent
User wants to complete a purchase or action.

**Signals**: "buy," "order," "purchase," "discount," "coupon," "free shipping," "deal," "cheap," "price," "subscribe"
**SERP indicators**: Shopping ads, product carousels, price comparisons, merchant listings
**Content format**: Product pages, category pages, pricing pages

**Examples**:
1. "buy running shoes online" — user is ready to purchase a specific product
2. "Semrush discount code" — user is at the point of purchase and seeking savings
3. "order custom t shirts" — user wants to initiate a transaction
4. "cheap laptop under 500" — user has budget constraints and wants to buy now
5. "free trial SEO tool" — user wants to sign up for a service immediately
6. "subscribe to Ahrefs annual plan" — user is ready to commit to a specific purchase

### Commercial Investigation
User is researching before a purchase decision.

**Signals**: "best," "vs," "review," "top 10," "comparison," "alternative to," "pros and cons," "worth it," "should I"
**SERP indicators**: Review sites ranking, comparison tables, listicles
**Content format**: Comparison posts, review roundups, buying guides, "best of" lists

**Examples**:
1. "best SEO tools 2026" — user is evaluating options before choosing a product
2. "Semrush vs Ahrefs" — user is comparing two specific products head to head
3. "top ecommerce platforms for small business" — user is researching solutions for a specific need
4. "is Shopify worth it for dropshipping" — user is evaluating a product for a specific use case
5. "Mailchimp alternatives" — user is dissatisfied with current solution and exploring replacements
6. "WordPress vs Squarespace pros and cons" — user wants a balanced comparison to inform their decision

## Keyword Difficulty Analysis

### KD% Interpretation (Semrush Scale)

| KD% Range | Classification | What It Takes |
|-----------|---------------|---------------|
| 0 to 14 | Very Easy | Minimal authority needed, new site can rank with quality content |
| 15 to 29 | Easy | Some backlinks needed (5 to 10 referring domains), solid content |
| 30 to 49 | Possible | Moderate authority needed (DA 30+), 10 to 25 referring domains |
| 50 to 69 | Difficult | Strong authority needed (DA 50+), 25 to 50 referring domains |
| 70 to 84 | Hard | High authority required (DA 60+), 50+ referring domains, comprehensive content |
| 85 to 100 | Very Hard | Only top authority domains rank, 100+ referring domains, exceptional content |

### Beyond KD%: Manual SERP Analysis

Always manually review the SERP for high priority keywords:

1. **Who ranks?** Check DA/DR of top 10 results. If all are DA 80+ and you are DA 30, deprioritize.
2. **Content depth**: How long and comprehensive are ranking pages? Can you meaningfully exceed them?
3. **Content freshness**: Are results from the last 6 months or years old? Fresh SERPs favor new content.
4. **SERP features**: Does a featured snippet exist? If yes, that is an opportunity to capture position zero.
5. **User generated content**: Do forums or Reddit rank? Weak competition signal.

## Long Tail Keyword Strategy

### Question Keywords
Target "who," "what," "when," "where," "why," "how" queries:
- Map to FAQ sections, dedicated blog posts, or PAA optimization
- Use exact question as H2 heading, answer immediately below
- Average volume is lower but conversion intent is often higher and competition weaker

### Modifier Keywords
Combine head terms with modifiers for long tail variations:
- **Quality modifiers**: best, top, leading, professional, affordable
- **Time modifiers**: 2026, this year, today, latest, updated
- **Location modifiers**: near me, in [city], [state], local
- **Comparison modifiers**: vs, versus, compared to, alternative to
- **Intent modifiers**: buy, hire, get, find, learn, free

### Local Keywords
For businesses with physical locations or service areas:
- "[service] + [city]" patterns
- "[service] near me" patterns
- "[service] in [neighborhood/region]" patterns
- Map to dedicated location pages or GMB optimization

## Keyword to Content Mapping

### Assignment Rules

**Primary keyword**: One per page. The single most important keyword the page targets.
- Appears in title tag, H1, URL slug, meta description, first 100 words
- Each primary keyword should map to exactly one page (no cannibalization)

**Secondary keywords**: 3 to 8 per page. Closely related terms from the same SERP cluster.
- Appear in H2/H3 headings, body content, image alt text
- Reinforce the primary topic without forcing unnatural usage

**Supporting keywords**: 10 to 20 per page. Long tail, synonyms, related entities.
- Appear naturally throughout body copy
- Used in FAQ sections, related content blocks, internal link anchor text

### Content Mapping Template

```
Page: /category/product-type
Primary: "product type keyword" (vol: 2,400, KD: 35)
Secondary:
  - "buy product type" (vol: 800, KD: 28)
  - "best product type" (vol: 1,200, KD: 42)
  - "product type reviews" (vol: 600, KD: 31)
Supporting:
  - "product type for beginners"
  - "affordable product type"
  - "product type comparison"
Intent: Commercial Investigation
Content Format: Category page with buying guide section
Target SERP Features: FAQ rich result, product carousel
```

## Cannibalization Detection

### Identification Methods

**GSC Method**:
1. Performance report > filter by query
2. Click "Pages" tab
3. If multiple pages appear for the same query, cannibalization exists
4. Check if position fluctuates wildly (Google is confused about which page to rank)

**Semrush Method**:
1. Position Tracking > Cannibalization report
2. Review keywords where 2+ pages from the same domain compete
3. Note which page has the higher average position

### Resolution Strategies

1. **Consolidate**: Merge thin or duplicate pages into one comprehensive page. 301 redirect the removed URL.
2. **Differentiate**: Adjust title tags, H1s, and content focus so each page targets distinct intent.
3. **Canonical**: If pages must both exist (e.g., product vs category), use canonical to signal the preferred version.
4. **Noindex**: If a page has utility for users but should not compete in SERPs, apply noindex.
5. **Internal linking**: Reinforce the preferred page with stronger internal link signals and anchor text.

### Cannibalization Resolution Decision Tree

When cannibalization is detected, follow this decision process to select the correct resolution:

**Question 1: Are the competing pages substantially similar in content?**
- YES: Proceed to consolidation assessment (Question 2).
- NO: Proceed to differentiation assessment (Question 4).

**Question 2: Is one page clearly stronger in performance (higher traffic, more backlinks, better position)?**
- YES: Keep the stronger page. Merge unique content from the weaker page into it. 301 redirect the weaker page to the stronger page.
- NO: Evaluate which URL is more authoritative and has a better link profile. If equal, keep the one with the better URL structure. Merge and redirect the other.

**Question 3: After consolidation, does the merged page need significant content expansion?**
- YES: Add the consolidated content update to the content sprint. Flag the page for E-E-A-T review.
- NO: Publish the merged page. Monitor for 30 days to confirm ranking improvement.

**Question 4: Can the pages reasonably target different intents (informational vs. transactional, for example)?**
- YES: Rewrite titles, H1s, and intro paragraphs to clearly separate intent. Adjust internal linking so each page receives anchor text matching its distinct intent.
- NO: Proceed to Question 5.

**Question 5: Do both pages need to exist for UX or business reasons (e.g., a product page and a category page)?**
- YES: Implement canonical from the secondary page to the primary page. Ensure internal linking favors the primary page.
- NO: One page is unnecessary. Consolidate (return to Question 2) or apply noindex to the page that should not compete in search.

**Question 6: After resolution, verify:**
- Check GSC in 2 to 4 weeks: does only one page appear for the target query?
- Monitor position stability: has the fluctuation stopped?
- If cannibalization persists, escalate by reviewing whether additional pages are competing that were not initially identified.

## Content Gap Analysis Process

Use keyword data to identify content gaps where competitors rank but you do not, and where existing content fails to cover topics adequately.

### Step 1: Competitor Keyword Coverage Comparison

1. Open Semrush Keyword Gap tool (under Competitive Research)
2. Enter your domain in the first field
3. Enter 2 to 4 competitor domains in the comparison fields
4. Click "Compare"
5. Select the "Missing" filter to show keywords where all competitors rank and you do not
6. Export this list. These are your primary content gaps.

### Step 2: Weak Keyword Identification

1. In the same Keyword Gap tool, switch to the "Weak" filter
2. This shows keywords where you rank but competitors outrank you by significant margins
3. Sort by volume descending
4. These keywords represent existing content that needs strengthening, not new content creation

### Step 3: Topic Cluster Gap Mapping

1. Take the missing and weak keyword lists from Steps 1 and 2
2. Cluster them using the SERP Similarity Method described in the clustering section
3. Map each cluster to a content type: new page needed, existing page needs expansion, or new section on existing page
4. Assign priority using the keyword prioritization formula

### Step 4: Content Calendar Integration

1. Sort gap clusters by priority score (Tier 1 first)
2. Estimate content creation effort per cluster: simple blog post (4 to 6 hours), comprehensive guide (8 to 16 hours), landing page (6 to 10 hours)
3. Allocate clusters to monthly content sprints based on available writing resources
4. For each cluster, note the target SERP feature and required content format
5. Flag clusters where existing pages can be expanded (lower effort than new creation)

### Step 5: Ongoing Gap Monitoring

1. Rerun the Keyword Gap analysis monthly
2. Track whether previously identified gaps have been filled (content published and ranking)
3. Add newly discovered gaps to the backlog
4. Reprioritize the backlog quarterly based on updated volume, difficulty, and business value data

## Seasonal Keyword Planning

### Google Trends Analysis Process
1. Enter keyword in Google Trends, set time range to "Past 5 years"
2. Identify peak months and trough months
3. Note year over year trend (growing, stable, declining)
4. Compare multiple keywords to find relative seasonality

### Content Calendar Alignment
- Publish seasonal content 2 to 3 months before the peak (Google needs time to index and rank)
- Refresh existing seasonal content 1 month before the peak with updated data and current year references
- Do not depublish seasonal content after the peak; update the date and keep it live for the next cycle
- Plan promotional landing pages with the seasonal keyword calendar in mind

## SERP Feature Opportunities

### Featured Snippet Capture
- Target keywords where a featured snippet already exists (you can replace it)
- Structure content with the exact question as an H2 and a concise 40 to 60 word answer immediately after
- Use tables, ordered lists, and definition formats (Google prefers structured answers)
- Page must already rank in the top 10 to be eligible for featured snippet

**Specific markup and format requirements**:
- **Paragraph snippets**: Place a direct, concise answer (40 to 60 words) immediately after the question heading. Use a `<p>` tag. Do not bury the answer inside a list or table.
- **List snippets**: Use `<ol>` for step by step processes or `<ul>` for item lists directly after the heading. Each `<li>` should be one clear step or item. Aim for 4 to 8 items.
- **Table snippets**: Use a proper `<table>` with `<thead>` and `<tbody>`. Include clear column headers. Tables with 3 to 5 columns and 4 to 8 rows perform best for snippet capture.
- **Definition snippets**: Format as "[Term] is [definition]" in the first sentence after the heading. Keep the definition under 50 words.

### People Also Ask (PAA)
- Extract all PAA questions for your target keywords
- Create FAQ sections that answer each PAA question directly
- Use FAQ schema markup to increase visibility
- Each answer should be 2 to 4 sentences, concise and authoritative

**Specific markup and format requirements**:
- Implement FAQPage schema in JSON-LD format on pages with FAQ sections
- Each question/answer pair maps to a `Question` entity within the `mainEntity` array
- The `acceptedAnswer` text should match the visible on page answer exactly
- Validate with Google Rich Results Test before publishing
- Structure: `<h2>` or `<h3>` for the question, `<p>` for the answer directly below, no intervening elements

### Knowledge Panels
- Build entity authority through Wikipedia, Wikidata, and structured data
- Ensure consistent NAP (Name, Address, Phone) across all platforms
- Implement Organization or Person schema with sameAs links to authoritative profiles

**Specific markup and format requirements**:
- JSON-LD Organization schema must include: `name`, `url`, `logo`, `sameAs` (array of social profiles, Wikidata, Crunchbase), `foundingDate`, `founder`, `description`
- Create or update Wikidata entry for the entity with all verifiable claims sourced
- Ensure Google Knowledge Panel is claimed via Google's knowledge panel claim process
- Wikipedia article (if notable enough) should cite reliable, independent secondary sources

### Image Packs
- Optimize images with descriptive file names (not IMG_001.jpg)
- Write detailed alt text that includes the target keyword naturally
- Use WebP format with appropriate dimensions
- Add image structured data where applicable

**Specific markup and format requirements**:
- File names should be descriptive and keyword relevant (e.g., "blue-running-shoes-nike-pegasus.webp")
- Alt text: 10 to 15 words, describe the image content, include the primary keyword once naturally
- Serve images in WebP with fallback. Dimensions should match the rendered display size (no oversized images scaled down by CSS).
- Implement ImageObject schema with `contentUrl`, `caption`, `description`, and `creator` properties
- Add images to the XML sitemap using `<image:image>` tags within the page's `<url>` entry

### Video Carousels
- Host video on YouTube and embed on page for dual visibility
- Implement VideoObject schema with `name`, `description`, `thumbnailUrl`, `uploadDate`, `duration`, `contentUrl`, and `embedUrl`
- Optimize YouTube title and description with the target keyword
- Add chapters/timestamps to YouTube descriptions for key moments markup

**Specific markup and format requirements**:
- JSON-LD VideoObject schema must include all required properties per Google's documentation
- Thumbnail should be high quality (1280x720 minimum) and visually compelling
- Duration should be between 3 and 15 minutes for most SERP feature appearances
- Transcript or closed captions should be provided for accessibility and additional keyword signals

### Sitelinks Search Box
- Implement WebSite schema with `potentialAction` of type `SearchAction`
- Ensure the site's internal search works correctly and returns relevant results
- The `target` URL pattern must match the site's actual search URL structure

## Semrush Keyword Tool Workflows

### Keyword Magic Tool
1. Navigate to: Semrush dashboard > Keyword Research (left sidebar) > Keyword Magic Tool
2. Enter seed keyword in the search bar > select target country from the dropdown > click "Search"
3. Use the "Questions" filter button (top of results) to isolate question based keywords
4. Use "Broad Match" tab (default) for maximum keyword variations. Switch to "Exact Match" for precise matching or "Related" for semantically connected terms.
5. Apply filters using the filter bar:
   - Volume: set minimum (e.g., 10 for B2B, 100 for B2C) by clicking "Volume" dropdown and entering the minimum value
   - KD%: set maximum (e.g., 60) by clicking "KD%" dropdown and entering the max value
   - Intent: click "Intent" dropdown and select specific intent types to filter
   - SERP Features: click "SERP Features" dropdown and check the features you want (Featured Snippet, PAA, Video, etc.)
   - Word Count: use "Advanced filters" > "Word Count" to find long tail keywords (set minimum 3 or 4 words)
6. Review the "SERP Features" column to identify snippet and PAA opportunities (marked with icons)
7. Use the left sidebar keyword groups to drill into subtopics (these are auto-generated modifier groups)
8. Select keywords using checkboxes > click "Export" > choose CSV format
9. Import exported CSV into keyword mapping spreadsheet for clustering

### Keyword Gap Analysis
1. Navigate to: Semrush dashboard > Competitive Research (left sidebar) > Keyword Gap
2. Enter your domain in the first field (labeled "You")
3. Enter 2 to 4 competitor domains in the comparison fields
4. Select comparison type: "Organic Keywords" (default), or switch to "Paid Keywords" if running PPC as well
5. Click "Compare"
6. Use the filter tabs at the top of results:
   - Select "Missing" to find keywords all competitors rank for that you do not
   - Select "Weak" to find keywords where competitors outrank you significantly
   - Select "Strong" to find keywords where you outrank competitors (defensive monitoring)
   - Select "Untapped" to find keywords where only one competitor ranks (easier opportunities)
   - Select "Unique" to find keywords only you rank for (competitive advantage)
7. Apply volume and difficulty filters using the dropdowns above the results table
8. Sort by volume descending to prioritize high impact opportunities
9. Select keywords using checkboxes > click "Export" > choose CSV format
10. Cross reference exported gaps with the prioritization scoring formula to rank opportunities

### Position Tracking Setup
1. Navigate to: Semrush dashboard > Projects > select or create project
2. Click "Position Tracking" > "Set up"
3. Configure settings:
   - Search engine: Google (default), add Bing if relevant
   - Device: select Mobile, Desktop, or both
   - Location: set to the target geographic market (country, state, or city level)
   - Language: match the target audience language
4. Import target keywords: click "Add keywords" > paste from your keyword map or upload CSV. Include both primary and secondary keywords.
5. Add competitor domains: click "Competitors" tab > add 3 to 5 SERP competitors by domain
6. Set tracking frequency: Daily for critical keywords (top 20 by business value), Weekly for monitoring keywords
7. Create keyword tags: click "Tags" in the keyword list, create tags matching your content clusters (e.g., "Product Category A," "Blog Topics," "Local Keywords") for grouped reporting
8. Set up alerts: click the bell icon > configure alerts for position changes greater than 5 positions (both gains and losses)
9. Configure SERP feature tracking: in the "Overview" tab, check "SERP Features" to monitor featured snippet ownership, PAA presence, and other features
10. Schedule weekly reports: click "Email reports" > set recipients and frequency to weekly on Monday mornings for review
