# Project Optimization Session: Complete Record
## SEO & Technical Dev Expert | OmniFunnel Marketing
## March 6, 2026

This document is a complete record of a deep optimization session performed on the
OmniFunnel Marketing "SEO & Technical Dev Expert" Claude Code project. It is intended
to be shared with other Claude Code projects so they can understand the methodology,
findings, and changes made, and adapt similar optimizations for their own specifications.

---

## THE PROMPT

Michael's original request:

> "Before we finalize this project and before I share it with my team we need to check
> absolutely everything and make sure it is as optimized and powerful as it can possibly
> be for our specific use case. I need you to once again deploy your agents to do deep
> research online including but not limited to YouTube, Reddit, Claude website, GitHub,
> etc. and review all best practices for rules, md files, hooks, MCPs, swarm, agents,
> Claude Code, etc. and make sure that this project is as absolutely powerful, intuitive,
> expert level, etc. to assist us with not only diagnosing issues, creating solutions
> but also executing them when we authorize."

---

## PROJECT CONTEXT BEFORE OPTIMIZATION

This is a boutique digital marketing agency (OmniFunnel Marketing) Claude Code project
specializing in SEO, technical development, and NetSuite SuiteCommerce optimization.
The project had already been built out with:

- **CLAUDE.md** (93 lines): Project identity, safety rules, client memory protocol,
  orchestration model, agency context, key standards
- **5 rules files** in .claude/rules/: anomaly-flagging, client-memory, security,
  context-management, agent-orchestration (~410 lines total)
- **9 agent definitions** in agents/: technical-seo-auditor, pagespeed-optimizer,
  content-strategist, aeo-specialist, netsuite-seo-developer, schema-architect,
  link-strategist, competitor-intelligence, search-console-analyst
- **20 project skills** in skills/: covering technical SEO, CWV, schema, AEO, NetSuite,
  content optimization, and more
- **287 global third party skills** in ~/.claude/skills/: installed from various GitHub repos
- **11 commands** in commands/: full-seo-audit, technical-audit, pagespeed-audit, aeo-audit,
  content-audit, netsuite-seo-audit, competitor-analysis, monthly-seo-report,
  quarterly-seo-review, catchup, spec-audit
- **10 frameworks** in .claude/frameworks/
- **4 hooks**: GTM blocker, file protection, PreCompact, Stop notification
- **5 project MCPs**: Semrush, PageSpeed, Lighthouse, Chrome DevTools (plus Chrome and
  Asana via integrations)
- **2 active clients**: Verocious Motorsports and Austenitex (both NetSuite SuiteCommerce)
- **Global settings**: effortLevel high, alwaysThinkingEnabled true, Agent Teams enabled

---

## PHASE 1: DEEP RESEARCH (6 Parallel Agents)

Six research agents were deployed simultaneously, each covering a different domain.
They searched across Claude Code official docs, Anthropic platform docs, GitHub repos,
community blogs, Reddit, YouTube summaries, and expert configurations.

### Agent 1: CLAUDE.md and Rules Best Practices
**Sources:** code.claude.com/docs, humanlayer.dev, builder.io, arize.com, claudefa.st,
alexop.dev, marioottmann.com, gend.co, SFEIR Institute, GitHub issues

**Key findings:**
- CLAUDE.md should target under 200 lines. Beyond that, instructions degrade.
- Frontier LLMs follow ~150 to 200 instructions consistently. Claude Code system prompt
  already consumes ~50 of those slots.
- Rules files should use `globs:` frontmatter for path scoping so they only load when
  Claude works on matching files. Use `globs:` not `paths:` (bug confirmed in multiple
  GitHub issues).
- Client subdirectory CLAUDE.md files auto load when Claude accesses those directories.
  This is deterministic context loading (guaranteed) vs relying on instructions (probabilistic).
- .claudeignore reduces token waste from irrelevant files.
- The decision framework: CLAUDE.md = universal identity (always loaded), Rules = deep
  domain knowledge (always or path scoped), Skills = reusable workflows (on demand),
  Hooks = deterministic enforcement (100% reliable).

### Agent 2: Hooks System
**Sources:** code.claude.com/docs/hooks, everything-claude-code GitHub, community configs

**Key findings:**
- 18 hook event types available: PreToolUse, PostToolUse, PreCompact, Stop, Notification,
  TaskCompleted, UserPromptSubmit, and more.
- Hook command type: exit code 0 = proceed, exit code 2 = block. This is the ONLY way to
  deterministically prevent an action. Echo/print messages are probabilistic (Claude sees
  them but may not obey).
