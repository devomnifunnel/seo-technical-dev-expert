# Anthropic Ecosystem Research: March 2026

Last updated: 2026-03-05
Researched by: Claude (SEO & Technical Dev Expert)

---

## 1. Current Claude Models

### Latest Generation (4.6 Series, February 2026)

| Model | API ID | Input/Output Pricing | Context Window | Max Output | Training Data Cutoff |
|-------|--------|---------------------|----------------|------------|---------------------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5/$25 per MTok | 200K (1M beta) | 128K tokens | Aug 2025 |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3/$15 per MTok | 200K (1M beta) | 64K tokens | Jan 2026 |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1/$5 per MTok | 200K | 64K tokens | Jul 2025 |

**Key benchmarks:**
- Opus 4.6: 80.8% SWE-bench Verified, 72.7% OSWorld, highest score on Terminal-Bench 2.0 and Humanity's Last Exam
- Sonnet 4.6: 79.6% SWE-bench Verified, 72.5% OSWorld, 58.3% ARC-AGI-2 (4.3x improvement over prior gen)
- Opus 4.6 scored 76% on 8-needle MRCR v2 (1M context), versus 18.5% for Sonnet 4.5

**Notable:** Sonnet 4.6 is the first Sonnet model preferred over the previous generation's Opus in coding evaluations. Opus 4.6 is the first Opus class model with 1M token context support.

### Legacy Models Still Available

| Model | API ID | Pricing | Context | Max Output |
|-------|--------|---------|---------|------------|
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3/$15 per MTok | 200K (1M beta) | 64K |
| Claude Opus 4.5 | `claude-opus-4-5` | $5/$25 per MTok | 200K | 64K |
| Claude Opus 4.1 | `claude-opus-4-1` | $15/$75 per MTok | 200K | 32K |
| Claude Sonnet 4 | `claude-sonnet-4-0` | $3/$15 per MTok | 200K (1M beta) | 64K |
| Claude Opus 4 | `claude-opus-4-0` | $15/$75 per MTok | 200K | 32K |

**Deprecation notice:** Claude Haiku 3 (`claude-3-haiku-20240307`) is deprecated and will be retired April 19, 2026.

### Cloud Platform IDs

- AWS Bedrock: `anthropic.claude-opus-4-6-v1`, `anthropic.claude-sonnet-4-6`
- GCP Vertex AI: `claude-opus-4-6`, `claude-sonnet-4-6`

---

## 2. Claude Code: Latest Features and Changelog

### Major 2026 Additions

**Agent Teams (Swarm Mode):**
- Officially launched alongside Opus 4.6 in February 2026
- Enable with `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`
- Lead agent coordinates multiple specialized teammates working in parallel
- TeammateTool provides 13 distinct operations for managing agents
- Unlike subagents (which run within a single session), teammates work in their own context windows and can communicate directly with each other
- Token heavy: every teammate is a full Claude Code session
- Known limitations: no session resumption, no nested teams

**Claude Code Security (February 20, 2026):**
- Limited research preview for Enterprise and Team customers
- Scans codebases for security vulnerabilities, suggests patches for human review
- Opus 4.6 found 500+ high severity zero-day vulnerabilities in production open source software
- Human in the loop approach: nothing applied without approval

**Other Recent Features:**
- "Summarize from here" for partial conversation summarization
- `/simplify` and `/batch` bundled slash commands
- `/copy` command with interactive picker for code blocks
- HTTP hooks that can POST JSON to a URL and receive JSON instead of running a shell command
- Project configs and auto memory now shared across git worktrees
- `isolation: worktree` in agent definitions for isolated git worktrees
- Remote control subcommand for external builds
- Plugin marketplace with npm registry support

**Default Effort Setting:**
- Opus 4.6 now defaults to medium effort for Max and Team subscribers
- "ultrathink" keyword re-introduced to enable high effort for the next turn

---

## 3. Extended Thinking / Adaptive Thinking

### The Shift: Adaptive Thinking Replaces Manual Budget

For Opus 4.6 and Sonnet 4.6, Anthropic now recommends **adaptive thinking** over manual `budget_tokens`. The old `thinking.type: "enabled"` with `budget_tokens` is **deprecated** on these models (still works but will be removed).

### Adaptive Thinking Configuration

```json
{
  "thinking": { "type": "adaptive" },
  "output_config": { "effort": "medium" }
}
```

**Effort Levels:**

