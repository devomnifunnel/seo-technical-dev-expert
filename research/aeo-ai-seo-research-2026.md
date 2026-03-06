# AEO, AI SEO, and GEO Research Compendium (2025/2026)

Last updated: March 5, 2026

This document compiles the latest research, data points, and actionable findings on Answer Engine Optimization, Generative Engine Optimization, and AI Search Optimization. It is organized by topic and intended to inform updates to the `skills/aeo-ai-seo/SKILL.md` file.

---

## Table of Contents

1. How AI Search Engines Select and Cite Sources
2. Generative Engine Optimization (GEO)
3. Citation Optimization Techniques
4. Entity SEO and Knowledge Graph Optimization
5. AI Overview / AI Mode Optimization
6. Brand Monitoring in AI Search
7. Google Algorithm Updates (2025/2026)
8. Emerging Concepts: AAO, llms.txt, Query Fan Out
9. Key Statistics and Data Points
10. Recommendations for Updating the SKILL.md File

---

## 1. How AI Search Engines Select and Cite Sources

### Platform Specific Selection Criteria

**ChatGPT**

ChatGPT holds approximately 81% of the AI chatbot market share and processes 2.5 billion prompts daily. It uses Bing's Search API for 92% of real time web lookups, meaning content that is not indexed by Bing and Google is unlikely to appear in ChatGPT responses.

Key ranking factors for ChatGPT:
- **Domain authority and backlink profile.** Sites with over 32,000 referring domains are 3.5x more likely to be cited by ChatGPT than sites with fewer than 200 referring domains.
- **Third party validation.** Domains with profiles on platforms like Trustpilot, G2, Capterra, Sitejabber, and Yelp have 3x higher chances of being selected as a source.
- **Content freshness.** The 65% freshness factor means content that worked a year ago may no longer be cited. Regular updates are essential.
- **Content position.** 44.2% of all LLM citations come from the first 30% of text (the intro), 31.1% from the middle section, and 24.7% from the conclusion. Front loading key information is critical.
- **Citation placement value.** The first cited source in a ChatGPT response receives 43% of user clicks, making position one significantly more valuable than any other.
- **Expert authorship.** ChatGPT favors content written by recognized experts with clear author credentials and qualifications.
- **YouTube and branded mentions.** YouTube mentions and branded web mentions are the top factors correlating with AI brand visibility in ChatGPT.

Wikipedia dominates ChatGPT citations at 7.8%, followed by Reddit at 1.8%.

Sources:
- https://aiclicks.io/blog/top-chatgpt-ranking-factors
- https://www.demandsage.com/how-to-rank-on-chatgpt/
- https://www.position.digital/blog/ai-seo-statistics/

**Perplexity AI**

Perplexity uses retrieval augmented generation (RAG) and crawls the live web during each query rather than relying on stale training data.

Key ranking factors for Perplexity:
- **Recency.** Perplexity heavily rewards newly published or freshly updated content. This "recency effect" is one of its most important ranking factors.
- **Domain authority.** Accounts for roughly 15% of ranking weight.
- **Citation frequency.** Drives up to 35% of all AI answer inclusions for a domain. Being frequently cited directly improves authority and traffic.
- **Citation placement.** Visual placement of citations influences 20% of overall ranking weight.
- **Schema and structured data.** Contributes up to 10% of ranking factors by making content more machine readable.
- **Content type preference.** Perplexity favors comprehensive guides, original research, recent updates, comparison articles, expert opinions with credentials, and well structured how to content. It avoids thin content, promotional material, and outdated information.

Perplexity ties every claim to a specific source 78% of the time for complex research questions, compared to ChatGPT at 62%.

Perplexity cites Reddit 6.1x more than YouTube, while Google AI Overviews show near parity between the two.

Sources:
- https://metehan.ai/blog/perplexity-ai-seo-59-ranking-patterns/
- https://www.trysight.ai/blog/how-perplexity-ai-selects-sources
- https://www.clickrank.ai/competitor-cited-in-perplexity/

**Google AI Overviews and AI Mode**

Google AI Overviews appear on roughly 47% of all Google searches and are powered by Gemini 2.5. AI Mode extends this into a fully conversational, multi turn experience.

Key ranking factors for Google AI Overviews:
- **Semantic completeness.** Content scoring 8.5/10+ on topical coverage is 4.2x more likely to be cited.
- **Multi modal content.** Text combined with images and video shows 156% higher selection rates compared to text only.
- **Fact verification.** Verifiable citations and referenced data boost selection probability by approximately 89%.
- **E E A T authority signals.** 96% of AI Overview content comes from verified, authoritative sources.
- **Entity knowledge graph density.** Content with 15+ connected entities shows 4.8x higher citation probability.
- **Structured data implementation.** Proper schema markup delivers 73% higher selection rates.
- **Content format.** Pages with text, images, video, and schema markup achieve a 34.6% selection rate versus 8.3% for text only (a 317% improvement).
- **Optimal passage length.** Self contained answer passages of 134 to 167 words perform best for AI extraction.

Critical shift: Domain Authority correlation dropped to r=0.18 (from 0.43 pre 2024). Traditional organic ranking position matters far less than content level authority signals. 47% of AI Overview citations come from pages ranking below position 5.

Sources:
- https://wellows.com/blog/google-ai-overviews-ranking-factors/
- https://www.averi.ai/blog/google-ai-overviews-optimization-how-to-get-featured-in-2026
- https://www.e2msolutions.com/blog/how-to-optimize-for-google-ai-mode/

### Cross Platform Commonalities

All major AI search engines share these citation preferences:

