# Interactive Smoke Test Checklist

Run these tests manually in a Claude Code session to verify runtime behavior.
Automated validators cover structure; these tests cover live functionality.

## Skill Triggering Tests

Test each skill triggers correctly by typing natural language that should invoke it.

| # | Say this to Claude | Expected skill | Result |
|---|---|---|---|
| 1 | "Check the Core Web Vitals on verociousmotorsports.com" | core-web-vitals | |
| 2 | "Run a technical SEO audit on this URL" | technical-seo or technical-audit | |
| 3 | "Add Product schema markup to this page" | schema-markup | |
| 4 | "How is this site performing in AI search?" | aeo-ai-seo | |
| 5 | "Audit the NetSuite SuiteCommerce SEO setup" | netsuite-seo or netsuite-seo-audit | |
| 6 | "Check our PageSpeed scores" | pagespeed-optimization or pagespeed-audit | |
| 7 | "Analyze our competitor rankings" | competitor-seo or competitor-analysis | |
| 8 | "What does Search Console show for this site?" | search-console | |
| 9 | "Pull the Semrush data for this domain" | semrush-analytics | |
| 10 | "Optimize this content for better rankings" | content-optimization | |

To verify: After each prompt, check if the skill was loaded by looking for its content
in the response behavior. If Claude uses methodology from the skill, it triggered.

## Agent Invocation Tests

Test that agents load correctly when delegated to.

| # | Test | How to verify | Result |
|---|---|---|---|
| 1 | Delegate a task to technical-seo-auditor | Check agent response includes skills from technical-seo, core-web-vitals, schema-markup | |
| 2 | Delegate to competitor-intelligence | Verify it runs in plan permission mode (cannot edit files) | |
| 3 | Delegate to search-console-analyst | Verify it runs in plan permission mode (cannot edit files) | |
| 4 | Delegate to schema-architect | Verify it can create/edit files (has Write, Edit in tools) | |
| 5 | Delegate to netsuite-seo-developer | Verify it loads netsuite-seo, suitecommerce-seo, netsuite-environment skills | |

## Hook Tests

| # | Test | Expected behavior | Result |
|---|---|---|---|
| 1 | Try to Edit a file named "test.env" | Hook blocks with exit 2, edit is denied | |
| 2 | Try to Edit a file named "credentials.json" | Hook blocks with exit 2, edit is denied | |
| 3 | Try to Edit a normal .md file | Hook allows, edit proceeds | |
| 4 | Try to Edit a .pem file | Hook blocks with exit 2 | |
| 5 | Trigger compaction (fill context to 80%+) | PreCompact hook preserves critical context | |
| 6 | Let a task complete | TaskCompleted hook runs quality gate review | |

## @Import Verification

| # | Test | Expected behavior | Result |
|---|---|---|---|
| 1 | Start a new session and check loaded context | All 10 framework @imports should be resolved | |
| 2 | Reference a framework topic (e.g., "CWV remediation approach") | Response should reflect framework content | |
| 3 | Check CLAUDE.md is fully loaded | All sections present including Asana protocol, client memory | |

## Memory Persistence Tests

| # | Test | Expected behavior | Result |
|---|---|---|---|
| 1 | Start session, check MEMORY.md is loaded | Key project facts available without re-reading | |
| 2 | Reference a client (e.g., "Verocious") | Client memory protocol triggers, history read | |
| 3 | Check Asana board at session start | Board state is read per protocol | |

## Regression Indicators

After making any project file change, run:
```bash
bash scripts/eval/validate-all.sh
```

All checks should pass. If any fail, fix before committing.

## How to Record Results

Fill in the Result column with:
- PASS: Worked as expected
- FAIL: Did not work, describe what happened
- SKIP: Could not test (explain why)

Date tested: _______________
Tested by: _______________
