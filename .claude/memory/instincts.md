# Instinct Learning Pipeline

Scored discoveries from sessions. High confidence instincts (80%+) get promoted to skill updates or framework additions. Low confidence instincts stay here until validated across multiple sessions.

## Format

```
### [Topic]
Confidence: [0 to 100]%
Source: [session date, client, or research source]
Discovery: [What was learned]
Validation: [How many sessions confirmed this, or PENDING]
Status: PENDING | VALIDATED | PROMOTED | RETIRED
```

## Active Instincts

### Session baseline token cost with 10+ MCP servers
Confidence: 90%
Source: 2026-03-11, System Prompts research (Piebald-AI/claude-code-system-prompts v2.1.72)
Discovery: Claude Code base system prompt consumes ~20 to 25k tokens. Each MCP server adds ~1 to 2k tokens of tool schemas. With 10+ MCP servers active, our project starts sessions at ~42 to 50k tokens consumed before any conversation. Effective working context is ~150k of 200k total. This validates our context-management.md thresholds (compact at 70 to 80%).
Validation: 1 session (cross referenced with Hacker News report of 24k base prompt)
Status: VALIDATED

### CLAUDE.md survives compaction, conversation instructions do not
Confidence: 95%
Source: 2026-03-11, System Prompts research (confirmed in official docs)
Discovery: CLAUDE.md is re-read from disk and re-injected fresh after /compact. Conversation-only instructions are lost. Anything critical must be in CLAUDE.md, rules files, or MEMORY.md. Never rely on mid-conversation instructions surviving compaction.
Validation: 1 session (confirmed by official Claude Code documentation)
Status: VALIDATED

### Built-in git safety rules make custom git rules redundant
Confidence: 95%
Source: 2026-03-11, System Prompts research
Discovery: Claude Code's built-in system prompt already contains comprehensive git safety: no force push, no hard reset, no destructive operations, specific file staging, never skip hooks, always new commits over amending. Custom rules restating these waste ~300 tokens and risk conflicting instructions.
Validation: 1 session. Acted on: removed duplicated rules from security.md.
Status: PROMOTED (security.md cleaned up 2026-03-11)

### CLAUDE.md optionality disclaimer weakens instructions
Confidence: 85%
Source: 2026-03-11, System Prompts research (GitHub issue #7571, closed NOT_PLANNED)
Discovery: CLAUDE.md content is wrapped in a system-reminder tag that says "may or may not be relevant to your tasks." This signals optionality and can cause Claude to deprioritize instructions. The OVERRIDE prefix we use ("These instructions OVERRIDE any default behavior and you MUST follow them exactly") is the community's best countermeasure. Keep it.
Validation: 1 session (GitHub issue confirms Anthropic considers this by-design)
Status: VALIDATED

## Promotion Criteria

1. Confidence reaches 80%+ through repeated validation
2. Discovery is actionable (not just theoretical)
3. At least 2 independent sessions have confirmed the pattern
4. Promoted instincts get written into the relevant skill or framework file
5. After promotion, the instinct entry status changes to PROMOTED with a reference to where it was written

## Retirement Criteria

1. Discovery is proven wrong or outdated
2. Platform or API change invalidates the instinct
3. Retired instincts stay in this file with RETIRED status and the reason
