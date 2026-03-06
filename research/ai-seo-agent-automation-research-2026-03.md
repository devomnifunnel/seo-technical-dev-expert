# AI Agents for SEO Automation: Research Compendium (March 2026)

Last updated: March 6, 2026

This document compiles findings from a comprehensive web research sweep on how AI agents (Claude Code, ChatGPT, and others) are being used for SEO automation and optimization in 2026. Organized by topic with actionable recommendations for OmniFunnel Marketing.

---

## Table of Contents

1. Claude Code for SEO: How Agencies Are Using It
2. SEO Tasks Being Fully Automated with AI Agents
3. AI Powered Technical SEO Audit Workflows
4. AI for Core Web Vitals Optimization
5. AI Driven Content Optimization and E E A T Scoring
6. Automated Schema Markup Generation and Validation
7. AI Agents for Competitive Analysis and Keyword Research
8. Tracking AI Search Citations Programmatically
9. AI Powered Link Building and Outreach
10. NetSuite / SuiteCommerce AI Automation
11. SEO MCP Tools Ecosystem
12. llms.txt and AI Crawler Optimization
13. Reddit Community Sentiment on AI and SEO
14. Actionable Recommendations for OFM

---

## 1. Claude Code for SEO: How Agencies Are Using It

### The Data Command Center Pattern

The dominant workflow pattern in 2026 is using Claude Code as an SEO data command center. Agencies connect multiple Google APIs (Search Console, GA4, Google Ads) through Python fetcher scripts, store results as local JSON files, and then let Claude Code analyze the unified dataset through natural language queries.

**Architecture:**
- Config layer: client details and API property identifiers
- Fetcher scripts: Python modules authenticating to GSC, GA4, and Google Ads APIs
- Data storage: JSON files organized by source
- Analysis layer: Claude Code interrogates combined datasets

**Authentication:** One Google Cloud service account covers GSC and GA4. Google Ads requires separate OAuth 2.0 credentials with developer token approval (24 to 48 hours). Python dependencies: google-api-python-client, google-auth, google-analytics-data, google-ads.

**Real World Results:** One higher education client analysis identified 2,742 search terms with wasted ad spend and 351 opportunities to reduce paid spending on strong organic keywords. That analysis completed in about 90 seconds versus most of an afternoon manually.

Sources:
- https://searchengineland.com/claude-code-seo-work-470668
- https://almcorp.com/blog/claude-code-for-seo/

### Claude Cowork (Desktop Agent)

Claude Cowork launched in January 2026 in the Claude desktop app. You give it a task, point it at a folder or website, and it executes: reading files, opening Chrome, visiting pages, and delivering structured outputs like spreadsheets and reports. Agencies are using it to perform SEO audits, generate reports, and analyze competitor sites autonomously.

Source: https://www.the-ai-corner.com/p/claude-seo-cowork-prompts-free-agency

### Claude Code with Puppeteer MCP

A practical workflow uses Claude Code with Puppeteer MCP to automate comprehensive SEO analysis. The system controls a real browser to visit websites, extract data, and generate actionable reports. Claude Code self-organizes through auto-generated todo lists, performing homepage navigation, meta tag extraction, heading hierarchy analysis, page load performance measurement, mobile responsiveness verification, and robots.txt/sitemap auditing.

Source: https://alexop.dev/posts/how-i-use-claude-code-for-doing-seo-audits/

### Key Limitation

Claude Code can hallucinate with data analysis results. The recommendation from practitioners: always spot-check the numbers against the source data before including in client deliverables.

---

## 2. SEO Tasks Being Fully Automated with AI Agents

### Tasks Now Fully or Near Fully Automated

1. **Keyword clustering and grouping** by intent and topic
2. **Meta tag generation** (titles, descriptions) at scale
3. **Schema markup generation** (JSON-LD) from page content
4. **Content brief creation** from keyword research data
5. **Internal linking analysis** and suggestion
6. **Technical audit checks** (missing H1s, crawl errors, duplicates, broken links)
7. **Paid/organic gap analysis** (cross referencing GSC and Ads data)
8. **Content decay detection** (identifying pages with declining traffic)
9. **Keyword cannibalization identification**
10. **SERP preview generation** (simulating how snippets will appear)
11. **Robots.txt and sitemap validation**
12. **Alt text generation** based on image context
13. **Monthly reporting** with automated data pulls and narrative

