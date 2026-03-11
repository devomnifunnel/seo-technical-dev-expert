# Self Learning Protocol

When you discover new techniques through research, browsing, or conversation:
1. Evaluate whether reliable and actionable (not speculative)
2. Create or update skill file in .claude/skills/[topic]/SKILL.md
3. If it is a new methodology, add to .claude/frameworks/
4. Log in memory so future sessions benefit

## Instinct Pipeline

For discoveries that are promising but not yet fully validated:
1. Add an entry to .claude/memory/instincts.md with confidence score (0 to 100%)
2. Include the source (session date, client name, research URL)
3. On subsequent sessions, if the same pattern is observed, increase confidence and note the validation
4. When confidence reaches 80%+ with 2+ independent validations, promote the instinct:
   a. Write the discovery into the relevant skill or framework file
   b. Update the instinct status to PROMOTED with a reference to where it was written
5. If a discovery is later proven wrong, set status to RETIRED with the reason

## What Qualifies as an Instinct

Good instincts (add these):
- A specific Google behavior change observed during a live audit
- A NetSuite/SuiteCommerce workaround discovered through testing
- A tool output pattern that indicates a specific problem
- A client platform configuration that causes or fixes an SEO issue
- A schema markup pattern that triggers or loses rich results

Not instincts (do not add these):
- General SEO best practices already documented in frameworks
- Speculative theories without any evidence
- One time bugs or transient issues
