---
paths:
  - ".claude/agents/**"
---

# Agent Orchestration Rules

These rules govern how agents are deployed, coordinated, and optimized for maximum
effectiveness across all SEO and technical development workflows.

---

## Model Tiering

Select the appropriate model for each agent role:

- **Opus** (lead, planning, complex reasoning): Technical SEO audits requiring judgment calls,
  architecture decisions, client strategy, synthesizing multi-agent outputs, code generation
  for complex SuiteCommerce fixes, E-E-A-T scoring, anomaly diagnosis.
- **Sonnet** (execution, implementation): Writing content briefs, generating schema markup,
  creating developer handoff docs, producing audit report sections, standard code edits,
  bulk file processing.
- **Haiku** (exploration, fast lookups): File discovery, keyword list processing, quick web
  searches, checking URL status codes, reading configuration files, simple data extraction.

## Agent Teams Protocol

When using Agent Teams (4+ teammates):
1. **Enable delegate mode** (Shift+Tab) immediately to prevent lead from grabbing tasks
2. Teammates spawn in 20 to 30 seconds and produce results within the first minute
3. Optimal team size: 3 to 5 teammates for most workflows
4. Maximum 5 to 6 tasks per teammate
5. Cost is approximately 3 to 4x for a 3 teammate team versus sequential solo

**Known Bug Workaround (GitHub #25037):** Even in delegate mode, the lead agent may grab
tasks intended for teammates. To prevent this, include explicit language in the lead prompt:
"You are the orchestrator. Do NOT execute any analysis tasks yourself. Your ONLY job is to
delegate tasks to teammates and synthesize their results when they complete. Wait for all
teammates to finish before producing the final output." This forces the lead to stay in
its coordination role.

## Execution Mode by Agent Role

Agents should run in background or foreground based on their role:

**Background (run_in_background: true):** Use when the lead does not need results immediately
and can continue with other work. Best for research and data gathering tasks.
- competitor-intelligence: research is self contained
- search-console-analyst: data retrieval, no iterative review
- content-strategist: content analysis can run independently
- link-strategist: backlink research is self contained

**Foreground (default):** Use when findings inform immediate next steps or require
iterative review before proceeding.
- technical-seo-auditor: findings drive the audit direction
- pagespeed-optimizer: CWV results shape remediation plan
- netsuite-seo-developer: code changes need review
- aeo-specialist: AI search findings inform strategy
- schema-architect: validation results need immediate review

## Swarm Archetypes

Select the appropriate pattern based on the task:

- **Leader**: One orchestrator delegates to specialists, synthesizes results. Use for full
  site audits where technical, content, and performance findings must be unified.
- **Pipeline**: Sequential handoff where each agent's output feeds the next. Use for
  audit > findings > recommendations > deliverable workflows.
- **Parallel Specialists**: Multiple agents analyze same target from different angles
  simultaneously. Use for comprehensive page analysis (technical + content + schema + CWV).
- **Competing Hypotheses**: Multiple agents independently diagnose the same problem. Use
  for debugging ranking drops or traffic anomalies where root cause is unclear.
- **Watchdog**: Background agent monitors for regressions while others implement changes.
  Use during live optimization sessions.

## Delegation Guidelines

**Use subagents when:**
- Task produces verbose output (web searches, file exploration)
- Work is self contained and does not need iterative feedback
- Parallel execution adds clear value
- You want to preserve main context window
- Research or investigation that may require many tool calls

**Work directly when:**
- Task needs back and forth with Michael
- Change is quick (under 5 tool calls)
- Context from the current conversation is essential
- Latency matters (subagent spawn adds 20 to 30 seconds)

## Subagent Prompt Quality

Most failures are delegation failures. Every subagent prompt must include:
1. **Specific scope**: exact files, URLs, or data to analyze
2. **Context the agent cannot discover**: client name, known issues, prior findings
3. **Clear deliverable format**: what to return and how to structure it
4. **Verification criteria**: how the agent knows it succeeded
5. **Tool guidance**: which tools to use and which to avoid

## File Conflict Prevention

When running parallel agents that may edit shared files:
- Assign clear file ownership to each agent
- Use worktree isolation for agents that modify code
- Never have two agents editing the same file simultaneously
- The lead agent should be the only one writing synthesis documents

## Persistent Memory on Agents

For agents that handle recurring client work, leverage persistent memory:
- Client specific patterns and common issues
- Previous audit scores for trend tracking
- Known platform quirks (e.g., SuiteCommerce rendering behaviors)
- Optimization strategies that worked in prior sessions
