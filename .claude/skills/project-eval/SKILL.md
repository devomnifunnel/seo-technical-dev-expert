---
name: project-eval
description: "Validate the entire Claude Code project structure, frontmatter, hooks, settings, and references. Use when checking project health, running validation, or after making changes to project files. Trigger on: validate project, project health, run eval, check project, regression check, test project, validate skills, validate agents, smoke test."
allowed-tools: Read, Glob, Grep, Bash
---

# Project Evaluation and Validation

## Quick Validation

Run the full automated validation suite:

```bash
bash scripts/eval/validate-all.sh
```

This runs all 6 validators in sequence:
1. **Skills** (validate-skills.sh): Frontmatter for all 31+ skills
2. **Agents** (validate-agents.sh): Frontmatter for all 9 agents
3. **Rules** (validate-rules.sh): Frontmatter and paths: syntax for all 6 rules
4. **Hooks** (validate-hooks.sh): Syntax, dependencies, functional tests for all 4 hooks
5. **Settings** (validate-settings.sh): JSON validity, required fields, security patterns
6. **References** (validate-refs.sh): All @imports, agent refs, script refs resolve

## Quick Mode

Skip functional hook tests (faster):

```bash
bash scripts/eval/validate-all.sh --quick
```

## Individual Validators

Run a specific check:

```bash
bash scripts/eval/validate-skills.sh
bash scripts/eval/validate-agents.sh
bash scripts/eval/validate-rules.sh
bash scripts/eval/validate-hooks.sh
bash scripts/eval/validate-settings.sh
bash scripts/eval/validate-refs.sh
```

## Interactive Smoke Tests

For runtime behavior that cannot be tested automatically (skill triggering, agent invocation, hook firing), use the manual checklist:

```
Read scripts/eval/smoke-test.md
```

## When to Run

- After any change to .claude/ directory files
- After adding or modifying skills, agents, or rules
- After changing hooks or settings
- Before committing project infrastructure changes
- At the start of any audit session as a health check

## Interpreting Results

- **[PASS]**: Check passed, no action needed
- **[FAIL]**: Check failed, must fix before the project is considered valid
- **[WARN]**: Check flagged a potential issue, review but may be acceptable
- **PROJECT STATUS: ALL CHECKS PASSING**: All validators report zero failures
- **PROJECT STATUS: FAILING**: At least one validator has failures, fix required

## Expected Baseline

When fully valid, the suite should report:
- Skills: 31+ skills, all with kebab-case names and trigger phrase descriptions
- Agents: 9 agents, all with kebab-case names, model aliases, memory: project
- Rules: 6 rules, 3 with paths: scoping, 0 with deprecated globs:
- Hooks: 4 scripts, all syntax valid, python available, functional tests pass
- Settings: Valid JSON, correct fields, security patterns present
- References: All @imports resolve, all agent/script refs resolve, no orphans