### Tasks Requiring Human Oversight

1. **Strategy and prioritization** (which findings matter most for this client)
2. **Brand voice and tone** in content
3. **E E A T signal building** (real expertise and authority)
4. **Link building relationships** (outreach personalization, relationship management)
5. **Client communication** and expectation management
6. **Final review** of all deliverables before sending to clients

### Top AI SEO Agent Platforms (2026)

| Platform | Focus | Starting Price |
|----------|-------|----------------|
| NightOwl (Nightwatch) | 24/7 site scanning, keyword tracking, competitor monitoring | $32/mo |
| Otto AI (Search Atlas) | Autonomous technical fixes, content optimization, any CMS | $99/mo |
| Alli AI | Live technical SEO changes without developers | $169/mo |
| WordLift | Semantic SEO, knowledge graphs, automatic schema | $160/mo (EUR) |
| KIVA (Wellows) | Hidden keyword discovery, content briefs from GSC data | $39.99/mo |
| AirOps | Modular workflow builder, bulk content pipelines | Free tier available |
| SEO Bot AI | Programmatic SEO, mass content generation | $19/mo |
| Chatsonic | AI content creation with real time web data | $16/mo |

Sources:
- https://nightwatch.io/blog/best-ai-seo-agents/
- https://almcorp.com/blog/ai-agents-for-seo/

---

## 3. AI Powered Technical SEO Audit Workflows

### State of the Art in 2026

The market has shifted from simple issue detection to intelligent analysis. "Best" now means fast discovery plus accurate prioritization plus repeatable monitoring, not just a crawler listing 10,000 issues.

### Screaming Frog AI Integration

Screaming Frog version 22.0 supports direct integration with OpenAI, Gemini, Anthropic (Claude), and Ollama via Config > API Access > AI. You can run custom prompts against your crawl data at scale while crawling. Key capabilities:
- Run AI prompts on every crawled page during the crawl
- Vector embeddings for semantic similarity analysis
- Identify pages that are semantically similar (beyond exact duplicates)
- Detect low relevance content deviating from site theme
- Generate semantic search results within a crawl
- Organizations have crawled 30,000+ pages sending each to AI for categorization

Source: https://www.screamingfrog.co.uk/seo-spider/tutorials/how-to-crawl-with-ai-prompts/

### Claude Code Audit Workflow

The advanced workflow for Claude Code technical audits uses "Ultra Think" (extended reasoning) to analyze entire repositories, identifying technical SEO bottlenecks that standard crawlers miss: inefficient JavaScript execution, CSS blocking critical rendering paths, and framework-specific issues across React, Next.js, or plain HTML.

Sub-agent deployment pattern:
- Agent 1: Alt text generation based on image context
- Agent 2: Meta description auditing and creation
- Agent 3: Internal linking analysis using topical authority mapping

Source: https://stormy.ai/blog/claude-code-technical-seo-guide

### Claude SEO Skill (Open Source)

The mangollc/claude-seo-skill GitHub repository provides a comprehensive Claude Code plugin for agencies covering:
- Website health audits with 0 to 100 scoring
- Page-specific SEO scoring for targeted keywords
- Content decay detection and keyword cannibalization identification
- Schema markup generation
- E E A T signal assessment
- Enhanced AEO Discovery (mining PAA boxes, autocomplete, Reddit/Quora questions)
- Multi-client architecture with dedicated folders per client
- No API keys required for core functionality (uses Firecrawl for website reading)

Installation: `claude plugin marketplace add mangollc/claude-seo-skill`
Dependency: Firecrawl CLI (`npm install -g firecrawl-cli`)

Source: https://github.com/mangollc/claude-seo-skill

---

## 4. AI for Core Web Vitals Optimization

### 2026 Status

- Only 48% of mobile pages and 56% of desktop pages pass all three Core Web Vitals
- INP is the most commonly failed metric: 43% of sites still fail the 200ms threshold
- CWV now directly impacts AI search visibility: sites passing all thresholds are more likely to be quoted by AI assistants

