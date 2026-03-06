# Project Optimization Research: Deep Analysis & Gap Report
## SEO & Technical Dev Expert | OmniFunnel Marketing
## March 6, 2026

Research compiled from 6 parallel research agents covering: Claude Code architecture, MCP servers,
agent orchestration, elite project setups, Anthropic ecosystem, and SEO automation with AI.

---

## EXECUTIVE SUMMARY

Our project is already in the top tier of Claude Code configurations (modular CLAUDE.md, 9 agents,
17 skills, 10 frameworks, rules system, client memory protocol, Asana integration). However, six
research agents identified 23 specific gaps and 14 new capabilities we are not leveraging. The
highest impact improvements fall into four categories:

1. **Settings modernization** (adaptive thinking replaces deprecated MAX_THINKING_TOKENS)
2. **Hooks system** (our biggest gap; PreCompact alone reduces info loss 30%)
3. **MCP server expansion** (Lighthouse, GSC, GA4, Chrome DevTools, Firecrawl)
4. **Agent orchestration upgrades** (model tiering, delegate mode, persistent memory)

---

## CRITICAL GAPS (Fix Immediately)

### 1. MAX_THINKING_TOKENS is Deprecated
Our settings use `MAX_THINKING_TOKENS=63999`. Anthropic replaced this with **adaptive thinking**
for Opus 4.6 and Sonnet 4.6. The new approach uses `thinking.type: "adaptive"` with effort levels
(max, high, medium, low). Interleaved thinking between tool calls is automatic with adaptive mode.

**Action:** Remove MAX_THINKING_TOKENS from settings. Add `alwaysThinkingEnabled: true` to
settings.json. The `effortLevel: "high"` we already have is correct and works with adaptive thinking.

### 2. No Hooks System (Biggest Gap)
We have basic hooks in settings.local.json (GTM blocking, Windows notification) but are missing
the most impactful hook patterns the community has proven:

**PreCompact hook** (reduces info loss by 30% during auto compaction):
Injects critical context (client name, open items, current task) before compaction summarizes.

**PreToolUse security gate** (programmatic enforcement of our NEVER rules):
Blocks writes to client sites, production systems, .env files. Exit code 2 = blocked action.
Currently our "NEVER without approval" rules are instructions only (probabilistic). Hooks are
deterministic and cannot be ignored.

**PostToolUse auto formatter** (run Prettier/ESLint on every file edit):
Ensures all generated code meets standards automatically.

**Stop notification** (Windows toast when Claude finishes long analysis):
We have a basic version but the community pattern is more robust.

### 3. Missing High Value MCP Servers
We have: Semrush (needs OAuth), PageSpeed, Chrome, Asana, Zapier.
We are missing servers that would transform our capabilities:

**Lighthouse MCP (danielsogl)** 13+ tools, far superior to our PageSpeed MCP:
Full Lighthouse audits, CWV, WCAG accessibility, security scanning, resource analysis.
Install: `claude mcp add lighthouse -- npx @danielsogl/lighthouse-mcp@latest`

**Google Search Console MCP (AminForou v2)** hosted, OAuth, no API keys:
Search analytics, URL inspection, sitemap management, index coverage.
GitHub: github.com/AminForou/google-search-console-mcp-v2

**Google Analytics MCP (official Google)** read only, first party:
Account summaries, run reports, realtime reports.
GitHub: github.com/googleanalytics/google-analytics-mcp

**Chrome DevTools MCP (Google official)** live performance tracing:
Core Web Vitals from real Chrome, network timing, JS execution costs.
Install: `claude mcp add chrome-devtools -- npx chrome-devtools-mcp@latest`

**IMPORTANT CAVEAT:** MCP tool definitions consume context tokens on every request whether used
or not. A few MCPs can eat 30%+ of the context window. Be selective. Install only what we will
use regularly.

---

## HIGH PRIORITY IMPROVEMENTS

### 4. StatusLine Configuration
Elite users monitor context usage in real time. We have no status line configured.

**Action:** Add to settings.json:
```json
"statusLine": "'{context_used}/{context_total} tokens | {git_status}'"
```
Shows token usage and git state at all times. Prevents the silent context bloat that degrades
performance (sessions at 180k tokens are 3 to 5x slower than at 40k).

### 5. Context Management Protocol
Research consensus: compact at 70 to 80% fill, not waiting for auto compact at 95%.

Best practices to add to CLAUDE.md or rules:
a. Use Grep over Read when searching (200 tokens vs 3,000 tokens, 15x more efficient)
b. Use /clear between unrelated tasks
c. Break sessions into 30 minute sprints with /compact between them
d. Use line ranges when reading large files (saves 70%)
e. Delegate investigation to subagents (separate context window)

### 6. Agent Model Tiering
Community consensus: use different models for different agent roles.
a. Opus for lead/planning/complex reasoning
b. Sonnet for execution/implementation
c. Haiku for exploration/fast lookups

Our agents all run at default model. Adding `model:` to skill/agent frontmatter would optimize
both cost and speed. Exploration agents (competitor research, keyword research) should use Haiku.
Critical agents (technical audits, code generation) should use Opus.

