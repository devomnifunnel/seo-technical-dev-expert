# Project Optimization Plan: Unified Synthesis
## SEO & Technical Dev Expert | OmniFunnel Marketing
## March 6, 2026

Synthesized from 6 parallel research agents covering CLAUDE.md best practices, hooks system,
agent orchestration, skills architecture, power features, and MCP server optimization.

---

## CURRENT STATE ASSESSMENT

### What We Have (Strong Foundation)
- CLAUDE.md: 94 lines (well under 200 line best practice target)
- 5 rules files in .claude/rules/ (anomaly, client memory, security, context mgmt, orchestration)
- 5 hooks: GTM blocker, file protection, PreCompact, Stop notification, TaskCompleted gate
- 9 agent definitions with model tiering (Opus/Sonnet assigned correctly)
- 20 project skills with proper frontmatter (auto trigger, context:fork, disable model invocation)
- 100+ global skills (third party installs in ~/.claude/skills/)
- 11 commands including /catchup and /spec-audit
- Permissions: granular allow/deny list in settings.local.json
- Global settings: adaptive thinking enabled, effort level high, Agent Teams enabled

### Architecture Quality
Our project follows the recommended pattern: CLAUDE.md defines identity, rules hold domain
knowledge, skills package workflows, agents are specialist personas. This is the correct
layered architecture confirmed by every research source.

### CRITICAL FINDING: Instruction Overload
**We are at approximately 553 total instructions** (93 CLAUDE.md + ~410 rules + ~50 system
prompt). Research consensus is that frontier LLMs follow ~150 to 200 instructions with
reasonable consistency. We are nearly 3x over budget. This is the single most impactful
finding from all 6 agents. It directly explains why some instructions may not be followed
consistently. The fix is path scoping rules so they only load when relevant, and moving
specialized CLAUDE.md content to on demand skills.

---

## TIER 0: HIGHEST IMPACT (Instruction Budget Crisis)

### 0.1 Path Scope All Rules Files (Reduces ~410 Instructions to ~50 Per Session)

**Problem:** All 5 rules files (~410 lines total) load unconditionally into every session.
Combined with CLAUDE.md (93 lines) and the system prompt (~50 instructions), we are at ~553
total instructions. The adherence threshold is ~150 to 200. This means Claude is likely
ignoring or deprioritizing a significant portion of our rules.

**Fix:** Add `globs:` frontmatter to each rules file so it only loads when relevant:

- `anomaly-flagging.md`: Add `globs: clients/**` (only loads during client work)
- `client-memory.md`: Add `globs: clients/**` (only loads during client work)
- `agent-orchestration.md`: Add `globs: agents/**` (only loads when working with agents)
- `context-management.md`: No scoping needed (always relevant)
- `security.md`: No scoping needed (always relevant)

**Important:** Use `globs:` not `paths:` in frontmatter. Multiple bug reports confirm globs
works more reliably. Format: `---\nglobs: clients/**\n---` at top of file.

**Impact:** Reduces per session instruction load from ~553 to approximately ~250 (security
+ context management + CLAUDE.md + system prompt) for non client sessions. During client
work sessions, the full ~553 would load, which is still high but more focused.


### 0.2 Move Specialized CLAUDE.md Sections to Skills/Rules

**Problem:** Several CLAUDE.md sections are specialized domain knowledge, not universal
instructions needed every session:
- Platform Detection (line 89): Domain knowledge, not universal
- Self Learning Protocol (lines 80 to 85): Workflow, not identity
- Key Specializations (lines 50 to 55): Reference info, rarely actionable

**Fix:** Move these to:
- Platform Detection > skills/platform-detection/SKILL.md (auto trigger)
- Self Learning Protocol > .claude/rules/self-learning.md (always loaded, but much smaller)
- Key Specializations > Keep in CLAUDE.md (useful for context setting, only 6 lines)

**Impact:** Reduces CLAUDE.md from 93 to ~80 lines. More importantly, moves domain knowledge
to where it belongs per the architecture pattern (skills for workflows, rules for knowledge).


### 0.3 Create Client Subdirectory CLAUDE.md Files

**Problem:** Our client memory protocol requires Claude to "check clients/ then read history
before engaging." This is a probabilistic instruction. Claude Code natively loads CLAUDE.md
files from any directory it works in.

**Fix:** Create a CLAUDE.md in each client directory (clients/verocious-motorsports/CLAUDE.md,
clients/austenitex/CLAUDE.md) containing:
- Client name and key identifiers
- Platform details (SuiteCommerce version, theme, account ID)
- Known issues and current priorities
- Links to history.md and profile.md for full context

**Impact:** When Claude accesses files in a client directory, it automatically loads that
client's context. No instruction needed. Deterministic over probabilistic.


### 0.4 Add .claudeignore File

