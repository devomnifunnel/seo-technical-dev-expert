# OFM Claude Code Repo Audit: Complete Combined Assessment

**Date**: 2026-03-11
**Prepared for**: Michael Tate, OmniFunnel Marketing
**Scope**: 82 repositories/items across 2 audit batches

---

## Table of Contents

1. [Batch 1: 49 Repositories](#batch-1-49-repositories)
2. [Batch 2: 33 Repositories/Items](#batch-2-33-repositoriesitems)
3. [Top 10 Power Stack (Batch 1)](#top-10-power-stack-batch-1-only)
4. [Top 5 from Batch 2](#top-5-from-batch-2)
5. [Combined 15 Repo Power Stack](#combined-15-repo-power-stack-both-batches-install-order)
6. [Redundancy Report](#redundancy-report)
7. [Custom Build Recommendations](#custom-build-recommendations)
8. [Implementation Timeline](#implementation-timeline)

---

## BATCH 1: 49 REPOSITORIES

---

### CATEGORY 1: CONTEXT MANAGEMENT & SESSION PERSISTENCE

### 1. Continuous Claude v3
**Verdict**: STUDY
**Priority**: N/A
**Why**: Interesting "compound, don't compact" philosophy with SQLite backed ledgers and auto handoffs. However, the hook architecture is heavy and the skill suggestion system on every message adds token overhead. Planning with Files (Batch 2) achieves the same persistence goal more elegantly with less machinery.
**Application**: Study the ledger/handoff pattern for ideas on improving OFM's PreCompact hook. The compound philosophy is sound but the implementation is overengineered for a boutique agency.
**Conflicts**: Superseded by Planning with Files (Batch 2 #2). Overlaps with Context Mode (#2).

### 2. Context Mode
**Verdict**: STUDY
**Priority**: N/A
**Why**: MCP virtualization layer with FTS5 indexed SQLite is genuinely clever. The structured Session Guide it generates after compaction (last request, pending tasks, key decisions, files modified, unresolved errors, git operations) is exactly what OFM needs. But running an MCP server for context management adds complexity and another failure point.
**Application**: Mine the Session Guide format and adapt it into OFM's existing PreCompact hook. The data structure is better than what the current 5 line echo provides. Do not adopt the full MCP server.
**Conflicts**: Overlaps with Continuous Claude v3 (#1), Planning with Files (Batch 2 #2).

### 3. Claude Mem
**Verdict**: STUDY
**Priority**: N/A
**Why**: Popular (20K+ stars) persistent memory system that captures everything per session and injects into future ones. The concept is sound but OFM already has a working memory system (MEMORY.md + client folders + Asana). Adding another layer creates confusion about which memory is authoritative.
**Application**: Study the injection mechanism for ideas on how to surface client context more automatically at session start. Do not install; OFM's existing system with client CLAUDE.md files and memory protocol is already purpose built.
**Conflicts**: Overlaps with OFM's existing memory architecture. Would create dual source of truth problems.

### 4. Claude Context Monitor
**Verdict**: SKIP
**Priority**: N/A
**Why**: Lightweight bash script for token usage warnings. OFM already has context management rules (compact at 70 to 80%, PreCompact hook preserves critical context). The color coded alerts are nice but this solves a problem Claude Code itself now handles with built in context indicators.
**Application**: N/A
**Conflicts**: Redundant with OFM's existing context management protocol in .claude/rules/context-management.md.

### 5. Claude Session Restore (ZENG3LD)
**Verdict**: SKIP
**Priority**: N/A
**Why**: Restores context from previous sessions by analyzing session files and git history. OFM's memory protocol (MEMORY.md, client folders, Asana task history) already provides session continuity. Session restore is a band aid for the real problem which is better memory architecture.
**Application**: N/A
**Conflicts**: Redundant with OFM's existing client memory protocol and Asana integration.

---

### CATEGORY 2: BEHAVIORAL FRAMEWORKS & COGNITIVE ARCHITECTURE

### 6. SuperClaude Framework
**Verdict**: SKIP
**Priority**: N/A
**Why**: Massive meta programming framework with 16 agents, 12 traits, 7 extensions, 30 skills, 14 commands, 6 modes. This is the definition of bloat for a boutique agency. The cognitive personas sound impressive but add enormous prompt overhead. OFM's purpose built agents are more effective because they know the exact domain.
**Application**: N/A
**Conflicts**: Would clash with OFM's entire agent architecture. The generic personas (architect, security, performance) are weaker than OFM's domain specific agents (technical-seo-auditor, pagespeed-optimizer, schema-architect, etc.).

### 7. Superpowers
**Verdict**: STUDY
**Priority**: N/A
**Why**: Auto enforces brainstorming, planning, TDD, and code review. 28K+ stars and zero config appeal. However, OFM is an SEO and paid media agency, not a software shop. The TDD and code review enforcement adds friction to the primary workflow (audits, analysis, client deliverables). The brainstorming and planning phases could be useful for complex implementations.
**Application**: Study the auto enforcement pattern for ideas on adding pre work planning to OFM's audit workflows. Do not install wholesale as most of the enforcement is code development focused.
**Conflicts**: Overlaps with GSD (#8) and Planning with Files (Batch 2 #2) for planning workflows.

### 8. GSD (Get Shit Done) glittercowboy
**Verdict**: SKIP (superseded)
**Priority**: N/A
**Why**: This is the SAME repository as Batch 2 #1 (gsd-build/get-shit-done). GitHub repo ID 1116260703 is identical. The gsd-build organization version is the evolved, actively maintained fork. Skip this entry and evaluate the Batch 2 version instead.
**Application**: N/A. See Batch 2 #1.
**Conflicts**: Identical to Batch 2 #1 (GSD gsd-build). Same repo, different org name.

### 9. Everything Claude Code
**Verdict**: STUDY
**Priority**: N/A
**Why**: Anthropic hackathon winner with 36K+ stars. The instinct based continuous learning with confidence scoring is a compelling pattern. Hook profiles (minimal/standard/strict) and session summaries at Stop phase are useful ideas. But 9 agents, 11 skills, 11 commands is a lot of surface area that overlaps with OFM's existing setup.
**Application**: Study the AgentShield security scanner (see Batch 2 #21) which ships as part of this package. Study the hook profiles pattern for ideas on situational hook intensity. Do not adopt the full framework.
**Conflicts**: AgentShield component is evaluated separately in Batch 2 #21. The agent/skill architecture overlaps heavily with OFM's existing setup.

---

### CATEGORY 3: CLAUDE CODE INFRASTRUCTURE & TOOLKITS

### 10. Awesome Claude Code (hesreallyhim)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Master directory of Claude Code ecosystem. 20K+ stars. Useful as a discovery resource to check periodically for new tools. Not something you install but something you bookmark and reference.
**Application**: Check monthly for newly listed tools that solve specific OFM pain points. Especially watch the MCP servers and skills categories.
**Conflicts**: Overlaps with Batch 2 #25 (Awesome Claude Plugins) and #26 (Awesome Claude Code jqueryscript) as discovery resources.

### 11. Claude Code Showcase
**Verdict**: STUDY
**Priority**: N/A
**Why**: Good reference implementation for hooks, skills, agents, and GitHub Actions. The skill evaluation system that auto suggests skills based on keywords/file paths/intent is interesting. JIRA/Linear integration patterns could inform how OFM uses Asana.
**Application**: Reference the skill evaluation system pattern when improving OFM's skill triggering. Study the GitHub Actions setup for CI/CD ideas.
**Conflicts**: None significant.

### 12. Awesome Claude Code Toolkit
**Verdict**: SKIP
**Priority**: N/A
**Why**: 135 agents, 35 skills, 42 commands is quantity over quality. Interactive installer is convenient but you end up with a bloated setup full of generic agents that do not know OFM's domain. Michael's 9 purpose built agents are more valuable than 135 generic ones.
**Application**: N/A
**Conflicts**: The kitchen sink approach conflicts with OFM's focused, domain specific architecture.

### 13. Claude Code Hooks Mastery
**Verdict**: STUDY
**Priority**: N/A
**Why**: All 13 hook events implemented with working code. This is the definitive reference for hook development. The meta agent that generates new agents and the UV single file scripts pattern are both useful. Worth studying before building OFM's next hook.
**Application**: Use as reference when building the UserPromptSubmit hook and PostToolUse validation hook recommended in the custom build section. The UV single file scripts pattern keeps hooks clean.
**Conflicts**: None. This is a reference/learning resource, not an installable framework.

### 14. Agents (wshobson)
**Verdict**: SKIP
**Priority**: N/A
**Why**: 112 agents across 72 plugins. Token optimized loading is a good idea but the agents are generic development focused. OFM needs paid media, SEO, and ecommerce agents, not language and framework experts.
**Application**: N/A
**Conflicts**: Overlaps with all subagent collections (#21 through #24).

### 15. Agentwise
**Verdict**: SKIP
**Priority**: N/A
**Why**: Multi agent orchestration with monitoring dashboard and model routing. OFM already has model tiering (Opus/Sonnet/Haiku), agent delegation via CLAUDE.md, and the Agent Teams experimental feature. Adding another orchestration layer creates confusion about who is routing what.
**Application**: N/A
**Conflicts**: Directly overlaps with OFM's existing orchestration model and Agent Teams.

### 16. Claude Code Skill Factory
**Verdict**: SKIP
**Priority**: N/A
**Why**: 69 prompt presets and interactive builders for creating skills. OFM already has 32 skills with a validated structure and eval framework. The factory approach is useful for someone starting from scratch, not someone with a mature skill library.
**Application**: N/A
**Conflicts**: Overlaps with Skill Seekers (Batch 2 #7) and SkillForge (Batch 2 #9).

### 17. Claude Code Guide (zebbern)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Good reference for Agent Teams documentation and power user tips. Worth a read for the LSP integration details and permission wildcard syntax. Not an installable tool.
**Application**: Reference when configuring Agent Teams. Check for tips on permission patterns.
**Conflicts**: Overlaps with Batch 2 #6 (same repo listed in both batches).

### 18. Claude Code Best Practice (shanraisshan)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Key insight about compacting at max 50% (OFM currently targets 70 to 80%) is worth testing. The "dumb zone" concept from context overload validates OFM's subagent delegation approach. Not an installable tool.
**Application**: Consider testing the 50% compact threshold to see if it improves output quality. OFM's 70 to 80% may be too aggressive.
**Conflicts**: Overlaps with Batch 2 #5 (same repo listed in both batches).

### 19. Anthropic Official Skills
**Verdict**: ADOPT
**Priority**: P1
**Why**: Anthropic's own skills repo with production quality DOCX, PDF, PPTX, and XLSX generation. 89K+ stars. ISO 29500 schema validation. This directly solves OFM's deliverable format requirement ("all documents as Word .docx"). Currently there is no reliable way to generate client facing documents from Claude Code.
**Application**: Install immediately. Every client audit, deliverable, and handoff spec can be generated as properly formatted .docx. Replaces the manual "draft in markdown, convert externally" workflow for VMS specs, Austenitex campaign reports, and all client proposals.
**Conflicts**: None. Fills a clear gap in OFM's current tooling.

### 20. Awesome Agent Skills (VoltAgent)
**Verdict**: STUDY
**Priority**: N/A
**Why**: 500+ skills from official dev teams including Google Workspace skills. Worth browsing for specific integrations but too broad to adopt wholesale. The Google Workspace skills could be useful for agency document management.
**Application**: Check for specific skills that map to OFM's stack: Google Workspace for client document management, Stripe for billing, Cloudflare for DNS/CDN.
**Conflicts**: Overlaps with all skill collection repos (#12, #16, Batch 2 #7 through #10).

---

### CATEGORY 4: SUBAGENT COLLECTIONS & ORCHESTRATION

### 21. Awesome Claude Code Subagents (VoltAgent)
**Verdict**: SKIP
**Priority**: N/A
**Why**: 100+ subagents for research, analysis, and competitive intelligence. Generic agents that do not know OFM's domain, client stack, or audit methodology. OFM's 9 purpose built agents with full framework references outperform generic research agents.
**Application**: N/A
**Conflicts**: Overlaps with #22, #23, #24, and #14. All subagent collections have the same problem: generic agents in a domain specific workflow.

### 22. Claude Code Subagents (0xfurai)
**Verdict**: SKIP
**Priority**: N/A
**Why**: Same problem as #21. Language and framework experts are not what a paid media agency needs. Auto delegation based on task context sounds useful but OFM's CLAUDE.md already handles task routing.
**Application**: N/A
**Conflicts**: Overlaps with #21, #23, #24.

### 23. Claude Code Sub Agents (lst97)
**Verdict**: SKIP
**Priority**: N/A
**Why**: Token usage and cost analysis metrics are interesting from a study perspective, but the agents themselves are full stack dev focused. OFM's operational concern is client deliverable quality, not development cost tracking.
**Application**: N/A
**Conflicts**: Overlaps with #21, #22, #24.

### 24. Awesome Claude Agents (rahulvrane)
**Verdict**: SKIP
**Priority**: N/A
**Why**: Meta directory of agent collections. Useful if starting from scratch, but OFM has already evaluated and built beyond what generic collections offer.
**Application**: N/A
**Conflicts**: Overlaps with all subagent repos and the Awesome lists.

### 25. Claude Subagent System
**Verdict**: STUDY
**Priority**: N/A
**Why**: The Discovery > Specification > Design > Implementation > Validation > Deployment pipeline with quality gates is a well structured product development pattern. Token bounded agents with role boundaries is a good discipline. Worth studying for how OFM structures complex multi phase client projects.
**Application**: The quality gate pattern could inform how OFM structures audit to implementation to verification workflows. Study the role boundary enforcement.
**Conflicts**: Overlaps with GSD (Batch 2 #1) for project execution workflow.

---

### CATEGORY 5: PAID MEDIA & MARKETING SPECIFIC

### 26. Claude Ads
**Verdict**: ADOPT
**Priority**: P2
**Why**: 186 audit checks across Google, Meta, YouTube, LinkedIn, TikTok, Microsoft. Weighted scoring, parallel agents, industry templates. The sub skills (/ads google, /ads meta, /ads tiktok, /ads budget, /ads creative, /ads landing, /ads competitor) map directly to OFM's service offerings. 808+ stars indicates real adoption.
**Application**: Use across all paid media clients. Austenitex (Google + Meta), Blessed Performance (TikTok + Meta), Joel (Google), Logan (Meta), FitBodyArizona (Meta). The ecommerce industry template fits VMS and Blessed. The weighted scoring provides standardized audit quality.
**Conflicts**: Overlaps with Digital Marketing Pro (#38) but more focused. Complements rather than conflicts with platform specific MCP servers (#28 through #34).

### 27. Ads MCP (Adspirer)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Cross platform MCP covering Google, Meta, LinkedIn, TikTok with 100+ tools. Strategy persistence to STRATEGY.md is interesting. However, OFM already has dedicated Google Ads MCP and needs a dedicated Meta Ads MCP. A single cross platform MCP creates a single point of failure and mixes authentication contexts.
**Application**: Study the STRATEGY.md persistence pattern for ideas on how OFM tracks campaign strategies across sessions. Prefer dedicated per platform MCPs over a single cross platform one.
**Conflicts**: Overlaps with individual platform MCPs (#28 through #34). Jack of all trades, master of none.

### 28. Google Ads MCP (cohnen)
**Verdict**: SKIP (already have)
**Priority**: N/A
**Why**: OFM already has mcp__google-ads__ configured and operational. This is the most popular Google Ads MCP (410+ stars) and is likely what OFM is already running or equivalent to it.
**Application**: N/A. Already installed.
**Conflicts**: Redundant with existing OFM setup.

### 29. Google Ads MCP Server (bjorndavidhansen)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Budget management, performance anomaly detection, and growth opportunity identification are features not in the standard Google Ads MCP. Claude Artifacts integration for visualization is interesting. However, switching MCPs mid stream adds risk.
**Application**: Study the anomaly detection and growth opportunity identification logic. Consider incorporating those patterns into OFM's existing Google Ads workflow without switching MCPs.
**Conflicts**: Would replace existing mcp__google-ads__ which is already working. Not worth the migration risk.

### 30. Google Ads MCP (gomarble)
**Verdict**: SKIP
**Priority**: N/A
**Why**: Another Google Ads MCP with OAuth and GAQL. Nothing that differentiates it from what OFM already has. Automatic token refresh is nice but standard.
**Application**: N/A
**Conflicts**: Redundant with existing mcp__google-ads__.

### 31. TrueClicks Google Ads MCP
**Verdict**: SKIP
**Priority**: N/A
**Why**: Archived. Google released an official MCP. Even the repo authors stopped maintaining it. No point installing something the creator has abandoned.
**Application**: N/A
**Conflicts**: Dead repo.

### 32. Meta Ads MCP (Pipeboard)
**Verdict**: ADOPT
**Priority**: P1
**Why**: OFM references mcp__meta-ads__ in 4 Paid Media framework files and permission rules but NO actual Meta Ads MCP is installed. This is a critical gap. Pipeboard's version offers read AND write with campaign lifecycle management and OAuth. Remote MCP means no complex local setup.
**Application**: Install immediately. Serves Austenitex (Meta campaigns), Blessed Performance (Meta retargeting), Logan (Meta consultation), FitBodyArizona (Meta lead flow). Four active clients need this today.
**Conflicts**: Overlaps with Meta Ads Analyzer (#33) and Meta MCP brijr (#34). Pipeboard is the best choice because it is remote MCP with both read and write.

### 33. Meta Ads Analyzer
**Verdict**: ADOPT
**Priority**: P2
**Why**: Breakdown Effect framework and Learning Phase diagnostics with 9 reference docs from Meta's official documentation. This is a skill/knowledge layer, not an MCP server. It complements #32 by providing analysis methodology on top of the data access.
**Application**: Install alongside Meta Ads MCP (#32). The Breakdown Effect analysis prevents the most common Meta Ads misdiagnosis (where aggregated metrics hide segment level problems). Use on all Meta clients.
**Conflicts**: Complements #32 (data access + analysis methodology). Does not conflict.

### 34. Meta MCP (brijr)
**Verdict**: SKIP
**Priority**: N/A
**Why**: 25 tools covering Meta Marketing API. Solid but Pipeboard (#32) is better for OFM because of the remote MCP architecture (no local server process) and campaign lifecycle management (read + write).
**Application**: N/A. Use Pipeboard instead.
**Conflicts**: Redundant with #32 (Pipeboard).

### 35. Google Analytics 4 MCP
**Verdict**: SKIP (already have)
**Priority**: N/A
**Why**: OFM already has mcp__google-analytics__ configured. The smart context window management with row estimation is a nice feature but not worth switching MCPs.
**Application**: N/A. Already installed.
**Conflicts**: Redundant with existing OFM setup.

### 36. Google Search Console MCP
**Verdict**: SKIP (already have)
**Priority**: N/A
**Why**: OFM already has mcp__google-search-console__ configured with 19 tools. Already operational.
**Application**: N/A. Already installed.
**Conflicts**: Redundant with existing OFM setup.

### 37. Marketing Skills
**Verdict**: STUDY
**Priority**: N/A
**Why**: CRO, copywriting, SEO, analytics tracking, email sequences, paid advertising, landing pages by Corey Haines. Well regarded marketing skills collection. Worth studying for gaps in OFM's skill coverage, particularly CRO and email sequence optimization which are thin areas.
**Application**: Review CRO and email sequence skills. Could inform Klaviyo/ActiveCampaign optimization workflows for VMS and other clients with email programs.
**Conflicts**: Some overlap with OFM's existing SEO and content skills, but the CRO and email angles are additive.

### 38. Digital Marketing Pro
**Verdict**: SKIP
**Priority**: N/A
**Why**: 115 commands, 25 agents, 64 scripts, 67 MCP integrations, 143 reference files. This is a bloated mega framework that tries to do everything. Self healing campaigns and creative fatigue prediction sound impressive but add massive prompt overhead. OFM's focused architecture with purpose built agents is more effective.
**Application**: N/A
**Conflicts**: Tries to replace OFM's entire architecture. That is the opposite of what Michael needs.

### 39. Growth Marketing Agents
**Verdict**: ADOPT
**Priority**: P2
**Why**: Competitive intelligence subagents for Meta Ads Library analysis and Google Ads Transparency analysis. Batch operations for multi competitor analysis. This fills a specific gap: competitive ad intelligence that OFM does not currently automate.
**Application**: Use for Austenitex (competitive Google/Meta landscape), Blessed Performance (competitive TikTok/Meta creative analysis), and new client pitches (competitive audit as sales tool). Batch operations make multi competitor sweeps efficient.
**Conflicts**: None significant. Fills a gap rather than overlapping.

### 40. Claude MCP Marketing
**Verdict**: SKIP
**Priority**: N/A
**Why**: One click installer for marketing MCPs. OFM already has its MCPs configured and working. An installer adds zero value when the installation is already done.
**Application**: N/A
**Conflicts**: Solves a problem OFM does not have.

---

### CATEGORY 6: DEVELOPMENT & BROWSER AUTOMATION

### 41. Context7
**Verdict**: ADOPT (already installed)
**Priority**: N/A
**Why**: Already installed as a plugin (verified in plugins/marketplaces). Injects current version specific docs to prevent hallucinated APIs. 30K+ stars, 140K installs. Working correctly.
**Application**: Already in use. Particularly valuable when working with NetSuite SuiteScript APIs, Shopify Liquid, and Webflow APIs where version specific syntax matters.
**Conflicts**: None. Already operational.

### 42. Repomix
**Verdict**: STUDY
**Priority**: N/A
**Why**: Packs entire codebase into one AI friendly file with token counting and tree sitter compression. Useful when you need to hand off a full codebase context to another AI tool or for creating comprehensive project snapshots. But for day to day work, OFM's existing agents explore codebases effectively.
**Application**: Could be useful for preparing VMS SuiteCommerce codebase for deep analysis or when onboarding a new developer. Not a daily use tool.
**Conflicts**: None.

### 43. UI/UX Pro Max Skill
**Verdict**: SKIP
**Priority**: N/A
**Why**: 50+ UI styles, 97 color palettes, 57 font pairings. OFM is an SEO and paid media agency, not a design studio. Client sites already have established design systems. This adds no value to audits, campaigns, or technical implementation.
**Application**: N/A
**Conflicts**: None, but irrelevant to OFM's services.

### 44. Obsidian Skills
**Verdict**: SKIP
**Priority**: N/A
**Why**: AI powered Obsidian vault management. OFM uses Asana for project management and MEMORY.md/client folders for knowledge persistence. Adding Obsidian as a third knowledge system creates fragmentation without solving a real problem.
**Application**: N/A
**Conflicts**: Would fragment OFM's knowledge across Asana, MEMORY.md, and Obsidian.

### 45. n8n MCP
**Verdict**: STUDY
**Priority**: N/A
**Why**: Claude Code with deep knowledge of all 1,084+ n8n nodes. If OFM uses or plans to use n8n for automation workflows, this becomes valuable. Currently OFM uses Zapier (mcp__claude_ai_Zapier__). Switching automation platforms is not a priority.
**Application**: Park for future consideration if OFM migrates from Zapier to n8n. The 2,646 pre extracted config examples would accelerate any migration.
**Conflicts**: Competes with existing Zapier integration. Only relevant if OFM moves to n8n.

### 46. Playwright MCP (Microsoft Official)
**Verdict**: ADOPT (already installed)
**Priority**: N/A
**Why**: Already installed as a plugin (verified in plugins/marketplaces). Official browser automation for testing and QA. Working alongside Claude in Chrome.
**Application**: Already in use. Use for automated testing of client sites, landing page QA, and accessibility checks.
**Conflicts**: Complementary with Claude in Chrome. Playwright for automated/scripted testing, Chrome for interactive exploration.

### 47. Playwright MCP (ExecuteAutomation)
**Verdict**: SKIP
**Priority**: N/A
**Why**: Community version when the official Microsoft version is already installed and working. No reason to run two Playwright MCPs.
**Application**: N/A
**Conflicts**: Redundant with already installed Microsoft Playwright MCP (#46).

### 48. GitHub MCP
**Verdict**: ADOPT (already installed)
**Priority**: N/A
**Why**: Already installed as a plugin (verified in plugins/marketplaces). Official GitHub MCP for repo management, issues, PRs, and CI/CD.
**Application**: Already in use.
**Conflicts**: None.

### 49. Claude Code MCP (steipete)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Running Claude Code as a one shot MCP server ("agent in your agent") is a powerful pattern for complex delegated tasks that need full Claude Code capabilities including tool access. The permission bypass and command queuing are double edged: powerful but risky for an agency handling client accounts.
**Application**: Study the pattern for potential use in complex multi step automations where subagents need full tool access. Do not install without careful permission scoping given OFM's strict approval requirements.
**Conflicts**: The permission bypass directly conflicts with OFM's safety architecture (block-gtm-modifications, block-protected-files hooks).

---

## BATCH 2: 33 REPOSITORIES/ITEMS

---

### CATEGORY 1: PROJECT EXECUTION & WORKFLOW ENGINES

### 1. GSD (gsd-build organization)
**Verdict**: ADOPT
**Priority**: P2
**Why**: Evolved version of the glittercowboy GSD (confirmed same GitHub repo ID 1116260703, just moved to gsd-build org). 12.8K stars, 757 commits. The spec driven workflow with fresh context per plan execution directly solves context rot in long client projects. The /gsd:verify-work command with debug agents for failures is particularly valuable for audit verification.
**Application**: Use for complex multi phase client projects: VMS CWV remediation (13 pending fixes across multiple page types), State N Nation Shopify build, any new client onboarding. The fresh context per plan execution prevents the "dumb zone" that hits long running sessions.
**Conflicts**: Replaces GSD glittercowboy from Batch 1 (same repo). Complements rather than conflicts with Planning with Files (#2) because GSD is for large projects while Planning with Files is for session level working memory.

### 2. Planning with Files (Manus Style)
**Verdict**: ADOPT
**Priority**: P1
**Why**: This is the highest value add in either batch. The filesystem as persistent working memory pattern solves OFM's #1 operational problem: context loss during complex sessions. Three file pattern (task_plan.md, findings.md, progress.md) survives compaction and /clear. The hooks (PreToolUse reads plan, PostToolUse prompts updates, Stop verifies completion) integrate seamlessly with OFM's existing hook architecture with ZERO conflicts.
**Application**: Install immediately. Every audit, every client engagement, every multi step task benefits. The "2 Action Rule" (save findings after every 2 operations) prevents the common pattern where 20 minutes of research vanishes on compaction. The error history in progress.md eliminates repeating failed approaches after context loss.
**Conflicts**: Does NOT conflict with OFM's existing PreCompact hook (different hook events). Complements Context Mode (Batch 1 #2) and supersedes Continuous Claude v3 (Batch 1 #1) for session level persistence.

---

### CATEGORY 2: CONTEXT ENGINEERING & ARCHITECTURE KNOWLEDGE

### 3. Agent Skills for Context Engineering
**Verdict**: STUDY
**Priority**: N/A
**Why**: Comprehensive knowledge base on context fundamentals, degradation patterns, compression strategies, and multi agent architectures. The "lost in middle" and "context poisoning" patterns are directly relevant to OFM's long audit sessions. Study material, not an installable tool.
**Application**: Read the context degradation and compression sections to improve OFM's context management rules. The multi agent patterns (orchestrator, peer to peer, hierarchical) could refine the orchestration model.
**Conflicts**: None. Reference material.

### 4. Claude Code System Prompts (Piebald AI)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Definitive documentation of Claude Code's internals with exact token counts. Understanding the system prompts helps write CLAUDE.md and hooks that work WITH the system instead of against it. Updated within minutes of every release. The CHANGELOG across 122 versions is invaluable for tracking behavior changes after updates.
**Application**: Reference when tuning OFM's CLAUDE.md, hooks, and agent definitions. Use the token counts to calculate true prompt overhead and stay within budget. Check after every Claude Code update for behavior changes that affect OFM's setup.
**Conflicts**: None. Pure reference material.

### 5. Claude Code Best Practice (shanraisshan)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Same repo as Batch 1 #18. Already evaluated. Key takeaway remains: test the 50% compact threshold vs OFM's current 70 to 80%.
**Application**: Same as Batch 1 evaluation.
**Conflicts**: Duplicate listing across batches.

### 6. Claude Code Guide (zebbern)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Same repo as Batch 1 #17. Already evaluated. Agent Teams documentation is the primary value.
**Application**: Same as Batch 1 evaluation.
**Conflicts**: Duplicate listing across batches.

---

### CATEGORY 3: SKILL GENERATION & MANAGEMENT

### 7. Skill Seekers
**Verdict**: ADOPT
**Priority**: P2
**Why**: Automatically converts documentation websites, GitHub repos, and PDFs into Claude Code skills. Instead of manually writing SKILL.md files for each platform, point it at the docs URL and get a structured skill. This accelerates OFM's skill library expansion significantly.
**Application**: Generate skills from: Klaviyo API docs (email/SMS for VMS and clients), ActiveCampaign docs (for applicable clients), Shopify Liquid docs (State N Nation build), Webflow API docs (ASAP Translate), BigCommerce API docs (Blessed Performance), Stape.io docs (server side tracking), Pacejet docs (VMS shipping). Each of these would take hours to write manually.
**Conflicts**: Overlaps with SkillForge (#9) and Claude Skills Supercharged (#8), but Skill Seekers solves a different problem (doc to skill conversion vs skill to skill generation).

### 8. Claude Skills Supercharged
**Verdict**: SKIP
**Priority**: N/A
**Why**: Haiku based relevance scoring for skill auto injection. OFM's skills already trigger automatically based on keyword matching in descriptions (the "pushy" pattern from Anthropic guidance). Adding a Haiku analysis layer introduces latency and cost on every prompt for marginal improvement over well written trigger phrases.
**Application**: N/A
**Conflicts**: Would add overhead to OFM's existing skill triggering which already works.

### 9. SkillForge
**Verdict**: SKIP
**Priority**: N/A
**Why**: A skill that creates other skills ("meta skill"). OFM already has 32 well structured skills with validated frontmatter and an eval framework. The skill creation process is not the bottleneck; it is the domain knowledge that goes into them. SkillForge cannot write a SuiteCommerce SEO skill because it does not know SuiteCommerce.
**Application**: N/A
**Conflicts**: Overlaps with Skill Seekers (#7) but Skill Seekers is more useful because it extracts from actual documentation.

### 10. meta_skilld
**Verdict**: SKIP
**Priority**: N/A
**Why**: Rust CLI for skill management (indexing, bundling, sharing). OFM is a single operator setup, not a team distributing skills across engineers. The management overhead is not justified.
**Application**: N/A
**Conflicts**: Solves a team scale problem OFM does not have.

---

### CATEGORY 4: WEB RESEARCH & SCRAPING

### 11. Firecrawl CLI + Skill
**Verdict**: ADOPT
**Priority**: P2
**Why**: Already listed as pending in OFM's MCP inventory ("Firecrawl needs API key"). The CLI + skill approach is more token efficient than the MCP approach. Scraping pages to clean markdown, crawling entire sites, and searching + scraping in one step are all directly useful for competitive analysis, content audits, and site migrations.
**Application**: Competitor site scraping for all clients. Content audits for VMS (crawl entire SuiteCommerce site to markdown). Site migration prep for State N Nation (crawl existing site before Shopify build). Landing page analysis for paid media clients. Get the API key and activate this.
**Conflicts**: Listed in MEMORY.md as pending MCP. The CLI + skill approach may be preferable to the MCP approach for token efficiency.

### 12. Dev Browser Skill
**Verdict**: SKIP
**Priority**: N/A
**Why**: Browser as a skill instead of MCP. OFM already has both Claude in Chrome and Playwright MCP installed and working. Adding a third browser automation approach creates confusion about which tool to use for what.
**Application**: N/A
**Conflicts**: Redundant with existing Claude in Chrome and Playwright MCP.

### 13. Google AI Mode Skill
**Verdict**: SKIP
**Priority**: N/A
**Why**: Free Google AI Mode search as alternative to paid APIs. OFM already has WebSearch capability and Semrush for competitive research. The "free" angle is not compelling when the paid tools provide structured, reliable data that agency clients expect.
**Application**: N/A
**Conflicts**: Inferior alternative to existing research tools.

### 14. Playwright CLI + Skill (NOT MCP)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Microsoft recommends CLI + Skills over MCP for coding agents because CLI is more token efficient (file paths vs full accessibility trees in context). The three specialized subagents (Planner, Generator, Executor) are compelling. However, OFM already has Playwright MCP installed and working. Worth studying the CLI approach for future optimization but not worth switching mid stream.
**Application**: Study the token efficiency claims. If OFM hits context limits during browser automation tasks, this is the optimization path. The Planner agent that produces structured test plans could be useful for systematic site QA.
**Conflicts**: Alternative to already installed Playwright MCP. Not a conflict but a future optimization path.

---

### CATEGORY 5: PROMPT PREPROCESSING & INPUT QUALITY

### 15. Claude Code Prompt Improver
**Verdict**: STUDY
**Priority**: N/A
**Why**: UserPromptSubmit hook that evaluates prompt clarity with only 189 token overhead for clear prompts. The progressive disclosure references for question patterns are well designed. However, OFM is a single operator setup where Michael writes the prompts, and Michael is highly technical. The "ask clarifying questions" pattern adds friction for someone who already knows what they want.
**Application**: Study the bypass prefix pattern (* to skip, / for commands, # to memorize). Could inform OFM's custom UserPromptSubmit hook with flags for client context injection.
**Conflicts**: Overlaps with Prompt Enhancer (#16) and UserPromptSubmit Hook (#17). All three solve the same problem differently.

### 16. Claude Code Prompt Enhancer
**Verdict**: SKIP
**Priority**: N/A
**Why**: Aggressive automatic prompt transformation that adds requirements, edge cases, performance considerations, and documentation expectations. For a technical user like Michael, this would be infuriating. It rewrites what you said into something you did not ask for, adding scope and complexity.
**Application**: N/A
**Conflicts**: The aggressive transformation philosophy conflicts with Michael's direct communication style.

### 17. UserPromptSubmit Hook (veteranbv)
**Verdict**: STUDY
**Priority**: N/A
**Why**: The 18 development mode flags concept is directly relevant to OFM. The idea of flags like -u (ultrathink), -th (think hard) is extensible to agency specific flags: -v (load Verocious context), -m (Meta Ads mode), -g (Google Ads mode), -a (audit mode). The git branch and current date injection is practical.
**Application**: Study the flag architecture for building OFM's custom UserPromptSubmit hook. The agency specific flags concept is the highest value idea in this category. Would allow Michael to type "-v cwv" and automatically load VMS context + CWV frameworks + relevant Asana tasks.
**Conflicts**: Overlaps with #15 and #16 but the flag approach is the most aligned with Michael's workflow.

---

### CATEGORY 6: CONTENT QUALITY & WRITING

### 18. Humanizer (blader)
**Verdict**: ADOPT
**Priority**: P2
**Why**: 2.9K stars. Removes AI writing artifacts (em dash overuse, passive voice, list addiction, semicolon chains). OFM already enforces "no hyphens/dashes, no em dashes" but this skill provides 24 pattern detection with a two pass self audit. Pattern 13 specifically targets em dash overuse. This is enforcement automation for rules Michael already has.
**Application**: Apply to every client deliverable, every audit report, every email draft. The two pass architecture (write then audit) catches patterns that single pass instructions miss. Particularly valuable because the "no dashes" rule is frequently violated during long sessions when context degrades.
**Conflicts**: Overlaps with HumanizerAI (#19) and Beautiful Prose (#20). Humanizer (blader) is the best choice because it is rule based (deterministic) rather than style based (subjective).

### 19. HumanizerAI Agent Skills
**Verdict**: SKIP
**Priority**: N/A
**Why**: The /detect-ai scoring (0 to 100) is interesting but OFM's problem is not "does this sound like AI" in general. The problem is specific patterns (dashes, semicolons, list overuse) that violate Michael's style rules. The blader Humanizer (#18) targets those specific patterns.
**Application**: N/A
**Conflicts**: Redundant with Humanizer (#18) for OFM's specific needs.

### 20. Beautiful Prose
**Verdict**: SKIP
**Priority**: N/A
**Why**: Style enforcement for "timeless, forceful English prose." OFM needs business prose for technical audiences, not literary prose. The style contract would fight against the concise, direct, data heavy writing that clients and developers expect.
**Application**: N/A
**Conflicts**: Style philosophy conflicts with OFM's business communication requirements.

---

### CATEGORY 7: SECURITY & CONFIGURATION

### 21. AgentShield
**Verdict**: ADOPT
**Priority**: P2
**Why**: 102 security rules across secrets detection, permission auditing, hook injection analysis, MCP server risk profiling, and agent config review. Ships as part of Everything Claude Code but runs independently via npx ecc-agentshield scan. OFM handles client ad accounts, API credentials, and has multiple MCP servers configured. A security scanner that validates the entire configuration is essential hygiene.
**Application**: Run as part of the periodic health check workflow. Scan after any changes to hooks, agents, skills, or MCP configurations. The secrets detection (14 patterns) complements OFM's existing block-protected-files.sh hook. The --opus red team/blue team/auditor pipeline provides deep analysis for quarterly security reviews.
**Conflicts**: Complements OFM's existing security rules (.claude/rules/security.md) and hooks rather than replacing them. AgentShield validates the configuration; OFM's hooks enforce at runtime.

### 22. Parry (Prompt Injection Scanner)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Prompt injection scanning for tool inputs and outputs. Early development. Worth monitoring given OFM handles client data and API credentials, but too immature to adopt now.
**Application**: Revisit in 3 months when more mature. If OFM exposes any agent workflows to external inputs (client forms, webhook data), this becomes more critical.
**Conflicts**: None.

### 23. Varlock
**Verdict**: STUDY
**Priority**: N/A
**Why**: Secure environment variable management preventing secret exposure. OFM's block-protected-files.sh already blocks .env, credentials, .pem, .key files. Varlock adds runtime protection ensuring secrets do not appear in Claude sessions, terminals, or logs. Defense in depth.
**Application**: Study the runtime protection patterns. If OFM starts managing more API credentials (Meta tokens, TikTok Events API keys, Stape credentials), the runtime layer becomes valuable.
**Conflicts**: Complements existing block-protected-files.sh hook.

### 24. Dippy
**Verdict**: SKIP
**Priority**: N/A
**Why**: Auto approve safe bash commands via AST parsing. OFM's permission settings already whitelist safe commands (Read, Glob, Grep, safe git commands) and deny dangerous ones. The existing permission model is working. Dippy solves permission fatigue which is not OFM's current pain point.
**Application**: N/A
**Conflicts**: Redundant with OFM's existing permission configuration in settings.local.json.

---

### CATEGORY 8: MONITORING, DIRECTORIES & ECOSYSTEM TRACKING

### 25. Awesome Claude Plugins (quemsah)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Automated adoption metrics across 7,413 repos. Real data on what people actually use vs what gets stars. Use this to validate adoption before committing to any new tool.
**Application**: Check before adopting any new plugin. Verify real install counts and active usage rather than relying on star counts which can be inflated.
**Conflicts**: Overlaps with Awesome lists (Batch 1 #10) as discovery resources.

### 26. Awesome Claude Code (jqueryscript)
**Verdict**: STUDY
**Priority**: N/A
**Why**: Curated list with star counts. Good for weekly ecosystem scanning. The star counts help prioritize which new tools to evaluate.
**Application**: Check weekly for new entries that match OFM's stack.
**Conflicts**: Overlaps with Batch 1 #10 (different curator, same concept).

### 27. Claude Agent Blueprints (Daniel Rosehill)
**Verdict**: STUDY
**Priority**: N/A
**Why**: The "Agent Workspace Model" concept (Git repo as complete workspace for any activity) is exactly what OFM has built. Validates the architecture. The non code applications (legal research, health docs, financial planning) show patterns that could apply to client onboarding or proposal generation.
**Application**: Study the workspace model patterns for new client onboarding automation. The folder structure + CLAUDE.md + slash commands + MCP configs pattern per workspace mirrors OFM's client folder approach.
**Conflicts**: None. Validates OFM's existing architecture.

### 28. Build with Claude (Marketplace Directory)
**Verdict**: SKIP
**Priority**: N/A
**Why**: Plugin marketplace directory. Useful for one time browsing but not an installable tool or ongoing resource. The plugin marketplace is accessible directly from Claude Code.
**Application**: N/A
**Conflicts**: None.

---

### CATEGORY 9: SOCIAL MEDIA & PUBLISHING

### 29. Typefully Skill
**Verdict**: SKIP
**Priority**: N/A
**Why**: Social media scheduling across X, LinkedIn, Threads. OFM is a paid media and SEO agency, not a social media management agency. Social publishing is not a core service offering. Adding this capability creates scope creep.
**Application**: N/A
**Conflicts**: Outside OFM's service scope.

### 30. X Article Publisher Skill
**Verdict**: SKIP
**Priority**: N/A
**Why**: Publishing to X Articles. Even more niche than Typefully. Not relevant to OFM's services.
**Application**: N/A
**Conflicts**: None, but irrelevant.

---

### CATEGORY 10: UPCOMING / JUST ANNOUNCED

### 31. Claude Code Auto Mode
**Verdict**: ADOPT (when available)
**Priority**: P1
**Why**: Removes the biggest friction point in running longer automated tasks. OFM's swarm mode with parallel agents is constantly interrupted by permission prompts. Auto Mode with --enable-auto-mode will allow audit swarms, competitive analysis batches, and multi client workflows to run unattended. Launching March 12+ as research preview.
**Application**: Enable immediately when available. Every multi agent workflow benefits. Audit swarms that currently require 20+ permission approvals will run end to end. Combined with Planning with Files (#2), this creates truly autonomous audit execution.
**Conflicts**: None. Built in Anthropic feature.

### 32. Claude Code Review
**Verdict**: STUDY
**Priority**: N/A
**Why**: Multi agent PR review. Relevant for code heavy client work (VMS SuiteScript, State N Nation Shopify theme) but OFM is not a software development shop. The parallel review with false positive filtering is a good pattern to study but not a daily use tool.
**Application**: Could be useful for reviewing VMS developer handoff implementations before they go live. Study the multi agent review pattern.
**Conflicts**: None.

### 33. Claude Code /loop Command
**Verdict**: ADOPT (already available)
**Priority**: P1
**Why**: Cron style scheduling is already available in Claude Code. Up to 50 concurrent tasks per session. This enables the monitoring workflows OFM needs: hourly campaign performance checks, daily CWV monitoring, automated anomaly detection loops.
**Application**: Immediate use cases: /loop 1h scan Austenitex Google Ads for spend anomalies. /loop 4h check VMS Core Web Vitals via PSI. /loop 1d check GSC for new indexing issues across all client properties. This is the automation layer that makes OFM's anomaly detection rules actionable.
**Conflicts**: None. Built in feature that amplifies existing capabilities.

---

## VERDICT SUMMARY

### Batch 1 (49 repos)

| Verdict | Count | Repos |
|---------|-------|-------|
| ADOPT | 3 new + 3 already installed | #19 Anthropic Skills, #26 Claude Ads, #32 Meta Ads MCP, #33 Meta Ads Analyzer, #39 Growth Marketing Agents + already installed: #41 Context7, #46 Playwright, #48 GitHub |
| STUDY | 14 | #1, #2, #3, #7, #9, #10, #11, #13, #17, #18, #20, #25, #27, #29, #37, #42, #45, #49 |
| SKIP | 26 | #4, #5, #6, #8, #12, #14, #15, #16, #21, #22, #23, #24, #28, #30, #31, #34, #35, #36, #38, #40, #43, #44, #47 |

### Batch 2 (33 repos/items)

| Verdict | Count | Repos |
|---------|-------|-------|
| ADOPT | 7 | #1 GSD, #2 Planning with Files, #7 Skill Seekers, #11 Firecrawl, #18 Humanizer, #21 AgentShield, #31 Auto Mode, #33 /loop |
| STUDY | 12 | #3, #4, #5, #6, #14, #15, #17, #22, #23, #25, #26, #27, #32 |
| SKIP | 14 | #8, #9, #10, #12, #13, #16, #19, #20, #24, #28, #29, #30 |

---

## TOP 10 POWER STACK (Batch 1 Only)

1. **Anthropic Official Skills (#19)**: Client deliverable generation in .docx format, the single most impactful gap fill
2. **Meta Ads MCP Pipeboard (#32)**: Four active clients need Meta data access that does not exist today
3. **Claude Ads (#26)**: Standardized 186 check audit framework across all ad platforms
4. **Meta Ads Analyzer (#33)**: Breakdown Effect methodology prevents the most common Meta diagnosis error
5. **Growth Marketing Agents (#39)**: Competitive ad intelligence that no current tool provides
6. **Context7 (#41)**: Already installed, confirm working
7. **Playwright MCP (#46)**: Already installed, confirm working
8. **GitHub MCP (#48)**: Already installed, confirm working
9. **Claude Code Hooks Mastery (#13)**: Reference for building the custom hooks OFM needs
10. **Claude Subagent System (#25)**: Quality gate patterns for audit verification workflows

---

## TOP 5 FROM BATCH 2

1. **Planning with Files (#2)**: Highest value single addition. Filesystem as working memory survives compaction. Zero hook conflicts with existing setup. Install this week.
2. **Auto Mode (#31)**: Removes permission friction from every multi agent workflow. Enable the day it launches.
3. **Humanizer (#18)**: Automates enforcement of Michael's "no dashes" writing rules. Two pass self audit catches what single pass misses.
4. **AgentShield (#21)**: Security validation for the entire Claude Code configuration. Essential hygiene for an agency handling client credentials.
5. **Skill Seekers (#7)**: Accelerates skill library expansion by converting platform documentation into skills automatically.

---

## COMBINED 15 REPO POWER STACK (Both Batches, Install Order)

| Order | Repo | Layer | Why |
|-------|------|-------|-----|
| 1 | Planning with Files (B2 #2) | Context Persistence | Filesystem working memory survives compaction, zero hook conflicts, install via plugin marketplace in 30 seconds |
| 2 | Anthropic Official Skills (B1 #19) | Content Generation | .docx/.pdf/.pptx generation for every client deliverable |
| 3 | Meta Ads MCP Pipeboard (B1 #32) | Platform Access | Four active clients need Meta data access today |
| 4 | Auto Mode (B2 #31) | Infrastructure | Remove permission friction from all multi agent workflows, enable on launch day |
| 5 | /loop Command (B2 #33) | Monitoring | Already available, start campaign and CWV monitoring loops immediately |
| 6 | Claude Ads (B1 #26) | Audit Framework | 186 check standardized audit across all ad platforms |
| 7 | Meta Ads Analyzer (B1 #33) | Analysis Methodology | Breakdown Effect framework prevents misdiagnosis |
| 8 | Humanizer (B2 #18) | Content Quality | Automates "no dashes" and 23 other AI writing pattern fixes |
| 9 | AgentShield (B2 #21) | Security | Configuration validation for hooks, agents, MCP, permissions |
| 10 | GSD gsd-build (B2 #1) | Project Execution | Spec driven workflow with fresh context per plan for large projects |
| 11 | Skill Seekers (B2 #7) | Skill Generation | Auto convert Klaviyo, Shopify, Webflow, BigCommerce docs to skills |
| 12 | Firecrawl CLI (B2 #11) | Web Research | Scrape competitor sites, crawl client sites to markdown, get the API key |
| 13 | Growth Marketing Agents (B1 #39) | Competitive Intelligence | Meta Ads Library + Google Ads Transparency batch analysis |
| 14 | Claude Code Hooks Mastery (B1 #13) | Reference | All 13 hook events with working code, reference for custom hook development |
| 15 | Claude Code System Prompts (B2 #4) | Reference | Internal system prompt documentation, check after every Claude Code update |

---

## REDUNDANCY REPORT

### Batch 2 Supersedes from Batch 1

- **GSD gsd-build (B2 #1) supersedes GSD glittercowboy (B1 #8)**: Same repo (identical GitHub ID 1116260703), gsd-build is the evolved maintained version
- **Planning with Files (B2 #2) supersedes Continuous Claude v3 (B1 #1)**: Both solve session persistence, Planning with Files is lighter, uses hooks OFM does not have yet (no conflicts), and the filesystem approach is more robust than SQLite ledgers

### Batch 2 Does NOT Supersede from Batch 1

- **Context Mode (B1 #2) is NOT superseded**: The FTS5 indexed Session Guide format is still worth studying even though Planning with Files handles the persistence layer differently
- **Claude Mem (B1 #3) is NOT superseded**: Different scope (cross session memory injection vs within session working memory)

### Duplicate Listings Across Batches

- **Claude Code Best Practice** (B1 #18 = B2 #5): Same repo, shanraisshan
- **Claude Code Guide** (B1 #17 = B2 #6): Same repo, zebbern

### Within Batch 2 Redundancies

- **Humanizer (B2 #18)** covers HumanizerAI (B2 #19) and Beautiful Prose (B2 #20)
- **Skill Seekers (B2 #7)** covers SkillForge (B2 #9) and meta_skilld (B2 #10)
- **Claude Code Prompt Improver (B2 #15), Enhancer (#16), and UserPromptSubmit Hook (#17)** all solve the same problem; study #17 for the flag architecture concept and build custom

---

## CUSTOM BUILD RECOMMENDATIONS

### P1: Build This Week

**1. PreCompact Hook v2**
Current state: 5 line echo with static context string. Replace with a dynamic hook that reads the current task_plan.md (from Planning with Files), the active client folder, and open Asana task GIDs, then outputs a structured preservation block. This makes every compaction preserve the actual working state, not a generic reminder.

**2. UserPromptSubmit Hook with Agency Flags**
Build a UserPromptSubmit hook inspired by veteranbv's flag system (B2 #17) but customized for OFM. Flags:
- `-v` Load Verocious Motorsports context (client folder + NetSuite skill + CWV frameworks)
- `-a` Load Austenitex context
- `-bp` Load Blessed Performance context
- `-audit` Activate full audit mode (load SEO audit methodology + all MCP tools)
- `-meta` Focus on Meta Ads (load Meta Ads Analyzer + framework)
- `-google` Focus on Google Ads
- `-u` Ultrathink (high effort reasoning)
- `*` Bypass (pass through without processing)

### P2: Build This Month

**3. SubagentStop Logger**
Hook into SubagentStop event to log every subagent's completion status, token usage, and key findings to a session log file. Creates audit trail for multi agent swarms and helps identify which agents are consuming disproportionate resources.

**4. PostToolUse Validation Hook**
After MCP tool calls (GSC, GA4, Google Ads, Semrush), validate that the response contains actual data (not auth errors, empty results, or rate limit messages). If validation fails, flag immediately instead of letting the agent proceed with bad data. This prevents the pattern where an auth failure silently produces an incomplete audit.

**5. POAS Optimization Skill**
OFM's core philosophy is POAS (Profit on Ad Spend) over ROAS. No existing repo covers this. Build a skill that takes Google Ads/Meta Ads performance data + product margin data and calculates true profit contribution by campaign/ad group/product. Requires: product cost data (from NetSuite), ad spend data (from Google Ads MCP/Meta Ads MCP), revenue data (from GA4).

### P3: Build Next Month

**6. Stape.io Health Check Skill**
Automated health monitoring for server side GTM via Stape. Check: container status, request volume, error rates, Meta CAPI event match quality, TikTok Events API delivery status. No existing repo covers server side tracking health.

**7. Klaviyo/ActiveCampaign Integration Skill**
Email and SMS performance analysis, flow optimization, segment health. Use Skill Seekers to generate the base skill from Klaviyo API docs, then customize with OFM's email marketing methodology.

**8. Client Onboarding Automation**
When a new client is signed, automatically: create Asana parent task, create client folder from template, prompt for platform credentials, run initial audits (Google Ads, Meta, GSC, GA4, Lighthouse), generate baseline report, create Asana subtasks for each finding. Combines multiple existing tools into a single workflow.

**9. Cross Platform Attribution Skill**
Reconcile conversion data across Google Ads, Meta Ads, GA4, and server side events (Stape). Identify attribution discrepancies, flag potential double counting, and produce a unified conversion picture. Critical for POAS optimization across platforms.

---

## IMPLEMENTATION TIMELINE

### This Week

1. Install Planning with Files via `/plugin marketplace add OthmanAdi/planning-with-files`
2. Install Anthropic Official Skills for .docx generation
3. Configure Meta Ads MCP (Pipeboard) with OAuth for the 4 active Meta clients
4. Enable Auto Mode when it launches (March 12+)

### This Month

5. Start /loop monitoring: campaign spend anomalies (hourly), CWV checks (4 hour), GSC index issues (daily)
6. Install Claude Ads skill for standardized audit checks
7. Install Meta Ads Analyzer for Breakdown Effect methodology
8. Install Humanizer skill for writing quality enforcement
9. Run AgentShield security scan on full configuration
10. Build PreCompact Hook v2 (dynamic context preservation)
11. Build UserPromptSubmit Hook with agency flags

### Next Month

12. Install GSD for complex multi phase projects (VMS CWV remediation)
13. Set up Skill Seekers and generate skills from Klaviyo, Shopify, Webflow, BigCommerce docs
14. Get Firecrawl API key and activate for competitor research
15. Install Growth Marketing Agents for competitive ad intelligence
16. Build SubagentStop Logger and PostToolUse Validation hooks

---

## ARCHITECTURE BLUEPRINT

```
Layer 1: Context Persistence (survives compaction and /clear)
├── Planning with Files (task_plan.md, findings.md, progress.md)
├── PreCompact Hook v2 (dynamic context preservation)
└── OFM Memory Protocol (MEMORY.md, client folders, Asana)

Layer 2: Input Quality (processes every prompt before execution)
├── UserPromptSubmit Hook with Agency Flags
└── Humanizer (two pass writing quality enforcement)

Layer 3: Project Execution (structures complex work)
├── GSD gsd-build (multi phase spec driven workflow)
└── /loop Command (recurring monitoring tasks)

Layer 4: Platform Access (data from live systems)
├── Google Ads MCP (existing)
├── Meta Ads MCP Pipeboard (new, P1)
├── Google Analytics 4 MCP (existing)
├── Google Search Console MCP (existing)
├── Semrush MCP (existing)
├── PageSpeed/Lighthouse MCP (existing)
└── Chrome/Playwright (existing)

Layer 5: Analysis & Audit (domain intelligence)
├── Claude Ads (186 cross platform audit checks)
├── Meta Ads Analyzer (Breakdown Effect framework)
├── Growth Marketing Agents (competitive intelligence)
├── OFM Agent Library (9 domain specific agents)
└── OFM Skill Library (32 specialized skills)

Layer 6: Content Generation (client deliverables)
├── Anthropic Official Skills (.docx, .pdf, .pptx, .xlsx)
└── Humanizer (AI artifact removal)

Layer 7: Security & Validation (protects everything)
├── AgentShield (configuration scanning)
├── PostToolUse Validation Hook (data quality)
├── block-protected-files.sh (file access control)
├── block-gtm-modifications.sh (GTM safety)
└── OFM Security Rules (.claude/rules/security.md)

Layer 8: Knowledge & Reference (inform all other layers)
├── Context7 (version specific API docs)
├── Claude Code System Prompts (internal architecture reference)
├── Claude Code Hooks Mastery (hook development reference)
├── Skill Seekers (doc to skill conversion)
└── Firecrawl CLI (web research and scraping)
```

This architecture ensures every layer serves a distinct purpose with no overlap. Platform access feeds analysis. Analysis produces deliverables. Security validates everything. Context persistence ensures nothing is lost. The entire system compounds knowledge across sessions, which is exactly what Michael described as the goal.
