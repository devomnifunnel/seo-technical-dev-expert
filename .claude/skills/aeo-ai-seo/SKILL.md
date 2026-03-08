---
name: aeo-ai-seo
description: "Strategies for optimizing content to be cited by AI search engines. Use when optimizing for ChatGPT, Perplexity, Gemini, Claude, or AI Overviews. Trigger on: AEO, GEO, LLMO, AI citations, AI visibility, answer engine, generative engine, zero click, AI search, entity SEO, citation optimization."
context: fork
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch
argument-hint: "[URL or brand name to analyze]"
---

# Answer Engine Optimization (AEO) and AI SEO
## Dynamic ContextWhen analyzing a specific URL or brand ($ARGUMENTS):- WebSearch: check current AI search visibility by querying "[brand] [category]" patterns- Fetch MCP: extract page content to evaluate citation readiness (statistics, quotes, structure)- Chrome MCP: inspect schema markup, heading hierarchy, and entity clarity on the live page

## The AI Search Landscape (2026)

Google processes 16.4 billion searches daily (89.9% market share), but AI search is growing rapidly. ChatGPT commands 81% of the AI chatbot market with 800M weekly users. Google AI Overviews appear on ~47% of searches. Gartner predicts 25% of organic traffic will shift to AI chatbots by 2026. 47% of enterprise tech buyers now start vendor research with AI assistants.

Source: https://www.position.digital/blog/ai-seo-statistics/

## The Evolution: SEO to AEO to GEO to AAO

| Discipline | Focus | Timeframe |
|-----------|-------|-----------|
| SEO | Rank in traditional search results | Ongoing foundation |
| AEO (Answer Engine Optimization) | Get cited in AI generated answers | 2023 to present |
| GEO (Generative Engine Optimization) | Optimize specifically for generative AI output | 2024 to present |
| AAO (Assistive Agent Optimization) | Optimize for autonomous AI agents that act on behalf of users | Emerging 2025+ |

## Core Methodology

### What Makes Content Citable by AI Systems

1. **Front loaded direct answers.** Place the definitive answer in the first sentence after each heading. 44.2% of LLM citations come from the first 30% of text.
2. **Verifiable claims with attribution.** Every statistic should name its source.
3. **Quotations from recognized experts.** Direct quotes from named authorities improve citation probability by up to 40% (single most effective GEO technique).
4. **Statistics with sources.** Including specific statistics with attribution improves visibility by 37%.
5. **Self contained passages.** Each section should be independently extractable. Optimal passage length: 134 to 167 words.
6. **Current data.** 85% of AI Overview citations were published within the last 2 years; 44% from 2025 alone.
7. **Multi modal content.** Text + images + video + schema = 317% higher selection rates vs text only.

### Authoritative Sourcing

Strengthen citation likelihood by: citing primary sources, including statistics with attribution, quoting recognized experts by name and credential, linking to authoritative external sources, and displaying author bylines with credentials and author schema markup.

For detailed content formatting patterns and HTML examples, load: ${CLAUDE_SKILL_DIR}/references/content-patterns.md

### Structured Data for Citations

Pages with schema markup are 2.5x more likely to appear in AI answers. GPT 4 accuracy improves from 16% to 54% with structured data.

**Most impactful schema types for AI visibility:**

| Schema Type | AI Citation Impact |
|-------------|-------------------|
| FAQPage | Very High: AI platforms present info in Q&A format |
| Article | High: enables attribution and freshness signals |
| HowTo | High: matches instructional queries |
| Organization | High: entity recognition and authority |
| Person | High: E E A T signals |
| Product | High: comparison and purchase queries |
| Speakable | Growing: voice search integration |

JSON LD is the gold standard. Expect 4 to 8 weeks for schema work to show measurable citation improvements.

**Google Schema Deprecations (January 2026):** Practice Problem, Dataset, Sitelinks Search Box, SpecialAnnouncement, and Q&A no longer trigger rich results.

For schema code examples (Article, Organization, FAQ, HowTo), load: ${CLAUDE_SKILL_DIR}/references/schema-examples.md

## Entity SEO and Knowledge Graph Optimization

### The Three Pillars of Entity SEO

1. **Precision.** Every page unambiguously about one canonical entity. Title, H1, and schema `mainEntityOfPage` must all point to the same concept.
2. **Coverage.** The entire site collectively represents entities and subtopics that define a niche, building a mini Knowledge Graph.
3. **Connectivity.** Internal links, `sameAs` references, and schema relationships tell search engines how concepts fit together.

Content with 15+ connected entities shows 4.8x higher probability of being cited in AI Overviews.

### Building Entity Authority

1. **Establish a Knowledge Panel:** Google Business Profile, consistent NAP, Knowledge Panel claim.
2. **Build corroborating sources:** Wikipedia, Wikidata, Crunchbase, LinkedIn, directories. Use `sameAs` in Organization schema.
3. **Reinforce with topical clusters:** Pillar cluster architecture produces 63% keyword ranking increase within 90 days, AI citation rate increase from 12% to 41%.
4. **Ensure entity disambiguation:** Consistent full name, disambiguating context in schema.

### Video and YouTube Optimization

