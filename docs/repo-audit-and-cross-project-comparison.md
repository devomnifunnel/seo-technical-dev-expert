# Repo Audit Infrastructure Implementation & Cross Project Comparison

Date: 2026-03-11
Asana Task: 1213613874900407 (Repo Audit Infrastructure Implementation, SEO Project)
Session: Multi session effort spanning 2 conversations (context overflow required continuation)

## Table of Contents

1. Repo Audit Summary (What Was Implemented)
2. Research Findings (7 Background Agents)
3. Cross Project Architecture Comparison (SEO vs Paid Media)
4. Gaps and Recommendations
5. Implementation Priority

---

## 1. Repo Audit Summary

This session implemented the reconciled action plan from auditing 82 GitHub repos. The goal: build the best possible Claude Code agent with bespoke expertise for OFM.

### Completed Implementations

**PostToolUse Hook Wiring**
The post-tool-validate.sh script existed but was not wired into settings.local.json. Added the PostToolUse entry with `mcp__` matcher so every MCP tool call gets validated for auth failures (401/403), empty responses, rate limits (429), and server errors (500+).

**Hook Profile System**
Added OFM_HOOK_PROFILE environment variable support (minimal/standard/strict) to 3 non safety hooks: user-prompt-flags.sh, pre-compact-context.sh, post-tool-validate.sh. In minimal mode, non safety hooks exit immediately. Safety hooks (block-gtm-modifications.sh, block-protected-files.sh) always run regardless of profile.

