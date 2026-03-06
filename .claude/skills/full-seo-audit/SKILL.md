---
name: full-seo-audit
description: >
  Use when someone asks for a full SEO audit, complete audit, comprehensive SEO review,
  or wants to audit everything. Trigger on: "full SEO audit", "complete audit",
  "comprehensive SEO", "audit everything", "full site audit", "complete SEO assessment",
  "audit the whole site", "run a full audit", "comprehensive organic audit",
  "all dimensions SEO check". This is the most thorough analysis available, orchestrating
  all eight specialist agents in parallel to produce a complete assessment across every
  SEO dimension: technical, content, AI search, page speed, links, schema, search console,
  and competitive positioning.
disable-model-invocation: true
argument-hint: "[client-name] [website-url]"
allowed-tools: Read, Glob, Grep, Bash, WebFetch, WebSearch, Agent, Write
---

# Full SEO Audit

Comprehensive SEO audit of a client's entire organic search ecosystem. This orchestrates all eight specialist agents in parallel to produce a complete assessment across every SEO dimension.

## Context

The user wants a complete SEO audit covering technical infrastructure, content quality, AI search readiness, page speed, link profile, structured data, search console health, and competitive positioning. This is the most thorough analysis available and produces a unified report with all dimensions scored and prioritized.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Website URL (required)
- Specific pages to audit (optional, key pages will be discovered via browser)
- Known issues or areas of concern (optional)

## Instructions

### Step 0: Initialize Audit Tracking

Use TaskCreate to set up the audit task list for progress tracking:
- Create a parent task: "[Client] Full SEO Audit" with description of scope
- Create subtasks for each phase: Browser Recon, Agent Deployment (one per agent), Report Synthesis, Save Results
- Update each task to in_progress as you begin it and completed when done
- This provides Michael with real time visibility into audit progress

### Step 1: Client Profile Setup

Check if the client exists in `clients/{client-name}/`. If not, create the client directory and profile:

```
clients/{client-name}/
├── profile.md
├── history.md
├── open-items.md
├── findings/
└── reports/
```

If the client exists, read their profile and all previous findings to build on prior knowledge.

### Step 2: Browser Reconnaissance

Before launching specialist agents, perform initial site reconnaissance:

1. Navigate to the client's homepage using Chrome tools
2. Identify the site's tech stack (CMS, frameworks, tag managers, CDN, hosting)
3. Discover key pages: homepage, product/service pages, category pages, blog, contact, about
4. Note the overall site structure, navigation hierarchy, and URL patterns
5. Check robots.txt and XML sitemap accessibility
6. Capture initial page load behavior (SPA vs traditional rendering)

### Step 3: Parallel Agent Deployment

Launch the following analyses simultaneously using subagents:

**Agent 1: Technical SEO Auditor**
- Read `.claude/agents/technical-seo-auditor.md` for methodology
- Audit crawlability, indexation, robots.txt, sitemaps, canonicals, redirects, rendering
- Use Chrome tools to inspect page source, headers, and rendering behavior

**Agent 2: Content Strategist**
- Read `.claude/agents/content-strategist.md` for methodology
- Score content quality, identify gaps and cannibalization, assess E-E-A-T signals
- Evaluate search intent alignment and featured snippet opportunities

**Agent 3: AEO Specialist**
- Read `.claude/agents/aeo-specialist.md` for methodology
- Assess AI Overview presence, citation eligibility, entity authority, conversational content readiness

**Agent 4: PageSpeed Optimizer**
- Read `.claude/agents/pagespeed-optimizer.md` for methodology
- Diagnose Core Web Vitals (LCP, INP, CLS), resource loading, third party impact

**Agent 5: Link Strategist**
- Read `.claude/agents/link-strategist.md` for methodology
- Analyze backlink profile, internal linking architecture, anchor text distribution, toxic links

**Agent 6: Schema Architect**
- Read `.claude/agents/schema-architect.md` for methodology
- Audit all structured data, validate JSON-LD, assess rich result eligibility

**Agent 7: Search Console Analyst**
- Read `.claude/agents/search-console-analyst.md` for methodology
- Analyze GSC performance data, index coverage issues, CWV report, manual actions

**Agent 8: Competitor Intelligence**
- Read `.claude/agents/competitor-intelligence.md` for methodology
- Identify top organic competitors, keyword overlap, content gaps, SERP feature competition

### Step 4: Report Synthesis

Consolidate all agent findings into a single report following the template in `templates/audit-report.md`:

1. **Executive Summary** with top 10 findings ranked by impact on organic performance
2. **Score Snapshot** with each of the 8 dimensions rated (Critical, Needs Work, Good, Excellent)
3. **Technical SEO** with all crawlability, indexation, and rendering findings
4. **Content Quality** with scoring matrix, gap analysis, and E-E-A-T assessment
5. **AI Search Readiness** with AEO findings and optimization opportunities
6. **Page Speed and Core Web Vitals** with metric scores and remediation priorities
7. **Link Profile** with backlink health, internal linking, and opportunities
8. **Structured Data** with schema audit results and rich result eligibility
9. **Search Console Health** with index coverage, performance trends, and anomalies
10. **Competitive Position** with gap analysis and opportunity matrix
11. **Implementation Roadmap** with prioritized action plan in phases (Critical, High, Medium, Low)

### Step 5: Save Results

1. Save the full report to `clients/{client-name}/reports/{date}-full-seo-audit.md`
2. Save individual findings to `clients/{client-name}/findings/`
3. Update `clients/{client-name}/profile.md` with discovered tech stack and site information
4. Update `clients/{client-name}/open-items.md` with all action items from the audit

## Output

The final deliverable is a comprehensive SEO audit report covering all 8 dimensions with individual scores, a unified priority ranking, and a phased implementation roadmap. The report is suitable for direct handoff to developers and internal teams, with specific code level fixes and clear performance impact explanations for each finding.