### AI Assisted Optimization Patterns

**For LCP (target under 2.5s):**
- Claude Code can analyze page source and identify LCP bottlenecks
- Image preloading, critical CSS inlining, font preloading with display swap, and SSR are the four highest impact fixes
- "Vibe debugging" approach: copy PageSpeed Insights error messages directly into Claude Code, which implements fixes including WebP conversion, CSS minification, and lazy loading

**For INP (target under 200ms):**
- Heavy JavaScript execution blocking the main thread is almost always the culprit
- Any single JavaScript task running over 50ms blocks browser input response
- AI agents can analyze JavaScript bundles and recommend code splitting strategies

**For CLS (target under 0.1):**
- Every image, video, iframe, and ad slot needs explicit width and height attributes
- AI can crawl entire sites to identify elements missing dimension attributes

### Business Impact

Sites passing all CWV thresholds have seen organic traffic increase 34% within 6 weeks and conversion rate improve by 12% in documented case studies.

Sources:
- https://www.digitalapplied.com/blog/core-web-vitals-2026-inp-lcp-cls-optimization-guide
- https://rankai.ai/articles/core-web-vitals-guide

---

## 5. AI Driven Content Optimization and E E A T Scoring

### Key Tools and Approaches

**Semrush AI Search Health Report:** Shows how well your website is optimized for LLMs. A higher report score means content is more accessible, better structured, and more likely to appear in AI search engines.

**Ahrefs AI Content Helper:** Choose a target keyword, Ahrefs scans top ranking pages, then you work in an editor that scores topic coverage, flags content gaps, and suggests improvements in real time. The AI Content Grader automatically analyzes top ranking articles for a keyword, identifies topics present, and scores them on coverage quality.

**AEO/GEO Specialist Tools (2026):**
- Scrunch
- Adobe LLM Optimizer
- AthenaHQ
- Bluefish
- Peec AI
- Profound
- Semrush AI Visibility Toolkit

### E E A T and AI Citation Correlation

E E A T signals show a +30.64% correlation with AI citations. Clear, concise information delivered in digestible blocks ranks higher, with clarity and summarization showing a +32.83% positive impact on AI citation rates.

### Content Factors That Drive AI Citations

- Content that leads with clear answers, demonstrates expertise, and uses structured formatting gets cited most often
- Front load key information: 44.2% of all LLM citations come from the first 30% of text
- The first cited source in a ChatGPT response receives 43% of user clicks
- Wikipedia dominates ChatGPT citations at 7.8%, Reddit dominates Perplexity at 6.6%

Sources:
- https://www.semrush.com/blog/content-optimization-ai-search-study/
- https://scrunch.com/blog/best-answer-engine-optimization-aeo-generative-engine-optimization-geo-tools-2026
- https://medium.com/@timsoulo/best-ai-seo-tools-for-2026-content-optimization-keyword-research-and-ai-visibility-6e9a13c354db

---

## 6. Automated Schema Markup Generation and Validation

### AI Schema Generation Tools

- **schemawriter.ai:** AI schema markup generator automating JSON-LD for any page
- **InstantAlt:** Shipped JSON-LD schema generation as of February 13, 2026
- **WordLift:** Automatic structured data/schema markup generation without coding, learns brand voice
- **Claude Code:** Can generate JSON-LD schema by analyzing page content directly

### Production Workflow

The recommended pattern for using AI in production schema generation:
1. Point AI at URL or HTML content
2. AI generates draft JSON-LD capturing products, authors, ratings, etc.
3. Validate programmatically with Google Rich Results Test and Pydantic
4. Run security review (SBOM checks) before deployment
5. Deploy validated schema

Teams following this approach report production ready JSON-LD at roughly 3x their previous speed while keeping validation error rates under 2%.

### Schema for AI Agents

In 2026, schema markup has become critical because AI agents use it to understand, verify, and cite content. JSON-LD structured data is the format AI systems rely on most heavily for entity disambiguation and fact verification.

### Cost Context

Token costs have dropped 280-fold in two years (per Deloitte Insights 2026), making AI powered schema generation affordable to embed in everyday workflows.

