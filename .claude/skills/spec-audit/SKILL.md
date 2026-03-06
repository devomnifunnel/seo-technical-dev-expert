---
name: spec-audit
description: >
  Use when someone asks to audit a specification, review a spec, check the spec, or run a
  structured phased audit with approval gates. Trigger on: "spec audit", "audit a specification",
  "review this spec", "check the spec", "phased audit", "gated audit", "spec driven audit",
  "run the spec workflow", "audit with phase gates", "structured audit process".
  This enforces a Requirements > Analysis > Findings > Recommendations phased workflow
  with mandatory stops for Michael's approval at each gate before proceeding.
disable-model-invocation: true
argument-hint: "[url-or-client-name]"
allowed-tools: Read, Glob, Grep, Bash, WebSearch, WebFetch, Agent, Write
---

# Spec Driven SEO Audit

Enforce a phased audit workflow. Review at phase gates, not during implementation.
Do NOT skip phases or combine them. Complete each phase and get Michael's approval before proceeding.

## Phase 1: Requirements (STOP for approval)

Define the audit scope before any analysis begins:
1. Identify the target URL(s) or client site
2. Load client history from clients/ if it exists
3. Determine audit type: full site, single page, technical only, content only, AEO, CWV
4. List specific concerns or goals Michael has mentioned
5. Identify which tools and agents will be needed
6. Estimate scope: number of pages, expected duration, deliverable format

Present the requirements summary and WAIT for Michael's approval before proceeding.

## Phase 2: Analysis (parallel agents)

Once requirements are approved, execute the analysis:
1. Deploy specialist agents in parallel based on audit type:
   - Technical SEO auditor for crawlability, indexation, technical issues
   - Content strategist for E-E-A-T, thin content, duplication
   - AEO specialist for AI search visibility and citations
   - PageSpeed optimizer for CWV and performance
   - Schema architect for structured data validation
   - Search Console analyst for GSC data (if connected)
2. Each agent produces findings in the standard format:
   Finding | Evidence | Impact | Priority | Fix
3. Run Chrome scripts for live page analysis where applicable
4. Cross reference findings between agents for systemic patterns

## Phase 3: Findings (STOP for review)

Synthesize all agent outputs into a unified findings document:
1. Group by priority tier: Critical > High > Medium > Low
2. Score the site: weighted average across all audit dimensions
3. Identify the top 5 highest impact issues
4. Flag any anomalies per .claude/rules/anomaly-flagging.md
5. Note any findings that contradict each other between agents

Present findings summary and WAIT for Michael's review before recommendations.

## Phase 4: Recommendations & Deliverable

After findings are reviewed, produce the final deliverable:
1. Action plan with implementation specs for each finding
2. Developer handoff documents for technical fixes
3. Content briefs for content improvements
4. Schema markup code (JSON-LD) for structured data fixes
5. Timeline with dependency ordering (what must be fixed first)
6. Format as .docx draft per Michael's preference
7. Update client history with session summary
8. Create/update Asana tasks for open action items