### 7. Missing Commands
Two commands the elite community considers essential:

**/catchup** reads all recently changed files to restore context after /clear.
Based on Shrivu Shankar's pattern (adopted by multiple top users).

**/spec-audit** enforces a structured workflow: Requirements > Analysis > Findings > Recommendations.
Matches the Spec Driven Development pattern that is the strongest emerging community consensus.
Review at phase gates, not during implementation.

### 8. Delegate Mode (Shift+Tab)
When using Agent Teams with 4+ teammates, enable delegate mode immediately. This prevents the
lead agent from grabbing tasks that should go to teammates. Critical for parallel audit workflows.
Currently not documented in our project.

### 9. Dynamic Context Injection in Skills
Skills can use `!`command`` syntax to run commands BEFORE Claude sees the content:
```yaml
## Current Context
- GSC data: !`python scripts/fetch-gsc.py`
- PageSpeed: !`curl -s "https://pagespeedonline.googleapis.com/..."`
```
This replaces static skill content with live data. None of our 17 skills use this pattern.

### 10. Persistent Memory on Subagents
Agent Teams now support `memory: user/project/local` for cross session learning. Our agents
could retain client specific patterns, common issues, and optimization strategies between sessions
without re reading history files each time.

---

## MEDIUM PRIORITY IMPROVEMENTS

### 11. Additional MCP Servers (Tier 2)
These add significant value but are not critical path:

**Firecrawl MCP** best in class web scraping for content analysis:
`claude mcp add firecrawl -e FIRECRAWL_API_KEY=key -- npx -y firecrawl-mcp`

**DataForSEO MCP** comprehensive SERP + keyword + backlink data ($0.01/query):
`npx -y dataforseo-mcp-server` with credentials

**Schema.org MCP** JSON-LD generation and schema vocabulary lookup:
github.com/Theycallmeholla/schema-org-mcp

**Sitemap MCP** parsing, stats, and validation:
github.com/mugoosse/sitemap-mcp-server

**Fetch MCP (Anthropic official)** clean HTML to markdown conversion:
`claude mcp add fetch -- npx -y @modelcontextprotocol/server-fetch`

**Jina AI MCP** content extraction optimized for LLMs:
`claude mcp add jina https://mcp.jina.ai/v1 -t http`

### 12. AI Citation Tracking Workflow
Only 11% of domains are cited by both ChatGPT and Perplexity. Each platform needs different
strategy. Citation patterns differ dramatically:
a. Wikipedia dominates ChatGPT (47.9% of top 10)
b. Reddit dominates Perplexity (46.7%)
c. Google AI Overviews distributes more evenly across Reddit, YouTube, Quora

Tools to evaluate: Otterly.AI, LLMrefs, Semrush AI Visibility Toolkit.
DataForSEO AI MCP can track brand visibility in LLMs programmatically.

**Action:** Build a weekly AI citation tracking workflow as a skill.

### 13. llms.txt Generation
Emerging standard for making sites LLM friendly. Should be added to our audit deliverables
checklist. Similar to robots.txt but specifically for AI crawlers.

### 14. Screaming Frog + Claude API Integration
Screaming Frog v22.0 integrates directly with Anthropic/Claude API (Config > API Access > AI).
Enables custom AI prompts during crawls, vector embeddings for semantic similarity, and AI
categorization across 30,000+ page crawls. Our clients using Screaming Frog should be using this.

### 15. 1M Context Window (Beta)
Opus 4.6 and Sonnet 4.6 support 1M tokens via beta header. Premium pricing above 200K tokens.
Useful for massive site audits where we need to hold thousands of URLs in context simultaneously.

### 16. Skills Frontmatter Enhancements
Our skills use basic frontmatter. New options available:
a. `allowed-tools:` restrict which tools a skill can use (security)
b. `agent: Explore|Plan` specify agent type when using context: fork
c. `argument-hint:` autocomplete hints for user invocation
d. `hooks:` lifecycle hooks scoped to individual skills
e. `$ARGUMENTS` substitutions for dynamic skill inputs

---

## LOW PRIORITY / FUTURE CONSIDERATIONS

### 17. Plugin Marketplace
Claude Code now has an npm based plugin marketplace. Worth monitoring for SEO relevant plugins
as the ecosystem matures.

### 18. Claude Agent SDK for Automation
Python/TypeScript SDK extracted from Claude Code runtime. Could power:
a. Automated nightly SEO monitoring pipelines
b. CI/CD integration for pre deployment SEO checks
c. Custom client facing dashboards with Claude powered analysis

### 19. SuiteCommerce AI SEO (Market Opportunity)
Research confirmed: NO dedicated AI SEO tools exist for NetSuite SuiteCommerce anywhere.
This is a wide open market for OFM. Our suitecommerce-seo skill + netsuite-seo skill already
position us uniquely. Consider productizing this expertise.

### 20. Spec Driven Development Pattern
The strongest emerging pattern across all sources. Separates planning from execution:
Requirements > Design/Architecture > Task Breakdown > Implementation.
"Review at phase gates, not during implementation."
Could be formalized as an audit workflow command.