- Stop hooks should be non blocking (use Start-Process or background execution) to avoid
  freezing the process.
- PreCompact hooks inject critical context before auto compaction summarizes, reducing
  information loss by approximately 30%.
- TaskCompleted hooks serve as quality gates for agent outputs.

### Agent 3: Agent Orchestration
**Sources:** code.claude.com/docs/agent-teams, addyosmani.com, alexop.dev, VoltAgent GitHub

**Key findings:**
- Delegate mode bug (GitHub #25037): lead agent grabs tasks even in delegate mode.
  Workaround is explicit prompt language forcing lead to only coordinate.
- Model tiering: Opus for planning/complex reasoning, Sonnet for execution, Haiku for
  exploration/fast lookups. Optimal ratio approximately 70/20/10 Haiku/Sonnet/Opus for
  cost efficiency.
- Swarm archetypes: Leader (one orchestrator), Pipeline (sequential handoff), Parallel
  Specialists (same target, different angles), Competing Hypotheses (same problem,
  independent diagnosis), Watchdog (background monitoring).
- Background vs foreground execution: research agents run in background, analysis agents
  needing iterative review run in foreground.
- context:fork bug exists; prefer using subagent_type parameter for agent delegation.

### Agent 4: Skills Architecture
**Sources:** platform.claude.com/docs/agent-skills, claude.com/blog/skills-explained,
community repos

**Key findings:**
- Skills budget is 15,000 characters for descriptions. All auto triggered skills compete
  for this budget. Exceeding it means skills get silently dropped.
- Third party skill packages can contain hundreds of skills (one package had 171) that
  consume budget even when irrelevant.
- Progressive disclosure pattern: keep SKILL.md under 500 lines, use references/
  subdirectory for detailed content loaded on demand.
- Frontmatter options: allowed-tools (security), agent type, argument-hint (autocomplete),
  hooks scoped to skills, $ARGUMENTS substitutions.

### Agent 5: Power Features
**Sources:** code.claude.com/docs, Anthropic blog, everything-claude-code, incident.io blog

**Key findings:**
- Native Task tools (TaskCreate, TaskGet, TaskUpdate, TaskList) provide structured
  progress tracking within audit workflows.
- Per client CLAUDE.md files enable automatic context loading per directory.
- Background agents (run_in_background: true) free the lead to continue other work.
- Worktree isolation (isolation: "worktree") gives agents their own git copy to prevent
  file conflicts.
- Ultrathink strategy: use "think harder" or "think step by step" in prompts for complex
  analysis, standard effort for routine tasks.

### Agent 6: MCP Server Optimization
**Sources:** registry.modelcontextprotocol.io, pulsemcp.com, GitHub repos, Oracle blog

**Key findings:**
- MCP tool definitions consume context tokens on EVERY request whether used or not.
  Multiple MCPs can eat 30%+ of context before any work begins.
- Dual MCP connectors for the same service (like two Asana connectors) waste tokens on
  duplicate tool definitions.
- Lighthouse MCP (danielsogl) has 13+ tools and is superior to PageSpeed MCP alone.
- Fetch MCP (Anthropic official) provides clean HTML to markdown conversion.
- NetSuite official MCP exists (Oracle published).
- Project scoped MCPs load only for that project; user level MCPs load everywhere.

---

## PHASE 2: SYNTHESIS AND CRITICAL FINDING

All 6 agent reports were synthesized into a unified optimization plan. The synthesis
revealed one critical finding that reordered all priorities:

### The Instruction Budget Crisis

**We were running at approximately 553 total instructions per session** (93 from CLAUDE.md +
~410 from 5 rules files all loading unconditionally + ~50 from Claude Code system prompt).

Research consensus from every source is that frontier LLMs follow approximately 150 to 200
instructions with reasonable consistency. We were nearly 3x over budget.

This directly explained why some instructions might not be followed consistently. The fix
was path scoping rules (so they only load when relevant) and moving specialized content
out of CLAUDE.md into on demand locations.

---

## PHASE 3: IMPLEMENTATION (All Changes Made)

### Tier 0: Instruction Budget (Highest Impact)

**Change 1: Path scoped 3 rules files**

Added `globs:` frontmatter to rules that do not need to load every session:
- `anomaly-flagging.md`: Added `globs: clients/**` (only loads during client work)
- `client-memory.md`: Added `globs: clients/**` (only loads during client work)
- `agent-orchestration.md`: Added `globs: agents/**` (only loads when reading agent files)
- `context-management.md`: No scope (always relevant)
- `security.md`: No scope (always relevant)

**Why:** Reduces per session instruction load from ~553 to ~250 for general sessions. The
scoped rules still load automatically when Claude accesses files matching the glob pattern,
so they are available exactly when needed.

**How to adapt:** Identify which rules in your project are universal (security, workflow) vs
domain specific (client protocols, specialized knowledge). Add `---\nglobs: path/pattern\n---`
at the top of domain specific rules. Use `globs:` not `paths:` due to confirmed bugs.


**Change 2: Client subdirectory CLAUDE.md files**

Created `clients/verocious-motorsports/CLAUDE.md` and `clients/austenitex/CLAUDE.md`
containing key identifiers (domain, platform version, tracking IDs, current priorities).
Also added CLAUDE.md to the `clients/_template/` for new clients.

**Why:** Claude Code natively loads CLAUDE.md from any directory it accesses. When Claude
reads a file in clients/verocious-motorsports/, it automatically loads that client's context.
This is deterministic (guaranteed by the system) vs our previous approach of instructing
Claude to "read history before engaging" (probabilistic, relies on instruction following).

**How to adapt:** Create CLAUDE.md files in any subdirectory where context specific rules
or knowledge should auto load. Keep them concise (under 30 lines). Include only the most
critical context that shapes every interaction in that directory.


**Change 3: Slimmed CLAUDE.md from 93 to 84 lines**

Moved Self Learning Protocol (6 lines) to a new `.claude/rules/self-learning.md` file.
Compressed verbose Platform Detection paragraph into a compact 2 line reference.

**Why:** Every line in CLAUDE.md competes for the ~150 to 200 instruction adherence budget.
Moving specialized content that does not apply to every session frees slots for the truly
universal instructions.

**How to adapt:** For each line in your CLAUDE.md, ask: "Would removing this cause mistakes
in EVERY session?" If not, move it to a rule or skill. CLAUDE.md should be identity and
universal constraints only.


**Change 4: Created .claudeignore**

Added `.claudeignore` at project root excluding .jsonl files, minified scripts, and
research transcript directories.

**Why:** Prevents Claude from scanning large irrelevant files during file discovery,
saving tokens and reducing noise.

**How to adapt:** Add .claudeignore excluding build artifacts, minified code, large data
files, and any directories that Claude should not discover.


### Tier 1: Security and Correctness

**Change 5: Fixed GTM hook to actually block (CRITICAL)**

Before:
```json
"command": "echo '{\"decision\": \"block\", \"reason\": \"SAFETY: ...\"}}'"
```

After:
```json
"command": "echo 'BLOCKED: This action modifies a live GTM container...' && exit 2"
```

**Why:** The old hook used `echo` which always returns exit code 0. The hooks system only
blocks tool execution on exit code 2. Our most important safety gate was not actually
enforced. Claude would see the "block" message and hopefully comply, but the tool call
would proceed regardless. Adding `&& exit 2` makes the block deterministic.

**How to adapt:** Audit every PreToolUse hook in your project. If it uses `echo` or any
command that returns exit code 0, the tool call is NOT blocked. Any action that must be
prevented 100% of the time needs `exit 2` (or equivalent for your platform).


**Change 6: Global skills audit (287 down to 91)**

Removed two massive third party skill packages:
- `ali-claude-skills` (171 skills covering engineering, finance, HR, product management)
- `seomachine` (25 skills covering CRO, copywriting, pricing, popups)

**Why:** 287 global skills were generating approximately 23,603 characters of descriptions
against a 15,000 character skill budget. This meant our 20 project specific SEO skills
were being crowded out by irrelevant skills about finance and HR. After removal, 91
remaining skills are all SEO, GTM, ads, and web quality related.

**How to adapt:** Count your global skills with `find ~/.claude/skills -name "SKILL.md" | wc -l`.
If over 100, audit for relevance. Remove packages that are irrelevant to your project domain.
Each skill's description competes for the 15,000 character budget regardless of whether it
is ever activated.


### Tier 2: Performance and Efficiency

**Change 7: Made Stop hook non blocking**

Before: Used PowerShell MessageBox directly (blocks until user clicks OK).
After: Wrapped in `Start-Process` with `-WindowStyle Hidden` so the notification fires
without freezing the process.

**Why:** If Michael stepped away, the blocking MessageBox would prevent the process from
accepting new input until manually dismissed.

**How to adapt:** Any Stop or Notification hook that uses a blocking UI element (MessageBox,
dialog, prompt) should be wrapped in a background process launch. On macOS, use `osascript`
with `&`. On Linux, use `notify-send`.


**Change 8: Verified model tiering on all 9 agents**

Confirmed all agents have appropriate model assignments:
- Opus (complex reasoning): technical-seo-auditor, netsuite-seo-developer, aeo-specialist
- Sonnet (execution): pagespeed-optimizer, content-strategist, link-strategist, schema-architect
- Haiku (fast lookups): competitor-intelligence, search-console-analyst

**Why:** Running Opus for simple data retrieval wastes money and adds latency. Running Haiku
for complex judgment calls produces lower quality output. Matching model capability to task
complexity optimizes both cost and quality.

**How to adapt:** Add `model: claude-opus-4-6`, `model: claude-sonnet-4-6`, or
`model: claude-haiku-4-5` to your agent frontmatter. Assign based on whether the agent
needs complex reasoning (Opus), execution speed (Sonnet), or fast lookups (Haiku).


**Change 9: Added delegate mode bug workaround to orchestration rules**

Added explicit documentation of GitHub #25037 (lead agent grabs tasks in delegate mode)
with the workaround: include language in the lead prompt saying "You are the orchestrator.
Do NOT execute any analysis tasks yourself. Your ONLY job is to delegate to teammates and
synthesize their results."

**Why:** Without this workaround, the lead agent may do work that should be parallelized
across teammates, defeating the purpose of Agent Teams.

**How to adapt:** If using Agent Teams with 4+ teammates, include this anti grab language
in your orchestration prompts until the bug is fixed upstream.


**Change 10: Added execution mode guidance to agent orchestration rules**

Categorized each agent as background (research, data gathering) or foreground (analysis
needing iterative review). Background agents free the lead to continue other work.

**Why:** Not all agent tasks need the lead to wait for results. Background execution
enables true parallel workflows where the lead processes results as they arrive.

**How to adapt:** For each agent in your project, determine: does the lead need this
agent's results before proceeding? If no, mark it as background. If yes, keep foreground.


**Change 11: Added Task tools integration to all 8 audit/report commands**

Every audit and reporting command now has a Step 0 that creates tasks with subtasks for
each phase using TaskCreate. Each phase updates its task status as it progresses.

**Why:** Provides real time visibility into audit progress. Michael (or any team member)
can see exactly which phase of a multi step audit is in progress, completed, or pending.

**How to adapt:** For any multi step command, add a Step 0 that creates a parent task and
subtasks for each phase. Use TaskUpdate to mark phases in_progress and completed. This is
especially valuable for long running workflows.


### Tier 3: Capability Expansion

**Change 12: Installed Fetch MCP (Anthropic official)**

`claude mcp add fetch -- npx -y @modelcontextprotocol/server-fetch`

**Why:** Converts any URL to clean markdown. Essential for content analysis, competitor
page extraction, and feeding page content into audit workflows without the overhead of
full browser automation.

**How to adapt:** Install with the command above. Available to all projects. Useful
anywhere you need to extract and analyze web page content.


---

## WHAT WAS ALREADY OPTIMAL (No Changes Needed)

These elements were confirmed as best practice by the research:

- CLAUDE.md structure and length (under 200 lines)
- Layered architecture (CLAUDE.md > rules > skills > agents > commands)
- Client memory protocol (history.md, profile.md, open-items.md per client)
- PreCompact hook preserving critical context through compaction
- File protection hook using exit code 2 correctly
- Permissions allow/deny lists (granular, comprehensive)
- .gitignore excluding sensitive files
- Self learning protocol (creating skills from research discoveries)
- Swarm mode as default orchestration approach
- /catchup command for context restoration after /clear
- /spec-audit command for structured review workflows

---

## METRICS: BEFORE AND AFTER

| Metric | Before | After | Impact |
|---|---|---|---|
| Instructions per session (general) | ~553 | ~250 | 55% reduction |
| Instructions per session (client work) | ~553 | ~553 | Same (scoped rules load) |
| CLAUDE.md lines | 93 | 84 | 10% reduction |
| Rules files (unconditional) | 5 | 3 | 40% fewer always loaded |
| Path scoped rules | 0 | 3 | New capability |
| Client auto context CLAUDE.md | 0 | 3 | Deterministic context |
| Global skills | 287 | 91 | 68% reduction |
| Skill description budget usage | ~157% (over) | ~60% (healthy) | Under budget |
| GTM safety hook | Probabilistic | Deterministic | 100% enforcement |
| Stop hook | Blocking | Non blocking | No process freeze |
| Commands with task tracking | 0 | 8 | Full audit visibility |
| Project MCPs | 4 | 5 | Added Fetch |
| Agent execution mode guidance | None | All 9 agents | Clear background/foreground |
| Delegate mode bug documented | No | Yes | Workaround available |

---

## HOW TO ADAPT THIS FOR ANOTHER PROJECT

If you are a Claude Code project reading this document to make similar optimizations:

### Step 1: Audit Your Instruction Budget
Count lines in your CLAUDE.md + all unconditional rules. If the total exceeds 200 (plus
the ~50 from Claude Code system prompt), you are over budget. Path scope rules that do not
apply to every session.

### Step 2: Audit Your Hooks
Check every PreToolUse hook. If it uses `echo` without `exit 2`, it is NOT blocking. Any
safety critical action needs exit code 2. Check Stop hooks for blocking behavior.

### Step 3: Audit Your Skills
Count global skills: `find ~/.claude/skills -name "SKILL.md" | wc -l`. If over 100,
remove irrelevant packages. The 15,000 character description budget is shared across ALL
skills (global + project).

### Step 4: Add Path Scoped Rules
Identify rules that only apply in specific contexts. Add `---\nglobs: path/**\n---` at
the top. This is the single highest leverage change for instruction following quality.

### Step 5: Create Subdirectory CLAUDE.md Files
For any directory where context specific knowledge should auto load (clients, modules,
services), create a concise CLAUDE.md with the essential context.

### Step 6: Verify Model Tiering
Every agent should have an explicit model assignment matching its task complexity.
Do not run Opus for data retrieval or Haiku for complex judgment.

### Step 7: Add Task Tracking to Multi Step Workflows
Any command with 3+ phases benefits from TaskCreate/TaskUpdate for progress visibility.

### Step 8: Review MCP Token Overhead
Each MCP's tool definitions consume context tokens on every request. Only install MCPs
you will use regularly. Project scope MCPs over global when possible.

---

## FILES MODIFIED IN THIS SESSION

### Created
- `.claudeignore` (token efficiency)
- `.claude/rules/self-learning.md` (extracted from CLAUDE.md)
- `clients/verocious-motorsports/CLAUDE.md` (auto context)
- `clients/austenitex/CLAUDE.md` (auto context)
- `clients/_template/CLAUDE.md` (template for new clients)
- `research/optimization-plan-2026-03.md` (full prioritized plan)
- `research/project-optimization-session-2026-03-06.md` (this document)

### Modified
- `.claude/CLAUDE.md` (93 to 84 lines, removed Self Learning and Platform Detection)
- `.claude/settings.local.json` (fixed GTM hook exit code, non blocking Stop hook)
- `.claude/rules/anomaly-flagging.md` (added globs: clients/**)
- `.claude/rules/client-memory.md` (added globs: clients/**)
- `.claude/rules/agent-orchestration.md` (added globs: agents/**, delegate mode workaround, execution modes)
- `commands/full-seo-audit.md` (added Step 0 task tracking)
- `commands/technical-audit.md` (added Step 0 task tracking)
- `commands/pagespeed-audit.md` (added Step 0 task tracking)
- `commands/aeo-audit.md` (added Step 0 task tracking)
- `commands/content-audit.md` (added Step 0 task tracking)
- `commands/netsuite-seo-audit.md` (added Step 0 task tracking)
- `commands/competitor-analysis.md` (added Step 0 task tracking)
- `commands/monthly-seo-report.md` (added Step 0 task tracking)
- `commands/quarterly-seo-review.md` (added Step 0 task tracking)
- `MEMORY.md` (auto memory updated with all changes)

### Removed
- `~/.claude/skills/ali-claude-skills/` (171 irrelevant skills)
- `~/.claude/skills/seomachine/` (25 irrelevant skills)

### Installed
- Fetch MCP (`@modelcontextprotocol/server-fetch`) at project scope

---

## REMAINING OPTIMIZATION OPPORTUNITIES (Not Yet Implemented)

These were identified by research but deferred for later:

- **Consolidate dual Asana MCP connectors** (both mcp__asana__ and mcp__claude_ai_Asana__ active)
- **Install GSC MCP** when service account is configured
- **Install GA4 MCP** when credentials are ready
- **Install Firecrawl MCP** when API key is obtained
- **Add dynamic context injection** (!`command` syntax) to key skills
- **Evaluate NetSuite official MCP** for SuiteCommerce configuration access
- **Build llms.txt** into audit deliverable checklist
- **Evaluate Claude Agent SDK** for automated monitoring pipelines
- **Productize SuiteCommerce SEO expertise** (confirmed no competition in this niche)

---

## SOURCES

Full source list in `research/project-optimization-research-2026-03.md` covering 30+
sources across Claude Code official docs, Anthropic platform docs, GitHub repos, community
blogs, and expert configurations.