Video is the most cited content format. YouTube accounts for 29.5% of all AI Overview citations (414% increase). "How to" video citations jumped 651%.

Popularity metrics carry near zero correlation with citation frequency. What matters: timestamps as headers, detailed descriptions, transcripts, and content structured for extraction.

## AI Overview and AI Mode Optimization

### What Triggers AI Overviews

AI Overviews appear on ~47% of searches (99.9% of informational queries). Triggers: informational queries, comparison queries, multi step processes, complex topics, how to content. Less frequent for navigational and branded searches.

### Query Fan Out

Google decomposes queries into multiple sub queries, fires them in parallel across web/Knowledge Graph/Shopping Graph/Maps, then synthesizes. The top 10 organic overlap has dropped from 76% (July 2025) to ~38% (February 2026).

| Source Position | Share of Citations |
|----------------|-------------------|
| Top 10 organic | 38% |
| Positions 11 to 50 | 28% |
| Positions 51 to 100 | 16% |
| Not in top 100 | 18% |

### How to Get Cited in AI Overviews

1. Maintain strong traditional SEO (still the strongest baseline signal)
2. Structure content for extraction (short paragraphs, clear headings, lists, tables)
3. Implement comprehensive schema markup (73% higher selection rates)
4. Create multi modal content (317% improvement over text only)
5. Target sub query variations (cover topic variations thoroughly)
6. Build topical authority across interconnected pages
7. Maintain content freshness (85% of citations from last 2 years)
8. Provide original research and proprietary data
9. Optimize video content (29.5% of all AI Overview citations)

### Google AI Mode

AI first search powered by Gemini 2.5. 93% of AI Mode searches end without a click (vs 43% for AI Overviews). Optimize through: comprehensive topic depth, authoritative actionable content, strong off site presence, schemas (Product, FAQ, HowTo, Article, Review), and Google Business Profile.

## Zero Click Impact and AI Traffic Quality

| Context | Zero Click Rate |
|---------|----------------|
| Google without AI Overviews | 34% |
| Google with AI Overviews | 43% |
| Google AI Mode | 93% |
| Mobile overall | 77% |

AI Overviews reduce organic CTR by 61%, but being cited increases CTR by 35%. AI referred traffic converts dramatically higher: ChatGPT 15.9%, Perplexity 10.5%, vs Google organic 1.76%. Pages loading under 0.4s average 6.7 citations vs 2.1 for slower pages.

## Brand Monitoring Across AI Platforms

Track visibility across ChatGPT, Perplexity, Gemini, Google AI Overviews using dedicated tools. Key metrics: visibility score, citation count, sentiment index, share of voice, prompt trigger mapping. Brands are 6.5x more likely to be cited through third party sources than their own domains.

For monitoring tools comparison, manual verification process, and tracking templates, load: ${CLAUDE_SKILL_DIR}/references/monitoring-tools.md

## Emerging Concepts

**AAO (Assistive Agent Optimization):** Optimization for autonomous AI agents. Uses a 10 gate pipeline (DSCRI ARGDW). Top performers captured 59.5% of citation opportunities by Feb 2026. Key: expose APIs, secure corroborating mentions, server side render, use IndexNow.

**llms.txt:** Proposed standard for AI bots. Adoption remains limited (0.1% of requests). Implement as low effort future proofing but do not rely on it.

**AI Bot Crawling:** GPTBot and ClaudeBot account for ~20% of Googlebot volume. Allow citation driving bots, block training only crawlers.

For full details on AAO pipeline, llms.txt, and emerging protocols, load: ${CLAUDE_SKILL_DIR}/references/emerging-concepts.md

## GEO Implementation Checklist

### Foundation
- [ ] Implement comprehensive schema (Organization, Article, FAQ, HowTo, Person, Product)
- [ ] Establish entity presence on Wikipedia, Wikidata, major directories
- [ ] Clear author attribution with credentials on all content
- [ ] Deploy `sameAs` links connecting all official brand profiles
- [ ] Complete Google Business Profile
- [ ] Build 15+ connected entity references per key content page
- [ ] Set up AI visibility monitoring

### Content Optimization
- [ ] Question based headings on all informational pages
- [ ] Direct answers in first sentence after each heading
- [ ] FAQ section on each major content page
- [ ] Statistics with cited sources (+37% visibility)
- [ ] Expert quotations (+40% visibility)
- [ ] Keep answer passages to 134 to 167 words
- [ ] Front load key information in first 30% of each page
- [ ] Multi modal content where possible

### Technical
- [ ] Deploy FAQPage and HowTo schema where applicable
- [ ] Fast page load (under 2.5s LCP, ideally under 0.4s)
- [ ] Server side rendered content
- [ ] Allow GPTBot and ClaudeBot in robots.txt
- [ ] Consider llms.txt as future proofing
- [ ] Set up IndexNow for instant content notification

### YouTube and Video
- [ ] Timestamps functioning as headers
- [ ] Detailed descriptions with key terms
- [ ] Accurate transcripts available
- [ ] Segments that stand alone as complete answers

### Monitoring
- [ ] Weekly brand mention checks across AI platforms
- [ ] Monthly citation frequency trends
- [ ] Quarterly content refresh of statistics and data points
- [ ] Maintain prompt library of 20 to 30 prompts per core topic