Sources:
- https://schemawriter.ai/
- https://witscode.com/blogs/schema-markup-ai-agents-json-ld-examples-that-work/
- https://www.singlegrain.com/artificial-intelligence/best-schema-markup-generators-in-2026/

---

## 7. AI Agents for Competitive Analysis and Keyword Research

### Automated Competitive Intelligence

AI agents conduct sophisticated competitor analysis that previously took human analysts days or weeks. When a system detects competitors ranking for target keywords, it can automatically compile competitor content, extract entities and questions, and suggest outline adjustments to outperform the competition.

### Keyword Research Automation

Modern NLP systems analyze thousands of keywords and automatically group them into topic clusters based on search intent. They classify intent along the buyer journey (informational, comparison, transactional) across entire keyword universes, mapping discoveries directly to content types and conversion funnels.

### Content Calendar Integration

When you approve a keyword opportunity, automation can create a content brief with target keywords, related terms, questions to answer, and competitor articles to reference. That brief flows directly into your content calendar as a scheduled task.

### Key Platforms for Competitive Analysis

| Tool | Specialty |
|------|-----------|
| Visualping | Website change and competitor monitoring |
| Semrush | SEO intelligence, AI visibility |
| Ahrefs | Backlink analysis, content grading |
| Similarweb | Traffic insights |
| SpyFu | PPC research |
| SE Ranking | Live competitor signals via MCP |
| DataForSEO | API level SEO data access |

Sources:
- https://almcorp.com/blog/ai-agents-for-seo/
- https://www.trysight.ai/blog/keyword-research-automation
- https://visualping.io/blog/best-ai-tools-competitor-analysis

---

## 8. Tracking AI Search Citations Programmatically

### The New Visibility Layer

With Google AI Overviews reaching 2 billion monthly users across 200+ countries and ChatGPT processing 3+ billion messages daily from 700 million weekly active users, tracking AI citations is now as important as tracking traditional SERP rankings.

### Platform Citation Patterns (Critical Data)

| Metric | ChatGPT | Google AI Overviews | Perplexity |
|--------|---------|---------------------|------------|
| Top source | Wikipedia (7.8%) | Reddit (2.2%) | Reddit (6.6%) |
| 2nd source | Reddit (1.8%) | YouTube (1.9%) | YouTube (2.0%) |
| 3rd source | Forbes (1.1%) | Quora (1.5%) | Gartner (1.0%) |
| Top 10 concentration | Wikipedia 47.9% | More distributed | Reddit 46.7% |
| Domain type | .com 80.41% | Mixed | .com dominant |

**Only 11% of domains are cited by both ChatGPT and Perplexity.** Each platform requires a different optimization strategy.

### Monitoring Tools

- **Otterly.AI:** Tracks brand mentions and citations on Google AI Overviews, ChatGPT, Perplexity, Google AI Mode, Gemini, and Copilot. API access and CSV/JSON data export available.
- **LLMrefs:** Monitors brand and URL citations across multiple LLMs, generating prompts automatically and outputting share of voice, citation counts, and competitor presence.
- **Semrush AI Visibility Toolkit:** Share of Voice, brand sentiment, prompt tracking for Google AI Mode and ChatGPT.
- **Omnia:** Runs prompts via browser sessions mirroring real user experiences across all platforms.
- **BrightEdge and Authoritas:** AI Overview monitoring capabilities with custom alerts.

### Key Metrics to Track

1. **Visibility rate:** Percentage of prompts where your brand appears
2. **Share of voice:** Your brand's percentage of total mentions vs competitors
3. **Citation frequency:** How often owned content gets cited
4. **Top cited domains:** Which sources AI engines trust most for your topics
5. **Geographical deltas:** Visibility differences by country
6. **Prompt coverage by cluster:** Which topic areas you dominate vs gaps

### Implementation Roadmap (15 Days)

**Week 1 (Days 1 to 7):**
- Build 20 to 30 prompts across 3 to 4 topic clusters from customer language
- Define 3 to 5 direct competitors
- Select tracking platforms and countries
- Set up spreadsheet or automated tool