**Problem:** No .claudeignore exists. Claude's file discovery may be scanning directories
that waste tokens (node_modules equivalents, build artifacts, etc.).

**Fix:** Create .claudeignore at project root:
```
research/transcripts/
scripts/chrome/*.min.js
*.jsonl
```

---

## TIER 1: CRITICAL FIXES (Do Now)

### 1.1 GTM Hook Does NOT Actually Block (SECURITY)

**Problem:** The PreToolUse GTM hook uses `echo` with a JSON "block" message, but `echo`
always returns exit code 0. In the hooks system, only exit code 2 blocks a tool call.
Our hook shows Claude a message asking it not to proceed (probabilistic) but does NOT
programmatically prevent the tool from executing (deterministic). This means our most
important safety gate is not enforced.

**Fix:** Replace the echo with a command that exits with code 2:

```json
{
  "matcher": "mcp__gtm-mcp__gtm_tag|mcp__gtm-mcp__gtm_trigger|mcp__gtm-mcp__gtm_variable",
  "hooks": [
    {
      "type": "command",
      "command": "echo 'BLOCKED: This action modifies a live GTM container. Michael must explicitly approve before any external changes are made.' && exit 2"
    }
  ]
}
```

The `echo` still sends the message to Claude, but `exit 2` ensures the tool call is
rejected by the system regardless of what Claude decides.

**Impact:** Changes safety enforcement from probabilistic (Claude follows instruction) to
deterministic (system blocks execution). Non negotiable for a client facing agency project.


### 1.2 Protected File Hook Also Does Not Block Correctly

**Problem:** The Edit/Write file protection hook uses `sys.exit(2)` on match, which IS
correct for blocking. However, `sys.exit(0)` on non match means the hook runs Python on
EVERY file edit/write operation. This adds latency to every single file operation.

**Assessment:** The exit code logic is correct (2 for block, 0 for pass). This is actually
working as intended. The latency concern is minor since Python starts in ~100ms. No change
needed, but worth noting.


### 1.3 Dual Asana MCP Connectors (Token Waste)

**Problem:** Two separate Asana MCP connectors are active simultaneously:
- `mcp__asana__*` (standalone MCP)
- `mcp__claude_ai_Asana__*` (Claude integration connector)

Both provide overlapping tools. The Claude AI Asana connector has MORE capabilities
(goals, portfolios, time periods, teams, attachments) while the standalone has search
functionality.

**Action:** Evaluate which connector provides the tools we actually use. Our CLAUDE.md
references: search tasks, create tasks, update tasks, get project sections. The
`mcp__claude_ai_Asana__*` connector has all of these plus more. Recommend disabling the
standalone `mcp__asana__*` connector to save ~5,000+ tokens of context overhead per request.

**How to disable:** Remove or uninstall the standalone Asana MCP. Keep the Claude AI Asana
integration since it is more comprehensive.


### 1.4 Global Skill Token Overhead Audit

**Problem:** Over 100 third party skills are installed in ~/.claude/skills/. Skills with
`auto` trigger type load their descriptions into every conversation. The skill budget is
15,000 characters. If auto triggered skills exceed this budget, critical skills get dropped
silently.

**Action:** Run `/context` to see actual skill budget utilization. Then:
1. Audit which global skills use `auto` trigger (these consume budget every session)
2. Change redundant or rarely used auto trigger skills to `context: fork` or manual
3. Ensure our 20 project skills (which are SEO specific and highest priority) do not get
   crowded out by generic global skills
4. Consider moving the most valuable global skills to project level for guaranteed loading