**Writing Style Rules Expansion**
Extracted writing style rules from CLAUDE.md into a dedicated rules file at .claude/rules/writing-style.md. Merged in all 24 anti AI writing tics from the blader/humanizer repo (Wikipedia's AI detection framework). Organized into three sections: Core Style (5 rules), Banned Words and Phrases (9 categories), Structural Tics to Avoid (8 patterns).

**MCP Response Efficiency Rules**
Created .claude/rules/mcp-response-efficiency.md with guidelines for handling verbose MCP tool responses. Implemented as a rules file rather than a hook because hooks cannot modify tool output. Covers: extracting key metrics first, summarizing before proceeding, using subagents for bulk data, LIMIT clauses on GAQL, paginating Semrush requests. Lists the 6 tools most likely to produce verbose output.

**CLAUDE.md Budget Compliance**
Trimmed CLAUDE.md from 107 lines to 98 lines (under the 100 line target). "How Michael Works" section reduced from 12 to 5 lines (writing rules extracted to rules file, behavioral rules consolidated). "Key Specializations" reduced from 7 to 4 lines (5 items consolidated to 3).

**Security.md Duplication Cleanup**
Removed 18 lines of duplicated git safety rules from .claude/rules/security.md. These duplicated Claude Code's built in system prompt rules (no force push, no hard reset, specific file staging, never skip hooks). Kept only OFM specific additions: credential pattern scanning, dependency typosquatting, code generation security (ES5, XSS, SQL injection), URL safety, network security, severity classification. Saves ~300 tokens per session.

**Validator Fix: Plan + Write Tools**
Fixed a false positive in validate-operational.sh where agents with permissionMode=plan and Write/Edit tools were flagged as failures. Plan mode means "require approval before writing," not "cannot write." Updated the validator logic to treat plan + write tools as PASS with message "approval required."

**Instinct Learning Pipeline**
Created .claude/memory/instincts.md with scored discovery system. 4 initial instincts logged:
- Session baseline token cost with 10+ MCP servers (90% confidence, VALIDATED)
- CLAUDE.md survives compaction, conversation instructions do not (95%, VALIDATED)
- Built in git safety rules make custom git rules redundant (95%, PROMOTED to security.md cleanup)
- CLAUDE.md optionality disclaimer weakens instructions (85%, VALIDATED)

Promotion criteria: 80%+ confidence, actionable, 2+ session confirmations, then written into the relevant skill or framework file.

### Files Modified

| File | Action | Details |
|------|--------|---------|
| .claude/settings.local.json | Modified | Added PostToolUse hook entry |
| .claude/hooks/user-prompt-flags.sh | Modified | Added hook profile check |
| .claude/hooks/pre-compact-context.sh | Modified | Added hook profile with behavioral differentiation |
| .claude/hooks/post-tool-validate.sh | Modified | Added hook profile check |
| .claude/rules/writing-style.md | Created | 24 Humanizer patterns, full style guide |
| .claude/rules/mcp-response-efficiency.md | Created | MCP verbose response handling |
| .claude/CLAUDE.md | Modified | Trimmed 107 to 98 lines |
| .claude/rules/security.md | Modified | Removed 18 lines of duplicated git safety |
| scripts/eval/validate-operational.sh | Modified | Fixed plan + write tools false positive |
| .claude/memory/instincts.md | Created | Scored discovery pipeline with 4 initial instincts |
| MEMORY.md | Modified | Updated counts, hooks, eval framework, audit tracking |

---

## 2. Research Findings (7 Background Agents)

Seven background research agents were dispatched to audit relevant GitHub repos. Results were processed and integrated where applicable.

### Humanizer (blader/humanizer)
Wikipedia's AI detection framework identifying 24 anti AI writing tics. All patterns merged into writing-style.md. Includes: filler openings ("Additionally"), inflated language ("leverage," "landscape"), structural patterns (synonym cycling, false ranges, rule of three overuse, superficial present participle analysis).

### System Prompts (Piebald-AI/claude-code-system-prompts v2.1.72)
Revealed Claude Code's base system prompt is ~20 to 25k tokens. With 10+ MCP servers active, sessions start at ~42 to 50k tokens consumed before any conversation. CLAUDE.md is re-read from disk after /compact (survives), but conversation instructions do not. CLAUDE.md content is wrapped in a "may or may not be relevant" disclaimer (GitHub issue #7571, closed NOT_PLANNED). The OVERRIDE prefix is the community's best countermeasure.

### Meta Ads Analyzer
Found a standalone analyzer repo focused on diagnosing the "Breakdown Effect" in Meta Ads campaign data. Confirmed scope: Paid Media project, not SEO. Skill already exists in PM project.

### Claude Ads (ai-ad-generator patterns)
AI ad copy generation patterns. Confirmed scope: Paid Media project for creative generation workflows.

### Growth Marketing Agents
Multi platform growth marketing agent patterns. Confirmed scope: Paid Media project for campaign orchestration.

### Varlock (configuration management)
Configuration version control for complex system settings. Interesting concept but P3 priority. Not implemented. Potential future use for tracking GTM container versions or NetSuite configuration changes.

### Skill Seekers (skill discovery patterns)
Patterns for skill auto discovery and loading. P3 priority. Our skill architecture already handles this through auto trigger and description matching. Filed for future reference.

---

## 3. Cross Project Architecture Comparison

### The Numbers

| Metric | SEO Project | PM Project |
|--------|------------|------------|
| Validation checks | 383 (331+52) | 71 |
| Passing | 383 (100%) | 64 (90%) |
| Failing | 0 | 7 |
| Agents | 9 | 9 |
| Skills | 32 | 27 (validator says 30) |
| Frameworks | 10 | 11 |
| Rules | 8 | 4 |
| Hooks (scripts) | 5 | 7 |
| Hook events | 6 | 7 |
| Chrome scripts | 8 | 11 |
| CLAUDE.md lines | 98 | 112 |

### Hook Event Coverage Comparison

| Event | SEO | PM |
|-------|-----|-----|
| UserPromptSubmit | Yes (flags) | Yes (flags) |
| PreToolUse | GTM block, file protect | Meta/Google/AC/Outlook write block |
| PostToolUse | MCP validation (all) | MCP validation (specific tools) |
| PreCompact | Dynamic context | Dynamic context |
| SessionStart | **MISSING** | Re-inject after compact |
| Stop | Notify only | **Check planning + notify** |
| TaskCompleted | Quality gate prompt | Quality gate prompt |

### PM Project Architecture Notes

PM uses Node.js for all hooks (Claude Code runs on Node, guaranteed available, handles JSON natively). Settings are split: settings.json for permissions (version controlled), settings.local.json for hooks (local paths). PM has a 73KB build-audit-doc.py script for generating Word audit documents. PM targets 50% context fill for compaction vs our 70 to 80%. PM's self learning protocol is 5 lines inline in CLAUDE.md.

---

## 4. Gaps and Recommendations

### Gaps in SEO Project (Adopt from PM)

**1. SessionStart Hook**
PM has compact-context.js that fires on SessionStart to re-inject critical context after compaction. We rely only on PreCompact to preserve context before it happens. PM does both: preserves before AND re-injects after. We're missing the second half.

**2. Read Deny on Sensitive Files (security gap)**
PM's settings.json denies Read on ~/.ssh/**, ~/.aws/**, **/.env, **/credentials*, **/secrets*. Our settings.local.json only denies Edit on those paths. An agent could technically Read a .env file in our project. PM blocks both Read and Edit.

**3. Zapier Write Protection (safety gap)**
PM blocks write operations through Zapier MCP: Google Ads set/add/create/send/remove, ActiveCampaign create/update/add/remove, Outlook send/reply/delete. We have Zapier MCP connected but zero PreToolUse guards on it. If an agent tried to send an email or modify ActiveCampaign through Zapier in our project, nothing would stop it.

**4. Verification Comments as a Rules File**
PM has a dedicated .claude/rules/verification-comments.md (47 lines) with a specific comment format template, list of applicable scenarios, and available verification tools. We have this concept embedded in the Asana Protocol section of CLAUDE.md but it's 2 lines, not a full specification with examples.

**5. Planning Scripts for Stop Hook**
PM's Stop hook runs check-complete.ps1/.sh before notifying. This verifies that planning files (task_plan.md, findings.md, progress.md) are properly saved before the session ends. Our Stop hook only sends a desktop notification.

**6. build-audit-doc.py**
PM has a 73KB Python script that generates Word (.docx) audit documents. We produce .docx drafts as a deliverable standard but don't have an automated builder.

**7. systemic-patterns.md**
PM has a memory file for tracking patterns that appear across 3+ clients (algorithm updates, platform bugs, common misconfigurations). We have instincts.md for session discoveries but not this cross-client pattern concept. Our client-memory.md rule describes this concept but we don't have the actual file.

### Gaps in PM Project (Things SEO does that PM doesn't)

**1. Validation Rigor**
383 checks vs 71, and PM has 7 failures. Our eval suite is 5x more comprehensive and catches issues PM's validator misses.

**2. Writing Style Rules (24 Humanizer patterns)**
PM has 21 lines of writing rules inline in CLAUDE.md. We have those PLUS the full 24 pattern Humanizer set as a dedicated rules file. PM is missing structural tics (synonym cycling, false ranges, superficial -ing analysis, etc.).

**3. Agent Orchestration Rules**
Model tiering, swarm archetypes, delegation guidelines, file conflict prevention. PM doesn't have this.

**4. MCP Response Efficiency Rules**
Guidelines for handling verbose GAQL/analytics output. PM doesn't have this despite being the project most likely to hit 50K+ token MCP responses.

**5. Hook Profile System (OFM_HOOK_PROFILE)**
Environment variable controlled hook intensity. PM doesn't have this.

**6. Instinct Learning Pipeline with Confidence Scoring**
PM's self learning protocol is 5 lines in CLAUDE.md. Ours is formalized with instincts.md, scored discoveries, promotion criteria at 80%+, and retirement tracking.

**7. CLAUDE.md OVERRIDE Prefix**
We have the override statement based on System Prompts research showing CLAUDE.md is wrapped in a "may or may not be relevant" disclaimer. PM doesn't have this countermeasure.

**8. Agent Permission Hardening**
We removed Bash from 4 research-only agents and added permissionMode: plan to 3 write-capable agents. PM's agents don't appear to have this hardening.

**9. Context Management and Self Learning as Rules Files**
We extracted these into standalone rules. PM has them inline in CLAUDE.md.

### Architectural Misalignments (Should Standardize)

**1. Hook Language: JS vs Bash**
PM uses Node.js for all hooks. We use bash + Python. Node.js is the better choice because Claude Code runs on Node (guaranteed available), avoids Windows bash compatibility issues, and handles JSON natively without needing Python. Our bash hooks work but are more fragile. Low priority fix since ours work, but if we ever rewrite, JS is the right target.

**2. Compaction Target: 50% vs 70 to 80%**
PM targets 50% context fill for compaction. We target 70 to 80%. Given our instinct finding that sessions start at ~42 to 50k tokens (21 to 25% consumed before any work), PM's 50% target is actually more appropriate. At 50% of 200k = 100k tokens, the agent has used about 50k of working context. At our 70% target (140k), we're allowing the agent to accumulate 90k+ of working context before compacting, which is where quality degrades.

**3. settings.json vs settings.local.json**
PM uses settings.json (checked in, for permissions) plus settings.local.json (for hooks). We use only settings.local.json for both. PM's split is cleaner because permissions are structural (should be version controlled) while hooks reference local paths.

**4. Client Folders**
PM has blessed-performance and affordable-acls folders. We don't have either. The blessed-performance folder should exist in both projects since we're building client profiles (the plan from this session).

---

## 5. Implementation Priority

### Do Now (misalignment fixes for this project)

1. Add Read deny rules to settings (security gap)
2. Add Zapier write protection to PreToolUse hooks (safety gap)
3. Create verification-comments.md rule with format template
4. Create systemic-patterns.md in .claude/memory/

### Do Soon (architectural alignment)

5. Add SessionStart hook for post compaction context re-injection
6. Add planning check to Stop hook
7. Lower compaction target from 70 to 80% to 50 to 60%
8. Create blessed-performance client folder

### Recommend to PM Project

9. Add OVERRIDE prefix to CLAUDE.md
10. Add writing-style.md with full Humanizer patterns
11. Add agent-orchestration.md and mcp-response-efficiency.md rules
12. Expand validation suite (71 checks with 7 failures needs attention)
13. Add hook profile system
14. Add instincts.md memory pattern

### Blocked Items

- Firecrawl MCP (needs API key from Michael)
- Auto Mode (not yet available in Claude Code)

### Deferred (P3)

- Varlock configuration management
- Skill Seekers auto discovery patterns
- Weighted Audit Scoring Engine
- Client Onboarding Automation
