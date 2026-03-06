# Claude Code Agent Orchestration Research
## Deep Research Findings, March 2026

Last updated: 2026-03-06

---

## 1. How Elite Claude Code Users Structure Multi Agent Workflows

### The Abstraction Ladder

The most effective users match orchestration complexity to task requirements rather than defaulting to the most powerful pattern:

**Solo session** (most control) -> **Subagents** (balanced delegation) -> **Agent Teams** (maximum autonomy)

Higher autonomy trades human control for computational throughput. The consensus from multiple expert sources is: "Let the problem guide the tooling, not the other way around."

### The 80/20 Rule

Addy Osmani and multiple practitioners emphasize that 80% of the value comes from planning and specification, and 20% from execution. "Build me an app" burns tokens while agents flail, but "Implement these five clearly defined API endpoints according to this specification" produces quality results.

### The Plan First Pattern

The most consistently recommended workflow across all sources:

1. **Plan mode** (~10k tokens): Explore the codebase, create a task breakdown with dependencies
2. **Human review**: Adjust the plan, approve the approach
3. **Team execution**: Execute the plan as an agent team with explicit dependency chains

This prevents expensive mid swarm course corrections. The plan document becomes the task descriptions that teammates read.

### The Specification Driven Approach (wshobson/agents framework)

The Compound Engineering Plugin philosophy: 80% planning/review, 20% execution. Uses a three stage pipeline:
- **pm-spec**: Reads enhancement, writes working spec, asks clarifying questions, sets status READY_FOR_ARCH
- **architect-review**: Validates design against platform constraints, produces an ADR, sets status READY_FOR_BUILD
- **implementer-tester**: Implements code and tests, runs green, produces summary

Each stage has a Definition of Done checklist before handoff.

