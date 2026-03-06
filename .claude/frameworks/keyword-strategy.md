# Keyword Research and Strategy Methodology

## Purpose
This framework defines the methodology for conducting keyword research, classifying search intent, building keyword clusters, and mapping keywords to content. It provides a repeatable process for identifying organic search opportunities and prioritizing them based on business value and competitive feasibility.

---

## 1. Keyword Research Methodology

### Phase 1: Seed Keyword Generation
Seed keywords are the starting point for expansion. Generate seeds from these sources:

- **Business knowledge**: Core products, services, categories, and brand terms
- **Customer language**: Review customer support tickets, sales call transcripts, and chat logs for the words customers actually use
- **Competitor analysis**: Extract keywords that competitors rank for using Semrush or Ahrefs
- **Google Search Console**: Export queries driving impressions and clicks to identify existing organic footprint
- **Site search data**: Analyze internal site search queries in GA4 to find what users look for on site
- **Industry terminology**: Trade publications, industry glossaries, and professional associations

Target: Generate 50 to 200 seed keywords per major product or service category.

### Phase 2: Keyword Expansion
Expand seed keywords into a comprehensive keyword universe:

- **Semrush Keyword Magic Tool**: Enter seeds, expand to related terms, questions, and long tail variations
- **Google Autocomplete**: Type seeds into Google and record autocomplete suggestions
- **People Also Ask**: Capture PAA questions for each seed query
- **Related Searches**: Record related searches from the bottom of SERPs
- **Answer the Public**: Generate question based keyword variations
- **Google Trends**: Identify trending and seasonal variations of seed keywords
- **Competitor gap analysis**: Use Semrush Keyword Gap to find keywords competitors rank for that you do not

Target: Expand to 500 to 5,000 keywords depending on the scope of the business.

### Phase 3: Keyword Clustering
Group keywords by topic and intent to map them to content:

- Cluster keywords that share the same search intent and would be satisfied by the same page
- Use Semrush Keyword Manager or manual SERP overlap analysis (if 3+ of the top 10 results are the same for two keywords, they belong in the same cluster)
- Name each cluster with a primary keyword (highest volume, most representative of the cluster)
- Assign secondary keywords and supporting terms to each cluster

### Phase 4: Prioritization
Score each keyword cluster using these criteria:

| Criterion               | Weight | Scoring                                              |
|--------------------------|--------|------------------------------------------------------|
| Search volume             | 25%    | Higher volume = higher score                         |
| Business relevance        | 30%    | Direct tie to revenue or lead generation = high      |
| Keyword difficulty        | 20%    | Lower difficulty = higher score (more achievable)    |
| Current ranking position  | 15%    | Already ranking 11 to 20 = high potential (striking distance) |
| SERP feature opportunity  | 10%    | Featured snippet, PAA, or knowledge panel available  |

Calculate a composite priority score and rank clusters from highest to lowest.

---

## 2. Search Intent Classification

Every keyword or keyword cluster must be classified by search intent. Intent determines the content format, depth, and call to action.

### Informational Intent
- **User goal**: Learn, understand, or research a topic
- **Query signals**: "what is," "how to," "why," "guide," "tutorial," "tips," "examples"
- **Content format**: Blog posts, guides, tutorials, explainer videos, infographics
- **Conversion path**: Email signup, content download, newsletter subscription
- **Example**: "how to improve page speed"

### Navigational Intent
- **User goal**: Find a specific website, brand, or page
- **Query signals**: Brand names, product names, "login," "pricing page," "[brand] support"
- **Content format**: Homepage, product pages, account pages, support pages
- **Conversion path**: Direct navigation to desired page
- **Example**: "Semrush login"

### Transactional Intent
- **User goal**: Complete a purchase or take a specific action
- **Query signals**: "buy," "order," "discount," "coupon," "free shipping," "price," "deal"
- **Content format**: Product pages, category pages, landing pages, checkout flows
- **Conversion path**: Add to cart, purchase, signup
- **Example**: "buy nike air max 90"

