---
name: agent-orchestration
description: "Complete guide to multi agent orchestration in Claude Code. Use when planning parallel agent work, delegating to subagents, or running agent teams. Trigger on: swarm mode, agent teams, subagent, delegation, parallel agents, teammate, orchestration."
allowed-tools: Read, Grep, Glob
user-invocable: false
---

# Claude Code Agent Orchestration Guide

## Architecture Overview

Claude Code supports three tiers of agent orchestration, each with different tradeoffs on autonomy, cost, and coordination complexity.

### Tier 1: Single Session (Direct Work)
One Claude Code instance handles everything sequentially. Best for small tasks, same file edits, or work with heavy interdependencies. Lowest token cost.

### Tier 2: Subagents (Delegated Workers)
Specialized agents spawned within a single session. Each runs in its own context window with a custom system prompt, specific tool access, and independent permissions. Results return to the parent session. Subagents cannot talk to each other or spawn their own subagents.

### Tier 3: Agent Teams (Swarm Mode)
Multiple independent Claude Code sessions coordinated through a shared task list and direct messaging system. A team lead orchestrates, teammates communicate peer to peer, and tasks self coordinate through dependency chains.

## When to Use Each Tier

| Scenario | Best Approach |
|----------|--------------|
| Quick single file edit | Single session |
| Running tests and reporting results | Subagent (isolates verbose output) |
| Parallel research on independent topics | Subagents (3 to 5) |
| Cross layer feature (frontend + backend + tests) | Agent team |
| Debugging with competing hypotheses | Agent team (adversarial debate) |
| Code review from multiple angles | Agent team (security + performance + coverage) |
| Sequential pipeline (research then plan then implement) | Chained subagents |
| Tasks requiring inter agent discussion | Agent team |

## Subagent Configuration

### File Structure
Subagent definitions are Markdown files with YAML frontmatter stored at:
- `.claude/agents/` for project scope (priority 2)
- `~/.claude/agents/` for user scope (priority 3)
- Plugin `agents/` directory (priority 4)
- `--agents` CLI flag for session scope (priority 1, highest)

### Frontmatter Fields

```yaml
---
name: seo-auditor
description: Reviews pages for technical SEO issues. Use proactively after any content or template changes.
tools: Read, Grep, Glob, Bash, WebFetch, WebSearch
disallowedTools: Write, Edit
model: sonnet
permissionMode: default
maxTurns: 20
skills:
  - technical-seo
  - schema-markup
memory: project
background: false
isolation: worktree
---
```

