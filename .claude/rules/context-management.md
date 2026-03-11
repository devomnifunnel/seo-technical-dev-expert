# Context Window Management Protocol

These rules govern efficient context usage to maintain peak performance throughout sessions.

---

## Token Efficiency Rules

- **Prefer Grep over Read** when searching for specific content. Grep costs ~200 tokens vs
  Read at ~3,000 tokens (15x more efficient). Only use Read when you need the full file.
- **Use line ranges** when reading large files. Specify offset and limit parameters to read
  only the section needed. Saves up to 70% on large files.
- **Delegate investigation to subagents** when exploring unfamiliar code or running research.
  Each subagent gets its own context window, preserving the main window for synthesis.
- **Keep tool output concise**. Pipe Bash output through head/tail when full output is not needed.
  Limit git log to relevant commit count.

## Session Structure

- **Break work into 30 minute sprints**, each focused on a specific task or client.
- **Run /compact with explicit summary** between sprints or when switching contexts.
  Include: current task status, key decisions made, open items, active client name.
- **Use /clear between unrelated tasks**. Mixing topics fills context with irrelevant noise.
  Follow /clear with the /catchup command to reload essential state.
- **Monitor context fill level**. Performance degrades as context fills:
  - Under 40k tokens: peak performance
  - 40k to 100k tokens: normal performance
  - 100k to 150k tokens: noticeable slowdown
  - Over 150k tokens: 3x to 5x slower, compact immediately

## Compaction Protocol

- **Compact proactively at 50 to 60% fill**, not waiting for auto compact at 95%.
  Sessions start at ~42 to 50k tokens (21 to 25% of 200k) before any work begins.
  At 50% fill (100k tokens), you have used about 50k of working context. Quality degrades beyond this.
- **PreCompact hook preserves critical context** automatically (client name, project rules,
  Asana GIDs, reference architecture paths). Do not rely solely on this.
- **After compaction**, verify key context by checking: which client are we working with,
  what was the current task, what open items exist.

## Subagent Delegation Guidelines

- Use subagents for: verbose research, file exploration, web searches, competitive analysis
- Work directly for: quick edits, simple reads, client communication, small changes
- Each subagent type consumes different token budgets:
  - Explore agents: lightweight, best for file discovery
  - General purpose agents: full toolkit, best for complex research
  - Plan agents: read only, best for architecture decisions

## MCP Token Awareness

- MCP server tool definitions load into context on every request whether used or not.
- Monitor baseline token cost at session start. If over 30k tokens before any work,
  consider which MCPs are active and whether all are needed for the current task.
- Prefer project scoped MCPs over global MCPs to avoid loading irrelevant tools.
