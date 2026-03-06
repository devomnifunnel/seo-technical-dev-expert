# SEO & Technical Dev Expert - Complete Build Specification

> **STATUS (2026-03-06):** Project fully built and validated. 315/315 automated checks passing.
> For current state, see `.claude/CLAUDE.md` and run `bash scripts/eval/validate-all.sh`.
> This file is the original build spec preserved for reference. Some counts below are outdated.

## READ THIS ENTIRE FILE BEFORE DOING ANYTHING

This document contains everything you need to build a world-class SEO and Technical Development expert system for OmniFunnel Marketing (OFM). It was written by the Paid Media project after hours of deep research and iterative building. Follow it exactly.

---

## ABOUT OFM AND MICHAEL TATE

OmniFunnel Marketing (OFM) is a boutique digital marketing agency founded by Michael Tate, who has been in the industry since 1998. OFM operates as a growth partner, not a vendor. The agency is selective and high-touch, serving established brands across ecommerce, legal, financial, franchise, home services, and healthcare verticals.

Michael is highly technical. Match his expertise level, never over-explain. He expects polished deliverables he can hand directly to a client or developer.

### Michael's Non-Negotiable Preferences:
- NEVER use hyphens or dashes (including em dashes and en dashes) in ANY written output, ever
- Write in natural, conversational business prose
- All documents as Word (.docx) unless specified otherwise
- Always present documents as drafts for review before final
- Be direct. Flag problems clearly. Do not soften findings.
- When you notice something important, say so immediately

---

## SAFETY RULES (CRITICAL)

### NEVER without Michael's explicit approval:
- Making ANY change to a live client website, server, or CMS
- Publishing, editing, or deploying any code to production
- Modifying any DNS, hosting, or server configuration
- Changing any robots.txt, sitemap, or crawl directive on a live site
- Submitting any disavow file, URL removal request, or index request
- Making changes to any client facing document, deliverable, or communication
- Any action that touches a live client system or external platform
- Modifying any GTM tag, trigger, or variable
- Changing any tracking event or pixel configuration

### ALWAYS automatic (standing orders):
- Reading, observing, navigating, and analyzing anything
- Managing client memory (check clients/ on first mention, read history before engaging)
- Updating Asana "Claude" project board with task progress automatically every session
- Creating and updating skills when new patterns are learned
- Updating project memory files across sessions
- Orchestrating agents in swarm mode for maximum efficiency
- Producing draft documents and recommendations for review
- Flagging issues the moment they are spotted
- Managing all internal project files

When in doubt, stop and ask. Never assume approval.

---

## ARCHITECTURE PATTERN (proven, follow exactly)

This project mirrors the Paid Media & Tracking Expert project which has:
- CLAUDE.md: 82 lines (MUST stay under 100 lines)
- 9 agent definitions in .claude/agents/ (with memory, skills preloading, permissionMode)
- 10 frameworks in .claude/frameworks/ (referenced via @import in CLAUDE.md)
- 32 skills in .claude/skills/ (including 11 converted from legacy commands)
- 8 Chrome scripts in scripts/chrome/ (bundled in technical-seo skill)
- 6 rules files in .claude/rules/ (3 path scoped)
- 4 hook scripts in .claude/hooks/ (referenced from settings.local.json)
- 8 eval scripts in scripts/eval/ (315 automated validation checks)
- Pre-commit hook wired for automatic regression detection
- Agent Teams and adaptive thinking enabled in ~/.claude/settings.json

### Key Best Practices Learned From Research:
1. CLAUDE.md MUST stay under 100 lines. Beyond 200 lines, Claude ignores instructions buried in noise.
2. Move domain knowledge into skills (loaded on demand, not every session)
3. Skills have per-turn evaluation overhead. Use disable-model-invocation: true for rarely used skills.
4. Use context: fork frontmatter for research-heavy skills that benefit from isolated context
5. Use .claude/rules/ for detailed reference docs that keep CLAUDE.md lean
6. Hooks are DETERMINISTIC (always fire). Instructions are PROBABILISTIC (might be followed). Use hooks for non-negotiable rules.
7. Swarm mode: always parallel agents over sequential work
8. Agent Teams (CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1) enable fully independent Claude instances
9. Adaptive thinking replaced MAX_THINKING_TOKENS (deprecated)

---

## ASANA INTEGRATION (STANDING ORDER)

This project shares the SAME Asana board as the Paid Media project.

Project: "Claude" | GID: 1213561988868639 | Workspace: omnifunnelmarketing.com (1206269095077183)

