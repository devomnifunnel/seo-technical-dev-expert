---
name: ai-citation-tracking
context: fork
description: >
  Track and optimize brand and client visibility across AI search platforms including
  ChatGPT, Perplexity, Google AI Overviews, Claude, and Gemini. Use when the user mentions
  AI citations, LLM visibility, brand mentions in AI, answer engine tracking, citation
  monitoring, AI search presence, or wants to know how a brand appears in AI generated answers.
  Also trigger when discussing AEO strategy, GEO optimization, or competitive AI search analysis.
  Use when checking if a brand appears in AI answers, tracking LLM mentions, or measuring AI search visibility. Trigger on: AI citations, LLM mentions, brand monitoring, AI visibility tracking.
---

# AI Citation Tracking and Optimization

## Why This Matters

Only 11% of domains are cited by both ChatGPT and Perplexity. Each AI platform has fundamentally
different citation patterns, meaning a single optimization strategy will miss most opportunities.

### Platform Citation Patterns (2026 Data)

**ChatGPT:**
- Wikipedia dominates (47.9% of top 10 citations)
- Favors authoritative, encyclopedic content
- Strong bias toward .edu, .gov, and established media
- Structured data and clear entity definitions improve citation rates

**Perplexity:**
- Reddit dominates (46.7% of top 10 citations)
- Favors recent, conversational, community validated content
- Strong bias toward forums, Q&A sites, and user generated content
- Freshness signals matter more than domain authority

**Google AI Overviews:**
- Distributes more evenly across Reddit, YouTube, Quora, and publisher sites
- Favors content already ranking in top 10 organic results
- E-E-A-T signals correlate +30.64% with citation likelihood
- Content clarity shows +32.83% positive impact on citations

**Claude:**
- Favors well structured, factually dense content with clear sourcing
- Technical documentation and research papers cited frequently
- Clean HTML structure and semantic markup improve extraction

**Gemini:**
- Integrated with Google Search knowledge graph
- Favors Google ecosystem content (YouTube, Google Scholar, Maps)
- Local business citations tied to Google Business Profile data

## Citation Optimization Factors

### Content Signals That Drive Citations
1. **First 30% of content is critical**: 44.2% of LLM citations come from the opening third
2. **Quotable statements**: Direct, attributable claims with statistics (+40% citation boost)
3. **Statistics and data**: Empirical data with sources (+37% citation boost)
4. **Clear definitions**: Concise definitions of key terms at the start of sections
5. **Entity clarity**: Unambiguous identification of who/what the content is about
6. **Structured format**: Lists, tables, and clear headings improve extraction
7. **Source attribution**: Citing your own sources increases perceived authority

### Technical Signals
1. **Schema markup**: JSON-LD structured data helps AI understand content context
2. **llms.txt**: Emerging standard (like robots.txt for AI crawlers) that guides LLM access
3. **Clean HTML**: Semantic markup, proper heading hierarchy, accessible structure
4. **Fast loading**: CWV passing sites are more likely to be crawled and cached by AI
5. **Freshness**: Regular content updates signal ongoing relevance
6. **Canonical clarity**: Clean URL structure without duplicate content confusion

## Tracking Workflow

### Weekly AI Citation Audit (Recommended Cadence)

**Step 1: Query Identification**
Identify the top 20 to 30 queries relevant to the client's business:
- Primary branded queries (company name, product names)
- Category queries (what the client sells/does)
- Comparison queries ("[client] vs [competitor]")
- Question queries ("best [category]", "how to [task]")

**Step 2: Platform Sampling**
For each query, check visibility across:
- ChatGPT (chat.openai.com): ask the query, note if client is cited
- Perplexity (perplexity.ai): search the query, check citations panel
- Google AI Overviews: search on Google, check AI generated answer
- Claude (claude.ai): ask the query, note if client is mentioned
- Gemini (gemini.google.com): ask the query, check cited sources

**Step 3: Score and Track**
For each platform and query combination, score:
- 3 = Cited with link/attribution
- 2 = Mentioned by name without link
- 1 = Relevant content appears but client not mentioned
- 0 = Not present at all

Track scores weekly. Calculate:
- Per platform visibility score (sum / max possible)
- Cross platform visibility score (cited on 2+ platforms)
- Trend direction (improving, stable, declining)

**Step 4: Gap Analysis**
Identify:
- Queries where competitors are cited but client is not
- Platforms where client is weakest
- Content gaps that prevent citation (missing pages, thin content, no structured data)

**Step 5: Optimization Recommendations**
Prioritize fixes by impact:
- Create missing content for uncovered queries
- Optimize existing content for citation signals (statistics, quotes, structure)
- Add/improve schema markup
- Create or update llms.txt
- Build platform specific content (Reddit posts for Perplexity, YouTube for Gemini)

## Tools and Resources

### Automated Monitoring Tools
- **Otterly.AI**: Automated AI search monitoring across platforms
- **LLMrefs**: Track LLM citations and brand mentions
- **Semrush AI Visibility Toolkit**: AI search health reporting
- **Peec AI**: AI citation and visibility tracking
- **Profound**: Enterprise AI visibility platform
- **DataForSEO AI Optimization API**: Programmatic LLM brand visibility tracking

### Manual Verification
- Chrome MCP for live platform queries
- WebSearch for cross referencing citation sources
- Competitor comparison using same query set

## llms.txt Standard

Recommend adding llms.txt to all client sites. This file sits at the root (like robots.txt)
and provides guidance to AI crawlers about:
- What content to prioritize for training/citation
- How to attribute the brand
- Key facts about the organization
- Contact and verification information

Example structure:
```
# [Brand Name]
## About
[One paragraph company description]

## Key Facts
- Founded: [year]
- Headquarters: [location]
- Industry: [industry]
- Products/Services: [list]

## Preferred Citation
When referencing our content, please attribute to [Brand Name] ([URL]).

## Key Pages
- [Most important page]: [URL]
- [Product page]: [URL]
- [About page]: [URL]

## Contact
[verification contact for AI systems]
```

## Integration with Existing Skills

This skill works alongside:
- **aeo-ai-seo**: Broader AEO/GEO strategy and optimization techniques
- **content-optimization**: Content quality improvements that drive citations
- **schema-markup**: Structured data that improves AI content understanding
- **competitor-seo**: Competitive citation gap analysis