**Priority global skill groups to evaluate:**
- ads/* (13 skills): Relevant for Paid Media project, may not need auto trigger here
- gtm-* (12 skills): Relevant, keep auto trigger
- claude-seo/* (12 skills): Overlaps with our project skills, may cause conflicts
- seo-geo/* (16 skills): Overlaps heavily with our project skills
- seomachine/* (15+ skills): Marketing skills, mostly irrelevant to SEO tech dev
- web-quality-lighthouse/* (6 skills): Relevant for CWV work

---

## TIER 2: MUST HAVE IMPROVEMENTS (This Session)

### 2.1 Make Stop Hook Non Blocking

**Problem:** The Stop hook uses PowerShell MessageBox which blocks until the user clicks OK.
If Michael is away from the machine, this blocks the entire process.

**Fix:** Add `Start-Process` to make it fire and forget:

```json
{
  "matcher": "",
  "hooks": [
    {
      "type": "command",
      "command": "powershell -Command \"Start-Process powershell -ArgumentList '-Command [System.Reflection.Assembly]::LoadWithPartialName(\\\"System.Windows.Forms\\\") > $null; [System.Windows.Forms.MessageBox]::Show(\\\"Claude has finished and needs your attention\\\", \\\"Claude Code\\\", \\\"OK\\\", \\\"Information\\\") > $null' -WindowStyle Hidden\""
    }
  ]
}
```

Alternative: Use Windows toast notification (BurntToast module) which auto dismisses:
```
powershell -Command "Import-Module BurntToast; New-BurntToastNotification -Text 'Claude Code', 'Task completed, needs your attention'"
```

### 2.2 Add SessionStart Hook (Asana Board Read)

CLAUDE.md says to read the Asana board at session start, but this relies on Claude
remembering the instruction. A `UserPromptSubmit` hook on the first message could
enforce this.

**Note:** Claude Code does not currently have a "SessionStart" event type. The closest
is `UserPromptSubmit` which fires on every user message. A conditional check (only on
first message) would add complexity. Better approach: keep this as a CLAUDE.md instruction
and reinforce it in the /catchup command. No hook needed.


### 2.3 Add Notification Hook for Background Agents

When background agents complete, Claude gets notified but Michael does not. Add a
`Notification` hook to surface agent completion events:

```json
{
  "matcher": "",
  "hooks": [
    {
      "type": "command",
      "command": "powershell -Command \"Start-Process powershell -ArgumentList '-Command Import-Module BurntToast; New-BurntToastNotification -Text \\\"Claude Code\\\", \\\"Background agent completed\\\"' -WindowStyle Hidden\""
    }
  ]
}
```

**Prerequisite:** Install BurntToast: `Install-Module -Name BurntToast -Force`


### 2.4 Document Ultrathink Strategy

Add to context management rules or CLAUDE.md a clear thinking strategy:
- **Standard tasks** (file reads, simple edits): effort level "high" (default)
- **Complex analysis** (audit synthesis, architecture decisions): use "think harder" or
  "think step by step" in prompts to Claude
- **Critical decisions** (client recommendations, code that touches production): use
  "ultrathink" or very detailed prompting to maximize reasoning depth

This is not a settings change but a usage pattern for Michael and the team to understand.


### 2.5 Add Task Tools to Audit Workflows

The native Task tools (TaskCreate, TaskGet, TaskUpdate, TaskList, TaskOutput) provide
structured project tracking. Our audit commands should use them to:
1. Create tasks for each audit phase
2. Track progress as phases complete
3. Generate final status reports

**Action:** Update key commands (full-seo-audit, technical-audit, pagespeed-audit) to
include TaskCreate steps at the beginning and TaskUpdate at each phase gate.


### 2.6 Add Background Agent Guidance to Agent Definitions

Agent files should include guidance on when to run in background vs foreground:
- Background: research, competitor analysis, keyword research, content audits
- Foreground: technical audits needing iterative review, client delivery prep

**Action:** Add a "## Execution Mode" section to each agent file specifying default mode.


### 2.7 Update Model Tiering Documentation

Current agent files already have model tiering:
- technical-seo-auditor: claude-opus-4-6 (correct, complex reasoning)
- pagespeed-optimizer: claude-sonnet-4-6 (correct, execution)

**Action:** Verify all 9 agents have appropriate model assignments:
- Opus: technical-seo-auditor, netsuite-seo-developer, aeo-specialist
- Sonnet: pagespeed-optimizer, content-strategist, schema-architect, link-strategist
- Haiku: competitor-intelligence, search-console-analyst (fast lookups, data retrieval)

---

## TIER 3: HIGH PRIORITY (This Week)

### 3.1 Install Lighthouse MCP

Superior to PageSpeed MCP alone. 13+ tools including full Lighthouse audits, CWV, WCAG
accessibility, security scanning, resource analysis.

```
claude mcp add lighthouse -- npx @danielsogl/lighthouse-mcp@latest
```

### 3.2 Install Chrome DevTools MCP

Already available in our deferred tools list. Provides live performance tracing, network
analysis, JS profiling directly from Chrome.

**Status:** Appears already installed (we see `mcp__chrome-devtools__*` in available tools).
Verify with Michael that it is configured and working.

### 3.3 Install Fetch MCP (Anthropic Official)

Clean HTML to markdown conversion. Essential for content analysis.

```
claude mcp add fetch -- npx -y @modelcontextprotocol/server-fetch
```

### 3.4 Install Firecrawl MCP

Best in class web scraping for large scale content analysis. Complements Chrome MCP
(which works on single pages) with batch crawling capability.

```
claude mcp add firecrawl -e FIRECRAWL_API_KEY=key -- npx -y firecrawl-mcp
```

**Requires:** Firecrawl API key (free tier available).

### 3.5 Create Project Level .mcp.json

Currently no project level MCP configuration exists. Create one to scope MCPs to this
project and avoid loading irrelevant global MCPs.

### 3.6 Review Delegate Mode Bug Workaround

GitHub issue #25037 documents a bug where the lead agent grabs tasks even in delegate
mode. Current workaround: explicit instructions in the prompt telling the lead to ONLY
delegate and never execute directly.

**Action:** Update agent-orchestration rule to include this workaround guidance.

### 3.7 Add Per Client CLAUDE.md Capability

Create a client template that includes a mini CLAUDE.md with client specific instructions:
- Known platform quirks
- Approved vs restricted actions for that client
- Key contacts and communication preferences
- Recurring tasks and their cadence

Store at: clients/[name]/.claude.md (or clients/[name]/instructions.md)
The team member can symlink or include this when working on that client.

---

## TIER 4: MEDIUM PRIORITY (This Month)

### 4.1 Install GSC MCP (When Service Account Ready)
github.com/AminForou/google-search-console-mcp-v2

### 4.2 Install GA4 MCP (When Credentials Ready)
github.com/googleanalytics/google-analytics-mcp

### 4.3 Add Dynamic Context Injection to Key Skills
Use `!command` syntax to pull live data into skill context before execution.

### 4.4 Build llms.txt Into Audit Checklist
Add to templates/audit-report as a standard check.

### 4.5 Evaluate NetSuite Official MCP
Oracle published a NetSuite MCP connector. Evaluate whether it provides SuiteCommerce
configuration access that would complement our backend exploration capabilities.

### 4.6 Create Quality Gate Hooks for Audit Deliverables
Expand TaskCompleted hook to check specific quality criteria per deliverable type.

---

## TIER 5: FUTURE CONSIDERATIONS (Next Quarter)

### 5.1 Evaluate Claude Agent SDK for Automated Monitoring
Python/TypeScript SDK for building automated SEO monitoring pipelines.

### 5.2 Productize SuiteCommerce SEO Expertise
No competition exists in this niche. Our skills + knowledge are unique.

### 5.3 Evaluate 1M Context Window for Large Site Audits
Opus 4.6 supports 1M tokens via beta header. Premium pricing above 200K.

### 5.4 Build Automated Nightly SEO Checks
Using Agent SDK + cron for continuous monitoring.

---

## IMPLEMENTATION ORDER (Recommended Sequence)

### Phase 0: Instruction Budget Crisis (Now, Highest Impact)
1. Add globs: frontmatter to path scope rules files (15 minutes, 3x instruction reduction)
2. Create client subdirectory CLAUDE.md files for VMS and Austenitex (15 minutes)
3. Move Platform Detection and Self Learning from CLAUDE.md to skills/rules (10 minutes)
4. Create .claudeignore file (5 minutes)

### Phase 1: Security & Correctness (Now)
5. Fix GTM hook exit code to actually block with exit 2 (5 minutes, CRITICAL)
6. Audit global skill overlap and disable/reconfigure as needed (30 minutes)
7. Evaluate and consolidate Asana connectors (15 minutes)

### Phase 2: Performance & Efficiency (Today)
8. Make Stop hook non blocking (5 minutes)
9. Verify model tiering on all 9 agents (15 minutes)
10. Add execution mode guidance to agents (30 minutes)
11. Update commands with Task tools integration (30 minutes)

### Phase 3: Capability Expansion (This Week)
12. Install Lighthouse MCP (5 minutes)
13. Install Fetch MCP (5 minutes)
14. Create project .mcp.json (15 minutes)
15. Install Firecrawl MCP if API key available (10 minutes)
16. Update delegate mode documentation (10 minutes)

### Phase 4: Advanced Features (This Month)
17. Install GSC MCP when service account ready
18. Install GA4 MCP when credentials ready
19. Add dynamic context injection to skills
20. Build llms.txt into audit checklist
21. Evaluate NetSuite MCP

---

## WHAT NOT TO CHANGE

These are confirmed as already optimal:
- CLAUDE.md length and structure (94 lines, well under 200)
- Rules file organization (5 focused files)
- Client memory protocol (history.md, profile.md, open items)
- PreCompact hook (preserves critical context through compaction)
- File protection hook (correctly uses exit code 2)
- Permissions allow/deny lists (comprehensive and correct)
- Agent model assignments (Opus/Sonnet correctly distributed)
- Command structure (11 commands covering all audit types)
- Self learning protocol (skills created from research automatically)
- Swarm mode as default (confirmed best practice)
- /catchup and /spec-audit commands (both well structured)

---

## SOURCES

See research/project-optimization-research-2026-03.md for full source list including:
- Claude Code official documentation (code.claude.com)
- Anthropic platform documentation (platform.claude.com)
- Community best practices (humanlayer.dev, arize.com, alexop.dev)
- Elite user setups (Boris Cherny, Addy Osmani, Freek Van der Herten, incident.io)
- Agent orchestration guides (VoltAgent, awesome-claude-code)
- MCP server registry (pulsemcp.com, registry.modelcontextprotocol.io)