### Commercial Investigation Intent
- **User goal**: Compare options before making a purchase decision
- **Query signals**: "best," "vs," "review," "comparison," "top 10," "alternative to"
- **Content format**: Comparison pages, review roundups, buyer's guides, case studies
- **Conversion path**: Click through to product page, request demo, free trial
- **Example**: "Shopify vs WooCommerce for small business"

---

## 3. Keyword Difficulty vs Opportunity Matrix

Plot keyword clusters on a 4 quadrant matrix to guide prioritization:

```
                    HIGH OPPORTUNITY (Volume + Relevance)
                    |
    QUICK WINS      |      STRATEGIC TARGETS
    Low difficulty,  |      High difficulty,
    high opportunity |      high opportunity
    ACTION: Target   |      ACTION: Build
    immediately      |      long-term content
                    |      and link strategy
  ------------------|------------------
    LOW PRIORITY     |      HARD BATTLES
    Low difficulty,  |      High difficulty,
    low opportunity  |      low opportunity
    ACTION: Target   |      ACTION: Deprioritize
    only if resources|      or avoid
    allow            |
                    |
                    LOW OPPORTUNITY
```

### Quadrant Definitions

**Quick Wins (Low Difficulty, High Opportunity)**
- Keywords with meaningful volume and business relevance that have low competition
- Often long tail or niche terms that larger competitors overlook
- Action: Create content immediately; expect results within 2 to 4 months

**Strategic Targets (High Difficulty, High Opportunity)**
- High volume, high value keywords dominated by strong competitors
- Require sustained content investment, link building, and topical authority
- Action: Build a content cluster around the topic; plan for 6 to 12 month timeline

**Low Priority (Low Difficulty, Low Opportunity)**
- Easy to rank for but limited traffic or business value
- Useful for filling content gaps or building topical coverage
- Action: Target when bandwidth allows; do not invest significant resources

**Hard Battles (High Difficulty, Low Opportunity)**
- Difficult to rank for and limited return even if successful
- Action: Avoid unless there is a compelling strategic reason (brand positioning, industry credibility)

---

## 4. Content Mapping to Keyword Clusters

### Mapping Structure
Each keyword cluster maps to one target page. Each target page has:

- **Primary keyword**: The single most important keyword for the page (used in title tag, H1, URL)
- **Secondary keywords**: 3 to 5 closely related keywords (used in H2 headings, body content, meta description)
- **Supporting terms**: 10 to 20 semantically related terms and phrases (used naturally throughout the content to signal topical depth)

### Mapping Checklist
- [ ] Each keyword cluster maps to exactly one page (no cluster should target multiple pages)
- [ ] No two pages target the same primary keyword (prevents cannibalization)
- [ ] The content format matches the search intent of the cluster
- [ ] Existing pages are evaluated before creating new ones (update and optimize first)
- [ ] The page's internal linking connects it to the broader topic cluster (reference content-architecture.md)

### Content Gap Identification
After mapping keywords to existing pages, identify gaps:
- Keyword clusters with no existing page = content creation opportunity
- Keyword clusters where the existing page is a poor match (wrong intent or format) = content revision opportunity
- Keyword clusters where the existing page is thin = content expansion opportunity

---

## 5. Seasonal Keyword Planning

### Trend Analysis
- Use Google Trends to identify seasonal patterns for key product and topic keywords
- Compare year over year search volume data in Semrush for monthly patterns
- Map seasonal peaks to a 12 month content calendar

### Content Calendar Alignment
- Publish seasonal content 6 to 8 weeks before the anticipated search volume peak
- Refresh existing seasonal content 4 weeks before peak season
- Plan promotional landing pages 8 weeks in advance for peak seasons
- After peak season, do not remove seasonal content; update it for the next cycle

### Seasonal Keyword Categories
| Season/Event          | Lead Time (Before Peak) | Content Actions                          |
|-----------------------|-------------------------|------------------------------------------|
| Holiday shopping      | 8 to 10 weeks           | Gift guides, deals pages, category pages |
| Back to school        | 6 to 8 weeks            | Product roundups, buying guides          |
| Industry trade shows  | 4 to 6 weeks            | Preview content, trend analysis          |
| Tax season            | 8 weeks                 | Service pages, FAQ content               |
| Summer/Winter peaks   | 6 to 8 weeks            | Seasonal category pages, blog content    |

