# SEO & Technical Dev Expert: Complete Infrastructure Document

**System:** OmniFunnel Marketing SEO & Technical Development Expert
**Platform:** Claude Code (Anthropic CLI for Claude)
**Model:** Claude Opus 4.6 (Lead), Claude Sonnet 4.6 (Execution), Claude Haiku 4.5 (Exploration)
**Version:** 1.0.0
**Document Date:** March 2026
**Prepared For:** Third Party Validation

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [System Identity and Purpose](#2-system-identity-and-purpose)
3. [Architecture Overview](#3-architecture-overview)
4. [Core Configuration Layer](#4-core-configuration-layer)
5. [Agent System](#5-agent-system)
6. [Skill System](#6-skill-system)
7. [Framework Library](#7-framework-library)
8. [Rules Engine](#8-rules-engine)
9. [Hook System](#9-hook-system)
10. [MCP Server Integrations](#10-mcp-server-integrations)
11. [Orchestration Model](#11-orchestration-model)
12. [Security Architecture](#12-security-architecture)
13. [Validation and Quality Assurance](#13-validation-and-quality-assurance)
14. [Client Management System](#14-client-management-system)
15. [Asana Integration](#15-asana-integration)
16. [Chrome Automation Scripts](#16-chrome-automation-scripts)
17. [Templates and Deliverables](#17-templates-and-deliverables)
18. [Research Library](#18-research-library)
19. [Complete File Inventory](#19-complete-file-inventory)

---

## 1. Executive Summary

This document provides a complete, granular accounting of the SEO & Technical Dev Expert system built on Anthropic's Claude Code platform. The system serves as the senior SEO and technical development lead for OmniFunnel Marketing (OFM), a boutique digital marketing agency. It operates as an autonomous multi agent orchestration system capable of conducting comprehensive SEO audits, performance optimization, AI search visibility analysis, content strategy development, and developer handoff specification creation across any web platform, with deep specialization in NetSuite SuiteCommerce.

### System at a Glance

| Component | Count | Purpose |
|-----------|-------|---------|
| Specialist Agents | 9 | Autonomous analysis workers with defined roles, tools, and permissions |
| Skills | 32 | Knowledge modules that auto load based on conversation context |
| Frameworks | 10 | Reference methodologies loaded on demand via @import |
| Rules | 6 | Path scoped behavioral instructions governing agent conduct |
| Hooks | 4 | Event driven scripts that enforce security and preserve context |
| MCP Servers | 9 active, 3 pending | External tool integrations (Semrush, Asana, Chrome, Lighthouse, etc.) |
| Chrome Scripts | 8 | ES5 browser automation for live site analysis |
| Validation Checks | 368 | Automated structural (315) and operational (53) quality gates |
| Research Documents | 7 | Deep investigation files totaling approximately 140KB |
| Client Templates | 3 | Standardized client onboarding and tracking structure |
| Deliverable Templates | 2 | Audit report and developer handoff document formats |

### Capabilities Summary

The system can autonomously perform:

1. **Full SEO Audits** covering 8 dimensions (crawlability, indexation, technical, content, links, UX/CWV, local, AI search) with weighted scoring (0 to 100 scale) and priority tiered findings
2. **Core Web Vitals Optimization** with live Lighthouse, PageSpeed Insights, and Chrome DevTools measurement, producing code level remediation specs
3. **AI Search Optimization (AEO/GEO)** analyzing brand visibility across ChatGPT, Perplexity, Gemini, Claude, and Google AI Overviews
4. **NetSuite SuiteCommerce SEO** including SPA rendering audits, prerender verification, SuiteScript automation, and faceted navigation management
5. **Competitive Intelligence** with keyword gap analysis, content gap identification, SERP feature mapping, and share of voice tracking
6. **Content Strategy** with E-E-A-T scoring, topic cluster architecture, keyword cannibalization detection, and editorial roadmap creation
7. **Schema Markup Implementation** generating validated JSON-LD for all Google supported rich result types
8. **Developer Handoff Specifications** with step by step implementation instructions, acceptance criteria, and rollback procedures
9. **Monthly and Quarterly Reporting** with KPI tracking, trend analysis, competitive benchmarking, and ROI attribution
10. **Link Profile Analysis** covering backlink audits, toxic link identification, disavow management, and internal linking optimization

---

## 2. System Identity and Purpose

### What This System Is

This is a Claude Code project: a structured directory of configuration files, agent definitions, skill modules, framework documents, rules, hooks, scripts, and templates that together transform Claude (Anthropic's large language model) into a specialized SEO and technical development expert. When a user opens Claude Code in this project directory, all configuration is automatically loaded, giving Claude the knowledge, tools, permissions, and behavioral constraints to operate as OFM's senior SEO lead.

### Who It Serves

**Michael Tate**, founder of OmniFunnel Marketing. Michael is the sole human operator. He has worked in the digital marketing industry since 1998 and possesses deep technical expertise. The system is designed to match his expertise level, never over explain, and produce deliverables polished enough to hand directly to clients or developers.

### How It Operates

Michael provides high level direction ("audit this site," "investigate this ranking drop," "prepare a CWV remediation spec"). The system then:

1. Reads the relevant agent definitions and skill modules
2. Deploys specialist agents in parallel (swarm mode is default)
3. Each agent uses its assigned tools (browser automation, Semrush API, Lighthouse, etc.) to gather live data
4. Agents produce structured findings following standardized output formats
5. The lead agent synthesizes all findings into unified deliverables
6. All work is tracked in Asana with meaningful progress comments
7. Client memory files are updated for cross session continuity
8. Deliverables are presented as drafts for Michael's review before any client facing action

### What It Never Does Without Explicit Approval

The system has hard coded restrictions preventing it from ever taking action on live client systems without Michael's explicit, per instance approval:

- Making any change to a client's website, CMS, or server configuration
- Publishing, editing, or deleting any page, redirect, robots.txt, or sitemap
- Creating, editing, or deleting any tag, trigger, variable, or container in GTM
- Submitting any URL for indexing, requesting removal, or disavowing links in GSC
- Changing any DNS, hosting, CDN, or server configuration
- Pushing any code to a production or staging environment
- Making changes to any client facing document, deliverable, or communication
- Any action that touches a live client system or external platform

---

## 3. Architecture Overview

### Directory Structure

```
SEO & Technical Dev Expert/
├── .claude/
│   ├── CLAUDE.md                    # Project instructions (97 lines, under 100 line budget)
│   ├── settings.local.json          # Hooks, permissions, project settings
│   ├── agents/                      # 9 specialist agent definitions
│   │   ├── aeo-specialist.md
│   │   ├── competitor-intelligence.md
│   │   ├── content-strategist.md
│   │   ├── link-strategist.md
│   │   ├── netsuite-seo-developer.md
│   │   ├── pagespeed-optimizer.md
│   │   ├── schema-architect.md
│   │   ├── search-console-analyst.md
│   │   └── technical-seo-auditor.md
│   ├── skills/                      # 32 skill modules
│   │   ├── aeo-ai-seo/SKILL.md (+references/)
│   │   ├── aeo-audit/SKILL.md
│   │   ├── agent-orchestration/SKILL.md
│   │   ├── ai-citation-tracking/SKILL.md
│   │   ├── catchup/SKILL.md
│   │   ├── competitor-analysis/SKILL.md
│   │   ├── competitor-seo/SKILL.md
│   │   ├── content-audit/SKILL.md
│   │   ├── content-optimization/SKILL.md
│   │   ├── core-web-vitals/SKILL.md (+references/)
│   │   ├── ecommerce-seo/SKILL.md (+references/)
│   │   ├── full-seo-audit/SKILL.md
│   │   ├── international-seo/SKILL.md
│   │   ├── keyword-research/SKILL.md
│   │   ├── link-building/SKILL.md
│   │   ├── local-seo/SKILL.md
│   │   ├── monthly-seo-report/SKILL.md
│   │   ├── netsuite-environment/SKILL.md
│   │   ├── netsuite-seo/SKILL.md (+references/)
│   │   ├── netsuite-seo-audit/SKILL.md
│   │   ├── pagespeed-audit/SKILL.md
│   │   ├── pagespeed-optimization/SKILL.md (+references/)
│   │   ├── project-eval/SKILL.md
│   │   ├── quarterly-seo-review/SKILL.md
│   │   ├── schema-markup/SKILL.md (+references/)
│   │   ├── search-console/SKILL.md
│   │   ├── semrush-analytics/SKILL.md
│   │   ├── seo-dev-implementation/SKILL.md (+references/)
│   │   ├── spec-audit/SKILL.md
│   │   ├── suitecommerce-seo/SKILL.md (+references/)
│   │   ├── technical-audit/SKILL.md
│   │   └── technical-seo/SKILL.md
│   ├── frameworks/                  # 10 methodology documents
│   │   ├── aeo-methodology.md
│   │   ├── content-architecture.md
│   │   ├── cwv-remediation.md
│   │   ├── keyword-strategy.md
│   │   ├── link-building-methodology.md
│   │   ├── netsuite-seo-architecture.md
│   │   ├── seo-audit-methodology.md
│   │   ├── seo-reporting.md
│   │   ├── technical-seo-dev.md
│   │   └── vertical-seo-benchmarks.md
│   ├── rules/                       # 6 behavioral rule files
│   │   ├── agent-orchestration.md
│   │   ├── anomaly-flagging.md
│   │   ├── client-memory.md
│   │   ├── context-management.md
│   │   ├── security.md
│   │   └── self-learning.md
│   └── hooks/                       # 4 event driven scripts
│       ├── block-gtm-modifications.sh
│       ├── block-protected-files.sh
│       ├── pre-compact-context.sh
│       └── stop-notify.ps1
├── scripts/
│   ├── chrome/                      # 8 ES5 browser automation scripts
│   │   ├── seo-meta-audit.js
│   │   ├── schema-validator.js
│   │   ├── cwv-diagnostics.js
│   │   ├── heading-structure.js
│   │   ├── image-seo-audit.js
│   │   ├── internal-links.js
│   │   ├── js-rendering-check.js
│   │   └── resource-loading.js
│   └── eval/                        # 10 validation scripts
│       ├── validate-all.sh
│       ├── validate-skills.sh
│       ├── validate-agents.sh
│       ├── validate-rules.sh
│       ├── validate-hooks.sh
│       ├── validate-settings.sh
│       ├── validate-refs.sh
│       ├── validate-operational.sh
│       ├── lib.sh
│       └── smoke-test.md
├── templates/
│   ├── audit-report.md
│   └── developer-handoff.md
├── clients/
│   ├── _template/
│   │   ├── CLAUDE.md
│   │   ├── profile.json
│   │   └── seo-config.json
│   ├── verocious-motorsports/
│   └── austenitex/
├── research/                        # 7 deep research documents
├── .claude-plugin/
│   └── plugin.json
├── .gitignore
├── .claudeignore
├── PROJECT-BLUEPRINT.md
└── mcp-setup-guide.md
```

### File Counts by Category

| Category | Files | Total Lines (approx.) |
|----------|-------|-----------------------|
| Agent Definitions | 9 | 1,600 |
| Skill Modules | 32 SKILL.md + reference files | 8,200 |
| Frameworks | 10 | 3,005 |
| Rules | 6 | 450 |
| Hooks | 4 | 120 |
| Chrome Scripts | 8 | 1,200 |
| Eval Scripts | 10 | 1,500 |
| Templates | 2 | 300 |
| Research | 7 | 4,000 |
| Configuration | 6 | 250 |
| **Total** | **94+** | **~20,625** |

---

## 4. Core Configuration Layer

### 4.1 CLAUDE.md (Project Instructions)

**Location:** `.claude/CLAUDE.md`
**Line Count:** 97 (under the 100 line budget recommended by Anthropic best practices)
**Load Behavior:** Automatically injected into every conversation in this project directory

This is the master instruction file. It defines:

- **Safety boundaries:** What the system must never do without approval (all live client system changes)
- **Standing orders:** What the system always does automatically (analyze, track in Asana, manage client memory, orchestrate agents, flag anomalies)
- **Asana Protocol:** Non negotiable per session task tracking with specific board and section GIDs
- **Client Memory Protocol:** Load history before engaging, track findings, draft updates for review
- **Communication style:** No hyphens or dashes ever, natural business prose, match Michael's technical expertise, .docx format for deliverables
- **Agency context:** OFM's tech stack (GSC, Semrush, PSI, GA4, NetSuite, GTM, Chrome MCP)
- **Key specializations:** NetSuite SuiteCommerce SEO, AEO, AI SEO, Technical SEO + Dev, Core Web Vitals
- **Quality standards:** Audit order, priority tiers, schema requirements, CWV thresholds, deliverable structure
- **Orchestration model:** Swarm mode default, agent teams with delegate mode, model tiering (Opus/Sonnet/Haiku)
- **Context management:** Compact at 70 to 80% fill, Grep over Read, /clear between tasks
- **Framework imports:** 10 @import references for on demand methodology loading
- **Validation command:** `bash scripts/eval/validate-all.sh` (315 checks, pre commit enforced)

### 4.2 Global Settings

**Location:** `~/.claude/settings.json`
**Scope:** Applies to all Claude Code projects on this machine

```json
{
  "alwaysThinkingEnabled": true,
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1",
    "CLAUDE_CODE_EFFORT_LEVEL": "high",
    "SLASH_COMMAND_TOOL_CHAR_BUDGET": "30000"
  }
}
```

| Setting | Value | Purpose |
|---------|-------|---------|
| alwaysThinkingEnabled | true | Extended thinking (chain of thought) active on every response |
| CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS | 1 | Enables Agent Teams feature (fully independent Claude instances working in parallel) |
| CLAUDE_CODE_EFFORT_LEVEL | high | Sets reasoning depth to high across all responses |
| SLASH_COMMAND_TOOL_CHAR_BUDGET | 30000 | Doubles default skill description budget from 15K to 30K characters |

### 4.3 Project Settings

**Location:** `.claude/settings.local.json`
**Scope:** Applies only to this project

Contains four configuration sections:

**Hooks:** 4 event driven scripts (detailed in Section 9)
**Permissions Allow List:** Read, Glob, Grep (all paths), safe git operations (log, status, diff, branch), ls, cat of settings, python zipfile
**Permissions Deny List:** All .ssh, .aws, .npmrc, .env, credentials, .pem, .key, .pfx files; all destructive git operations (push force, reset hard, clean -f); rm -rf

### 4.4 Permissions Model

The system operates under a layered permission model:

**Layer 1: CLAUDE.md Instructions** (behavioral, enforced by the model's instruction following)
- Never modify live client systems without explicit approval

**Layer 2: settings.local.json Permissions** (enforced by Claude Code runtime)
- Allow list: read only operations and safe git commands auto approved
- Deny list: credential files and destructive operations always blocked

**Layer 3: Hook Scripts** (enforced by external shell scripts)
- PreToolUse hooks intercept Edit/Write on protected files and GTM modifications
- Exit code 2 produces deterministic blocks that cannot be overridden

**Layer 4: Model Instruction Following** (enforced by the model's training)
- Security rules in `.claude/rules/security.md` provide additional behavioral constraints

---

## 5. Agent System

The system deploys 9 specialist agents, each defined as a markdown file with YAML frontmatter specifying its configuration and a body defining its role, methodology, output format, and key signals.

### 5.1 Agent Configuration Matrix

| Agent | Model | Permission Mode | Max Turns | Background | Skills Loaded |
|-------|-------|----------------|-----------|------------|---------------|
| technical-seo-auditor | Opus | plan (read only) | 30 | No | technical-seo, core-web-vitals, schema-markup |
| netsuite-seo-developer | Opus | default (read/write) | 30 | No | netsuite-seo, suitecommerce-seo, netsuite-environment |
| aeo-specialist | Opus | plan (read only) | 25 | No | aeo-ai-seo, ai-citation-tracking |
| pagespeed-optimizer | Sonnet | default (read/write) | 25 | No | core-web-vitals, pagespeed-optimization |
| schema-architect | Sonnet | default (read/write) | 25 | No | schema-markup |
| content-strategist | Sonnet | plan (read only) | 20 | Yes | content-optimization, keyword-research |
| link-strategist | Sonnet | plan (read only) | 20 | Yes | link-building |
| competitor-intelligence | Haiku | plan (read only) | 20 | Yes | competitor-seo |
| search-console-analyst | Haiku | plan (read only) | 20 | Yes | search-console |

### 5.2 Model Tiering Rationale

**Opus (3 agents):** Used for roles requiring complex judgment, architecture decisions, and synthesis. The technical SEO auditor, NetSuite developer, and AEO specialist handle the most nuanced analysis where reasoning quality directly impacts output accuracy.

**Sonnet (4 agents):** Used for execution focused roles where the methodology is well defined and the agent follows structured phases. The pagespeed optimizer, schema architect, content strategist, and link strategist produce structured deliverables from established frameworks.

**Haiku (2 agents):** Used for data retrieval and exploration roles where speed matters more than deep reasoning. The competitor intelligence and search console analyst agents primarily gather and organize data that feeds into higher level analysis.

### 5.3 Permission Mode Design

**plan mode (6 agents):** Read only access. These agents analyze and recommend but cannot modify files. Used for all audit and analysis roles where the agent should never autonomously write code or edit configurations. Any proposed changes are presented as recommendations for review.

**default mode (3 agents):** Read and write access. These agents can create and modify files. Used for roles that produce implementation code: the NetSuite developer writes SuiteScript, the pagespeed optimizer generates optimized code, and the schema architect creates JSON-LD markup. All writes still require user approval through the permission system.

### 5.4 Background Execution

Four agents run in background mode (content-strategist, link-strategist, competitor-intelligence, search-console-analyst). Background agents execute without blocking the lead agent, allowing parallel work. They are self contained research roles whose output feeds into later synthesis rather than driving immediate next steps.

Five agents run in foreground mode (technical-seo-auditor, netsuite-seo-developer, aeo-specialist, pagespeed-optimizer, schema-architect). Foreground agents block until complete because their findings inform immediate decisions about audit direction, remediation priority, or implementation approach.

### 5.5 Individual Agent Profiles

#### 5.5.1 Technical SEO Auditor

**Model:** Opus | **Permission:** plan | **Max Turns:** 30

**Role:** Identifies every infrastructure level issue preventing search engines from efficiently crawling, rendering, indexing, and ranking a website. Deep knowledge of Googlebot behavior, JavaScript rendering pipelines, HTTP protocol mechanics, and Core Web Vitals measurement.

**Methodology (5 Phases):**
1. **Crawl Analysis:** Full site crawl, robots.txt validation, XML sitemap audit, redirect chain analysis, 4xx/5xx cataloging, orphan page detection, crawl budget allocation, crawl rate metrics
2. **Indexation Audit:** Index status cross reference, indexation ratio calculation, canonical validation, duplicate content detection (85%+ similarity threshold), meta robots review, pagination handling, parameter/faceted navigation audit
3. **Rendering Check:** Raw HTML vs rendered DOM comparison, JavaScript dependent content identification, prerendering solution testing, SPA URL validation, lazy loaded content verification, JavaScript error rate measurement
4. **Speed and Core Web Vitals:** LCP/INP/CLS measurement (lab and field), TTFB analysis, render blocking resource identification, image optimization audit, third party script impact, server response time percentiles
5. **Mobile and Security:** Mobile usability, HTTPS verification, security header checklist (HSTS, CSP, X-Content-Type-Options, X-Frame-Options, Referrer-Policy, Permissions-Policy), hreflang validation

**Output:** Findings table with severity, dimension, score impact, affected pages, current/expected state, performance impact, and step by step fix. Executive summary highlighting top 3 issues and organic traffic risk estimate.

**Key Signals (15):** Robots.txt blocking CSS/JS, canonical pointing to non indexable URLs, JS frameworks rendering only after interaction, redirect chains 3+ hops, missing/outdated sitemaps, orphan pages with organic traffic, CLS from images without dimensions, mixed HTTP/HTTPS content, hreflang loops, faceted navigation generating thousands of near duplicate URLs, disproportionate crawl on low value pages, indexation ratio drops, content delta above 30%, TTFB exceeding 1.5s, security headers below 50%.

#### 5.5.2 NetSuite SEO Developer

**Model:** Opus | **Permission:** default | **Max Turns:** 30

**Role:** Specializes in the intersection of SuiteCommerce Advanced platform architecture and SEO. Expert in SuiteScript 2.x, SuiteCommerce rendering pipelines, Backbone.js SPA routing, and the unique SEO challenges of NetSuite's ecommerce framework.

**Methodology (4 Phases):**
1. **Architecture Review:** Frontend SPA framework version mapping, rendering model identification, SEO module configuration audit, SuiteCommerce config file review, custom SuiteScript extension documentation, hosting architecture assessment, extension/theme inventory
2. **Rendering Audit:** Raw HTML vs rendered JS DOM comparison, prerendering service testing, content completeness verification, JavaScript only content identification, Googlebot rendering testing via GSC, AJAX call audit
3. **URL and Navigation Analysis:** URL structure audit, URL alias review, faceted navigation parameter mapping, crawl budget impact identification, redirect manager audit, hash based URL migration verification, pagination testing, site search URL exclusion, hreflang implementation
4. **Schema and Structured Data:** Product schema audit (name, description, price, availability, SKU, brand, image, review), BreadcrumbList validation, Organization schema completeness, missing schema opportunities, SuiteScript dynamic schema generation, Rich Results Test validation

**Output:** Findings with NetSuite specific configuration changes, SuiteScript code modifications, and prerendering adjustments. SuiteCommerce SEO health summary with rendering coverage percentage, URL structure compliance rate, and schema completeness score.

**Key Signals (11):** Stale prerender cache, empty HTML shell to Googlebot, faceted nav generating thousands of indexable parameter URLs, URL aliases creating duplicates without canonicals, Product schema missing price/availability/reviews, hash fragment URLs still in use, search results indexed competing with categories, custom SuiteScript overriding SEO module defaults, prerender timeout, sitemap excluding new products, different product listings for authenticated vs anonymous.

#### 5.5.3 AEO Specialist

**Model:** Opus | **Permission:** plan | **Max Turns:** 25

**Role:** Ensures brand, products, and content are surfaced, cited, and accurately represented by AI powered answer engines (ChatGPT, Perplexity, Gemini, Claude, Google AI Overviews). Understands how LLMs retrieve, synthesize, and attribute information to optimize content for maximum AI citation probability.

**Methodology (5 Phases):**
1. **AI Visibility Audit:** Standardized 50+ query testing across platforms, competitor citation analysis, conversational query mapping, Google AI Overview analysis
2. **Entity Analysis:** Knowledge graph presence, entity disambiguation, Wikipedia/Wikidata evaluation, entity relationship mapping
3. **Content Optimization:** Inverted pyramid structure, conversational query patterns, source citation, comprehensive reference content, FAQ development, topical authority pages
4. **Schema Enhancement:** FAQPage, HowTo, Organization, speakable, Article, QAPage, AboutPage, DefinedTerm markup
5. **AI Platform Monitoring:** Weekly testing cadence, citation frequency tracking, platform policy monitoring, AI Overview trigger analysis, sentiment tracking, referral traffic measurement

**Output:** AEO Health Score with dimension scores (Citation Frequency, Entity Authority, Content Extractability, Schema Coverage), priority optimization queue.

**Key Signals (15):** Brand absent from AI responses for core queries, competitors cited instead, inaccurate brand info in AI responses, content as walls of text with no extraction point, missing knowledge graph entity, FAQ without FAQPage schema, key pages blocked by robots/noindex, competitor earning citations through superior structure, brand mentions linking to third parties, conversational trends with no optimized content, content synthesized without citation, AI Overview triggers changing, entity authority below 50, schema coverage gaps, citation frequency declining despite stable traditional rankings.

#### 5.5.4 PageSpeed Optimizer

**Model:** Sonnet | **Permission:** default | **Max Turns:** 25

**Role:** Diagnoses and remediates every performance bottleneck degrading user experience and search ranking potential. Expert in CWV measurement, browser rendering pipelines, network waterfall analysis, and SPA performance implications.

**Methodology (4 Phases):**
1. **CWV Measurement:** CrUX field data, Lighthouse lab audits per template, LCP element identification, INP measurement, CLS cataloging, lab vs field comparison, performance budget establishment (LCP under 2.5s, INP under 200ms, CLS under 0.1)
2. **Resource Audit:** Resource waterfall generation, image optimization analysis, JS bundle analysis (payload/unused code), synchronous JS identification, third party script impact, font loading review, CSS delivery assessment, total page weight vs benchmarks
3. **Rendering Analysis:** Critical rendering path mapping, server response time analysis, DOM size/complexity assessment, lazy loading testing, layout shift source identification, service worker evaluation, HTTP/2 or HTTP/3 multiplexing review
4. **Optimization Recommendations:** LCP remediation prioritization, JS optimization, image optimization, critical CSS extraction, caching architecture, resource hints, third party governance, font optimization, regression testing process

**Output:** Performance dashboard with current vs target CWV per page template and overall site health grade.

**Key Signals (10):** LCP exceeding 4s mobile, LCP element as CSS background image, INP exceeding 500ms, CLS above 0.25 from images/ads, JS bundle exceeding 500KB compressed, third parties adding 1s+ TBT, web fonts without font-display:swap, missing preconnect hints, TTFB exceeding 800ms, hero image using lazy loading.

#### 5.5.5 Schema Architect

**Model:** Sonnet | **Permission:** default | **Max Turns:** 25

**Role:** Designs, implements, validates, and maintains structured data markup across all website properties. Comprehensive knowledge of Schema.org vocabulary, JSON-LD syntax, Google's requirements, and rich result types.

**Methodology (4 Phases):**
1. **Schema Discovery:** Site crawl extracting all structured data, schema instance cataloging by type/template, coverage mapping, data source identification, competitor benchmark comparison
2. **Validation:** Google Rich Results Test, Schema.org specification validation, GSC Enhancement report, price/availability/currency verification, review genuineness confirmation, URL property resolution, ISO 8601 date format validation, schema rendering timing testing
3. **Gap Analysis:** Templates eligible for rich results lacking schema, Product pages vs Google requirements, FAQ content eligibility, HowTo opportunities, Article/NewsArticle, BreadcrumbList, SearchAction for sitelinks searchbox, VideoObject, Event schema
4. **Implementation Specs:** JSON-LD templates mapping every property to data source, ecommerce Product schema, Organization schema, BreadcrumbList dynamic generation, FAQPage templates, HowTo specifications, testing/deployment workflow, maintenance procedures, changelog protocol

**Output:** Schema coverage matrix showing page template, current schema types, validation status, and rich result eligibility.

**Key Signals (10):** Product pages missing price/availability, schema in JS DOM but not initial HTML, AggregateRating not matching visible content, BreadcrumbList missing on interior pages, Article lacking author/datePublished, FAQ schema on non genuine Q&A pages, video without VideoObject, Organization with broken logo URL, conflicting schema types on single page, relative URLs in schema properties.

#### 5.5.6 Content Strategist

**Model:** Sonnet | **Permission:** plan | **Max Turns:** 20 | **Background:** Yes

**Role:** Evaluates, plans, and optimizes all content assets to maximize organic search visibility, user engagement, and topical authority. Combines keyword research, search intent analysis, content quality scoring, and information architecture expertise.

**Methodology (4 Phases):**
1. **Content Inventory:** Crawl and catalog every indexable asset, ranking position mapping, format tagging, thin content identification by page type (blog 800 words, product 300 words, category 150 words, landing 500 words, FAQ 5+ Q&A at 75+ words each, guide/pillar 2000 words), duplicate detection (90%+ = duplicate, 70 to 89% = near duplicate, 50 to 69% = cannibalization risk), freshness scoring, authorship attribution
2. **Quality Scoring:** 0 to 100 composite score using six weighted sub dimensions: E-E-A-T signals (25%), topical depth (20%), freshness (15%), readability (15%), on page optimization (15%), engagement metrics (10%)
3. **Gap Analysis:** Keyword gap vs top 3 to 5 competitors, search intent classification (Informational, Navigational, Transactional, Commercial Investigation), high volume low competition opportunities, featured snippet opportunities, keyword cannibalization detection, topic cluster completeness, People Also Ask coverage, AI Overview citation source analysis
4. **Architecture Planning:** Content cluster maps with pillar/supporting article linking, weighted prioritization model (search volume 30%, competition 20%, business value 25%, effort 25%), content briefs (target keyword, 5+ secondary, intent, word count, heading outline, 5+ internal links, external citations), consolidation recommendations, editorial calendar, KPIs, governance guidelines

**Output:** Content Health Score dashboard with four dimension scores: Content Quality (30%), Search Relevance (25%), Architecture Completeness (25%), Competitive Position (20%). Priority action matrix categorized as Quick Win (under 4 hours), Medium Effort (4 to 20 hours), Strategic Investment (20+ hours).

#### 5.5.7 Link Strategist

**Model:** Sonnet | **Permission:** plan | **Max Turns:** 20 | **Background:** Yes

**Role:** Analyzes, protects, and grows website link equity profile across external backlinks and internal linking architecture. Combines technical backlink auditing with creative link acquisition strategy.

**Methodology (4 Phases):**
1. **Profile Audit:** Multi source backlink export and deduplication (Ahrefs, Moz, Semrush, GSC), referring domain cataloging, backlink velocity trends (trailing 12 months), toxic link identification, dofollow/nofollow ratio, linking page type analysis, most linked page verification, link acquisition pattern analysis
2. **Competitive Gap:** Competitor backlink profiles (top 3 to 5), referring domains linking to competitors but not target, competitor tactic categorization, authority/domain/velocity comparison, competitor content assets attracting most backlinks, industry publications and resource page mapping
3. **Internal Links:** Internal link graph crawl and equity flow visualization, orphan page identification, internal anchor text audit, navigation/breadcrumb/footer link assessment, deep page link support, content silo mapping, specific internal link insertion recommendations
4. **Strategy Development:** Prioritized roadmap (impact, feasibility, timeline), digital PR campaign concepts, content led link building, targeted outreach lists, anchor text strategy guidelines (branded 30 to 40%, URL 15 to 25%, exact match 5 to 10%, partial match 10 to 15%, generic 10 to 15%, topical 10 to 20%), disavow file management, monthly KPIs, monitoring/alert system, outreach templates

**Output:** Link profile health dashboard with total referring domains, toxic link percentage, competitor gap size, internal link equity distribution score.

#### 5.5.8 Competitor Intelligence

**Model:** Haiku | **Permission:** plan | **Max Turns:** 20 | **Background:** Yes

**Role:** Systematically analyzes organic search landscape to identify competitive advantages, vulnerabilities, and strategic opportunities across keyword portfolios, content depth, backlink authority, technical health, SERP features, ranking momentum, and AI search visibility.

**Methodology (4 Phases):**
1. **Keyword Overlap:** Portfolio extraction, overlap matrix, competitor positioning segmentation, high volume ranking gaps, intent category analysis, ranking distribution, traffic value estimation, keyword cluster analysis
2. **Content Gaps:** Content library cataloging, consensus gaps, top 3 ranking content analysis, E-E-A-T evaluation, update pattern analysis, underserved subtopic identification, engagement format analysis
3. **Technical Comparison:** Parallel audits on speed/CWV/mobile/HTTPS, architecture depth, URL structure evaluation, JS rendering comparison, sitemap strategy, server response benchmarking, schema comparison
4. **SERP Features:** Ownership mapping (featured snippets, PAA, knowledge panels, image packs, video carousels), feature capture opportunities, AI Overview tracking, rich result comparison, share of voice calculation, AI platform visibility analysis, ranking velocity

**Output:** Competitive dashboard with keyword overlap percentages, domain authority comparison, content gap count, SERP feature ownership rates, AI search visibility scores.

#### 5.5.9 Search Console Analyst

**Model:** Haiku | **Permission:** plan | **Max Turns:** 20 | **Background:** Yes

**Role:** Extracts actionable intelligence from GSC data to drive organic search strategy. Expert in performance reports, index coverage classifications, URL inspection mechanics, CWV reporting methodology, and search appearance features.

**Methodology (4 Phases):**
1. **Performance Analysis:** Data segmentation (queries, pages, countries, devices, search appearance) for 3/6/12 month periods, top queries by clicks/impressions, CTR benchmarking by position, high impression low CTR detection, striking distance keywords (position 5 to 15), device type segmentation, country level analysis, page level trends, share of voice, cannibalization pattern identification
2. **Index Coverage:** Classification review (Valid, Valid with warnings, Error, Excluded), error type diagnosis, discovered but not indexed investigation, crawled but not indexed analysis, excluded vs sitemap cross reference, duplicate without user selected canonical, alternate page with proper canonical confirmation, trend monitoring
3. **CWV Review:** CWV report analysis (mobile/desktop), URL group categorization (Good/Needs Improvement/Poor), page template correlation, field vs lab comparison, CWV trend tracking, Page Experience report, remediation prioritization
4. **Anomaly Detection:** Automated trend analysis (WoW, MoM), traffic drop detection (greater than 15%), impression spike without click correlation, Manual Actions monitoring, Security Issues monitoring, sitemap status review, search appearance data, algorithm update date correlation

**Output:** Executive dashboard with total indexed pages, MoM click trend, average CTR, CWV pass rate, active manual actions/security issues.

---

## 6. Skill System

Skills are knowledge modules stored as `SKILL.md` files within subdirectories of `.claude/skills/`. They auto load into the conversation context based on description matching when Claude Code detects a relevant topic.

### 6.1 Skill Configuration Options

| Frontmatter Field | Purpose | Values |
|-------------------|---------|--------|
| name | Unique identifier | Kebab case string |
| description | Trigger phrases and scope definition | Free text with "Trigger on:" keywords |
| allowed-tools | Tools the skill can use | Array of tool names |
| argument-hint | Prompt guidance for the user | Bracketed placeholder text |
| user-invocable | Whether available as slash command | true (default) or false |
| context | Memory scope behavior | "fork" creates isolated context |
| agent | Subagent type for exploration | "Explore" for lightweight research |
| disable-model-invocation | Prevent auto triggering | true requires explicit invocation |

### 6.2 Skill Categories and Inventory

#### Auto Trigger Knowledge Skills (13 skills)

These skills automatically load when the conversation topic matches their trigger phrases. They provide domain expertise and structured methodologies.

| Skill | Lines | Tools | Key Trigger Phrases |
|-------|-------|-------|-------------------|
| technical-seo | 340 | Read, Glob, Grep, Bash, WebSearch, WebFetch, Agent | robots.txt, sitemap, canonical, redirect, 404, crawl budget, HTTPS |
| aeo-ai-seo | 190 | Read, Grep, Glob, WebSearch, WebFetch | AEO, GEO, LLMO, AI citations, answer engine, zero click |
| content-optimization | 424 | Read, Grep, Glob, WebSearch, WebFetch | title tag, meta description, E-E-A-T, content quality, featured snippets |
| core-web-vitals | 168 | Read, Write, Edit, Bash, Grep, Glob, WebFetch | CWV, LCP, INP, CLS, page speed, Lighthouse score |
| ecommerce-seo | 156 | Read, Grep, Glob, WebSearch, WebFetch | product SEO, category SEO, faceted navigation, PDP, PLP |
| schema-markup | 109 | Read, Glob, Grep, Bash, Write, WebFetch | schema, JSON-LD, rich snippets, Product schema, FAQ schema |
| pagespeed-optimization | 176 | Read, Write, Edit, Bash, Grep, Glob, WebFetch | image optimization, JS optimization, caching, CDN, lazy loading |
| search-console | 439 | Read, Glob, Grep, Bash, WebSearch | Search Console, GSC, index coverage, ranking drop, CTR |
| seo-dev-implementation | 150 | Read, Write, Edit, Bash, Grep, Glob | developer handoff, implementation spec, SEO code, deployment |
| netsuite-seo | 133 | Read, Write, Edit, Bash, Grep, Glob, WebFetch | NetSuite SEO, SuiteCommerce, SCA, SuiteScript, prerender |
| suitecommerce-seo | 115 | Read, Write, Edit, Bash, Grep, Glob, WebFetch | SuiteCommerce, SCA, NetSuite storefront, SuiteCommerce audit |
| ai-citation-tracking | 170 | Read, Grep, Glob, WebSearch, WebFetch | AI citations, LLM mentions, AI visibility tracking, citation monitoring |
| netsuite-environment | 374 | Read, Grep, Glob | NetSuite account, Verocious, Austenitex (auto trigger: true) |

#### Forked Research Skills (4 skills)

These skills run in an isolated context ("fork") to prevent research data from consuming the main conversation's context window. Three of them use Explore subagents for lightweight file and web research.

| Skill | Lines | Context | Agent | Key Trigger Phrases |
|-------|-------|---------|-------|-------------------|
| semrush-analytics | 472 | fork | Explore | Semrush, position tracking, site audit, keyword tracking |
| competitor-seo | 362 | fork | Explore | competitor analysis, keyword gap, content gap, share of voice |
| keyword-research | 493 | fork | Explore | keyword research, search intent, keyword clustering, topic mapping |
| international-seo | 442 | fork | Explore | hreflang, international SEO, multilingual, geo targeting |

#### Command/Workflow Skills (11 skills)

These skills define structured, multi phase audit and reporting workflows. All have `disable-model-invocation: true`, meaning they only execute when explicitly invoked (not auto triggered). They orchestrate multiple agents in parallel and produce formal deliverables.

| Skill | Lines | Key Workflow |
|-------|-------|-------------|
| full-seo-audit | 133 | 5 phases: client setup, browser recon, 8 agent parallel deployment, report synthesis, save results |
| technical-audit | 109 | 5 phases: client context, browser inspection, 3 agent deployment, report generation, save |
| pagespeed-audit | 108 | 5 phases: client context, performance baseline, 2 agent deployment, report, save |
| aeo-audit | 108 | 5 phases: client context, AI search recon, 3 agent deployment, report, save |
| content-audit | 101 | 5 phases: client context, content discovery, agent deployment, report, save |
| competitor-analysis | 111 | 5 phases: client context, landscape discovery, agent deployment, report, save |
| netsuite-seo-audit | 127 | 5 phases: client context, SuiteCommerce recon, 4 agent deployment, report, save |
| monthly-seo-report | 136 | 6 phases: GSC data pull, ranking/traffic analysis, index coverage, CWV, competitive update, compile |
| quarterly-seo-review | 159 | 8 phases: aggregate monthly reports, mini technical audit, content review, link profile, competitive shifts, strategy adjustment, next quarter planning, produce document |
| spec-audit | 69 | 4 gated phases: requirements (STOP for approval), analysis (parallel agents), findings (STOP for review), recommendations and deliverable |
| catchup | 52 | 5 step context restoration: load project state, check recent activity, load client context, check Asana board, summarize state |

#### Internal/Utility Skills (4 skills)

| Skill | Lines | User Invocable | Purpose |
|-------|-------|---------------|---------|
| agent-orchestration | 434 | false | Complete guide to multi agent orchestration, swarm patterns, agent teams, delegation |
| project-eval | 79 | false | Project validation commands and procedures |
| link-building | 409 | N/A (disable-model-invocation) | Link acquisition, backlink audits, internal linking (requires explicit invocation) |
| local-seo | 493 | N/A (disable-model-invocation) | GBP optimization, citations, NAP, local pack (requires explicit invocation) |

### 6.3 Progressive Disclosure

Eight skills use a references/ subdirectory containing supplementary files that are only loaded when the skill needs detailed examples, code templates, or schema patterns. This prevents large skill files from consuming context budget unnecessarily.

| Skill | SKILL.md Lines | Reference Files |
|-------|---------------|----------------|
| aeo-ai-seo | 190 | content-patterns, schema-examples, monitoring-tools, emerging-concepts (4 files) |
| seo-dev-implementation | 150 | code-examples, framework-patterns (2 files) |
| core-web-vitals | 168 | code-examples (1 file) |
| ecommerce-seo | 156 | schema-examples (1 file) |
| schema-markup | 109 | schema-templates (1 file) |
| pagespeed-optimization | 176 | code-examples (1 file) |
| netsuite-seo | 133 | suitescript-examples (1 file) |
| suitecommerce-seo | 115 | reference files (1+ files) |

### 6.4 Skill Description Budget

Total skill description characters across all 32 skills: approximately 5,494 characters out of a 30,000 character budget (18% utilization). This leaves substantial headroom for future skill additions without hitting the description injection limit.

---

## 7. Framework Library

Frameworks are detailed methodology documents stored in `.claude/frameworks/` and loaded on demand via @import syntax in CLAUDE.md. They provide the scoring systems, decision trees, and reference data that agents use during analysis.

### 7.1 Framework Inventory

| Framework | Lines | Primary Purpose | Key Scoring Systems |
|-----------|-------|----------------|-------------------|
| seo-audit-methodology.md | 532 | Master audit methodology | 8 dimension scoring (0 to 100), risk matrix (likelihood x impact), 4 tier priority system, 5 section deliverable structure |
| content-architecture.md | 313 | Content strategy and E-E-A-T | E-E-A-T rubric (4 dimensions, 0 to 25 each), topic cluster model, content refresh action framework |
| vertical-seo-benchmarks.md | 308 | Industry vertical benchmarks | 7 verticals (ecommerce, legal, healthcare, financial, home services, franchise, SaaS), CTR by position, CWV by platform |
| technical-seo-dev.md | 355 | Developer handoff standards | Code review checklist (7 categories), deployment timeline (pre/post launch), emergency response severity levels (P0 to P3) |
| seo-reporting.md | 270 | Reporting structure and KPIs | Primary/secondary KPI framework, ROI formula, reporting cadence (weekly, monthly, quarterly) |
| link-building-methodology.md | 271 | Link acquisition and management | Link quality scoring matrix (5 criteria, 0 to 15), anchor text distribution targets, toxic link scoring |
| keyword-strategy.md | 262 | Keyword research methodology | Keyword prioritization matrix (5 criteria, weighted %), difficulty vs opportunity 4 quadrant matrix, intent classification |
| netsuite-seo-architecture.md | 252 | NetSuite SuiteCommerce SEO | Prerendering verification checklist, URL canonicalization strategy, product page SEO template, 11 common problems with solutions |
| cwv-remediation.md | 228 | Core Web Vitals triage | CWV target thresholds, LCP decision tree (4 nodes), INP 3 phase diagnosis, CLS root cause analysis (5 categories), performance budget methodology |
| aeo-methodology.md | 214 | Answer Engine Optimization | Citation optimization checklist, entity authority building, measurement framework (6 metrics with frequency), GEO principles |

**Total Framework Lines:** 3,005

### 7.2 SEO Audit Scoring System (from seo-audit-methodology.md)

The master scoring system used across all audits:

**Overall Score: 0 to 100 Scale**
- 90 to 100: Excellent
- 70 to 89: Good
- 50 to 69: Fair
- 30 to 49: Poor
- 0 to 29: Critical

**Dimension Weights:**
| Dimension | Weight | Sub Scores |
|-----------|--------|------------|
| Crawlability | 15% | Robots.txt, sitemaps, redirect chains, status codes, orphan pages, crawl rate |
| Indexation | 15% | Index coverage, canonicalization, duplicate content, meta robots, pagination, parameters |
| Technical SEO | 15% | Page speed, mobile, HTTPS, structured data, URL structure, international, JavaScript |
| Content | 20% | Quality scores, thin content, freshness, E-E-A-T, featured snippet readiness, keyword mapping |
| Link Profile | 15% | Referring domains, toxic links, anchor text, internal links, link velocity, competitor comparison |
| UX / CWV | 10% | LCP, INP, CLS, mobile usability, page experience |
| Local SEO | 5% | GBP, citations, NAP, local pack, reviews, local content |
| AI Search Readiness | 5% | Entity authority, citation optimization, schema coverage, content extractability |

**Priority Tier System:**
- **Critical:** Blocks indexing or revenue. Risk matrix score 20 to 25. Fix immediately.
- **High:** Significant impact on rankings or traffic. Risk matrix score 12 to 19. Fix within 1 to 2 weeks.
- **Medium:** Optimization opportunity. Risk matrix score 6 to 11. Fix within 1 month.
- **Low:** Best practice alignment. Risk matrix score 1 to 5. Fix when convenient.

---

## 8. Rules Engine

Rules are behavioral instruction files stored in `.claude/rules/`. They are path scoped, meaning they only activate when the conversation involves files or topics matching their defined paths.

### 8.1 Rule Inventory

| Rule File | Paths Scope | Purpose | Key Instructions |
|-----------|-------------|---------|-----------------|
| anomaly-flagging.md | clients/** | Auto detect and flag SEO anomalies during analysis | GSC ranking drops greater than 10 positions, CWV regressions, robots.txt errors, noindex on traffic pages, redirect chains greater than 2 hops, 404s on high value pages, SPA rendering failures, prerender downtime |
| agent-orchestration.md | .claude/agents/** | Model tiering, team protocol, swarm archetypes, delegation | Opus for complex, Sonnet for execution, Haiku for exploration; 3 to 5 teammates optimal; delegate mode (Shift+Tab) for 4+ teammates; bug #25037 workaround |
| client-memory.md | clients/** | Client context management across sessions | Fuzzy name matching (greater than 80%), multi division support, file structure (history.md, profile.md, open-items.md), 500 line archival, 6 month inactive archival |
| context-management.md | (global) | Token efficiency and session structure | Grep over Read (15x more efficient), 30 minute sprint structure, compact at 70 to 80% fill, subagent delegation for verbose research |
| security.md | (global) | Credential protection, git safety, code security | Never read .ssh/.aws/.env/credentials, secret pattern detection (sk-, pk-, AKIA, ghp_, xoxb-), no force push/hard reset, ES5 only for Chrome/GTM, HTTPS only for API calls |
| self-learning.md | (global) | Continuous improvement protocol | Evaluate reliability, create/update skill files, add methodologies to frameworks, log in memory |

### 8.2 Instruction Budget Management

Research identified that Claude Code instruction adherence degrades above 150 to 200 total instructions per session. The project manages this through:

1. **Path scoping:** 3 rules only load when relevant paths are involved (anomaly-flagging and client-memory for clients/**, agent-orchestration for .claude/agents/**), reducing the unconditional instruction count
2. **CLAUDE.md budget:** Kept under 100 lines (currently 97)
3. **Skill description budget:** 5,494 of 30,000 characters (18%), leaving headroom
4. **Framework lazy loading:** 10 frameworks loaded via @import only when needed, not pre loaded

---

## 9. Hook System

Hooks are event driven scripts that execute automatically in response to specific Claude Code lifecycle events. They operate outside the model's control, providing deterministic enforcement of security and operational policies.

### 9.1 Hook Inventory

#### 9.1.1 GTM Modification Blocker

**File:** `.claude/hooks/block-gtm-modifications.sh`
**Event:** PreToolUse
**Matcher:** `mcp__gtm-mcp__gtm_tag|mcp__gtm-mcp__gtm_trigger|mcp__gtm-mcp__gtm_variable`
**Exit Code:** 2 (deterministic block, cannot be overridden)
**Behavior:** Intercepts any attempt to modify a GTM container tag, trigger, or variable. Outputs "BLOCKED: This action modifies a live GTM container. Michael must explicitly approve..." to stderr.

#### 9.1.2 Protected File Blocker

**File:** `.claude/hooks/block-protected-files.sh`
**Event:** PreToolUse
**Matcher:** `Edit|Write`
**Exit Code:** 2 (block) or 0 (allow)
**Behavior:** Reads the tool input JSON from stdin, extracts the file_path, converts to lowercase, and uses a bash `case` statement to match against protected patterns:
- `*/.env|*/.env.*|*.env` (environment files)
- `*/credentials*` (credential files)
- `*/.ssh/*` (SSH keys)
- `*/.aws/*` (AWS config)
- `*.pem` (certificates)
- `*.key` (private keys)
- `*.pfx` (PKCS12 bundles)

**Design Note:** Uses bash `case` matching instead of `grep` regex to prevent false positives. Previous implementation using `grep -qi ".env"` incorrectly matched "netsuite-environment" and `grep -qi ".key"` matched "keyword-research". The `grep -qiF` fixed string flag crashes on Windows Git Bash. Pure bash `case` eliminates all three issues.

#### 9.1.3 Pre Compact Context Preserver

**File:** `.claude/hooks/pre-compact-context.sh`
**Event:** PreCompact
**Exit Code:** 0 (informational, does not block)
**Behavior:** Outputs critical context that must survive automatic context compaction:
- Project identity: OFM SEO Tech Dev Expert
- Active rules and their paths
- Asana board GID, workspace GID, section GIDs
- Reference architecture paths (agents, skills, scripts, templates, clients, rules, hooks)
- Key conventions (no dashes, ES5, swarm default)

#### 9.1.4 Stop Notification

**File:** `.claude/hooks/stop-notify.ps1`
**Event:** Stop
**Behavior:** Non blocking Windows notification using PowerShell. Launches a separate hidden process (`Start-Process powershell -WindowStyle Hidden`) that displays a message box: "Claude has finished and needs your attention." This design prevents the notification from blocking Claude Code's shutdown sequence.

#### 9.1.5 TaskCompleted Quality Gate

**Event:** TaskCompleted
**Type:** Prompt (inline, not external script)
**Behavior:** Validates that completed agent work meets quality standards:
- Evidence and impact data present
- Implementation specs included where applicable
- Priority tier assignment on all findings
- No placeholder text
- Client name consistency throughout

---

## 10. MCP Server Integrations

MCP (Model Context Protocol) servers extend Claude Code's capabilities by connecting it to external platforms and APIs. Each MCP server registers tools that the model can invoke during conversations.

### 10.1 Active MCP Servers (9)

#### 10.1.1 Semrush

**Tool Prefix:** `mcp__semrush__`
**Authentication:** OAuth 2.1 with refresh tokens
**Capabilities:** Domain analytics, keyword research, backlink data, position tracking, site audit, competitive analysis, organic research, subdomain/subfolder analysis, trend research
**Key Tools:** `keyword_research`, `organic_research`, `backlink_research`, `siteaudit_research`, `overview_research`, `tracking_research`, `trends_research`, `url_research`, `execute_report`, `get_report_schema`

#### 10.1.2 Asana (Claude AI Connector)

**Tool Prefix:** `mcp__claude_ai_Asana__`
**Authentication:** OAuth via Claude AI connector
**Board:** "Claude" (GID: 1213561988868639)
**Workspace:** omnifunnelmarketing.com (GID: 1206269095077183)
**Capabilities:** Full task management: create, read, update, delete tasks; manage subtasks, stories, dependencies, followers; project and section management; goal tracking; portfolio management; team and user management; workspace search
**Key Tools:** `asana_create_task`, `asana_update_task`, `asana_get_task`, `asana_search_tasks`, `asana_create_task_story`, `asana_get_project`, `asana_get_project_sections`

#### 10.1.3 Chrome (Claude in Chrome)

**Tool Prefix:** `mcp__claude-in-chrome__`
**Authentication:** Local browser extension
**Capabilities:** Full browser automation: page navigation, text extraction, form filling, screenshot capture, JavaScript execution, console log reading, network request monitoring, GIF recording, tab management, keyboard shortcuts
**Key Tools:** `navigate`, `read_page`, `get_page_text`, `javascript_tool`, `form_input`, `computer`, `find`, `tabs_context_mcp`, `tabs_create_mcp`, `gif_creator`, `read_console_messages`, `read_network_requests`

#### 10.1.4 Chrome DevTools

**Tool Prefix:** `mcp__chrome-devtools__`
**Authentication:** Local DevTools protocol
**Capabilities:** JavaScript evaluation, network inspection, console message reading, performance tracing, Lighthouse audits, DOM snapshots, memory snapshots, page navigation, element interaction, dialog handling, device emulation
**Key Tools:** `evaluate_script`, `list_network_requests`, `get_network_request`, `list_console_messages`, `lighthouse_audit`, `performance_start_trace`, `performance_stop_trace`, `take_screenshot`, `take_snapshot`, `navigate_page`, `click`, `fill`

#### 10.1.5 PageSpeed Insights

**Tool Prefix:** `mcp__pagespeed__`
**Authentication:** API key (PAGESPEED_API_KEY environment variable)
**Capabilities:** Real time Core Web Vitals metrics, performance scoring, accessibility audits, SEO checks, best practices audits
**Key Tools:** `analyze_pagespeed`

#### 10.1.6 Lighthouse

**Tool Prefix:** `mcp__lighthouse__`
**Authentication:** Local (no API key required)
**Capabilities:** Full Lighthouse auditing: performance scoring, accessibility checks, SEO analysis, PWA readiness, Core Web Vitals, LCP opportunities, unused JavaScript detection, resource analysis, security audits, mobile/desktop comparison, performance budgets
**Key Tools:** `run_audit`, `get_performance_score`, `get_core_web_vitals`, `get_lcp_opportunities`, `get_accessibility_score`, `get_seo_analysis`, `get_security_audit`, `find_unused_javascript`, `analyze_resources`, `compare_mobile_desktop`, `check_performance_budget`, `check_pwa_readiness`

#### 10.1.7 Zapier (Claude AI Connector)

**Tool Prefix:** `mcp__claude_ai_Zapier__`
**Authentication:** OAuth via Claude AI connector
**Capabilities:** ActiveCampaign CRM operations (contacts, deals, automations, campaigns), Google Ads management (customer lists, campaigns, reports, conversions), Microsoft Outlook (email, calendar, contacts), OpenAI/ChatGPT operations (conversation, image generation, transcription, analysis), Anthropic Claude messaging
**Key Integrations:** ActiveCampaign, Google Ads, Microsoft Outlook, ChatGPT/OpenAI, Claude API

#### 10.1.8 Asana (Local MCP)

**Tool Prefix:** `mcp__asana__`
**Authentication:** OAuth (local server)
**Capabilities:** Task management, project management, section management, workspace search, tag management, story management, dependency management
**Note:** This is a secondary Asana connector alongside the Claude AI connector. Both provide task management capabilities.

#### 10.1.9 GTM MCP

**Tool Prefix:** `mcp__gtm-mcp__`
**Authentication:** OAuth
**Capabilities:** GTM container management (tags, triggers, variables)
**Status:** Active but modification operations are blocked by the PreToolUse hook. Read operations are allowed; write operations require explicit approval from Michael.

### 10.2 Pending MCP Servers (3)

| Server | Status | Requirement | Expected Capabilities |
|--------|--------|-------------|----------------------|
| Google Search Console | Pending | Google Cloud service account with Search Console API enabled | Performance data, index coverage, URL inspection, sitemaps, manual actions |
| Google Analytics 4 | Pending | Google Cloud credentials with Analytics API access | Traffic data, conversion data, audience segments, event data |
| Firecrawl | Pending | Firecrawl API key | Web scraping, full site crawling, content extraction |

---

## 11. Orchestration Model

### 11.1 Execution Hierarchy

The system operates as a three tier orchestration model:

**Tier 1: Lead Agent (Opus)**
The user interacts with the lead agent (Claude Opus 4.6). The lead reads CLAUDE.md, loads relevant skills and rules, and decides how to decompose work. For simple tasks, the lead executes directly. For complex tasks, the lead delegates to specialist agents.

**Tier 2: Specialist Agents (9 defined)**
Each agent is a fully independent Claude instance with its own context window, tool access, and permission scope. The lead deploys agents based on task requirements, passing them specific scope, context, and deliverable expectations. Agents execute autonomously and return structured results.

**Tier 3: Subagent Exploration**
Skills with `agent: Explore` or `context: fork` spawn lightweight exploration subagents for file discovery, web searches, and data gathering. These run in isolated contexts to prevent research data from consuming the main conversation window.

### 11.2 Swarm Mode (Default)

The system defaults to parallel execution whenever work is independent. This means:

- Multiple agents are deployed simultaneously rather than sequentially
- Background agents (content-strategist, link-strategist, competitor-intelligence, search-console-analyst) run without blocking
- Research skills fork into isolated contexts to preserve the main window
- A full SEO audit deploys up to 8 agents in parallel

### 11.3 Agent Teams

Agent Teams (enabled via `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`) provide fully independent Claude instances that can work as a coordinated team:

- **Lead Agent:** Orchestrates work, delegates tasks, synthesizes results. Must NOT execute analysis tasks directly.
- **Teammates:** 3 to 5 recommended, spawn in 20 to 30 seconds, produce results within the first minute.
- **Delegate Mode (Shift+Tab):** Critical for 4+ teammates. Restricts the lead to coordination only, preventing it from grabbing tasks intended for teammates.
- **Bug #25037 Workaround:** Include explicit language in lead prompt: "You are the orchestrator. Do NOT execute any analysis tasks yourself."
- **Cost:** Approximately 3 to 4x tokens compared to sequential solo for a 3 teammate team.
- **Limitations (as of March 2026):** No session resumption with in process teams, task status lag, slow shutdown, one team per session, no nesting, fixed lead.

### 11.4 Swarm Archetypes

| Pattern | Description | Use Case |
|---------|-------------|----------|
| Leader | One orchestrator delegates to specialists, synthesizes results | Full site audits needing unified findings |
| Pipeline | Sequential handoff where each agent's output feeds the next | Audit to findings to recommendations to deliverable workflows |
| Parallel Specialists | Multiple agents analyze same target from different angles | Comprehensive page analysis (technical + content + schema + CWV) |
| Competing Hypotheses | Multiple agents independently diagnose same problem | Debugging ranking drops or traffic anomalies |
| Watchdog | Background agent monitors for regressions while others implement | Live optimization sessions |

### 11.5 Model Tiering

| Model | Cost (input/output per MTok) | Use Cases |
|-------|------------------------------|-----------|
| Opus 4.6 | $5 / $25 | Lead orchestration, complex audits, architecture decisions, NetSuite development, AEO strategy |
| Sonnet 4.6 | $3 / $15 | Content briefs, schema markup, developer handoffs, audit report sections, code edits, pagespeed optimization |
| Haiku 4.5 | $1 / $5 | File discovery, keyword processing, web searches, URL status checks, config reading, data extraction |

### 11.6 Delegation Decision Framework

**Use Subagents When:**
- Task produces verbose output (web searches, file exploration)
- Work is self contained without iterative feedback needs
- Parallel execution adds clear value
- You want to preserve main context window
- Research may require many tool calls

**Work Directly When:**
- Task needs back and forth with Michael
- Change is under 5 tool calls
- Current conversation context is essential
- Latency matters (subagent spawn adds 20 to 30 seconds)

---

## 12. Security Architecture

### 12.1 Defense in Depth Layers

The security model operates across four reinforcing layers:

**Layer 1: Behavioral Instructions (CLAUDE.md)**
- Hard coded "NEVER without approval" list covering all live client system modifications
- "When in doubt, stop and ask" principle

**Layer 2: Permission System (settings.local.json)**
- Explicit allow list for read operations and safe git commands
- Explicit deny list for credential files and destructive operations
- Applied at the Claude Code runtime level before the model can execute

**Layer 3: Hook Scripts (PreToolUse)**
- `block-gtm-modifications.sh`: Deterministic block (exit code 2) on any GTM write operation
- `block-protected-files.sh`: Deterministic block on Edit/Write to .env, credentials, .ssh, .aws, .pem, .key, .pfx files
- Bash case matching prevents regex false positives

**Layer 4: Security Rules (.claude/rules/security.md)**
- Secret pattern detection (sk-, pk-, AKIA, ghp_, gho_, xoxb-, xoxp-)
- Base64 string scanning in configuration contexts
- Connection string scanning for embedded credentials
- HTTPS enforcement for all API calls
- ES5 only for Chrome scripts and GTM (prevents eval(), Function(), innerHTML injection)
- Input validation requirements on all generated code
- XSS prevention (textContent over innerHTML)
- SQL injection prevention (parameterized queries only)
- URL validation before navigation (HTTPS, no malicious domains, no open redirects)

### 12.2 Credential Management

- API credentials stored in `~/.claude/` system directory (outside project)
- OAuth tokens managed by Claude AI connectors (Asana, Semrush)
- No hardcoded secrets in project files
- `.gitignore` excludes: .env, .env.*, credentials*, secrets*, *token*, *api_key*, *.pem, *.key
- Discovered credentials are reported by location and type only, never logged, copied, or transmitted
- Any exposed credential is flagged as CRITICAL with immediate rotation recommendation

### 12.3 Git Safety

- Force push blocked in deny list
- Hard reset blocked in deny list
- Clean -f blocked in deny list
- rm -rf blocked in deny list
- Feature branches recommended for all client work
- Pre commit hook runs 315 validation checks before allowing commits

---

## 13. Validation and Quality Assurance

### 13.1 Structural Validation (315 checks)

**Runner:** `bash scripts/eval/validate-all.sh`
**Enforcement:** Pre commit hook blocks commits on failure

| Validator | Checks | What It Validates |
|-----------|--------|-------------------|
| validate-skills.sh | 160 | All 32 skill SKILL.md files: frontmatter fields (name, description, allowed-tools), kebab case naming, file existence, description content |
| validate-refs.sh | 72 | All @import references resolve, framework files exist, cross references valid |
| validate-agents.sh | 47 | All 9 agent files: frontmatter fields (name, model, description, memory, skills, tools, permissionMode, maxTurns), model aliases valid, skill references exist |
| validate-hooks.sh | 17 | All 4 hook scripts: file existence, execute permissions, correct shebang, referenced in settings.local.json |
| validate-settings.sh | 10 | settings.local.json structure, permission lists, hook configuration, required keys |
| validate-rules.sh | 9 | All 6 rule files: frontmatter validation, paths: field present where required |

### 13.2 Operational Validation (53 checks)

**Runner:** `bash scripts/eval/validate-operational.sh`

| Test Category | Checks | What It Validates |
|---------------|--------|-------------------|
| CLAUDE.md Budget | 4 | Line count under 100, no currentDate (system injects), verification command present, compaction guidance present |
| Skill Description Budget | 1 | Total description characters (5,494) under 30,000 budget (18%) |
| Skill Line Counts | 32 | All 32 skills under 500 lines (progressive disclosure applied to oversized skills) |
| Progressive Disclosure | 8 | Skills with references/ directories have valid reference files |
| Agent Frontmatter | 9 | All 9 agents have all required fields |
| Skill Frontmatter | varies | 32/32 have allowed-tools, 29/32 have argument-hint |
| Hook Functional Tests | 13 | 8 block tests (correct files blocked) + 5 false positive tests (safe files allowed) |
| Framework Resolution | 10 | All 10 @import framework references resolve to existing files |
| Agent Permission Scoping | 9 | Plan mode agents have read only tools, default mode agents have write tools |
| Global Settings | varies | Agent Teams enabled, thinking enabled, effort level set, description budget set |

### 13.3 Quality Gate (TaskCompleted Hook)

Every completed agent task is checked for:
- Evidence and impact data present
- Implementation specifications included where applicable
- Priority tier assignment on all findings
- No placeholder text
- Client name consistency throughout

---

## 14. Client Management System

### 14.1 Client Memory Protocol

When a client is mentioned in conversation:
1. Check `clients/` for existing folder
2. If exists, read full history before engaging
3. If not, create folder silently with template structure
4. During work, track findings, decisions, and open items
5. At session end, draft memory update for Michael to confirm before saving

### 14.2 Client Folder Structure

```
clients/{client-name}/
├── CLAUDE.md         # Auto loaded project context (domain, platform, priorities)
├── profile.md        # Client metadata (from profile.json template)
├── history.md        # Session by session work record
├── open-items.md     # Unresolved issues and pending work
└── specs/            # Developer handoff specifications
```

### 14.3 Client Template Files

**CLAUDE.md Template:** Domain, platform details, key context, current priorities, file references. Auto loaded when conversation touches files in that client's directory.

**profile.json Template:** Structured client metadata including:
- Business: name, URL, industry, platform
- Infrastructure: ecommerce, CMS, hosting, CDN
- Analytics: GA4 property ID, GSC property, Semrush project
- Key pages: homepage, product pages, category pages, blog, landing pages
- Competitors, target keywords, locations, contacts

**seo-config.json Template:** Technical SEO baseline including:
- Technical: robots.txt URL, sitemap URL, canonical strategy, SPA framework, prerendering
- Schema: boolean flags for each markup type
- Tracking: GTM container ID, GA4 measurement ID, server side GTM
- Performance: LCP/INP/CLS baselines, PSI scores
- Content: indexed pages, blog count, update frequency
- Links: referring domains, domain rating, internal linking strategy, disavow file

### 14.4 Active Clients

**Verocious Motorsports (VMS)**
- NetSuite Account 606473, Website ID 3
- Platform: SuiteCommerce Standard (SCS/SC Lite), Version 2025.2.20, Theme Summit 4.0.0
- GTM: GTM-57T4T5BW (client), GTM-P6KQPVPF (server side)
- GA4: G-862KMNBJX6 (active), G-MDZKSYLJ1B (flagged for removal)
- Critical Finding: seoSupport: false
- CWV: 0% GSC pass rate, LCP 3.3s / CLS 0.75 on mobile, 13 pending fixes

**Austenitex (AUX)**
- NetSuite Account 606473, Website ID 4
- Platform: SuiteCommerce Standard (SCS/SC Lite), Version 2025.2.20, Theme Summit 4.0.0
- GA4: G-TRYJ3FTG3K
- No GTM container
- Critical Finding: seoSupport: false

---

## 15. Asana Integration

### 15.1 Non Negotiable Protocol

Asana task tracking is required every session without exception:

1. **Session Start:** Read the Asana board to see active and recent tasks. Resume any in progress work.
2. **When Starting Work:** Create a task immediately. Format: "[Client]: [What]" for client work, "Infrastructure: [What]" for project work. Place in correct section. Include scope in notes.
3. **During Work:** Add meaningful comments with specific data (IDs, scores, URLs, config values). Each comment is a substantive progress update.
4. **When Work Completes:** Update task notes with full summary of findings, changes made, and open items. Mark complete. Create follow up tasks if needed.
5. **Subtasks:** Create for multi phase work (audits, implementations) so individual phases can be tracked.
6. **Sync:** Mirror Asana updates to client memory files and MEMORY.md.

### 15.2 Board Configuration

**Project:** "Claude"
**GID:** 1213561988868639
**Workspace:** omnifunnelmarketing.com (1206269095077183)

| Section | GID | Purpose |
|---------|-----|---------|
| Active Client Work | 1213563254857599 | Current client engagements |
| Audits & Analysis | 1213533330666074 | Active audit work |
| Tracking & Implementation | 1213533330648841 | GTM, analytics, code implementation |
| Reporting & Deliverables | 1213563254870417 | Monthly/quarterly reports, client docs |
| Infrastructure & Tools | 1213563259658898 | Project maintenance, MCP setup, skill development |
| Research & Learning | 1213533330676288 | Research tasks, new technique investigation |
| Backlog | 1213563254874568 | Future work and low priority items |

---

## 16. Chrome Automation Scripts

Eight ES5 JavaScript scripts for browser based site analysis. All scripts use strict ES5 syntax (no arrow functions, no let/const, no template literals) for maximum compatibility with Chrome's execution environment and GTM Custom HTML tags.

| Script | Purpose | Key Outputs |
|--------|---------|-------------|
| seo-meta-audit.js | Extract and validate title, meta description, canonical, robots, OG, Twitter Card | JSON with values, lengths, warnings (title 30 to 60 chars, meta 70 to 160 chars) |
| schema-validator.js | Parse all JSON-LD blocks, validate required/recommended properties by type | Validation errors and warnings per schema instance |
| cwv-diagnostics.js | Real time LCP, CLS, TTFB, TBT measurement via PerformanceObserver | Navigation timing breakdown (DNS, TCP, SSL, download, DOM interactive) |
| heading-structure.js | Audit heading hierarchy (h1 to h6) | Multiple h1 flags, missing hierarchy levels, keyword presence |
| image-seo-audit.js | Check alt text, file names, dimensions, lazy loading, srcset | Missing alt text, oversized images, missing responsive attributes |
| internal-links.js | Crawl internal links, identify broken links, analyze anchors | Broken links, orphaned pages, nofollow usage, anchor text analysis |
| js-rendering-check.js | Compare pre rendered vs JS rendered content | Content delta, JS errors blocking content, rendering gaps |
| resource-loading.js | Analyze resource timing, identify render blocking resources | TTFB per resource, render blocking list, lazy loadable candidates |

---

## 17. Templates and Deliverables

### 17.1 Audit Report Template

**File:** `templates/audit-report.md`
**Format:** Designed for .docx export

Structure:
1. **Header:** Client name, audit type, date, prepared by
2. **Executive Summary:** Top findings, overall health assessment, critical action items
3. **Score Snapshot:** Table with dimension scores, weights, and weighted overall score
4. **Issue Inventory by Priority Tier:** Critical, High, Medium, Low categorized lists
5. **Detailed Findings by Dimension:** Full finding tables with severity, affected pages, current/expected state, performance impact, fix
6. **Implementation Roadmap:** 4 phase plan (immediate, short term, medium term, long term)
7. **Appendix:** AI readiness checklist, tools and data sources, glossary

### 17.2 Developer Handoff Template

**File:** `templates/developer-handoff.md`
**Target Audience:** Developers who are not necessarily NetSuite or SEO experts

Structure:
1. **Summary:** What is being fixed and why
2. **Implementation Items:** For each fix:
   - Title and priority
   - Current state (what is wrong)
   - Required change (what to do)
   - Step by step instructions
   - Code example (if applicable)
   - Acceptance criteria (how to verify success)
   - SEO impact (why this matters)
3. **Testing Protocol:** Pre deployment and post deployment verification steps
4. **Notes:** Rollback procedures, dependencies, timeline

---

## 18. Research Library

Seven comprehensive research documents created in March 2026 through deep investigation sessions:

| Document | Size | Key Findings |
|----------|------|-------------|
| aeo-ai-seo-research-2026.md | 53 KB | ChatGPT 81% market share, Wikipedia cited 47.9% in ChatGPT, Reddit 46.7% in Perplexity, E-E-A-T +30.64% correlation with AI citations, first 30% of content generates 44.2% of citations |
| ai-seo-agent-automation-research-2026-03.md | 14 KB | 13 SEO tasks now automatable, CWV 48% mobile pass rate, +34% organic traffic for passing sites, SuiteCommerce SEO identified as wide open market opportunity |
| anthropic-ecosystem-research-2026-03.md | 8 KB | Opus 4.6 is 80.8% SWE-bench, Agent Teams launched February 2026, adaptive thinking replaces manual budget_tokens, 1M context support |
| claude-code-agent-orchestration-research-2026.md | 24 KB | 80% value from planning not execution, 3 to 5 optimal teammates, 3 to 4x cost for team vs solo, 7 swarm patterns, 5 emergent archetypes |
| optimization-plan-2026-03.md | 15 KB | 553 instructions vs 150 to 200 adherence threshold (3x over budget), 5 tier optimization plan with implementation phases |
| project-optimization-research-2026-03.md | 13 KB | 23 gaps and 14 new capabilities identified, critical instruction budget finding, Reddit cited 12x more than 2,000 word guides in AI answers |
| project-optimization-session-2026-03-06.md | 15 KB | 12 changes implemented, instructions reduced 55% (553 to 250), global skills 68% reduction (287 to 91), GTM hook fixed to deterministic blocking |

---

## 19. Complete File Inventory

### Configuration Files (6)
1. `.claude/CLAUDE.md` (97 lines)
2. `.claude/settings.local.json`
3. `~/.claude/settings.json` (global)
4. `.claude-plugin/plugin.json`
5. `.gitignore`
6. `.claudeignore`

### Agent Definitions (9)
1. `.claude/agents/technical-seo-auditor.md`
2. `.claude/agents/netsuite-seo-developer.md`
3. `.claude/agents/aeo-specialist.md`
4. `.claude/agents/pagespeed-optimizer.md`
5. `.claude/agents/schema-architect.md`
6. `.claude/agents/content-strategist.md`
7. `.claude/agents/link-strategist.md`
8. `.claude/agents/competitor-intelligence.md`
9. `.claude/agents/search-console-analyst.md`

### Skill Modules (32 SKILL.md files + reference directories)
1. `.claude/skills/technical-seo/SKILL.md` (340 lines)
2. `.claude/skills/aeo-ai-seo/SKILL.md` (190 lines + 4 reference files)
3. `.claude/skills/content-optimization/SKILL.md` (424 lines)
4. `.claude/skills/core-web-vitals/SKILL.md` (168 lines + 1 reference file)
5. `.claude/skills/ecommerce-seo/SKILL.md` (156 lines + 1 reference file)
6. `.claude/skills/schema-markup/SKILL.md` (109 lines + 1 reference file)
7. `.claude/skills/pagespeed-optimization/SKILL.md` (176 lines + 1 reference file)
8. `.claude/skills/search-console/SKILL.md` (439 lines)
9. `.claude/skills/seo-dev-implementation/SKILL.md` (150 lines + 2 reference files)
10. `.claude/skills/netsuite-seo/SKILL.md` (133 lines + 1 reference file)
11. `.claude/skills/suitecommerce-seo/SKILL.md` (115 lines + 1 reference file)
12. `.claude/skills/netsuite-environment/SKILL.md` (374 lines)
13. `.claude/skills/keyword-research/SKILL.md` (493 lines)
14. `.claude/skills/competitor-seo/SKILL.md` (362 lines)
15. `.claude/skills/link-building/SKILL.md` (409 lines)
16. `.claude/skills/local-seo/SKILL.md` (493 lines)
17. `.claude/skills/international-seo/SKILL.md` (442 lines)
18. `.claude/skills/ai-citation-tracking/SKILL.md` (170 lines)
19. `.claude/skills/semrush-analytics/SKILL.md` (472 lines)
20. `.claude/skills/agent-orchestration/SKILL.md` (434 lines)
21. `.claude/skills/project-eval/SKILL.md` (79 lines)
22. `.claude/skills/full-seo-audit/SKILL.md` (133 lines)
23. `.claude/skills/technical-audit/SKILL.md` (109 lines)
24. `.claude/skills/pagespeed-audit/SKILL.md` (108 lines)
25. `.claude/skills/aeo-audit/SKILL.md` (108 lines)
26. `.claude/skills/content-audit/SKILL.md` (101 lines)
27. `.claude/skills/competitor-analysis/SKILL.md` (111 lines)
28. `.claude/skills/netsuite-seo-audit/SKILL.md` (127 lines)
29. `.claude/skills/monthly-seo-report/SKILL.md` (136 lines)
30. `.claude/skills/quarterly-seo-review/SKILL.md` (159 lines)
31. `.claude/skills/spec-audit/SKILL.md` (69 lines)
32. `.claude/skills/catchup/SKILL.md` (52 lines)

### Frameworks (10)
1. `.claude/frameworks/seo-audit-methodology.md` (532 lines)
2. `.claude/frameworks/content-architecture.md` (313 lines)
3. `.claude/frameworks/vertical-seo-benchmarks.md` (308 lines)
4. `.claude/frameworks/technical-seo-dev.md` (355 lines)
5. `.claude/frameworks/seo-reporting.md` (270 lines)
6. `.claude/frameworks/link-building-methodology.md` (271 lines)
7. `.claude/frameworks/keyword-strategy.md` (262 lines)
8. `.claude/frameworks/netsuite-seo-architecture.md` (252 lines)
9. `.claude/frameworks/cwv-remediation.md` (228 lines)
10. `.claude/frameworks/aeo-methodology.md` (214 lines)

### Rules (6)
1. `.claude/rules/anomaly-flagging.md` (paths: clients/**)
2. `.claude/rules/agent-orchestration.md` (paths: .claude/agents/**)
3. `.claude/rules/client-memory.md` (paths: clients/**)
4. `.claude/rules/context-management.md` (global)
5. `.claude/rules/security.md` (global)
6. `.claude/rules/self-learning.md` (global)

### Hooks (4)
1. `.claude/hooks/block-gtm-modifications.sh`
2. `.claude/hooks/block-protected-files.sh`
3. `.claude/hooks/pre-compact-context.sh`
4. `.claude/hooks/stop-notify.ps1`

### Chrome Scripts (8)
1. `scripts/chrome/seo-meta-audit.js`
2. `scripts/chrome/schema-validator.js`
3. `scripts/chrome/cwv-diagnostics.js`
4. `scripts/chrome/heading-structure.js`
5. `scripts/chrome/image-seo-audit.js`
6. `scripts/chrome/internal-links.js`
7. `scripts/chrome/js-rendering-check.js`
8. `scripts/chrome/resource-loading.js`

### Validation Scripts (10)
1. `scripts/eval/validate-all.sh` (master runner)
2. `scripts/eval/validate-skills.sh` (160 checks)
3. `scripts/eval/validate-agents.sh` (47 checks)
4. `scripts/eval/validate-rules.sh` (9 checks)
5. `scripts/eval/validate-hooks.sh` (17 checks)
6. `scripts/eval/validate-settings.sh` (10 checks)
7. `scripts/eval/validate-refs.sh` (72 checks)
8. `scripts/eval/validate-operational.sh` (53 checks)
9. `scripts/eval/lib.sh` (shared library)
10. `scripts/eval/smoke-test.md` (manual checklist)

### Templates (2)
1. `templates/audit-report.md`
2. `templates/developer-handoff.md`

### Client Files
1. `clients/_template/CLAUDE.md`
2. `clients/_template/profile.json`
3. `clients/_template/seo-config.json`
4. `clients/verocious-motorsports/` (full client folder)
5. `clients/austenitex/` (full client folder)

### Research (7)
1. `research/aeo-ai-seo-research-2026.md`
2. `research/ai-seo-agent-automation-research-2026-03.md`
3. `research/anthropic-ecosystem-research-2026-03.md`
4. `research/claude-code-agent-orchestration-research-2026.md`
5. `research/optimization-plan-2026-03.md`
6. `research/project-optimization-research-2026-03.md`
7. `research/project-optimization-session-2026-03-06.md`

### Other
1. `PROJECT-BLUEPRINT.md`
2. `mcp-setup-guide.md`

---

## Document Verification

This document was compiled by scanning every file in the project directory using 10 parallel research agents, each reading and extracting data from their assigned component area. All file counts, line counts, frontmatter fields, and configuration values were verified against the actual files at the time of compilation.

**Validation Status at Time of Writing:**
- Structural validation: 315/315 checks passing
- Operational validation: 53/53 checks passing
- Pre commit hook: Active and enforced
- All 9 active MCP servers: Authenticated and operational

---

*Prepared by: SEO & Technical Dev Expert System (Claude Opus 4.6)*
*For: OmniFunnel Marketing*
*Document Version: 1.0*