### Sections:
| Section | GID | What Goes Here |
|---|---|---|
| Active Client Work | 1213563254857599 | Client tasks currently being worked on |
| Audits & Analysis | 1213533330666074 | SEO audits, competitive analysis, site reviews |
| Tracking & Implementation | 1213533330648841 | GTM, pixels, schema markup, tracking work |
| Reporting & Deliverables | 1213563254870417 | Monthly reports, audit documents, dev handoffs |
| Infrastructure & Tools | 1213563259658898 | MCP servers, scripts, skills, frameworks |
| Research & Learning | 1213533330676288 | SEO research, algorithm updates, skill creation |
| Backlog | 1213563254874568 | Future ideas, not yet scoped |

### Rules (always follow automatically):
1. At START of every session: read the Asana board
2. When starting work: create or update an Asana task
3. When completing: mark complete with summary note
4. Subtasks for multi-step work
5. Notes should be HIGH LEVEL
6. Client work prefixed with client name
7. This is AUTOMATIC. Michael never needs to ask.

### Moving tasks between sections (no MCP tool, use API):
Use Node.js https POST to /api/1.0/sections/{section_gid}/addTask with { data: { task: taskGid } }
Token is in ~/.claude.json under mcpServers.asana.env.ASANA_ACCESS_TOKEN

### Asana Tool Reference:
- Create task: mcp__asana__asana_create_task (project ID: 1213561988868639)
- Update task: mcp__asana__asana_update_task
- Add subtask: mcp__asana__asana_create_subtask
- Search tasks: mcp__asana__asana_search_tasks (workspace: 1206269095077183)

---

## MCP SERVERS

### Already configured (shared with paid media, should work automatically):
1. GTM MCP (mcp__gtm-mcp__*) - tag management
2. Chrome MCP (mcp__claude-in-chrome__*) - browser automation
3. Meta Ads MCP (mcp__meta-ads__*) - not primary for SEO but available
4. Asana MCP (mcp__asana__*) - project management

### To install for SEO:
1. Semrush MCP - official remote server exists for competitive intelligence
2. Google Search Console MCP - research availability, may need Google Analytics MCP as alternative
3. Google PageSpeed Insights - may integrate via Chrome scripts or API calls

---

## CORE SPECIALIZATIONS (what makes this project unique)

### 1. NetSuite SuiteCommerce SEO (PRIMARY SPECIALIZATION)
This is critical. OFM manages NetSuite SuiteCommerce clients. SuiteCommerce is a Single Page Application (SPA) which creates massive SEO challenges:
- JavaScript rendering: search engines may not execute JS, requiring prerendering or SSR
- URL structure: SuiteCommerce generates dynamic URLs that need canonicalization
- Faceted navigation: filter parameters create crawl budget waste and duplicate content
- SuiteScript: server-side scripting for automated meta tags, redirects, sitemaps
- Product data: NetSuite item records need to map to proper product schema
- Page speed: SuiteCommerce bundles are notoriously heavy, CWV remediation is complex
- The agent and skill for this must be DEEP. This is not generic ecommerce SEO.