Key fields:
- **name**: Unique identifier, lowercase with hyphens
- **description**: Tells Claude when to delegate (include "use proactively" for automatic delegation)
- **tools**: Allowlist of available tools (inherits all if omitted)
- **disallowedTools**: Denylist removed from inherited or specified list
- **model**: `sonnet`, `opus`, `haiku`, or `inherit`
- **permissionMode**: `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, or `plan`
- **maxTurns**: Maximum agentic turns before stopping
- **skills**: Skills injected into subagent context at startup (does not inherit parent skills)
- **memory**: Persistent memory scope: `user`, `project`, or `local`
- **background**: Set true to run concurrently while main session continues
- **isolation**: Set to `worktree` for git worktree isolation

### Built In Subagents

| Agent | Model | Tools | Purpose |
|-------|-------|-------|---------|
| Explore | Haiku | Read only | Fast codebase search and analysis |
| Plan | Inherit | Read only | Research for plan mode |
| general-purpose | Inherit | All | Complex multi step tasks |
| Bash | Inherit | Bash | Terminal command execution |
| Claude Code Guide | Haiku | Read only | Questions about Claude Code features |

### Model Routing for Cost Optimization

Run the lead session or main conversation on Opus for complex reasoning. Route subagents to Sonnet for focused execution tasks. Use Haiku for fast read only exploration.

Set the subagent model globally: `CLAUDE_CODE_SUBAGENT_MODEL="claude-sonnet-4-5-20250929"`

### Subagent Persistent Memory

When `memory` is set, the subagent gets a persistent directory that survives across conversations:
- `user` scope: `~/.claude/agent-memory/<name>/`
- `project` scope: `.claude/agent-memory/<name>/`
- `local` scope: `.claude/agent-memory-local/<name>/`

The subagent auto loads the first 200 lines of MEMORY.md from its memory directory. Include instructions in the agent prompt to read memory before starting work and update memory after completing work.

### Subagent Invocation Patterns

**Parallel dispatch**: When 3+ unrelated tasks exist with no shared state and clear file boundaries.

```text
Research the authentication, database, and API modules in parallel using separate subagents
```

**Sequential chaining**: When tasks have dependencies or shared state.

```text
Use the code-reviewer subagent to find performance issues, then use the optimizer subagent to fix them
```

**Background dispatch**: For research or analysis that does not block current work. Press Ctrl+B to background a running task.

**Isolate verbose output**: Delegate test runs, log processing, or documentation fetches to subagents so only the summary returns to your main context.

### Critical Invocation Principle

Most subagent failures come from poor delegation, not execution failures. Always provide:
- Specific scope and file references
- Clear success criteria
- Relevant context the subagent cannot discover on its own

Bad: "Fix authentication"
Good: "Fix OAuth redirect loop where successful login redirects to /login instead of /dashboard. Reference auth middleware in src/lib/auth.ts. Verify fix by running npm test -- --filter=auth."

## Agent Teams (Swarm Mode)

### Enabling Agent Teams

Add to settings.json:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

### Architecture Components

| Component | Role |
|-----------|------|
| Team lead | Main session that creates the team, spawns teammates, coordinates work |
| Teammates | Separate Claude Code instances working on assigned tasks |
| Task list | Shared work items with dependency tracking and auto unblocking |
| Mailbox | Direct messaging system between any agents |

Team state is stored locally:
- Team config: `~/.claude/teams/{team-name}/config.json`
- Task list: `~/.claude/tasks/{team-name}/`

### TeammateTool Operations (13 Functions)

**Team Management**: spawnTeam, discoverTeams, cleanup
**Membership Control**: requestJoin, approveJoin, rejectJoin
**Communication**: write (targeted message), broadcast (all teammates)
**Lifecycle**: requestShutdown, approveShutdown, rejectShutdown
**Quality**: approvePlan, rejectPlan

### Starting a Team

Tell Claude what team you want in natural language:

```text
Create an agent team to review PR #142. Spawn three reviewers:
- One focused on security implications
- One checking performance impact
- One validating test coverage
Have them each review and report findings.
```

Claude creates the team, spawns teammates, coordinates work, and synthesizes findings.

### Display Modes

**In process mode** (default): All teammates in main terminal. Shift+Down to cycle between teammates. Enter to view a session. Escape to interrupt. Ctrl+T to toggle task list. Works in any terminal.

**Split pane mode**: Each teammate gets its own pane. Requires tmux or iTerm2. Not supported in VS Code terminal, Windows Terminal, or Ghostty.

```json
{
  "teammateMode": "tmux"
}
```

### Delegate Mode

Press Shift+Tab to enable delegate mode. Restricts the lead to coordination only. The lead cannot write code, run tests, or do implementation. It can only manage tasks, communicate, and review output. Essential for 4+ teammate sessions to prevent the lead from competing with its own workers.

### Plan Approval Workflow

Require teammates to plan before implementing:

```text
Spawn an architect teammate to refactor the authentication module.
Require plan approval before they make any changes.
```

The teammate works in read only plan mode until the lead approves. If rejected, the teammate revises and resubmits. Influence the lead's judgment with criteria: "only approve plans that include test coverage."

### Quality Gates with Hooks

Two team specific hook events:

**TeammateIdle**: Fires when a teammate is about to idle. Exit code 2 sends feedback and keeps the teammate working. Use to assign follow up tasks or redirect early finishers.

**TaskCompleted**: Fires when a task is being marked complete. Exit code 2 prevents completion and sends feedback. Use to enforce test passage, lint checks, or acceptance criteria.

### Task Management

Tasks flow through three states: pending, in_progress, completed. Dependencies auto unblock when blocking tasks complete. File locking prevents race conditions on simultaneous claims.

Wave based execution:
- Wave 1: Independent parallel tasks
- Wave 2: Tasks depending on Wave 1
- Wave 3+: Downstream work

### Context and Communication

Teammates load CLAUDE.md, MCP servers, and skills automatically. They do NOT inherit the lead's conversation history. Whatever context they need, the lead must provide in the spawn prompt.

Communication methods:
- **write**: Send to one specific teammate
- **broadcast**: Send to all (use sparingly, costs scale with team size)
- Messages are delivered automatically, no polling needed
- Idle notifications auto sent when teammates finish

### Optimal Team Sizing

Start with 3 to 5 teammates for most workflows. Aim for 5 to 6 tasks per teammate. Three focused teammates often outperform five scattered ones. Scale up only when work genuinely benefits from additional parallelism.

### Cost Analysis

| Approach | Approximate Token Multiplier | Best For |
|----------|------------------------------|----------|
| Solo session | 1x | Direct control, small tasks |
| 3 subagents | 2 to 2.5x | Focused parallel research |
| 3 person team | 3 to 4x | Cross layer features needing coordination |

Reserve Opus for the lead. Use Sonnet for teammates. Prefer targeted messages over broadcasts.

### Known Limitations

- No session resumption with in process teammates (/resume and /rewind do not restore them)
- Task status can lag (teammates sometimes forget to mark tasks complete)
- Shutdown can be slow (teammates finish current request before stopping)
- One team per session (clean up before starting a new one)
- No nested teams (teammates cannot spawn their own teams)
- Lead is fixed for the session lifetime
- All teammates inherit the lead's permission mode at spawn
- Split panes not supported on Windows Terminal

## Git Worktree Isolation

Use `--worktree` or `-w` flag to create isolated working directories for parallel sessions:

```bash
claude --worktree
```

Worktrees are created at `<repo>/.claude/worktrees/<n>` branching from the default remote branch. Subagents can use worktree isolation via `isolation: worktree` in their frontmatter. Worktrees are automatically cleaned up if the subagent makes no changes.

For agent teams, each teammate can work in its own worktree to prevent file conflicts when multiple agents need to modify code in overlapping areas.

## Orchestration Patterns

### Pattern 1: Plan First, Then Execute

1. Use plan mode to explore the codebase and create a task breakdown (~10k tokens)
2. Review and adjust the plan with human approval
3. Execute the plan as an agent team with explicit dependency chains

This prevents expensive mid swarm course corrections. The plan becomes the task descriptions teammates read.

### Pattern 2: Parallel Specialists

Spawn multiple reviewers analyzing from different angles simultaneously:
- Security reviewer
- Performance reviewer
- Test coverage reviewer
- Accessibility reviewer

Each applies a different filter to the same codebase. The lead synthesizes findings.

### Pattern 3: Competing Hypotheses

For debugging with unclear root causes:

```text
Spawn 5 agent teammates to investigate different hypotheses about why users report the app exits after one message. Have them talk to each other to try to disprove each other's theories, like a scientific debate.
```

Adversarial debate avoids anchoring bias that sequential investigation suffers from.

### Pattern 4: Sequential Pipeline

Tasks unblock automatically as dependencies complete:
Research -> Plan -> Implement -> Test -> Deploy

Each stage has clear deliverables that feed the next.

### Pattern 5: Domain Based Routing

Split work by architectural domain:
- Frontend agent: React/UI components
- Backend agent: APIs and server logic
- Database agent: Schema and migrations
- Test agent: Test coverage

Each owns its domain to prevent file conflicts.

### Pattern 6: QA Swarm

Run 3 to 5 parallel agents each testing a different domain:
- Core pages and navigation
- Content and blog posts
- Link integrity
- SEO metadata validation
- Accessibility compliance

Results synthesized into a prioritized issue list in about 3 minutes.

## CLAUDE.md Optimization for Teams

Three critical additions maximize team efficiency:

1. **Module Boundaries**: Document independent modules in a table so Claude splits work without conflicts.

2. **Short Operational Context**: Include stack, entry points, test commands, and verification steps. Avoid exploratory filler.

3. **Verification Commands**: List how to check that work succeeds (e.g., `npm test`, `npm run lint`, `npm run build`) so teammates self verify before reporting.

## Advanced Techniques

### Hooks for Subagent Lifecycle

Configure in settings.json:

```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "seo-auditor",
        "hooks": [
          { "type": "command", "command": "./scripts/setup-audit.sh" }
        ]
      }
    ],
    "SubagentStop": [
      {
        "hooks": [
          { "type": "command", "command": "./scripts/cleanup.sh" }
        ]
      }
    ]
  }
}
```

### Restricting Subagent Spawning

Control which subagents an agent can spawn using `Agent(type)` syntax:

```yaml
tools: Agent(worker, researcher), Read, Bash
```

This is an allowlist. Omitting `Agent` entirely prevents spawning any subagents.

### Plugin Distribution

Package subagents, skills, and hooks as plugins for team distribution:
- Plugins go in a Git repo with `plugin.json` at root
- Install via plugin marketplace or direct URL
- Plugins include agents/, skills/, rules/, and hooks
- Each plugin averages 3.4 components following Anthropic's 2 to 8 pattern

## Notable Open Source Projects

### Production Frameworks
- **claude_code_agent_farm** (Dicklesworthstone): 20 to 50 parallel agents with tmux monitoring, lock based coordination, 34 tech stack configs
- **ruflo** (ruvnet): Enterprise grade swarm orchestration with RAG integration
- **ccswarm** (nwiizo): Rust native with Claude ACP integration and git worktree isolation
- **oh-my-claudecode** (Yeachan-Heo): Teams first orchestration, 32+ specialized agents

### Resource Collections
- **awesome-claude-code-subagents** (VoltAgent): 127+ subagent definitions across 10 categories
- **awesome-agent-skills** (VoltAgent): 500+ agent skills compatible with Claude Code and other tools
- **agents** (wshobson): 112 agents, 16 orchestrators, 146 skills, 79 tools across 72 plugins
- **claude-007-agents** (avivl): Specialized agents across 14 categories

## Claude Agent SDK

The Claude Agent SDK (formerly Claude Code SDK, renamed September 2025) is the runtime that powers Claude Code, available as:
- TypeScript: `@anthropic-ai/claude-agent-sdk`
- Python: `claude-agent-sdk`

### Core Loop
1. Gather context (agentic search via bash utilities, file system exploration)
2. Take action (tools, bash, code generation, MCP)
3. Verify work (rules based feedback, visual feedback, LLM as judge)
4. Iterate (refine based on verification)

### Key Capabilities
- **Built in tools**: File ops, command execution, web search, code editing
- **Context compaction**: Auto summarizes conversation history near limits, enabling 30+ hour sustained operation
- **Subagent support**: Parallel execution with isolated context windows
- **MCP integration**: Standardized connections to external services
- **Permissions system**: Fine grained control over agent capabilities
- **Session management**: Persistent sessions with checkpoint and rollback

### Building Custom Agents

```python
from claude_agent_sdk import Agent

agent = Agent(
    model="claude-sonnet-4-5",
    tools=["Read", "Write", "Bash"],
    system_prompt="You are an SEO technical auditor..."
)

async for message in agent.query("Audit the sitemap at example.com/sitemap.xml"):
    print(message)
```

The SDK exposes a `query()` function returning an async generator that yields typed messages as the agent works. Use this for CI/CD automation, headless audits, and custom agentic workflows.