1. **Authority and trust.** Strong E E A T signals, backlink profiles, and third party validation.
2. **Content structure.** Clear headings, lists, tables, and structured data for easy extraction.
3. **Recency.** Fresh content with visible "Last Updated" signals and current statistics.
4. **Direct answers.** Front loaded, concise, quotable statements in the first sentence after headings.
5. **Verifiability.** Claims supported by cited sources, statistics, and expert quotes.
6. **Entity clarity.** Consistent, unambiguous entity definitions connected across the web.

### Content Formats Most Likely to Be Cited

**Video is the single most cited content format across all verticals.** YouTube alone accounts for nearly a quarter of all AI citations. YouTube citations in AI Overviews have increased by 414% overall, with "how to" video citations jumping by 651%.

For video optimization, popularity metrics (views, likes, subscriber count) carry near zero correlation with citation frequency. What matters instead is structure: timestamps that function like headers, descriptions that read like metadata, and content built for extraction. AI systems access YouTube transcripts through the platform's API and rely entirely on text to understand video content.

Beyond video, the most effective formats are:
- **Lists and bullet points.** Easily parsed and cited by AI systems.
- **Short paragraphs.** Maximum 3 to 4 sentences. AI rarely extracts long text blocks.
- **Direct answer leads.** The first sentence of each section should stand alone as a complete answer.
- **Bold key information.** AI systems give more weight to highlighted text.
- **Tables.** Especially for comparisons, pricing, and feature lists.
- **Q&A format.** The best format for AI search citation.

Structure matters more than length. A 500 word piece that is perfectly structured with direct answers will be cited more often than a disorganized 3,000 word article.

Sources:
- https://searchengineland.com/youtube-ai-search-citations-data-462830
- https://neilpatel.com/marketing-stats/youtube-citations-ai-overviews/
- https://pikaseo.com/articles/youtube-overtakes-reddit-ai-citations

---

## 2. Generative Engine Optimization (GEO)

### The Foundational Research Paper

The seminal GEO paper (Aggarwal et al., published at KDD 2024, arxiv 2311.09735) tested nine optimization methods and measured their impact on visibility in generative engine responses.

**Nine Methods Tested and Their Effectiveness:**

| Method | Visibility Improvement | Best Domains |
|--------|----------------------|--------------|
| Quotation Addition | +40% | People and Society, Explanation, History |
| Statistics Addition | +37% | Law and Government, Debate, Opinion based |
| Cite Sources | +30% | Factual questions, Statements, Law and Government |
| Fluency Optimization | +26% | Business, Science, Health |
| Easy to Understand | +15% | General audience content |
| Technical Terms | Moderate | Specialized domains |
| Authoritative Tone | Minimal | Debate, History, Science |
| Unique Words | Negligible | None significant |
| Keyword Stuffing | Negative | None (counterproductive for generative engines) |

**Critical finding:** Lower ranked websites (positions 4 to 5 in search results) benefited most dramatically from GEO methods, gaining up to 115% visibility improvements with the "Cite Sources" technique. Top ranked sites saw decreased relative visibility as competition increased.

**Key takeaway:** Traditional SEO techniques like keyword stuffing are counterproductive for generative engines. The most effective GEO techniques center on credibility signals (quotations, statistics, citations).

Source: https://arxiv.org/abs/2311.09735

### The 10 Step GEO Framework (Profound, 2025)

A practical implementation framework for GEO:

1. **Align GEO objectives with business KPIs.** Map AI visibility to leads, revenue, or signups. Target metrics: AI attributed leads (+20% YoY), visibility score (Top 3), positive sentiment (90%+ favorable).
2. **Audit current AI visibility and sentiment.** Benchmark visibility scores, share of voice, and sentiment trends across AI platforms.
3. **Map real user prompts across the funnel.** Collect actual customer questions from sales calls, existing customers, and social listening. Document intent at each funnel stage (awareness, consideration, decision).
4. **Structure content for AI friendly summaries.** Use TL;DR blocks, bullet lists, schema markup (FAQPage, HowTo), tables, and comparative articles. Prioritize clarity and organization.
5. **Optimize technical signals and schema markup.** Maintain HTTPS, mobile speed under 1.8 seconds, complete structured data coverage, and track AI bot traffic. Consider adding llms.txt files.
6. **Elevate citation authority through thought leadership.** Publish original research, whitepapers, and expert commentary. Target 20+ high authority domain citations per quarter.
7. **Strengthen E E A T and brand trust signals.** Develop detailed author bios, transparent sourcing, and review schemas. Remove or update outdated content regularly.
8. **Integrate multimedia and data assets for rich answers.** Embed charts, infographics, and video transcripts with descriptive captions and alt tags.
9. **Scale prompt testing and conversation workflows.** Build a library of 20 to 30 unique prompts per core topic, tested daily. Monitor responses and adapt.
10. **Benchmark, report, and iterate quarterly.** Track visibility score, citation count, sentiment index, and share of voice.

**GEO KPI Dashboard Metrics:**
- Visibility score
- Citation count and citation score
- Sentiment index
- Share of voice

**Budget benchmarks:** Mid market brands should expect $75K to $150K annually; enterprise programs require $250K+.

Source: https://www.tryprofound.com/resources/articles/generative-engine-optimization-geo-guide-2025

### How GEO Differs from Traditional SEO

| Aspect | Traditional SEO | GEO |
|--------|----------------|-----|
| Goal | Rank in search results | Be cited in AI generated answers |
| Primary signal | Keywords and backlinks | Entity clarity, citations, structured data |
| Content format | Optimized for CTR | Optimized for extraction |
| Success metric | Rankings, organic traffic | Citation frequency, visibility score |
| Competitive unit | Individual pages | Entire topical authority ecosystem |
| Audience | Human searchers | AI retrieval systems, then humans |