### 21. Quality Gate Hooks
TaskCompleted hooks that enforce audit checklists before marking work done.
Ensures every audit hits minimum quality standards programmatically.

### 22. Permission Optimization
Current approach: default permissions with manual approval.
Advanced approach: auto approve safe operations (Read, Grep, Glob, git log) while keeping
dangerous operations gated. Scoped Bash permissions like "Bash(git log:*)" for granular control.

### 23. MCP Token Budget Awareness
Every MCP server's tool definitions load into context on every request. Our current MCPs
(Semrush, PageSpeed, Chrome, Asana, Zapier) plus new additions could consume 30%+ of the
context window before any work begins. Need to audit baseline token cost and potentially
use conditional MCP loading or limit active servers to the ones needed for current work.

---

## COMPETITIVE INTELLIGENCE: WHAT THE BEST ARE DOING

### Boris Cherny (Creator of Claude Code)
Runs 5 local + 5 to 10 remote sessions in parallel. Uses Plan mode iteratively until solid,
then auto accept edits for one shot implementation. "A good plan is really important."

### incident.io
Went from zero to 4 to 7 concurrent AI agents in four months. Estimated a task at two hours,
completed in ten minutes with five parallel agents. Use SuperWhisper for voice dictation.

### Addy Osmani (Google)
80% planning, 20% execution. Emphasizes agent teams for parallel specialist work.
Published web-quality-skills (Lighthouse + CWV) that we already installed.

### Freek Van der Herten (Laravel/Spatie)
CLAUDE.md tells Claude to "be critical, not sycophantic." Always on thinking mode.
Custom status line. All config public in dotfiles repo.

### Community Consensus
Session at 180k tokens is 3 to 5x slower than one at 40k tokens. The single highest
leverage improvement is giving Claude verification criteria (tests, expected outputs).
The single most common mistake is vague prompts without context.

---

## PRIORITY ACTION PLAN

### This Session (Immediate)
1. Update settings: remove MAX_THINKING_TOKENS, add alwaysThinkingEnabled, add statusLine
2. Add PreCompact hook (30% less info loss)
3. Add PreToolUse security gate hook (programmatic NEVER enforcement)

### This Week
4. Install Lighthouse MCP (replaces/supplements PageSpeed)
5. Install Chrome DevTools MCP (live CWV from real Chrome)
6. Install Fetch MCP (Anthropic official, clean content extraction)
7. Create /catchup command
8. Add context management protocol to rules

### This Month
9. Install GSC MCP (when service account ready)
10. Install GA4 MCP (when credentials ready)
11. Build AI citation tracking skill
12. Add dynamic context injection to key skills
13. Implement model tiering on agents
14. Create /spec-audit command
15. Add llms.txt to audit deliverable checklist

### Next Quarter
16. Evaluate Agent SDK for automated monitoring pipelines
17. Productize SuiteCommerce SEO expertise
18. Build quality gate hooks
19. Evaluate 1M context for large site audits
20. Audit MCP token overhead and optimize

---

## SOURCES (Selected)

### Claude Code Architecture
- code.claude.com/docs/en/best-practices.md
- code.claude.com/docs/en/memory.md
- code.claude.com/docs/en/skills.md
- code.claude.com/docs/en/hooks-guide.md
- humanlayer.dev/blog/writing-a-good-claude-md
- arize.com/blog/claude-md-best-practices

### Anthropic Ecosystem
- anthropic.com/news/claude-opus-4-6
- platform.claude.com/docs/en/build-with-claude/adaptive-thinking
- platform.claude.com/docs/en/agent-sdk/overview
- github.com/anthropics/claude-code/releases

### Agent Orchestration
- code.claude.com/docs/en/agent-teams
- addyosmani.com/blog/claude-code-agent-teams
- alexop.dev/posts/from-tasks-to-swarms-agent-teams-in-claude-code
- github.com/VoltAgent/awesome-claude-code-subagents

### Elite Setups
- blog.sshh.io/p/how-i-use-every-claude-code-feature
- boristane.com/blog/how-i-use-claude-code
- freek.dev/3026-my-claude-code-setup
- incident.io/blog/shipping-faster-with-claude-code-and-git-worktrees
- github.com/hesreallyhim/awesome-claude-code (21,600+ stars)
- github.com/rohitg00/awesome-claude-code-toolkit

### MCP Servers
- registry.modelcontextprotocol.io
- pulsemcp.com/servers (8,600+ servers)
- github.com/punkpeye/awesome-mcp-servers (79,600+ stars)
- github.com/danielsogl/lighthouse-mcp-server
- github.com/ChromeDevTools/chrome-devtools-mcp
- github.com/googleanalytics/google-analytics-mcp

### SEO Automation
- Search Engine Journal, Moz, Ahrefs, Semrush blogs
- r/SEO, r/TechSEO, r/bigseo Reddit communities
- dataforseo.com/help-center/setting-up-the-official-dataforseo-mcp-server