| Level | Behavior | Availability |
|-------|----------|-------------|
| `max` | Always thinks, no constraints on depth | Opus 4.6 only |
| `high` (default) | Always thinks, deep reasoning | Opus 4.6, Sonnet 4.6 |
| `medium` | Moderate thinking, may skip for simple queries | Opus 4.6, Sonnet 4.6 |
| `low` | Minimizes thinking, skips for simple tasks | Opus 4.6, Sonnet 4.6 |

### Key Changes from Previous Approach

- **Interleaved thinking** is automatically enabled with adaptive mode, meaning Claude can think between tool calls (critical for agentic workflows)
- Manual mode on Opus 4.6 does NOT support interleaved thinking; you must use adaptive mode
- Thinking tokens are billed as output tokens at the standard rate
- Summarized thinking: Claude 4 models return summaries of thinking (not full chain), billed at full token count
- Use `max_tokens` as hard limit on total output (thinking + response)

### Implications for Our Setup

Our `MAX_THINKING_TOKENS=63999` global setting was designed for the old manual `budget_tokens` approach. For Opus 4.6 and Sonnet 4.6, this should be replaced with adaptive thinking using the effort parameter. The old setting still works but is deprecated.

**Recommendation:** Switch to `thinking.type: "adaptive"` with `effort: "high"` as default, using `effort: "max"` (Opus only) for complex research/audit tasks.

---

## 4. Tool Use Improvements

### Now Generally Available (No Beta Header)
- **Web Search Tool**: Claude can search the web directly
- **Programmatic Tool Calling**: Code execution step for complex tool outputs, improving token efficiency
- **Web Search/Fetch Dynamic Filtering**: Uses code execution to filter results before they reach context window

### Advanced Tool Use Features (November 2025)
- **Tool Search Tool**: Dynamic tool discovery instead of loading all definitions upfront. 85% reduction in token usage (191,300 vs 122,800 tokens) while maintaining full tool library access
- **Agent Skills**: Organized folders of instructions, scripts, and resources that Claude loads dynamically

### Updated Computer Use Commands
New options: `hold_key`, `left_mouse_down`, `left_mouse_up`, `scroll`, `triple_click`, `wait`

---

## 5. MCP Protocol Updates

### November 2025 Specification (2025-11-25)
Major expansion beyond synchronous tool calling:
- **Tasks Primitive**: Asynchronous, long running operations with progress updates and result delivery
- **OAuth 2.1 Authorization**: Protected Resource Metadata discovery, OpenID Connect support
- **Enterprise features**: Secure, governed workflows for production environments

### June 2025 Specification (2025-06-18)
- Structured tool outputs
- OAuth based authorization
- Elicitation for server initiated user interactions
- MCP servers classified as OAuth Resource Servers
- Clients required to implement Resource Indicators (RFC 8707)

### Governance
- December 2025: Anthropic donated MCP to the **Agentic AI Foundation (AAIF)**, a Linux Foundation directed fund co-founded by Anthropic, Block, and OpenAI
- Formal governance model established with Specification Enhancement Proposal (SEP) process

### Future Focus Areas
1. Asynchronous operations for long running tasks
2. Stateless implementation for enterprise scalability
3. Server discovery mechanisms
4. Protocol extensions for specialized industries
5. Transport optimization for production deployments

---

## 6. Claude Plans and Pricing

### Consumer/Business Plans

| Plan | Price | Claude Code Access | Key Limits |
|------|-------|-------------------|------------|
| Free | $0 | No | Basic access |
| Pro | $20/mo ($17/mo annual) | Yes | 5x Free capacity |
| Max 5x | $100/mo | Yes (full) | 25x Free capacity, maximum priority |
| Max 20x | $200/mo | Yes (full) | 100x Free capacity, zero-latency priority |
| Team Standard | $25/user/mo ($20 annual) | Yes | 25,000 Pro-equivalent messages/seat/week, min 5 users |
| Team Premium | $150/user/mo ($100 annual) | Yes | Higher quotas, min 5 users |

### Claude Code Specifics
- Pro subscribers can select Opus 4.6
- Max subscribers get full Opus 4.6 access with Agent Teams
- Opus 4.6 defaults to medium effort for Max and Team (cost/speed balance)
- "ultrathink" keyword triggers high effort per turn

---

## 7. New Anthropic Products

### Claude Cowork (January 2026)
Brings Claude Code's engineering capabilities to broader knowledge work. Key features:
- **11 open source plugins** at launch for sales, legal, finance, HR, design, engineering, operations
- **Private plugin marketplaces** for enterprise admins (February 24 update)
- Per-user provisioning and auto-install for team-specific plugins
- Cross-app workflows between Excel and PowerPoint

