---
name: content-audit
description: >
  Use when someone asks to run a content audit, review content quality, find thin content,
  assess E-E-A-T, or check for content decay. Trigger on: "content audit", "content quality",
  "thin content", "E-E-A-T review", "content decay", "content cannibalization",
  "keyword cannibalization", "content gap analysis", "content strategy audit",
  "which pages need updating", "content scoring", "duplicate content check".
  This is the full content quality and strategy audit workflow covering quality scoring,
  keyword gap analysis, content cannibalization, thin content identification, and E-E-A-T assessment.
disable-model-invocation: true
argument-hint: "[URL or domain to audit]"
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch, Agent
---

# Content Quality and Strategy Audit

Focused content audit covering quality scoring, keyword gap analysis, content cannibalization, thin content identification, and E-E-A-T assessment. This deploys the Content Strategist and Competitor Intelligence agents to produce a content roadmap.

## Context

The user wants to evaluate a client's content ecosystem for SEO effectiveness. This is appropriate when organic traffic is stagnating, when planning a content strategy overhaul, when content cannibalization is suspected, or when preparing for an AI search optimization initiative that requires strong foundational content.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Website URL (required)
- Target keywords or topic areas (optional, will be discovered through analysis if not provided)
- Specific content sections to focus on (optional, e.g., "blog," "product pages," "resource center")

## Instructions

### Step 0: Initialize Audit Tracking

Use TaskCreate to set up the audit task list:
- Create a parent task: "[Client] Content Audit" with description of scope
- Create subtasks for each phase: Client Context, Content Discovery, Agent Deployment, Report Generation, Save Results
- Update each task status as you progress through phases

### Step 1: Load Client Context

Check `clients/{client-name}/` for existing profile and previous audit findings. Read any prior content analysis, keyword research, or ranking data. If the client does not exist, create the directory structure.

### Step 2: Content Discovery

Using Chrome tools, map the client's content landscape:

1. Navigate the site to identify all content sections (blog, resources, guides, product pages, category pages)
2. Review the XML sitemap for a complete URL inventory
3. Check for content hubs, pillar pages, and topic cluster structures
4. Note the content publishing cadence (dates on blog posts, freshness signals)
5. Identify the primary content types (articles, product descriptions, landing pages, FAQs)
6. Capture navigation structure and internal linking patterns between content sections

### Step 3: Parallel Agent Deployment

Launch the following analyses simultaneously using subagents:

**Agent 1: Content Strategist (primary)**
- Read `.claude/agents/content-strategist.md` for full methodology
- **Content Quality Scoring:** Evaluate each major page/section against E-E-A-T criteria (Experience, Expertise, Authoritativeness, Trustworthiness)
- **Thin Content Detection:** Identify pages with insufficient depth, word count below threshold, or low unique value
- **Duplicate and Cannibalization Analysis:** Find pages competing for the same keywords or covering overlapping topics
- **Search Intent Mapping:** Assess whether content matches the dominant search intent for target queries (informational, navigational, transactional, commercial)
- **Featured Snippet Opportunities:** Identify queries where content restructuring could capture position zero
- **Content Freshness:** Flag outdated content that needs updating or consolidation
- **Content Gaps:** Identify topics the site should cover but currently does not

**Agent 2: Competitor Intelligence (supporting)**
- Read `.claude/agents/competitor-intelligence.md` for methodology
- Identify top organic competitors for the client's primary keyword set
- Analyze competitor content strategies: topics covered, depth, formats, publishing frequency
- Map content gaps where competitors rank but the client has no content
- Identify content types and formats driving the most organic visibility for competitors
- Assess competitor E-E-A-T signals (author bios, credentials, citations, external validation)

### Step 4: Report Generation

Compile findings into a content audit report:

1. **Executive Summary** with top content opportunities and critical issues
2. **Content Inventory** with page count by section and content type
3. **Quality Scoring Matrix** with each major page/section scored on depth, E-E-A-T, intent match, and uniqueness
4. **Thin Content Report** listing pages that need expansion, consolidation, or removal
5. **Cannibalization Map** showing keyword overlaps between competing pages with recommended resolution
6. **Content Gap Analysis** with prioritized topics the site should create content for
7. **Competitor Content Comparison** with gap analysis and format insights
8. **Content Roadmap** with a prioritized 90 day plan organized by impact and effort
9. **Quick Wins** listing content optimizations that can be implemented immediately

### Step 5: Save Results

1. Save the report to `clients/{client-name}/reports/{date}-content-audit.md`
2. Save individual findings to `clients/{client-name}/findings/`
3. Update `clients/{client-name}/open-items.md` with all content action items

## Output

The final deliverable is a content audit report with a quality scoring matrix for all major content sections, a cannibalization map with resolution recommendations, a competitive content gap analysis, and a prioritized 90 day content roadmap. Each recommendation includes specific implementation guidance covering target keywords, search intent, content format, depth requirements, and internal linking instructions.