### Key GEO Statistics

- 1 billion prompts are sent to ChatGPT daily.
- 71% of Americans use AI search for purchase research.
- 89% of B2B buyers have adopted generative AI for self guided information.
- 2 to 7 domains are cited per LLM response (versus Google's 10 blue links).
- Generative AI accounts for over 60% of information retrieval by users as of Q1 2026.
- AI search systems exhibit a systematic and overwhelming bias toward earned media (third party, authoritative sources) over brand owned content. Brands are 6.5x more likely to be cited through third party sources than their own domains.

Sources:
- https://www.tryprofound.com/resources/articles/generative-engine-optimization-geo-guide-2025
- https://www.position.digital/blog/ai-seo-statistics/

---

## 3. Citation Optimization Techniques

### What Makes Content Citable by AI Systems

Based on cross platform research, content that earns AI citations consistently exhibits these characteristics:

1. **Front loaded direct answers.** Place the definitive answer in the first sentence after each heading. AI models frequently extract just the first sentence.
2. **Verifiable claims with attribution.** Every statistic should name its source. "According to Gartner's 2025 forecast" carries more weight than an unsourced claim.
3. **Quotations from recognized experts.** Direct quotes from named authorities with credentials improve citation probability by up to 40%.
4. **Structured formatting.** Use headings, ordered lists, unordered lists, tables, and bold text. AI systems give more weight to bold and highlighted text.
5. **Self contained passages.** Each section should be independently extractable. Optimal passage length for AI extraction is 134 to 167 words.
6. **Current data.** 85% of AI Overview citations were published within the last 2 years; 44% were from 2025 alone. Content freshness is a dominant signal.
7. **Multi modal content.** Pages combining text, images, video, and schema markup achieve 317% higher selection rates than text only pages.

### Structured Data That Improves AI Citation Chances

Pages with schema markup are 36% more likely to appear in AI generated summaries. Content with proper schema markup has a 2.5x higher chance of appearing in AI generated answers. Pages with clean structure and schema markup earn 2.8x higher AI citation rates than poorly structured pages.

**Most impactful schema types for AI visibility:**

| Schema Type | Purpose | AI Citation Impact |
|-------------|---------|-------------------|
| Article | Content metadata, authorship, dates | High: enables attribution and freshness signals |
| FAQPage | Question and answer pairs | Very High: AI platforms present info in Q&A format |
| HowTo | Step by step processes | High: matches instructional queries |
| Organization | Brand identity and connections | High: entity recognition and authority |
| Person | Author credentials and expertise | High: E E A T signals |
| Product | Product details, pricing, reviews | High: comparison and purchase queries |
| Review/AggregateRating | Trust signals | Medium: credibility enhancement |
| LocalBusiness | Location based information | High: local and service queries |
| Speakable | Voice assistant optimized content | Growing: voice search integration |

**Implementation notes:**
- JSON LD is the gold standard format. Google's official guidance as of May 2025 explicitly recommends JSON LD for AI optimized content.
- Both Google and Microsoft have publicly stated they use schema markup for their generative AI features.
- GPT 4 accuracy improves from 16% to 54% when content uses structured data.
- Expect 4 to 8 weeks for schema foundation work to take effect, with measurable citation improvements within 90 days.

**Google Schema Deprecations (January 2026):**
Google deprecated support for Practice Problem, Dataset, Sitelinks Search Box, SpecialAnnouncement, and Q&A schema types. These deprecations do not cause penalties but these types no longer trigger rich results.

### Content Formatting Patterns Preferred by AI Extractors

**The Answer First Pattern:**
```
## [Question Based Heading]

[Direct answer in one sentence]. [Supporting context]. [Evidence or statistic with source attribution].

[Expanded explanation paragraph, 3 to 4 sentences maximum].

**Key takeaway:** [Bold summary statement that stands alone as a quotable fact].
```

**The Comparison Table Pattern:**
AI systems frequently cite tabular data for comparison queries.
```
| Feature | Option A | Option B |
|---------|----------|----------|
| Price | $X/mo | $Y/mo |
| Key Benefit | Specific claim | Specific claim |
| Best For | Use case | Use case |
```

**The Step by Step Pattern:**
Numbered lists for processes, each step starting with an action verb and containing a self contained instruction.

Sources:
- https://wpriders.com/schema-markup-for-ai-search-types-that-get-you-cited/
- https://www.stackmatix.com/blog/structured-data-ai-search
- https://www.geostar.ai/blog/complete-guide-schema-markup-ai-search-optimization

---

## 4. Entity SEO and Knowledge Graph Optimization

### Latest Techniques for Building Entity Authority

Entity based SEO has become the foundational discipline for AI search visibility in 2026. Search systems now prioritize context, topical depth, and entity relationships over individual keywords.

**The Three Pillars of Entity SEO:**

1. **Precision.** Every page should be unambiguously about one canonical entity. The title, H1, and schema `mainEntityOfPage` must all point to the same concept.
2. **Coverage.** The entire site should collectively represent the entities and subtopics that define a niche. Think of it as building a mini Knowledge Graph where each node (page) reinforces topical authority.
3. **Connectivity.** Entities gain strength through context. Internal links, `sameAs` references, and schema relationships (such as Product to Category to Brand) tell search engines how concepts fit together.

**The Four Part Entity Playbook:**
Consistency, Structure, Authority, Visibility. Unify brand data, layer in schema markup, publish deep topic cluster content, then package assets for Knowledge Panels, rich snippets, and AI citations.

### How to Optimize for Google's Knowledge Graph

**Step 1: Establish your entity home.**
Create a definitive page on your website that serves as the canonical entity reference. This is the anchor that all other references point back to.

**Step 2: Build corroborating sources.**
- Wikipedia article (following notability guidelines)
- Wikidata entry with proper property mappings
- Google Business Profile (verified and complete)
- Crunchbase, LinkedIn Company Page, and industry directories
- Use `sameAs` in Organization schema to link all profiles

**Step 3: Reinforce with topical clusters.**
Build topic clusters that demonstrate depth and breadth around your entity. A 2025 case study of 50 B2B SaaS websites implementing pillar cluster architecture found:
- 63% increase in "primary topic" keyword rankings within 90 days
- Average domain authority increase of 8 points over 6 months
- 4.7x more internal link equity flowing to priority pages
- AI citation rate increased from 12% to 41% for pillar topics

**Step 4: Ensure entity disambiguation.**
Use your full official name consistently across all pages and profiles. Include disambiguating context (location, industry, founding year) in schema markup. Cross reference related entities in structured data.

### Entity Based Ranking Factors

- **Content with 15+ connected entities** shows 4.8x higher probability of being cited in AI Overviews.
- **E E A T signals** tell AI systems which entities deserve visibility. Strong E E A T helps Google validate whether an entity is credible, knowledgeable, and connected to real world signals such as authorship, brand recognition, citations, and reputation.
- **Topical authority** is now evaluated at the site level, not the page level. Google evaluates how well entire websites cover a subject area, rewarding deep coverage instead of broad, thin coverage.

### Proven Results

- One website using entity based SEO saw a 1400% visibility increase in six months through E E A T optimization.
- A real estate agency's organic traffic surged by more than 100% and impressions increased by over 200% after adding proper schema types and semantic structure.

Sources:
- https://searchengineland.com/guide/entity-first-content-optimization
- https://aliseoservices.com/entity-based-seo/
- https://niumatrix.com/semantic-seo-guide/
- https://www.clickrank.ai/topical-authority/

---

## 5. AI Overview / AI Mode Optimization

### What Triggers AI Overviews

AI Overviews now appear on roughly 47% of all Google searches (up from 25% in mid 2024). They appear in 99.9% of informational queries. The triggers include:

1. **Informational queries** with clear question intent ("how to," "what is," "why does")
2. **Comparison queries** ("X vs Y," "best X for Y")
3. **Multi step processes** that benefit from synthesized answers
4. **Complex topics** where a single result may not fully answer the query
5. **How to content** (YouTube how to video citations jumped 651%)

AI Overviews appear less frequently for navigational queries, branded searches, and simple factual lookups answered by the Knowledge Panel.

### The Query Fan Out Process

Query fan out is the mechanism Google uses to construct AI Overviews and AI Mode responses. It fundamentally changes how content is selected compared to traditional search.

**How it works:**
1. The AI system analyzes the user query for intent, complexity, and response type needed.
2. It decomposes the query into multiple themed sub queries.
3. Sub queries are fired in parallel across the web, Knowledge Graph, Shopping Graph, and Maps.
4. Retrieved content is evaluated based on relevance, recency, authority, extractability, and safety.
5. The AI synthesizes information from multiple sources into a cohesive answer with citations.

**Example:** A query for "best sneakers for walking" might generate sub queries like "best sneakers for men walking," "best sneakers for different seasons," "trail walking sneakers," and "slip on walking sneakers."

**Critical implication for SEO:** A December 2025 Surfer SEO study analyzing 173,902 URLs across 10,000 keywords found that 68% of pages cited in AI Overviews were NOT in the top 10 organic results. This directly contradicts earlier data showing 76% overlap (July 2025). The top 10 overlap has dropped from 76% to approximately 38% as of February 2026.

**Where AI Overview citations actually come from (February 2026):**
- Top 10 organic results: 38%
- Positions 11 to 50: 28%
- Positions 51 to 100: 16%
- Not in top 100: 18%

This means traditional organic ranking is necessary but no longer sufficient. Content must also be optimized for extraction and citation by AI systems.

### How to Get Cited in AI Overviews

Based on the latest research:

1. **Maintain strong traditional SEO.** While the overlap is declining, organic ranking is still the strongest baseline signal.
2. **Structure content for extraction.** Use short paragraphs (3 to 4 sentences), clear headings, bullet points, numbered lists, and comparison tables.
3. **Implement comprehensive schema markup.** Pages with schema achieve 73% higher selection rates.
4. **Create multi modal content.** Text + images + video + schema = 317% improvement over text only.
5. **Target sub query variations.** Because of query fan out, cover topic variations and related subtopics thoroughly.
6. **Build topical authority.** Cover subjects deeply across multiple interconnected pages rather than addressing topics in isolation.
7. **Maintain content freshness.** 85% of citations come from content published within the last 2 years.
8. **Provide original research and proprietary data.** First hand experience and unique data points are increasingly valued.
9. **Optimize video content.** YouTube accounts for 29.5% of all AI Overview citations, making it the top cited domain overall.

### Google AI Mode Specific Optimization

Google AI Mode is an AI first search experience powered by Gemini 2.5 that uses multi turn, iterative retrieval. Each follow up question prompts refined, contextually updated responses.

**AI Mode differs from AI Overviews because:**
- It generates more complex, synthesized responses across multiple retrieval cycles.
- It pulls from more queries and diverse data points per session.
- 93% of AI Mode searches end without a click (versus 43% for AI Overviews).
- It rewards conversational, question based content structure.

**Key optimization strategies for AI Mode:**
- Build comprehensive topic depth covering all subtopics and related entities.
- Create authoritative, actionable content with original research and case studies.
- Strengthen off site presence through linked and unlinked brand mentions.
- Implement Product, FAQ, HowTo, Article, and Review schemas.
- Maintain strong local targeting through Google Business Profile.

### Tracking AI Search Performance

Google Search Console now tracks AI Mode appearances (as of June 2025). However, AI Mode data is mixed into the Performance reporting under the Web search type alongside traditional results, featured snippets, and AI Overviews. There is currently no way to isolate AI specific data within GSC.

Google introduced an AI powered configuration feature in December 2025 that allows natural language queries to be transformed into appropriate GSC filters and settings.

Sources:
- https://www.aleydasolis.com/en/ai-search/google-query-fan-out/
- https://www.semrush.com/blog/query-fan-out/
- https://almcorp.com/blog/google-ai-overview-citations-drop-top-ranking-pages-2026/
- https://www.semrush.com/blog/google-ai-mode/
- https://brodieclark.com/ai-mode-google-search-console/

---

## 6. Brand Monitoring in AI Search

### Dedicated AI Visibility Monitoring Tools (2026)

The manual monitoring approach described in the current SKILL.md is now supplemented by a growing ecosystem of specialized tools.

| Tool | Platforms Monitored | Starting Price | Key Features |
|------|-------------------|----------------|--------------|
| Otterly.ai | ChatGPT, Google AI Overviews/Mode, Perplexity, Copilot, Gemini | $29/mo (Lite, 15 prompts) | Daily updates, visibility scoring, 25+ technical/content recommendations per area |
| Peec.ai | ChatGPT, Google AIO, Perplexity, Claude, Gemini, Copilot | 89 EUR/mo (Starter, 25 prompts) | Brand sentiment analysis, tracks both mentions and source citations |
| Finseo | ChatGPT, Claude, Gemini, Google AI Overviews, DeepSeek | Custom pricing | GEO focused, industry segmented reporting, prompt trigger dashboards |
| SE Visible | ChatGPT, Perplexity, AI Mode, Gemini | $99/mo | Full spectrum tracking, competitor comparison |
| Peec AI (Pro) | All major platforms | 199 EUR/mo (100 prompts) | Daily tracking, stronger analytics |

**Key metrics to track:**
- **Visibility score:** How frequently and prominently your brand appears across AI platforms.
- **Citation count and citation score:** Number of times your content is cited as a source.
- **Sentiment index:** Positive versus negative mentions and recommendations.
- **Share of voice:** Your citation frequency relative to competitors.
- **Prompt trigger mapping:** Which user prompts generate mentions of your brand.

### Monitoring Best Practices

1. **Build a prompt library.** Create 20 to 30 unique prompts per core topic, tested across platforms weekly.
2. **Track competitor citations.** AI recommendations show extreme inconsistency (less than 1 in 100 chance of identical brand lists across repeated prompts), so large sample sizes are necessary.
3. **Monitor both brand mentions and source citations.** Your brand may be mentioned without your content being cited as a source, or vice versa.
4. **Segment by platform.** Each AI search engine has different citation preferences and patterns.
5. **Report quarterly.** Share AI visibility metrics alongside traditional SEO reporting to communicate the growing importance of this channel.

### The Third Party Citation Reality

Brands are 6.5x more likely to be cited through third party sources than their own domains. This means monitoring must extend beyond your own content to track:
- Review sites that mention your brand (G2, Capterra, Trustpilot)
- News articles and press coverage
- Industry directory listings
- Wikipedia and Wikidata references
- YouTube videos that mention or review your products

Sources:
- https://otterly.ai
- https://www.finseo.ai/ai-visibility-tracking
- https://visible.seranking.com/blog/best-ai-visibility-tools/
- https://peec.ai/
- https://siftly.ai/blog/best-platforms-track-brand-mentions-ai-engines-chatgpt-perplexity-2026

---

## 7. Google Algorithm Updates (2025/2026)

### 2025 Updates Timeline

Google released three core updates and one spam update in 2025:

**March 2025 Core Update (March 13 to 27)**
- Duration: 14 days
- Focus: Broad ranking refinement, continued push toward comprehensive and helpful content
- Signal: First update signaling expanded use of AI Overviews in search results

**June 2025 Core Update (June 30 to July 17)**
- Duration: 16 days
- Focus: Heavy emphasis on YMYL topics, expanded AI Overviews deployment
- Impact: Significant ranking volatility, especially in health and finance verticals

**August 2025 Spam Update (August 26 to September 22)**
- Duration: 27 days (nearly a month, signaling deep enforcement)
- Focus: Scaled low effort content, AI generated content without human review, scraped or stolen text, content providing no unique value
- Impact: Significant demotions for sites publishing high volumes of unreviewed AI content

**December 2025 Core Update (December 11 to 29)**
- Duration: 18 days
- Focus: Intent understanding, first hand experience, topical authority
- Impact: About 15% of pages that ranked in the Top 10 disappeared entirely from the Top 100. E Commerce and Retail saw the highest volatility with over 23% of Top 3 URLs replaced. Healthcare saw only about 8% replacement.

### January 2026 Core Update (January 14 onward)

The first major update of 2026 targeted three key abuse patterns:

1. **Expired domain abuse.** Sites that acquired aged domains and rapidly filled them with AI content experienced sharp ranking drops.
2. **Site reputation abuse (parasite SEO).** High authority sites hosting third party content sections primarily to pass PageRank to affiliate content were targeted. Several major news publishers were affected.
3. **Scaled content abuse.** Sites publishing 50+ articles per day with no editorial process were primary targets. Google's documentation explicitly names this as a spam policy violation.

### Key Ranking Factors and Signals (2025/2026)

**E E A T Expansion:**
E E A T requirements expanded beyond traditional YMYL topics to practically all competitive searches, including e commerce reviews, SaaS comparisons, and how to guides.

**First Hand Experience:**
Google's algorithms now actively identify and reward content created by people with demonstrated first hand experience. The January 2026 update specifically prioritized this signal. Sites relying heavily on AI generated summaries experienced declines.

**Topical Authority:**
Rather than ranking individual pages in isolation, Google now evaluates how well entire websites cover a subject area. Winning sites show clear patterns: strong topical authority, clean site structure, and consistent content quality.

**Content Quality Over Length:**
Length alone no longer wins. Clarity, usefulness, and perspective are the primary quality signals. Content must provide information, insights, or perspectives that go beyond what is readily available.

**Core Web Vitals as Quality Tiebreaker:**
Pages with LCP above 3 seconds experienced 23% more traffic loss than faster competitors with similar content. Core Web Vitals act as a quality tiebreaker when content is otherwise comparable.

**AI Content Policy:**
Google's Search Quality Rater Guidelines (updated September 2025) now include a formal definition of generative AI. If raters find that the majority of main content on a page is AI generated with no additional value, insight, or original concepts, the page receives the "lowest" quality rating.

### Predicted 2026 Update Schedule

Based on 2025's pattern (March, June, December), the next update is expected in March or April 2026. Google has stated they want "more core updates, more often." Expected trends include progressive quality standard increases, growing emphasis on demonstrated expertise and experience, enhanced ability to differentiate quality AI assisted content from AI generated spam, and stricter E E A T enforcement across all content categories.

Sources:
- https://searchengineland.com/google-algorithm-updates-2025-in-review-3-core-updates-and-1-spam-update-466450
- https://www.gsqi.com/marketing-blog/google-december-2025-broad-core-update-analysis-findings/
- https://thatware.co/google-december-2025-core-update/
- https://digiwizard.ie/seo-optimization/google-algorithm-update-2026/

---

## 8. Emerging Concepts: AAO, llms.txt, Query Fan Out

### Assistive Agent Optimization (AAO)

AAO is the newest evolution in AI visibility strategy, coined by Jason Barnard. It describes optimization for when AI systems recommend and act autonomously on behalf of users with no human review of the selection.

**The Evolution:**
- **SEO:** Be found
- **AEO:** Be the answer
- **GEO:** Be described (cited in generated responses)
- **AAO:** Be chosen (when no human is in the loop)

**The Algorithmic Trinity:**
All modern AI systems rely on three components working together:
1. Large Language Models (language understanding and generation)
2. Knowledge Graphs (structured entity relationships)
3. Traditional Search (content discovery and retrieval)

The balance differs by platform. ChatGPT leans heavily on LLMs while Google relies more on its Knowledge Graph.

**Key Strategic Shifts Under AAO:**

1. **Brand identity as foundation.** Your brand becomes the core asset. Agents evaluate "who this company is, what it does, who it serves, why it would be a reliable solution."
2. **The funnel moves inside the agent.** The entire awareness, consideration, and decision funnel happens inside the AI without the user ever seeing a list of options.
3. **Web index loses monopoly status.** Proprietary datasets, APIs, booking systems, and structured feeds now bypass traditional indexes.
4. **Push layer returns.** Technologies like IndexNow and MCP let marketers actively push structured data rather than waiting for crawlers.
5. **JavaScript rendering risk.** Most AI agent bots do not render JavaScript. Client side rendered content is invisible to a growing number of agents.

**The 10 Gate Pipeline (DSCRI ARGDW):**
1. Discovered (bot finds you exist)
2. Selected (bot decides you are worth fetching)
3. Crawled (bot retrieves your content)
4. Rendered (bot translates content into readable format)
5. Indexed (algorithm commits content to memory)
6. Annotated (algorithm classifies meaning across 24+ dimensions)
7. Recruited (algorithm pulls content for use)
8. Grounded (engine verifies against other sources)
9. Displayed (engine presents you to user)
10. Won (perfect click at zero sum moment)

**Concentration data:** Top performers captured 59.5% of AI citation opportunities by February 2026, up from 30.9% in December. That is a 293% increase in concentration in just two months. Early adoption creates compounding advantages.

**Practical AAO implementation:**
- Expose APIs, booking calendars, or demo request endpoints that agents can call directly.
- Secure 2 to 3 high authority unlinked mentions that confirm positioning. Agents trust corroborated signals far more than self claimed ones.
- Ensure content is server side rendered (not dependent on JavaScript).
- Use IndexNow for instant content notification.

Sources:
- https://searchengineland.com/aao-assistive-agent-optimization-469919
- https://sunilpratapsingh.com/ai-marketing/ai-seo/ai-seo-glossary/aao-assistive-agent-optimization/

### llms.txt

llms.txt is a proposed open standard (created by Jeremy Howard of Answer.AI in 2024) that provides AI systems with a curated set of priority pages, similar to robots.txt but designed specifically for AI bots.

**Current reality (as of Q1 2026):**
- Adoption remains limited. Only 0.1% of AI crawler requests touch /llms.txt over 90 days.
- 8 out of 9 sites in independent studies saw no measurable change in traffic after llms.txt implementation.
- No mainstream AI search or LLM provider has confirmed they meaningfully rely on llms.txt yet.
- The file receives far fewer AI visits than the average content page.

**Recommendation:** Implement llms.txt as a low effort, future proofing measure, but do not rely on it for current AI visibility. Focus instead on semantic HTML, structured data, clear taxonomy, and content quality.

### AI Bot Crawling

OpenAI's GPTBot and Anthropic's ClaudeBot are two prominent LLM crawlers. In one month of late 2024, requests from GPTBot and ClaudeBot accounted for about 20% of Googlebot's volume from the same timeframe. 79% of major news publishers block AI training bots via robots.txt.

**Recommended approach:** Allow AI crawlers that drive citation traffic (GPTBot for ChatGPT citations, ClaudeBot for Claude citations) while blocking unwanted training only crawlers through robots.txt rules.

### IndexNow and MCP Protocol

**IndexNow:** For 2026, the use of instant notification protocols like IndexNow and Indexing APIs is becoming essential for ensuring fresh content reaches AI systems quickly. Traditional crawling with multi day delays is insufficient for the pace of AI search.

**MCP (Model Context Protocol):** Created by Anthropic in late 2024 and donated to the Linux Foundation in December 2025. MCP is emerging as the standard protocol for agent communication, enabling a shift from chat based prompting to active agentic workflows. In 2026, it is expected to become the dominant infrastructure for contextual AI interaction.

Sources:
- https://www.linkbuildinghq.com/blog/should-websites-implement-llms-txt-in-2026/
- https://otterly.ai/blog/the-llms-txt-experiment/
- https://hallam.agency/blog/how-mcp-will-supercharge-ai-automation-in-2026/

---

## 9. Key Statistics and Data Points

### AI Search Market

- Google processes 16.4 billion searches daily with 5+ billion users globally, holding 89.9% search market share.
- ChatGPT has 81% AI chatbot market share, 800 million weekly users, and 2.5 billion daily prompts.
- ChatGPT is the fourth most visited website globally with over 5 billion monthly visits.
- 2 billion monthly users engage with Google AI Overviews globally.
- The agentic AI market reached $7.29 billion in 2025, projected to grow to $9.14 billion in 2026.
- 47% of enterprise technology buyers now initiate vendor research with AI assistants, surpassing Google Search at 43%.

### Zero Click Search Impact

- 60% of all global searches result in no external click.
- 34% zero click rate for Google Search without AI Overviews.
- 43% zero click rate for Google Search with AI Overviews.
- 93% zero click rate for Google AI Mode.
- On mobile, 77% of queries end without visiting another website (versus 46.5% on desktop).
- Organic CTR drops 61% when AI Overviews appear (from 1.76% to 0.61%).
- AI Overviews reduce clicks by 58% overall.

### Citation and Traffic Quality

- Being cited in AI Overviews increases organic CTR by 35%.
- AI referred visitors convert 23x higher than organic search visitors (alternate source reports 4.4x).
- ChatGPT conversion rate: 15.9%; Perplexity: 10.5%; Google organic: 1.76%.
- 87.4% of all AI referral traffic comes from ChatGPT.
- AI traffic represents only 1.08% of total website traffic versus 25% for organic.
- Pages loading under 0.4 seconds average 6.7 citations versus 2.1 for slower pages.
- Articles exceeding 2,900 words average 5.1 citations versus 3.2 for sub 800 word content.
- Case studies and pricing pages drive the highest AI referral traffic.
- 63% of ChatGPT agents leave pages immediately after landing.

### Content Freshness

- 85% of AI Overview citations published within last 2 years.
- 44% of AI Overview citations from 2025 alone.
- Content freshness accounts for a 65% factor in AI citations.

### Gartner Prediction

Gartner predicts that by 2026, 25% of organic search traffic will shift to AI chatbots and virtual assistants.

---

## 10. Recommendations for Updating the SKILL.md File

Based on this research, the following updates are recommended for `skills/aeo-ai-seo/SKILL.md`:

### High Priority Additions

1. **Add platform specific ranking factors.** The current file treats AI search as monolithic. Add dedicated subsections for ChatGPT, Perplexity, and Google AI Overviews/AI Mode with their unique ranking factors and citation patterns.

2. **Add the GEO research paper findings.** Include the nine tested methods and their effectiveness percentages from the foundational GEO paper. Highlight that quotations (+40%), statistics (+37%), and citations (+30%) are the most effective techniques, while keyword stuffing is counterproductive.

3. **Add query fan out section.** Explain how Google decomposes queries into sub queries and its impact on content strategy. Note the declining overlap between organic rankings and AI Overview citations (from 76% to 38%).

4. **Add AAO (Assistive Agent Optimization) section.** Cover the evolution from SEO to AEO to GEO to AAO, the algorithmic trinity concept, and the 10 gate pipeline. Include practical implications for JavaScript rendering, IndexNow, and API exposure.

5. **Add YouTube and video optimization section.** YouTube is the most cited domain in AI Overviews (29.5% of citations). Cover transcript optimization, timestamp structure, and the finding that popularity metrics have near zero correlation with citation frequency.

6. **Update the brand monitoring section.** Replace or supplement the manual monitoring workflow with the ecosystem of dedicated tools (Otterly.ai, Peec.ai, Finseo, SE Visible). Add specific KPIs: visibility score, citation count, sentiment index, share of voice.

7. **Add key statistics section.** Include the most impactful data points about zero click rates, AI search market share, citation quality metrics, and conversion rates.

### Medium Priority Updates

8. **Update the citation optimization section.** Add the finding about front loading (44.2% of citations from the first 30% of text). Add optimal passage length (134 to 167 words). Add the 317% improvement for multi modal content.

9. **Expand structured data section.** Add impact statistics (2.5x higher citation chances, 2.8x higher citation rates). Note schema deprecations. Add the Speakable schema type. Include the GPT 4 accuracy improvement (16% to 54%) with structured data.

10. **Update entity SEO section.** Add the three pillars (Precision, Coverage, Connectivity), the four part playbook, and the topical cluster case study data (63% keyword increase, citation rate from 12% to 41%).

11. **Add topical authority section.** Cover topic clusters, pillar pages, and topical maps as foundational architecture for AI visibility.

12. **Update AI Overview section.** Add AI Mode as a distinct optimization target. Include the query fan out mechanism. Update trigger data to reflect 47% of searches. Add the citation distribution data showing 62% of citations come from outside the top 10.

### Lower Priority Additions

13. **Add llms.txt guidance.** Include as a future proofing measure while noting current limited effectiveness.

14. **Add Google algorithm update summary.** Include 2025 update timeline and key ranking factor changes, particularly the expanded E E A T requirements, first hand experience weighting, and AI content quality standards.

15. **Add the 10 step GEO implementation framework.** Adapt from the Profound framework with business aligned KPIs and quarterly benchmarking.

16. **Add AI bot crawling guidance.** Cover robots.txt configuration for AI crawlers, the significance of GPTBot and ClaudeBot traffic, and the 79% news publisher blocking rate.

17. **Add conversion and traffic quality data.** Include the 23x higher conversion rate for AI referred visitors and the 15.9% ChatGPT conversion rate to help justify investment in AEO/GEO.

---

## Source URLs Referenced in This Document

### AEO and AI Search
- https://cxl.com/blog/answer-engine-optimization-aeo-the-comprehensive-guide/
- https://www.evergreen.media/en/guide/answer-engine-optimization/
- https://eminence.ch/en/aeo-answer-engine-optimization-2026/
- https://llmrefs.com/answer-engine-optimization
- https://www.typeface.ai/blog/what-is-answer-engine-optimization-why-aeo-matters
- https://blog.hubspot.com/marketing/answer-engine-optimization-trends

### GEO Research and Implementation
- https://arxiv.org/abs/2311.09735
- https://dl.acm.org/doi/10.1145/3637528.3671900
- https://www.tryprofound.com/resources/articles/generative-engine-optimization-geo-guide-2025
- https://searchengineland.com/mastering-generative-engine-optimization-in-2026-full-guide-469142

### ChatGPT Ranking Factors
- https://aiclicks.io/blog/top-chatgpt-ranking-factors
- https://www.demandsage.com/how-to-rank-on-chatgpt/
- https://www.ekamoira.com/blog/chatgpt-seo-the-complete-guide-to-ranking-in-chatgpt-search-results-2026

### Perplexity Optimization
- https://metehan.ai/blog/perplexity-ai-seo-59-ranking-patterns/
- https://www.trysight.ai/blog/how-perplexity-ai-selects-sources
- https://wellows.com/blog/how-to-rank-in-perplexity/

### Google AI Overviews and AI Mode
- https://www.averi.ai/blog/google-ai-overviews-optimization-how-to-get-featured-in-2026
- https://www.semrush.com/blog/google-ai-mode/
- https://www.e2msolutions.com/blog/how-to-optimize-for-google-ai-mode/
- https://wellows.com/blog/google-ai-overviews-ranking-factors/
- https://almcorp.com/blog/google-ai-overview-citations-drop-top-ranking-pages-2026/

### Query Fan Out
- https://www.aleydasolis.com/en/ai-search/google-query-fan-out/
- https://www.semrush.com/blog/query-fan-out/
- https://surferseo.com/blog/query-fan-out/

### Entity SEO
- https://searchengineland.com/guide/entity-first-content-optimization
- https://aliseoservices.com/entity-based-seo/
- https://niumatrix.com/semantic-seo-guide/
- https://www.clickrank.ai/topical-authority/

### Schema and Structured Data
- https://wpriders.com/schema-markup-for-ai-search-types-that-get-you-cited/
- https://www.stackmatix.com/blog/structured-data-ai-search
- https://www.geostar.ai/blog/complete-guide-schema-markup-ai-search-optimization
- https://www.schemaapp.com/schema-markup/what-2025-revealed-about-ai-search-and-the-future-of-schema-markup/

### Brand Monitoring Tools
- https://otterly.ai
- https://www.finseo.ai/ai-visibility-tracking
- https://visible.seranking.com/blog/best-ai-visibility-tools/
- https://peec.ai/

### Google Algorithm Updates
- https://searchengineland.com/google-algorithm-updates-2025-in-review-3-core-updates-and-1-spam-update-466450
- https://www.gsqi.com/marketing-blog/google-december-2025-broad-core-update-analysis-findings/
- https://thatware.co/google-december-2025-core-update/
- https://digiwizard.ie/seo-optimization/google-algorithm-update-2026/
- https://turboseo.tools/blog/google-algorithm-updates-2026

### AAO and Agentic SEO
- https://searchengineland.com/aao-assistive-agent-optimization-469919
- https://sunilpratapsingh.com/ai-marketing/ai-seo/ai-seo-glossary/aao-assistive-agent-optimization/

### YouTube and Video Optimization
- https://searchengineland.com/youtube-ai-search-citations-data-462830
- https://neilpatel.com/marketing-stats/youtube-citations-ai-overviews/
- https://searchengineland.com/youtube-seo-ai-overviews-467253

### AI SEO Statistics
- https://www.position.digital/blog/ai-seo-statistics/
- https://seranking.com/blog/ai-statistics/
- https://www.semrush.com/blog/ai-seo-statistics/
- https://surferseo.com/blog/ai-citation-report/

### llms.txt and AI Crawling
- https://www.linkbuildinghq.com/blog/should-websites-implement-llms-txt-in-2026/
- https://otterly.ai/blog/the-llms-txt-experiment/
- https://higoodie.com/blog/llms-txt-robots-txt-ai-optimization

### Google Search Quality Guidelines
- https://originality.ai/blog/google-search-quality-rater-guidelines-ai
- https://searchengineland.com/google-quality-raters-content-ai-generated-454161