### Department Specific Plugins
HR, design, engineering, operations, financial analysis, investment banking, equity research, private equity, wealth management

### New MCP Connectors (12 total)
Google Calendar, Google Drive, Gmail, DocuSign, Apollo, Clay, Outreach, Similarweb, MSCI, LegalZoom, FactSet, WordPress, Harvey

### Claude Apps (January 26, 2026)
Interactive apps within Claude for Slack, Figma, Asana, Hex, Box, and more. Users can:
- Draft Slack messages
- Generate Figma diagrams
- Update Asana project timelines
- Analyze data in Hex
- Access cloud files from Box

### Claude Code Security (February 20, 2026)
- AI powered vulnerability scanning
- Found 500+ zero-day vulnerabilities in open source code
- Enterprise and Team customers only (research preview)

### Claude for Enterprise
- Now available under HIPAA for healthcare organizations
- Accenture partnership: 30,000 professionals receiving training

### Funding
- Series G: $30 billion raised at $380 billion post-money valuation

---

## 8. Computer Use / Browser Automation

### Claude in Chrome
- **August 2025**: Launched as research preview (1,000 testers)
- **November 2025**: Expanded to all Max subscribers
- **December 2025**: Available in beta on all paid plans (Pro+)

### Capabilities
- Navigate websites, read screen content, click buttons, fill forms
- Manage multiple tabs, complete multi-step workflows
- Browser actions run in a visible Chrome window in real time
- Integrates with Claude Code CLI and VS Code extension

### Security Improvements
- Safety mitigations reduced attack success rate from 23.6% to 11.2%
- Browser-specific attacks reduced from 35.7% to 0%

### Vercept Acquisition
Anthropic acquired Vercept (perception and interaction startup) to enhance computer use capabilities

### Three-Part Automation Ecosystem
1. Claude in Chrome (browser automation)
2. Claude Cowork (desktop file management)
3. Claude Code (developer workflows)

---

## 9. Context Window Sizes

### Current Limits

| Model | Default | Extended (Beta) | How to Enable |
|-------|---------|----------------|---------------|
| Opus 4.6 | 200K tokens | 1M tokens | `context-1m-2025-08-07` beta header |
| Sonnet 4.6 | 200K tokens | 1M tokens | `context-1m-2025-08-07` beta header |
| Sonnet 4.5 | 200K tokens | 1M tokens | `context-1m-2025-08-07` beta header |
| Sonnet 4 | 200K tokens | 1M tokens | `context-1m-2025-08-07` beta header |
| Haiku 4.5 | 200K tokens | N/A | N/A |

### Long Context Pricing
Requests exceeding 200K tokens incur premium pricing: $10/$37.50 per MTok (input/output) for Opus 4.6

### Context Compaction
Automatically summarizes and replaces older context when approaching a configurable threshold, enabling longer tasks without hitting limits

---

## 10. Prompt Caching and Performance

### Cost Savings
- Up to 90% cost reduction and 85% latency reduction for long prompts
- Example: 100K token book response time dropped from 11.5s to 2.4s

### Cache Duration Options

| TTL | Write Cost | Read Cost |
|-----|-----------|-----------|
| 5 minutes (default) | 1.25x base input price | 0.1x base input price |
| 1 hour | 2x base input price | 0.1x base input price |

### Configuration
Set `"ttl": "1h"` within the `cache_control` object for extended caching.

### Recent Change (February 5, 2026)
Prompt caching now uses **workspace-level isolation** instead of organization-level isolation.

### Interaction with Adaptive Thinking
Consecutive requests using the same adaptive thinking mode preserve cache breakpoints. Switching between `adaptive` and `enabled`/`disabled` modes breaks cache breakpoints for messages (system prompts and tool definitions remain cached).

---

## 11. Claude Agent SDK

### Timeline
- **May 22, 2025**: Launched as "Claude Code SDK" alongside Opus 4 and Sonnet 4
- **September 29, 2025**: Renamed to "Claude Agent SDK" alongside Sonnet 4.5
- **December 2025**: Skills published as open standard at agentskills.io

### What It Is
An open source, production grade framework that exposes the same infrastructure powering Claude Code as a programmable library. Available in **Python** (`pip install claude-agent-sdk`) and **TypeScript** (`npm install @anthropic-ai/claude-agent-sdk`).

### How It Differs from Claude Code

| Use Case | Best Choice |
|----------|-------------|
| Interactive development | Claude Code CLI |
| CI/CD pipelines | Agent SDK |
| Custom applications | Agent SDK |
| One off tasks | Claude Code CLI |
| Production automation | Agent SDK |