**Week 2 (Days 8 to 15):**
- Run baseline measurement across all platforms
- Analyze gaps (content, authority, clarity)
- Prioritize 3 to 5 highest impact fixes
- Ship quick wins and establish weekly tracking cadence

### Tracking Frequency

- Weekly reruns: standard for active monitoring
- Daily reruns: for teams shipping content rapidly
- Monthly reruns: too infrequent for meaningful trends

Sources:
- https://otterly.ai/
- https://www.tryprofound.com/blog/ai-platform-citation-patterns
- https://www.averi.ai/how-to/chatgpt-vs.-perplexity-vs.-google-ai-mode-the-b2b-saas-citation-benchmarks-report-(2026)
- https://www.useomnia.com/blog/how-to-monitor-ai-search-visibility
- https://visible.seranking.com/blog/best-ai-visibility-tools/

---

## 9. AI Powered Link Building and Outreach

### Current State

AI automates prospect identification, email personalization, and results analysis. However, no platform eliminates the need for strategic thinking and relationship building. The most successful teams use AI to augment human creativity and relationship management rather than fully automate link acquisition.

### Key Platforms

- **Respona:** Complete AI link building platform combining prospect research, contact finding, and personalized outreach
- **Postaga:** AI email personalization and campaign automation at scale
- **Linkee:** Automates the entire process from finding email addresses to AI email creation and follow-ups
- **Search Atlas:** Automated outreach tools for backlink profile growth

### Quality Context

Google's AI systems can now identify link manipulation in real time, making trustworthy, contextual, and editorial links the only ones with lasting value.

Sources:
- https://hypertxt.ai/blog/ai-tools/best-ai-link-building-tools-2026/
- https://www.searchenginejournal.com/ai-overviews-link-building-editorialink-spa/561875/

---

## 10. NetSuite / SuiteCommerce AI Automation

### Current Status

There are no dedicated AI SEO tools specifically built for SuiteCommerce Advanced. The landscape remains dominated by general SuiteCommerce SEO service providers (AWA Labs, ERP Peers, RSM) and Oracle's native SEO engine.

### Oracle AI Updates

Oracle unveiled NetSuite Next with AI powered features:
- **Ask Oracle:** Natural language interface for NetSuite
- **AI powered coding companion:** Generates SuiteScript code, automates deployment tasks, streamlines workflows
- **SEO Page Generator upgrade:** New infrastructure and rendering engine, enabling latest ECMAScript syntax with performance and reliability improvements

### SuiteCommerce SEO Architecture

SuiteCommerce relies on single page application architecture. JavaScript-based applications route direct requests through a server-side headless browser known as the SEO Generator or Engine. This is the prerendering layer critical for search engine visibility.

### Opportunity for OFM

This is a wide open market. No one has built a Claude Code skill or MCP integration specifically for SuiteCommerce SEO. The combination of SuiteScript automation, prerender monitoring, faceted navigation SEO, and SPA rendering analysis represents a highly differentiated offering that OFM could own.

Sources:
- https://www.awalabs.com/knowledge-center/seo-engine
- https://www.netsuite.com/portal/products/artificial-intelligence-ai.shtml
- https://developers.suitecommerce.com/index.html

---

## 11. SEO MCP Tools Ecosystem

### Available MCP Servers for SEO

**SEO MCP Server (seomcp.dev)**
39 tools across 7 categories:
- Site Auditing (3 tools): full audits, page analysis, robots.txt validation
- Search Console (9 tools): performance metrics, URL inspection, sitemap admin
- Google Analytics 4 (11 tools): traffic analysis, sources, device/geo data
- Google Indexing (4 tools): URL submissions, batch processing
- IndexNow (4 tools): rapid indexing for Bing, Yandex
- Core Web Vitals (1 tool): PageSpeed Insights with LCP, INP, CLS
- Schema and Validation (2 tools): JSON-LD verification, robots.txt analysis

Pricing: Free (50 calls/mo) | Pro $29/mo (500 calls) | Enterprise custom

**MCP GSC Server (AminForou/mcp-gsc)**
19 tools for Google Search Console:
- Property management (list, add, delete)
- Search analytics with visualization
- URL inspection and batch checking
- Sitemap management
- Supports OAuth and service account authentication
- Python 3.11+, configures via claude_desktop_config.json