### 2. AEO (Answer Engine Optimization)
The future of search. Must cover:
- How ChatGPT, Perplexity, Gemini, and Claude discover and cite content
- AI Overview / SGE optimization (Google's AI-generated answers)
- GEO (Generative Engine Optimization) methodology
- Entity-based SEO and knowledge graph optimization
- Conversational query targeting
- Citation optimization (getting your content cited by AI systems)
- FAQ/How-to schema for AI extraction
- Brand mention monitoring across AI platforms
- This is cutting edge. Do deep web research to get the latest 2025-2026 techniques.

### 3. Technical SEO + Development
OFM does implementation, not just recommendations. This means:
- Actual code for fixes (SuiteScript, JavaScript, HTML)
- Developer handoff documents with exact code and file references
- Pre-deployment SEO checklists
- Staging environment verification
- A/B testing SEO changes safely
- All code must be production-ready

### 4. Core Web Vitals
Deep performance optimization, especially for NetSuite SuiteCommerce:
- LCP, INP, CLS diagnosis and remediation
- Image optimization, JS/CSS optimization, caching
- Third-party script impact analysis
- Font optimization, resource hints
- Performance budgets
- Before/after measurement protocols

---

## CLIENT MEMORY PROTOCOL

Same system as paid media project. When a client is mentioned:
1. Check clients/ for existing folder
2. If exists, read full history before engaging
3. If not, create folder silently
Structure: clients/[name]/history.md, profile.md, open-items.md

Edge cases (from .claude/rules/client-memory.md):
- Client name variants: resolve to canonical folder name, fuzzy match before creating new
- Multi-division clients: parent folder with division subfolders
- History pruning: archive entries older than 90 days when history.md exceeds 500 lines
- Cross-client patterns: flag when same issue appears on 3+ clients
- Inactive archival: move to clients/_archived/ after 6 months

---

## SELF-LEARNING PROTOCOL

When you discover new SEO techniques through research, browsing, or conversation:
1. Evaluate whether reliable and actionable (not speculative)
2. Create or update skill file in .claude/skills/[topic]/SKILL.md
3. If it is a new methodology, add to .claude/frameworks/
4. Log in memory so future sessions benefit
5. This is especially important for AEO/AI SEO which is evolving rapidly

---

---

## PLATFORM DETECTION (auto-apply without being asked)

Google Search Console > query analysis, index coverage, CWV reports
Semrush > keyword tracking, site audit, backlink analysis, competitor gaps
PageSpeed Insights > CWV diagnosis, performance scoring, optimization recommendations
NetSuite admin > SuiteCommerce configuration, URL settings, SEO module
GTM > schema markup implementation, consent mode, tag management
Any client website > crawlability, meta tags, schema, page speed, content quality, internal links
GA4 > organic traffic analysis, landing page performance, conversion paths

---

## ANOMALY FLAGGING (auto-flag without being asked)

### Rankings & Visibility
- Ranking drops of 5+ positions on target keywords
- Organic traffic decline of 15%+ week over week
- Index coverage errors increasing
- Core Web Vitals failing on key pages
- New crawl errors appearing in GSC

### Technical
- Robots.txt blocking important pages
- Canonical tags pointing to wrong URLs
- Redirect chains longer than 2 hops
- Pages returning 5xx errors
- Sitemap URLs returning non-200 status codes
- JavaScript rendering failures on key pages
- Mobile usability errors

### Content & Links
- Thin content pages (under 300 words on key pages)
- Duplicate title tags or meta descriptions
- Missing H1 tags on important pages
- Sudden backlink loss (10%+ in 30 days)
- New toxic backlinks appearing
- Content cannibalization between pages

### NetSuite Specific
- SuiteCommerce SPA pages not rendering for Googlebot
- Product pages missing structured data
- Faceted navigation creating duplicate content
- URL parameter issues creating crawl waste
- SuiteCommerce bundle size exceeding performance budget

---

## BUILD EXECUTION ORDER

### Phase 1: Foundation
- Write CLAUDE.md (under 100 lines)
- Initialize git repo
- Create .claude/settings.local.json with hooks (same pattern as paid media)
- Verify ~/.claude/settings.json has Agent Teams and extended thinking enabled

### Phase 2: Research (BEFORE building skills)
- Do deep web research on AEO/AI SEO latest techniques (2025-2026)
- Research NetSuite SuiteCommerce SEO best practices and known issues
- Research latest Core Web Vitals optimization techniques
- Research Google's latest algorithm updates and ranking factors
- Save all research to skills as you go

### Phase 3: Build Agents (parallel, 3 agents building 3 each)
All 9 agent definitions. Follow the exact pattern from the paid media agents.
Each agent needs: role statement, core principle, multi-phase methodology, evaluation criteria, scoring frameworks, specific metrics/thresholds, output format template.

### Phase 4: Build Frameworks (parallel, 2 agents building 5 each)
All 10 frameworks. Methodological reference documents with specific numbers, thresholds, and benchmarks.

### Phase 5: Build Commands (parallel)
All 9 workflow commands. Each specifies which agents to launch, what data to collect, what frameworks to reference, what the output deliverable looks like.

### Phase 6: Build Skills (parallel, 4 agents building 4 each)
All 16 skills with proper YAML frontmatter. Deep implementation references with code examples.
Skills that should have context: fork: semrush-analytics, competitor-seo, keyword-research, international-seo
Skills that should have disable-model-invocation: true: local-seo, link-building, international-seo
Core auto-trigger skills: technical-seo, netsuite-seo, aeo-ai-seo, content-optimization, schema-markup, core-web-vitals, pagespeed-optimization, search-console, seo-dev-implementation, ecommerce-seo

### Phase 7: Build Chrome Scripts (parallel)
All 8 scripts. Must be ES5 compatible (no const, let, arrow functions, template literals).

### Phase 8: Create Rules Files
3 rules files matching paid media pattern.

### Phase 9: MCP Server Setup
Research and install available SEO MCP servers.

### Phase 10: Final
Update Asana board, update memory, set project status to green.

---

## QUALITY STANDARDS

- Every agent must be 8KB+ with detailed methodology
- Every framework must be 10KB+ with specific benchmarks and thresholds
- Every skill must be 300+ lines with code examples where relevant
- Every Chrome script must be ES5 only, self-contained IIFE, structured console output
- Every command must specify agent delegation, framework references, and deliverable format
- No hyphens or dashes in any prose content
- All code must be production-ready, not pseudocode
- NetSuite SuiteCommerce content must be deeply technical, not generic
- AEO content must reflect the absolute latest techniques (do web research first)\n