### Key Capabilities
- **Built-in tools**: Read, Write, Edit, Bash, Glob, Grep, WebSearch, WebFetch, AskUserQuestion
- **Hooks**: PreToolUse, PostToolUse, Stop, SessionStart, SessionEnd, UserPromptSubmit
- **Subagents**: Spawn specialized agents for focused subtasks
- **MCP integration**: Connect to external systems (databases, browsers, APIs)
- **Permissions**: Granular tool access control
- **Sessions**: Maintain context across multiple exchanges, resume/fork sessions
- **Skills, slash commands, memory**: Same filesystem-based configuration as Claude Code

### How It Differs from the Anthropic Client SDK
Client SDK: you implement the tool loop manually. Agent SDK: Claude handles tools autonomously with built-in execution.

### Cloud Provider Support
- Amazon Bedrock: `CLAUDE_CODE_USE_BEDROCK=1`
- Google Vertex AI: `CLAUDE_CODE_USE_VERTEX=1`
- Microsoft Azure: `CLAUDE_CODE_USE_FOUNDRY=1`

---

## 12. Partnership Integrations

### Native Claude Apps (Inside Claude Chat)

| Integration | What It Does |
|-------------|-------------|
| **Asana** | Create/update projects, tasks, timelines directly from chat |
| **Slack** | Draft/send messages, search channels, threads, files; two-way MCP integration |
| **Figma** | Generate diagrams and design assets |
| **Hex** | Analyze data within conversations |
| **Box** | Access cloud files |
| **Canva** | Create presentations and visual content |
| **Google Drive/Gmail** | File access and email |
| **DocuSign** | Document signing workflows |

### Enterprise Connectors (via Cowork Plugins)
Google Calendar, Apollo, Clay, Outreach, Similarweb, MSCI, LegalZoom, FactSet, WordPress, Harvey

### Slack Deep Integration
Salesforce's Slack supports two-way MCP integration with Claude:
- Search and retrieve messages, channels, threads, files, users
- Create and share canvases
- Send messages to colleagues
- Available on Pro, Max, Team, and Enterprise plans

### GitHub Integration
As of February 26, 2026: Claude and Codex now available for GitHub Copilot Business and Pro users

### Relevance to Our Setup
- **Asana**: Our existing MCP integration aligns with the native Asana app. The native integration allows creating projects/tasks/timelines from Claude chat, complementing our programmatic MCP approach
- **Slack**: Two-way MCP integration could enhance client communication workflows
- **Google Drive/Gmail**: Potential for automated report distribution to clients

---

## Actionable Recommendations for OFM

### Immediate Actions

1. **Switch to Adaptive Thinking**: Replace `MAX_THINKING_TOKENS=63999` with adaptive thinking configuration. Use `effort: "high"` as default, `effort: "max"` for complex audits (Opus only).

2. **Evaluate Agent Teams**: With swarm mode officially launched, our existing agent orchestration model in `agents/` is well positioned. Test CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 for parallel audit workflows.

3. **Leverage 1M Context**: For large site audits and codebase analysis, enable the `context-1m-2025-08-07` beta header. Premium pricing applies above 200K tokens.

4. **Prompt Caching Strategy**: For recurring audit patterns and client system prompts, implement 1-hour TTL caching to reduce costs on repeated analysis runs.

5. **Claude Code Security**: Request access for Enterprise/Team customers. This could be a differentiator for NetSuite security audits.

### Medium Term Actions

6. **Agent SDK for Automation**: Build production audit pipelines using the Agent SDK for CI/CD style automated monitoring (scheduled CWV checks, index coverage monitoring).

7. **Native Asana Integration**: Evaluate whether the built-in Claude Asana app can supplement our MCP based workflow for task creation and project timeline management.

8. **Slack Integration**: Set up two-way Slack MCP for client communication workflows.

9. **Cowork Plugins**: Monitor the plugin marketplace for SEO-relevant connectors. The WordPress connector is immediately relevant for non-NetSuite clients.

### Stay Updated

10. **MCP Specification**: Watch the AAIF (Linux Foundation) for the next spec release. The Tasks primitive for async operations could transform how we run long-running audits.

11. **Model Migration**: Plan migration path away from any Claude Sonnet 4.5/Opus 4.5 usage. The 4.6 series offers better performance at same pricing.

12. **Claude Haiku 3 Retirement**: Ensure no workflows depend on `claude-3-haiku-20240307` before April 19, 2026 deadline.