**DataForSEO MCP Server**
Modules: AI Optimization, SERP, Keywords Data, OnPage, DataForSEO Labs, Backlinks, Business Data
Three installation methods: remote HTTP server, NPM repository, local with custom changes
Pay per use pricing ($0.01 per query for many endpoints)

**SE Ranking MCP Server**
Live competitor signals, keyword opportunities, AI search insights
Can chain 15+ API calls in a single task
GitHub: https://github.com/seranking/seo-data-api-mcp-server

**Technical SEO MCP (technicalseomcp.com)**
SEO tools for Claude and AI agents. Details limited from public page.

### MCP Integration Priority for OFM

Based on capability, pricing, and relevance to our workflow:

1. **MCP GSC Server** (free, open source, 19 tools) - HIGHEST PRIORITY
2. **DataForSEO MCP** (pay per use, comprehensive API access) - HIGH PRIORITY
3. **SE Ranking MCP** (live competitor data, AI search insights) - HIGH PRIORITY
4. **SEO MCP Server** (unified 39-tool platform) - MEDIUM PRIORITY (evaluate free tier)
5. **PageSpeed MCP** (previously identified, CWV automation) - HIGH PRIORITY

Sources:
- https://seomcp.dev/
- https://github.com/AminForou/mcp-gsc
- https://dataforseo.com/model-context-protocol
- https://seranking.com/api/integrations/mcp/

---

## 12. llms.txt and AI Crawler Optimization

### What Is llms.txt

A plain text file hosted in a website's root directory that provides a concise, Markdown formatted map of a site's most important resources. Designed for large language models, not search engine crawlers. Does not replace XML sitemaps or change how Google indexes a site.

### Current Adoption Reality

Mixed evidence on effectiveness:
- 8 out of 9 sites saw no measurable change in traffic after llms.txt implementation (Search Engine Land)
- John Mueller confirmed none of the AI crawlers have claimed they extract information via llms.txt yet
- However, Claude/Anthropic listed llms.txt and llms-full.txt in their official documentation, reflecting a clear endorsement

### AI Crawler Traffic

AI crawlers now generate over 50% of web traffic in some contexts. AI crawler optimization requires:
- Proper robots.txt configuration
- llms.txt implementation
- Server-side rendering
- Comprehensive, accurate content with clear structure
- Detailed schema markup
- Fast loading times

### Recommendation

Low effort, no risk implementation. Add llms.txt to client sites as a forward-looking measure even though current impact is minimal. It positions sites for future AI crawler behavior changes.

Sources:
- https://www.bluehost.com/blog/what-is-llms-txt/
- https://neilpatel.com/blog/llms-txt-files-for-seo/
- https://koanthic.com/en/ai-crawler-optimization-complete-guide-for-2026/

---

## 13. Reddit Community Sentiment on AI and SEO

### Key Findings from r/SEO, r/bigseo, r/TechSEO

- Sentiment is mixed: fearful of AI's impact on search rankings and content quality, but positive about its use for technical tasks
- Most panic comes from junior SEOs and freelance writers worried about automation
- Senior SEOs are doubling down on strategic skills: authority building, UX improvement, AI-assisted workflow mastery
- A 100-word Reddit comment in r/SEO gets cited in AI answers 12x more frequently than a 2,000-word guide on the same topic

### Reddit as a Citation Source

- Reddit dominates Perplexity citations at 46.7% of top 10 sources
- Reddit leads Google AI Overviews citations at 21% of top 10 sources
- Reddit is ChatGPT's second most cited source at 1.8%
- ChatGPT synthesizes Reddit threads where real users compare tools and share workflows

### Implication for Clients

Authentic, helpful Reddit participation in relevant subreddits is now a legitimate SEO strategy that drives visibility in AI search results.

Sources:
- https://www.recoverreputation.com/i-looked-at-the-pulse-of-seo-what-a-year-on-reddit-revealed-about-ais-unfolding-impact/
- https://sitebulb.com/resources/guides/reddit-is-no-longer-just-a-nerd-forum-its-an-ai-visibility-lever/

---

## 14. Actionable Recommendations for OFM