---

## 6. Long Tail Keyword Strategy

### Why Long Tail Matters
- Long tail keywords (4+ words) typically have lower competition and higher conversion rates
- They collectively represent the majority of all search queries
- They reveal specific user needs and purchase intent
- They are ideal for building topical authority through comprehensive content coverage

### Long Tail Identification Methods
- Filter keyword research data for queries with 4+ words
- Mine Google Search Console for queries with impressions but low CTR (indicating opportunity)
- Analyze People Also Ask and Related Searches for long tail variations
- Review customer questions from support channels, forums, and social media
- Use answer based tools (AnswerThePublic, AlsoAsked) for question variations

### Long Tail Content Strategy
- Create FAQ sections on existing pages to capture long tail queries
- Build comprehensive guides that naturally include long tail variations
- Create dedicated pages for high value long tail clusters (e.g., specific use cases, niche comparisons)
- Use long tail keywords in H2/H3 headings within pillar content

---

## 7. SERP Feature Targeting

### Featured Snippets
- **Trigger format**: Definition queries ("what is"), process queries ("how to"), list queries ("best," "top")
- **Optimization**: Provide a concise answer (40 to 60 words) immediately after the target heading, then expand with detail
- **Content formats**: Paragraph snippets (definitions), list snippets (steps, rankings), table snippets (comparisons, data)
- **Targeting**: Identify queries where competitors hold featured snippets and create better structured answers

### People Also Ask (PAA)
- **Opportunity**: Each PAA question is a potential featured snippet position
- **Optimization**: Include PAA questions as H2 or H3 headings with direct answers
- **Research**: Expand PAA boxes for target queries to discover all related questions
- **Implementation**: Address 3 to 5 PAA questions within each comprehensive content page

### Knowledge Panels
- **Trigger**: Brand or entity queries with sufficient authority signals
- **Optimization**: Build entity authority through schema markup, Wikipedia, Wikidata, and consistent NAP/entity data (reference aeo-methodology.md)
- **Maintenance**: Monitor knowledge panel accuracy and submit corrections through Google's feedback mechanism

### Local Pack
- **Trigger**: Queries with local intent ("near me," city names, service area terms)
- **Optimization**: Google Business Profile optimization, local schema, NAP consistency, local content
- **Targeting**: Include city and service area keywords in page titles and content for local service pages

---

## 8. Keyword Cannibalization Detection and Resolution

### What is Cannibalization
Keyword cannibalization occurs when multiple pages on the same site compete for the same keyword, diluting ranking signals and confusing search engines about which page to rank.

### Detection Methods
- **GSC query report**: Filter by a target keyword and check if multiple pages receive impressions. If more than one page appears for the same query, cannibalization is likely.
- **Site: search**: Search `site:domain.com "target keyword"` and review which pages appear
- **Rank tracking**: Monitor if different pages alternate in rankings for the same keyword (URL flipping)
- **Semrush Cannibalization Report**: Identify keywords where multiple URLs from the same domain rank

### Resolution Strategies

| Scenario                                   | Resolution                                              |
|--------------------------------------------|----------------------------------------------------------|
| Two similar pages targeting the same keyword | Consolidate into one comprehensive page; 301 redirect the weaker page |
| A blog post and a product page competing    | Differentiate intent: optimize the blog for informational intent, the product page for transactional intent |
| Category page and subcategory page competing | Refine keyword targeting: assign distinct primary keywords to each |
| Thin pages cannibalizing a strong page      | Remove or noindex thin pages; redirect if they have backlinks |
| New content cannibalizing old content       | Update internal linking to signal the preferred page; adjust title tags and on page optimization |

### Prevention
- Maintain a keyword map document that assigns each primary keyword to exactly one URL
- Review the keyword map before creating new content
- Use the content mapping process (Section 4) to ensure no overlaps
- Audit for cannibalization quarterly using GSC data