### Sources
- [Addy Osmani: Claude Code Swarms](https://addyosmani.com/blog/claude-code-agent-teams/)
- [From Tasks to Swarms (alexop.dev)](https://alexop.dev/posts/from-tasks-to-swarms-agent-teams-in-claude-code/)
- [wshobson/agents on GitHub](https://github.com/wshobson/agents)

---

## 2. The Claude Agent SDK

### What It Is

The Claude Agent SDK is the runtime that powers Claude Code, extracted and productized for building custom agents. Originally called the Claude Code SDK, Anthropic renamed it in September 2025 to reflect that the harness built for a coding tool had become general enough for any agentic workflow.

Available as:
- **TypeScript**: `@anthropic-ai/claude-agent-sdk` (npm)
- **Python**: `claude-agent-sdk` (PyPI) at [github.com/anthropics/claude-agent-sdk-python](https://github.com/anthropics/claude-agent-sdk-python)

### Core Design Philosophy

"Give your agents a computer, not just a prompt." The SDK provides Claude with direct, controlled access to a terminal, file system, and the web. This is fundamentally different from prompt only agents.

### The Agent Loop (4 Stages)

1. **Gather Context**: Agentic search using bash utilities (grep, tail, find), treating folder structure as context engineering. Transparent and accurate versus semantic search.
2. **Take Action**: Execute via tools, bash commands, code generation, or MCP integrations.
3. **Verify Work**: Rules based feedback (linting, type checking), visual feedback (screenshots), or LLM as judge evaluation.
4. **Iterate**: Refine based on verification feedback. Errors caught early prevent compounding.

### Key Technical Capabilities

**Context Compaction**: As conversations approach context limits, the SDK automatically summarizes the oldest parts. Enables 30+ hours of sustained agent operation observed with Sonnet 4.5.

**Subagents**: Parallel execution in isolated context windows. Results return only relevant excerpts to the orchestrator, ideal for filtering large datasets.

**MCP Integration**: Standardized connections to Slack, GitHub, Asana, Google Drive, and custom services. Handles authentication and API calls automatically.

**Built In Tools**: File operations, command execution, web search, code editing. Agents start working immediately without custom tool implementation.

**Sessions**: Persistent sessions with checkpoint and rollback. Agent transcripts stored at `~/.claude/projects/{project}/{sessionId}/`.

### How It Relates to Claude Code

Claude Code is the SDK's implementation for coding workflows. But the underlying harness also powers non coding applications at Anthropic: deep research, video creation, and note taking. The SDK rename reflects recognition that the architecture serves general agentic workflows.

### Best Practices from Anthropic

- **Context engineering**: File system organization directly impacts agent effectiveness. Information accessibility through folder structure shapes behavior.
- **Tool design**: Prioritize tools representing primary, frequent actions. Avoid cluttering context with secondary capabilities.
- **Agentic search over semantic search**: Start with bash based transparent search. Add semantic search only if performance demands justify complexity.
- **Testing**: Build representative test sets based on usage patterns to evaluate performance variations.

### Sources
- [Anthropic Engineering: Building Agents with the Claude Agent SDK](https://claude.com/blog/building-agents-with-the-claude-agent-sdk)
- [Agent SDK Overview (Platform Docs)](https://platform.claude.com/docs/en/agent-sdk/overview)
- [Claude Agent SDK Python (GitHub)](https://github.com/anthropics/claude-agent-sdk-python)
- [DataCamp Tutorial](https://www.datacamp.com/tutorial/how-to-use-claude-agent-sdk)

---

## 3. Agent Teams Feature (CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS)

### How to Enable

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

Add to settings.json or set as environment variable. Shipped with Opus 4.6 in early 2026 as a research preview.

### Architecture

Agent teams consist of four components:
- **Team lead**: Main Claude Code session. Creates team, spawns teammates, coordinates work.
- **Teammates**: Separate Claude Code instances. Each has its own full context window.
- **Task list**: Shared work queue with dependency tracking and auto unblocking. File locking prevents race conditions.
- **Mailbox**: Direct messaging system. Any agent can message any other.

State is stored locally:
- `~/.claude/teams/{team-name}/config.json` (team metadata and members)
- `~/.claude/tasks/{team-name}/` (task list)

### The Seven Team Primitives

1. **TeamCreate**: Initialize team directory and config file
2. **TaskCreate**: Define work items as JSON files on disk
3. **TaskUpdate**: Claim and mark tasks complete
4. **TaskList**: Poll available work for self coordination
5. **Task (with team_name)**: Spawn a teammate into the shared workspace
6. **SendMessage**: Direct communication between teammates
7. **TeamDelete**: Cleanup after shutdown

### TeammateTool (13 Operations, Full Lifecycle)

Team Management: spawnTeam, discoverTeams, cleanup
Membership: requestJoin, approveJoin, rejectJoin
Communication: write (targeted), broadcast (all)
Lifecycle: requestShutdown, approveShutdown, rejectShutdown
Quality: approvePlan, rejectPlan

### Display Modes

**In process** (default): All teammates in main terminal. Navigate with Shift+Down. Enter to view, Escape to interrupt. Works everywhere.

**Split pane**: Each teammate gets its own pane. Requires tmux or iTerm2. Not supported on Windows Terminal, VS Code integrated terminal, or Ghostty.

Configure: `"teammateMode": "in-process"` or `"tmux"` in settings.json. Override per session: `claude --teammate-mode in-process`.

### Delegate Mode (Shift+Tab)

Restricts the lead to coordination only. Cannot write code, run tests, or implement. Can only manage tasks, communicate, and review. Essential for 4+ teammates to prevent the lead from competing with workers.

### Plan Approval

Require teammates to plan before implementing. Teammate works in read only plan mode until lead approves. If rejected, teammate revises and resubmits. Influence lead's judgment: "only approve plans that include test coverage" or "reject plans that modify the database schema."

### Quality Gates via Hooks

**TeammateIdle**: Fires when teammate is about to idle. Exit code 2 sends feedback and keeps them working.

**TaskCompleted**: Fires when task is being marked complete. Exit code 2 prevents completion and sends feedback. Enforce test passage, lint checks, or acceptance criteria.

### Context Rules

- Teammates load CLAUDE.md, MCP servers, and skills automatically
- They do NOT inherit the lead's conversation history
- The spawn prompt is their only task specific context
- Be generous with the initial briefing

### Communication

- **write**: Target one specific teammate. Preferred for cost efficiency.
- **broadcast**: All teammates simultaneously. Use sparingly, costs scale with team size.
- Messages delivered automatically, no polling needed.
- Idle notifications auto sent when teammates finish.

### Environment Variables (Auto Set for Teammates)

- `CLAUDE_CODE_TEAM_NAME`
- `CLAUDE_CODE_AGENT_ID`
- `CLAUDE_CODE_AGENT_NAME`
- `CLAUDE_CODE_AGENT_TYPE`
- `CLAUDE_CODE_AGENT_COLOR`
- `CLAUDE_CODE_PLAN_MODE_REQUIRED`
- `CLAUDE_CODE_PARENT_SESSION_ID`

### Optimal Team Size

- Start with 3 to 5 teammates for most workflows
- Aim for 5 to 6 tasks per teammate
- Three focused teammates often outperform five scattered ones
- Diminishing returns beyond a certain point
- Scale up only when work genuinely benefits from parallelism

### Cost Reality

A 3 teammate team uses roughly 3 to 4x the tokens of a single session doing the same work sequentially. Each teammate has its own context window. Token usage scales linearly with active teammates. Worth it for research, reviews, features, and debugging. Not worth it for routine single file edits.

Optimization: Reserve Opus for the lead (planning, coordination). Use Sonnet for teammates (execution, implementation). Use Haiku for read only exploration subagents.

### Known Limitations (March 2026)

- No session resumption with in process teammates (/resume and /rewind do not restore them)
- Task status can lag (teammates sometimes forget to mark completion)
- Shutdown can be slow (teammates finish current request before stopping)
- One team per session (clean up before starting a new one)
- No nested teams (teammates cannot spawn their own teams)
- Lead is fixed for session lifetime (cannot transfer leadership)
- All teammates inherit lead's permission mode at spawn
- Split panes require tmux or iTerm2 (not on Windows Terminal)

### Sources
- [Official Docs: Agent Teams](https://code.claude.com/docs/en/agent-teams)
- [claudefa.st Complete Guide 2026](https://claudefa.st/blog/guide/agents/agent-teams)
- [claudefa.st Agent Teams Controls](https://claudefa.st/blog/guide/agents/agent-teams-controls)
- [alexop.dev: From Tasks to Swarms](https://alexop.dev/posts/from-tasks-to-swarms-agent-teams-in-claude-code/)
- [Addy Osmani: Claude Code Swarms](https://addyosmani.com/blog/claude-code-agent-teams/)

---

## 4. Swarm Mode Patterns and Parallel Agent Best Practices

### Pattern 1: Parallel Specialists
Multiple agents analyze from different angles simultaneously. Best for code review, QA, and research.

Example: Security reviewer + Performance reviewer + Test coverage reviewer all examine the same PR.

### Pattern 2: Competing Hypotheses (Adversarial Debate)
For debugging with unclear root causes. Multiple investigators actively trying to disprove each other. The theory that survives is more likely correct.

```text
Spawn 5 agent teammates to investigate different hypotheses.
Have them talk to each other to try to disprove each other's theories,
like a scientific debate. Update the findings doc with whatever consensus emerges.
```

### Pattern 3: Wave Based Execution
Work executes in dependency aware waves:
- Wave 1: Independent parallel tasks
- Wave 2: Tasks depending on Wave 1 completion
- Wave 3+: Downstream work

Tasks auto unblock when dependencies complete.

### Pattern 4: Domain Based Routing
Split by architectural domain (Frontend, Backend, Database, Tests). Each agent owns its domain. Prevents file conflicts that destroy parallel execution.

### Pattern 5: QA Swarm
3 to 5 parallel agents each testing a different domain. Results synthesized into prioritized findings. Demonstrated at about 3 minutes end to end for a full site QA sweep.

### Pattern 6: Self Organizing Swarms
Workers poll the task list, claim unclaimed work, and naturally load balance across the team. No explicit assignment needed.

### Pattern 7: Pipeline (Sequential Multi Stage)
Research -> Plan -> Implement -> Test -> Deploy. Each stage has clear deliverables feeding the next. Auto unblocking on completion.

### Five Emergent Multi Agent Archetypes (from paddo.dev analysis)

1. **Leader**: Hierarchical task direction
2. **Swarm**: Parallel processing of identical work
3. **Pipeline**: Sequential multi stage workflows
4. **Council**: Multi perspective decision making
5. **Watchdog**: Quality monitoring and oversight

These parallel Steve Yegge's "Gastown" architecture (Mayor orchestrates, Polecats execute in parallel, Witness monitors).

### Optimal Number of Concurrent Agents

There is no single optimal number. Guidance from multiple sources:

- **2 to 5 agents**: Most common recommendation for typical workflows
- **5 to 6 tasks per agent**: Keeps everyone productive without excessive context switching
- **10+ agents**: Possible with frameworks like claude_code_agent_farm but requires sophisticated coordination
- **20 to 50 agents**: Maximum demonstrated with agent farm framework, requires tmux monitoring and lock based coordination
- **Over parallelizing risk**: Launching 10 parallel agents for a simple feature wastes tokens and creates coordination overhead

Rule of thumb: If you have 15 independent tasks, 3 teammates is a good starting point (5 tasks each).

### Sources
- [paddo.dev: Claude Code's Hidden Multi Agent System](https://paddo.dev/blog/claude-code-hidden-swarm/)
- [Kieran Klaassen Gist: Swarm Orchestration Skill](https://gist.github.com/kieranklaassen/4f2aba89594a4aea4ad64d753984b2ea)
- [DEV Community: Multi Agent Orchestration 10+ Instances](https://dev.to/bredmond1019/multi-agent-orchestration-running-10-claude-instances-in-parallel-part-3-29da)
- [claudefa.st: Sub Agent Best Practices](https://claudefa.st/blog/guide/agents/sub-agent-best-practices)

---

## 5. Agent Delegation Patterns: Subagents vs Direct Work

### When to Use Subagents

- Task produces verbose output you do not need in main context (test runs, log processing)
- You want to enforce specific tool restrictions or permissions
- Work is self contained and can return a summary
- Parallel research on independent topics
- Cost optimization by routing to cheaper models

### When to Work Directly

- Task needs frequent back and forth or iterative refinement
- Multiple phases share significant context (planning then implementation then testing)
- Quick targeted change
- Latency matters (subagents start fresh and need time to gather context)

### Structuring Agent Prompts for Best Results

From multiple sources, the critical invocation principle is clear: most failures stem from poor delegation, not execution failures.

**Essential elements in a spawn/delegation prompt:**

1. **Specific scope**: Exact files, modules, or areas to work on
2. **Context the agent cannot discover**: Business logic, architectural decisions, constraints
3. **Clear deliverable**: What the agent should produce
4. **Success criteria**: How to verify the work is done correctly
5. **Verification commands**: Specific test or lint commands to run before reporting

**Example of a well structured delegation:**

```text
Review the authentication module at src/auth/ for security vulnerabilities.
Focus on token handling, session management, and input validation.
The app uses JWT tokens stored in httpOnly cookies.
Report any issues with severity ratings.
Run npm test -- --filter=auth to verify no regressions.
```

### Background vs Foreground Subagents

**Foreground**: Blocks main conversation until complete. Permission prompts pass through to you. Use for tasks where you need the result immediately.

**Background**: Run concurrently. Press Ctrl+B to background a running task. Auto denies anything not pre approved. If it fails due to missing permissions, resume in foreground to retry.

Rule: If a task takes >30 seconds, consider backgrounding it.

### Sources
- [Official Docs: Custom Subagents](https://code.claude.com/docs/en/sub-agents)
- [PubNub: Best Practices for Subagents](https://www.pubnub.com/blog/best-practices-for-claude-code-sub-agents/)
- [claudefa.st: Sub Agent Best Practices](https://claudefa.st/blog/guide/agents/sub-agent-best-practices)
- [Tim Dietrich: Parallel Subagents](https://timdietrich.me/blog/claude-code-parallel-subagents/)

---

## 6. Creating Specialized Agent Roles That Work Together

### The Three Tier Model Strategy (from wshobson/agents)

112 agents distributed across four capability tiers:

- **Tier 1 (Opus)**: 42 agents for critical work. Architecture decisions, security audits, comprehensive code review, production coding.
- **Tier 2 (Inherit)**: 42 agents for complex tasks where users choose models based on needs.
- **Tier 3 (Sonnet)**: 51 agents for documentation, testing, debugging, API work.
- **Tier 4 (Haiku)**: 18 agents for fast operational tasks. SEO optimization, deployment, content generation.

### Tool Allocation by Role

- **Read only agents** (reviewers, auditors): Read, Grep, Glob
- **Research agents** (analysts, researchers): Read, Grep, Glob, WebFetch, WebSearch
- **Documentation agents** (writers, documenters): Read, Write, Edit, Glob, Grep, WebFetch, WebSearch
- **Implementation agents** (builders, fixers): All tools
- **Database agents**: Bash with PreToolUse hooks validating read only SQL

### Specialized Role Examples

**Code Reviewer** (read only, Sonnet):
```yaml
---
name: code-reviewer
description: Expert code review specialist. Use proactively after code changes.
tools: Read, Grep, Glob, Bash
model: sonnet
---
```

**Debugger** (can modify, inherit model):
```yaml
---
name: debugger
description: Debugging specialist for errors and test failures. Use proactively when encountering issues.
tools: Read, Edit, Bash, Grep, Glob
---
```

**Security Auditor** (read only, Opus for critical analysis):
```yaml
---
name: security-auditor
description: Security vulnerability expert. Reviews code for XSS, injection, auth flaws.
tools: Read, Grep, Glob, Bash
model: opus
permissionMode: plan
---
```

### The Pipeline Pattern (PM to Architect to Implementer)

Three stage handoff with clear definitions of done:

1. **PM Spec Agent**: Reads enhancement request, writes working spec, asks clarifying questions, sets status READY_FOR_ARCH. DoD: acceptance criteria plus questions answered.

2. **Architect Review Agent**: Validates design against platform constraints, produces an Architecture Decision Record (ADR), sets status READY_FOR_BUILD. DoD: ADR plus guardrails documented.

3. **Implementer Tester Agent**: Implements code and tests, runs green, produces summary. DoD: code plus tests green plus summary.

### For SEO/Agency Work (OFM Specific)

Potential specialized roles for our workflow:

- **Technical SEO Auditor**: Read only, loads technical-seo and schema-markup skills, uses WebFetch/WebSearch for live page analysis
- **Content Analyzer**: Read only, loads content-optimization and aeo-ai-seo skills, evaluates E-E-A-T signals
- **Implementation Specialist**: Full tools, loads seo-dev-implementation and netsuite-seo skills, generates code handoffs
- **Competitor Researcher**: Read only, loads competitor-seo and keyword-research skills, uses WebSearch heavily
- **Report Generator**: Write capable, loads templates, produces .docx deliverables

### Sources
- [Official Docs: Custom Subagents](https://code.claude.com/docs/en/sub-agents)
- [wshobson/agents (GitHub)](https://github.com/wshobson/agents)
- [VoltAgent/awesome-claude-code-subagents (GitHub)](https://github.com/VoltAgent/awesome-claude-code-subagents)
- [everything-claude-code AGENTS.md](https://github.com/affaan-m/everything-claude-code/blob/main/AGENTS.md)

---

## 7. Best GitHub Repos for Advanced Claude Code Agent Architectures

### Production Frameworks

| Repo | Stars Focus | Key Feature |
|------|-------------|-------------|
| [Dicklesworthstone/claude_code_agent_farm](https://github.com/Dicklesworthstone/claude_code_agent_farm) | 20 to 50 parallel agents | tmux monitoring, lock based coordination, 34 tech stacks, cooperating agents workflow |
| [ruvnet/ruflo](https://github.com/ruvnet/ruflo) | Enterprise orchestration | RAG integration, distributed swarm intelligence, native Claude Code integration |
| [nwiizo/ccswarm](https://github.com/nwiizo/ccswarm) | Rust native orchestration | Git worktree isolation, Claude ACP integration, terminal UI |
| [Yeachan-Heo/oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) | Teams first orchestration | 32+ specialized agents, 40 skills, simplified swarm setup |
| [baryhuang/claude-code-by-agents](https://github.com/baryhuang/claude-code-by-agents) | Desktop app | Multi agent coordination via @mentions, local and remote agents |

### Resource Collections

| Repo | Content |
|------|---------|
| [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) | 127+ subagent definitions across 10 categories |
| [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | 500+ agent skills compatible with Claude Code, Codex, Cursor, and others |
| [wshobson/agents](https://github.com/wshobson/agents) | 112 agents, 16 orchestrators, 146 skills, 79 tools across 72 plugins |
| [avivl/claude-007-agents](https://github.com/avivl/claude-007-agents) | Specialized agents across 14 categories with resilience engineering |
| [anthropics/skills](https://github.com/anthropics/skills) | Official Anthropic public skills repository |

### Reference Guides

| Repo | Content |
|------|---------|
| [FlorianBruniaux/claude-code-ultimate-guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide) | Comprehensive Claude Code guide including multi agent orchestration |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | AGENTS.md with detailed agent definitions and patterns |
| [Kieran Klaassen Gist: Swarm Orchestration](https://gist.github.com/kieranklaassen/4f2aba89594a4aea4ad64d753984b2ea) | Complete swarm skill with all 13 TeammateTool operations |
| [Kieran Klaassen Gist: Multi Agent Orchestration](https://gist.github.com/kieranklaassen/d2b35569be2c7f1412c64861a219d51f) | Orchestration system definition |

### Notable: claude_code_agent_farm Deep Dive

This is the most sophisticated open source parallel agent framework found. Key details:

**Three Workflow Types:**
1. **Bug Fixing**: Agents work through type checker and linter problems in parallel. Generates problem files, selects random chunks, marks completed items.
2. **Best Practices**: Systematic modernization with progress tracking and continuation across sessions.
3. **Cooperating Agents** (most advanced): Distributed coordination protocol with:
   - `/coordination/active_work_registry.json` for all ongoing work
   - `/coordination/completed_work_log.json` for history
   - `/coordination/agent_locks/` for file level locks
   - `/coordination/planned_work_queue.json` for unstarted work
   - Each agent generates unique ID: `agent_{timestamp}_{random_4_chars}`
   - Stale lock detection (2+ hours)

**Monitoring**: Real time tmux dashboard with context warnings, heartbeat tracking, JSON state files for external monitoring.

**Scale**: 34 pre configured technology stacks. Up to 50 concurrent agents with `max_agents` config.

---

## 8. Community Discussions and Practitioner Insights

### Key Findings from Developer Blogs and Community Posts

**Addy Osmani (Google Chrome team)** wrote one of the most referenced articles on agent teams. Key takeaway: "The strongest use cases are research and review, new modules, debugging with competing hypotheses, and cross layer coordination." He emphasizes starting with research tasks before attempting parallel implementation.

**Alex Op** ran a practical QA swarm against his blog: 5 parallel Sonnet agents, 5 different test domains, ~3 minutes end to end, 10 prioritized issues found. His cost analysis: solo session ~200k tokens, 3 subagents ~440k tokens, 3 person team ~800k tokens.

**Boris Cherny (Anthropic)** announced agent teams on Threads, calling it a research preview where "a lead agent can delegate to multiple teammates that work in parallel to research, debug, and build while coordinating with each other." He also announced built in git worktree support for agent isolation.

**Daniel Avila** documented practical experience noting that "teammates typically spawn within 20 to 30 seconds and begin producing results within the first minute."

**Perrotta.dev** noted the critical importance of delegate mode (Shift+Tab) for preventing the lead from grabbing tasks that teammates should handle.

**Joe Njenga (Medium)** tested Oh My Claude Code, calling it "the only agents swarm orchestration you need" with 32 specialized agents and 40 skills. Also discovered a new approach to swarming using native agent teams.

### Common Pitfalls Reported by Practitioners

1. **Lead implementing instead of delegating**: Without delegate mode, the lead grabs tasks. Use Shift+Tab immediately.
2. **Vague spawn prompts**: Most failures are delegation failures, not execution failures. Be specific.
3. **Over parallelizing**: 10 agents for a simple feature wastes tokens. Match team size to task complexity.
4. **File conflicts**: Two teammates editing the same file causes overwrites. Define clear ownership boundaries.
5. **Not waiting for teammates**: The lead sometimes starts implementing before teammates finish. Tell it to wait.
6. **Ignoring task dependencies**: Tasks without explicit dependencies run in parallel and may produce conflicting results.
7. **Cost blindness**: Each teammate is a full Claude instance. Monitor token usage.

### Sources
- [Addy Osmani Blog](https://addyosmani.com/blog/claude-code-agent-teams/)
- [alexop.dev](https://alexop.dev/posts/from-tasks-to-swarms-agent-teams-in-claude-code/)
- [Threads: Boris Cherny Announcement](https://www.threads.com/@boris_cherny/post/DUYr3wwkxHH/)
- [Daniel Avila (Medium)](https://medium.com/@dan.avila7/agent-teams-in-claude-code-d6bb90b3333b)
- [perrotta.dev](https://perrotta.dev/2026/02/claude-code-swarm-mode-agent-teams/)
- [Joe Njenga (Medium)](https://medium.com/@joe.njenga/i-tested-oh-my-claude-code-the-only-agents-swarm-orchestration-you-need-7338ad92c00f)

---

## 9. YouTube and Tutorial Resources

While specific YouTube URLs were not surfaced in search results, the following tutorial resources were found:

- [NxCode: Claude Opus 4.6 Agent Teams Setup Tutorial (2026)](https://www.nxcode.io/resources/news/claude-agent-teams-parallel-ai-development-guide-2026)
- [claudefa.st: The Complete Guide 2026](https://claudefa.st/blog/guide/agents/agent-teams)
- [marc0.dev: Setup Guide](https://www.marc0.dev/en/blog/claude-code-agent-teams-multiple-ai-agents-working-in-parallel-setup-guide-1770317684454)
- [Serenitiesai: Setup Guide 2026](https://serenitiesai.com/articles/claude-code-agent-teams-documentation)
- [Turing College: Agent Teams Explained](https://www.turingcollege.com/blog/claude-agent-teams-explained)
- [DataCamp: Claude Agent SDK Tutorial](https://www.datacamp.com/tutorial/how-to-use-claude-agent-sdk)
- [Nader Dabit: Complete Guide to Building Agents](https://nader.substack.com/p/the-complete-guide-to-building-agents)

---

## 10. New Agent Related Features from Anthropic (2025 to 2026)

### Timeline of Major Agent Features

**October 2025**: Agent Skills launched (skills-2025-10-02 beta). Organized folders of instructions, scripts, and resources that Claude loads dynamically.

**Late 2025**: Checkpoints added. Save progress and allow instant rollback to previous state (one of the most requested features).

**Early 2026**: Claude Agent SDK renamed from Claude Code SDK. Available in TypeScript and Python.

**February 2026**: Agent Teams (swarm mode) shipped as research preview alongside Claude Opus 4.6 and Sonnet 5.

**February 2026**: Built in git worktree support. `--worktree` flag for agent isolation. Each agent gets its own worktree at `<repo>/.claude/worktrees/<n>`.

**February 2026**: GitHub Agent HQ launched. Claude Code and OpenAI Codex available alongside Copilot for Pro+ and Enterprise subscribers.

**February 2026**: Subagent persistent memory. `memory` field in subagent frontmatter for cross session learning.

**February 2026**: Plugin marketplace and distribution system.

**March 2026 (v2.1.69)**: Claude API skill, agent naming in terminal titles, agent_id/agent_type in hook events, InstructionsLoaded hook, worktree fields in status line hooks.

**March 2026 (v2.1.70)**: VS Code session management, MCP server management dialog.

**March 2026**: Multi agent memory improvements. Released completed subagent task state for better memory management.

**March 2026**: Subagent `isolation: worktree` field in frontmatter. Auto cleanup when no changes made.

**March 2026**: Background subagent improvements. Ctrl+B to background, auto permission handling.

### Key Environment Variables for Agent Features

```
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1     # Enable agent teams
CLAUDE_CODE_SUBAGENT_MODEL=<model-id>      # Set default subagent model
CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1     # Disable background tasks
CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50         # Trigger compaction earlier
```

### Sources
- [ReleaseBot: Claude Code Release Notes](https://releasebot.io/updates/anthropic/claude-code)
- [Claude Developer Platform Release Notes](https://platform.claude.com/docs/en/release-notes/overview)
- [Threads: Boris Cherny on Worktrees](https://www.threads.com/@boris_cherny/post/DVAAnexgRUj/)
- [GitHub Blog: Agent HQ](https://github.blog/news-insights/company-news/pick-your-agent-use-claude-and-codex-on-agent-hq/)

---

## Implications for OFM Agent Architecture

Based on this research, the following upgrades to our orchestration model should be considered:

### Immediate Opportunities

1. **Define specialized subagents** in `.claude/agents/` for our core workflows: technical-seo-auditor, content-analyzer, competitor-researcher, implementation-specialist, report-generator

2. **Enable agent teams** for multi faceted client audits: spawn parallel specialists for technical SEO, content quality, schema validation, and performance analysis

3. **Implement persistent memory** on key subagents so they build knowledge across client sessions

4. **Use model tiering**: Opus for lead/planning, Sonnet for implementation agents, Haiku for exploration

5. **Create quality gate hooks**: TaskCompleted hooks that enforce audit checklist completion before marking done

### Architecture Alignment

Our existing 9 agent files in `agents/` align well with the subagent pattern. They could be enhanced with:
- YAML frontmatter for automatic delegation triggers
- Tool restrictions appropriate to each role
- Model routing for cost optimization
- Skills preloading for domain expertise
- Persistent memory for cross session learning

### Cost Management

For typical client audit work:
- Solo session: Adequate for single page analysis
- 3 subagents: Ideal for parallel module research (technical + content + competitive)
- 5 person team: Full site audit with cross domain coordination

Estimated token multiplier: 3 to 4x for team based audit versus sequential solo session, offset by significant time savings and more thorough coverage.