### IMMEDIATE (Build This Week)

1. **Install MCP GSC Server** - Free, open source, 19 tools. Gives us live GSC data inside Claude Code conversations. No cost, high impact.

2. **Install DataForSEO MCP** - Pay per use, gives us SERP, keyword, backlink, and onpage data directly in Claude Code. $0.01 per query makes this extremely cost effective.

3. **Evaluate mangollc/claude-seo-skill** - Open source Claude Code plugin with multi-client architecture, health scoring, AEO discovery, and reporting. Could replace or augment several of our existing manual workflows.

4. **Add llms.txt generation** to our technical SEO audit deliverables. Low effort, positions clients for future AI visibility.

### SHORT TERM (This Month)

5. **Build AI citation tracking workflow** - Use Otterly.AI or build a custom prompt-based tracking system to monitor client visibility across ChatGPT, Perplexity, Google AI Overviews, and Gemini. Establish weekly tracking cadence.

6. **Integrate Screaming Frog with Claude/Anthropic API** - Enable AI prompts during crawls for automated content categorization, semantic similarity detection, and E E A T assessment at scale.

7. **Create a CWV optimization agent** - Build a specialized agent that takes PageSpeed Insights data and generates specific code fixes (image optimization, CSS/JS optimization, layout shift fixes) tailored to the client's tech stack.

8. **Install SE Ranking MCP** - Live competitor signals and AI search insights feed directly into Claude Code workflows.

### MEDIUM TERM (Next Quarter)

9. **Build SuiteCommerce SEO automation** - No one has built this yet. Create a Claude Code skill specifically for SuiteCommerce: prerender monitoring, SPA rendering validation, faceted navigation SEO, SuiteScript SEO automation. This is a unique market position for OFM.

10. **Develop AI visibility audit service** - Using Semrush AI Visibility Toolkit combined with custom prompt tracking, create a standardized AI visibility audit that covers ChatGPT, Perplexity, Google AI Overviews, Gemini, and Copilot. Package as a new service offering.

11. **Create automated schema pipeline** - Build a workflow that crawls client sites, generates JSON-LD schema using Claude, validates against Rich Results Test programmatically, and produces deployment-ready schema files with review checkpoints.

12. **Build content optimization scoring** - Combine E E A T assessment, AI citation correlation factors (+30.64% for E E A T signals, +32.83% for clarity/summarization), and content structure analysis into a scoring system that predicts both traditional ranking potential and AI citation likelihood.

### STRATEGIC (Ongoing)

13. **Reddit strategy for clients** - Given Reddit's dominance in Perplexity (46.7%) and Google AI Overviews (21%) citations, develop a framework for authentic client participation in relevant subreddits.

14. **Monitor AI search landscape** - Track monthly: AI Overview expansion, ChatGPT search feature updates, Perplexity market share, new AI citation patterns. Update our AEO skill and frameworks accordingly.

15. **Skill updates** - Update the following skills based on this research:
    - aeo-ai-seo: Add AI citation tracking metrics, platform-specific optimization strategies
    - technical-seo: Add llms.txt generation, AI crawler optimization checks
    - schema-markup: Add AI agent optimization context, production validation workflow
    - core-web-vitals: Add AI search correlation data, automated fix generation patterns
    - content-optimization: Add E E A T scoring correlation data, AI citation factors

---

## Key Statistics Reference

- Google AI Overviews: 2 billion monthly users, 200+ countries (Feb 2026)
- ChatGPT: 3+ billion messages daily, 700 million weekly active users
- Only 11% of domains cited by both ChatGPT and Perplexity
- E E A T signals: +30.64% correlation with AI citations
- Content clarity: +32.83% positive impact on AI citations
- First cited source in ChatGPT gets 43% of user clicks
- 44.2% of LLM citations come from the first 30% of text
- CWV pass rates: 48% mobile, 56% desktop
- 43% of sites fail INP threshold (200ms)
- Sites passing CWV: +34% organic traffic, +12% conversion rate
- Token costs dropped 280-fold in two years
- AI schema generation: 3x speed, under 2% error rate
- Reddit comment cited 12x more than 2,000-word guide in AI answers
