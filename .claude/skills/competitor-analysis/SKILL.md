---
name: competitor-analysis
description: >
  Use when someone asks to run a competitor analysis, competitive audit, or wants to know
  who they are competing with in organic search. Trigger on: "competitor analysis",
  "competitive audit", "who are we competing with", "competitor SEO", "competitive landscape",
  "competitor comparison", "who is outranking us", "share of voice comparison",
  "keyword overlap analysis", "content gap vs competitors", "backlink gap analysis".
  This is the full competitive SEO analysis workflow covering keyword overlap, content gaps,
  SERP feature competition, backlink comparison, and technical benchmarking.
disable-model-invocation: true
argument-hint: "[competitor domain or URL]"
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch, Agent
---

# Competitive SEO Analysis

Full competitive analysis covering keyword overlap, content gaps, SERP feature competition, backlink comparison, and technical benchmarking. This deploys the Competitor Intelligence, Content Strategist, and Link Strategist agents to produce an opportunity matrix.

## Context

The user wants to understand how a client's organic search presence compares to specific competitors. This analysis identifies where competitors are winning, where the client has untapped opportunities, and what strategic moves will close competitive gaps most effectively. This is appropriate when onboarding a new client, when organic visibility is declining relative to competitors, or when planning a quarterly strategy refresh.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Client website URL (required)
- Competitor URLs (required, 2 to 5 competitor domains)
- Target keywords or topic areas (optional, will be discovered through analysis if not provided)
- Specific competitive concerns (optional, e.g., "competitor X recently launched a blog," "losing rankings to competitor Y")

## Instructions

### Step 0: Initialize Audit Tracking

Use TaskCreate to set up the analysis task list:
- Create a parent task: "[Client] Competitive SEO Analysis" with description of scope
- Create subtasks for each phase: Client Context, Landscape Discovery, Agent Deployment, Report Generation, Save Results
- Update each task status as you progress through phases

### Step 1: Load Client Context

Check `clients/{client-name}/` for existing profile, keyword data, and previous competitive analysis. Read any prior findings to track competitive position changes over time. If the client does not exist, create the directory structure.

### Step 2: Competitive Landscape Discovery

Using Chrome tools and web search, perform initial competitive reconnaissance:

1. Visit each competitor's website to understand their content strategy, site structure, and UX approach
2. Note each competitor's tech stack, CMS, and site architecture
3. Identify competitor content formats (blogs, resource centers, tools, calculators, videos)
4. Check competitor structured data and rich result appearances
5. Search for key industry queries and note which competitors appear in organic results, AI Overviews, featured snippets, and SERP features
6. Observe competitor brand authority signals (knowledge panels, Wikipedia presence, social proof)

### Step 3: Parallel Agent Deployment

Launch the following analyses simultaneously using subagents:

**Agent 1: Competitor Intelligence (primary)**
- Read `.claude/agents/competitor-intelligence.md` for full methodology
- **Keyword Overlap Analysis:** Map the client's ranking keywords against each competitor. Identify shared keywords, unique keywords (only client ranks), and competitor exclusive keywords (opportunities).
- **SERP Feature Competition:** Map which competitors hold featured snippets, People Also Ask, AI Overviews, image packs, video carousels, and knowledge panels for target queries.
- **Ranking Velocity and Trends:** Compare ranking trajectory over the past 6 to 12 months. Identify competitors gaining or losing ground.
- **Share of Voice:** Calculate estimated organic share of voice across the target keyword set.
- **Technical SEO Comparison:** Compare page speed, mobile usability, and CWV performance across all competitors.
- **AI Search Visibility Comparison:** Check which competitors are being cited by AI search engines for key queries.
- **Domain Authority and Trust Signals:** Compare domain strength metrics across all sites.

**Agent 2: Content Strategist (supporting)**
- Read `.claude/agents/content-strategist.md` for methodology
- **Content Gap Identification:** Map topics and keywords that competitors rank for where the client has no content.
- **Content Quality Comparison:** Compare content depth, format, freshness, and E-E-A-T signals between the client and top competitors.
- **Content Format Analysis:** Identify content types and formats driving the most organic visibility for competitors (guides, comparisons, tools, videos).
- **Topic Coverage Breadth:** Assess which competitor has the most comprehensive topical authority in the core subject area.

**Agent 3: Link Strategist (supporting)**
- Read `.claude/agents/link-strategist.md` for methodology
- **Backlink Profile Comparison:** Compare total referring domains, domain quality distribution, and link velocity across all sites.
- **Link Gap Analysis:** Identify high quality domains linking to competitors but not to the client.
- **Anchor Text Distribution:** Compare anchor text profiles for naturalness and keyword targeting.
- **Content Driven Link Opportunities:** Identify competitor content that has earned significant backlinks and could be replicated or improved upon.

### Step 4: Report Generation

Compile findings into a competitive analysis report:

1. **Executive Summary** with competitive position overview and top 5 opportunities
2. **Competitive Landscape Overview** with a summary profile of each competitor
3. **Keyword Overlap Matrix** showing shared, unique, and opportunity keywords across all competitors
4. **Content Gap Report** with prioritized topics the client should target based on competitor success
5. **SERP Feature Map** showing which competitors own which features for target queries
6. **Backlink Comparison** with referring domain counts, quality distribution, and gap analysis
7. **Share of Voice Dashboard** with current market position and trend direction
8. **Technical Benchmark Comparison** with page speed and CWV comparisons
9. **AI Search Visibility Comparison** showing citation rates across AI platforms
10. **Opportunity Matrix** ranking all opportunities by potential impact and implementation difficulty
11. **Strategic Recommendations** with specific actions to close competitive gaps, organized by priority

### Step 5: Save Results

1. Save the report to `clients/{client-name}/reports/{date}-competitor-analysis.md`
2. Save individual findings to `clients/{client-name}/findings/`
3. Update `clients/{client-name}/profile.md` with competitive landscape information
4. Update `clients/{client-name}/open-items.md` with competitive strategy action items

## Output

The final deliverable is a competitive SEO analysis report with a keyword overlap matrix, content gap analysis, backlink comparison, SERP feature map, and a scored opportunity matrix. Each opportunity is ranked by potential traffic impact and implementation effort, providing a clear prioritization framework for closing competitive gaps and capturing market share.
