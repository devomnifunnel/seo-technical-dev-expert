---
name: seo-dev-implementation
description: "Developer handoff standards and code patterns for SEO. Use when creating implementation specs, writing SEO code, or preparing developer handoffs. Trigger on: developer handoff, implementation spec, SEO code, deployment checklist, framework SEO, technical implementation."
allowed-tools: Read, Write, Edit, Bash, Grep, Glob
argument-hint: "[issue or URL to fix]"
---

# SEO Developer Handoff and Implementation

## Developer Handoff Document Structure

Every SEO recommendation delivered to a developer must follow this standardized format:

### Template

```
## SEO Implementation Ticket

**Issue**: [Clear, specific description of the SEO problem]
**Impact**: [Critical/High/Medium/Low] — [Explanation of SEO/business impact]
**Affected URLs**: [Specific URLs or URL patterns affected]

### Acceptance Criteria
- [ ] [Specific, testable requirement 1]
- [ ] [Specific, testable requirement 2]
- [ ] [Specific, testable requirement 3]

### Implementation Steps
1. [Step by step technical instructions]
2. [Include file paths, code snippets, configuration changes]
3. [Reference relevant documentation]

### Testing
- [ ] [How to verify the fix works]
- [ ] [Edge cases to check]
- [ ] [Tools to use for validation]

### References
- [Link to relevant documentation]
- [Link to PageSpeed/GSC report showing the issue]
```

## Code Patterns for SEO

Meta tag management, canonical URL logic, redirect middleware, and sitemap generation patterns are available for Next.js, Nuxt 3, NetSuite SuiteCommerce, Express.js, and Shopify.

For all code examples, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Testing SEO Implementations

Automated testing covers: meta tag validation, structured data verification, broken link detection, image alt/dimension checks, and heading hierarchy validation using Playwright. A bash pre deployment script validates robots.txt, sitemap, key page status codes, and HTTPS redirects.

For Playwright test suite and pre deployment bash script, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Pre-deployment SEO Checklist

### Before Launch

- [ ] **Redirects**: All old URLs have 301 redirects (no chains, no loops)
- [ ] **Meta tags**: Unique title (50 to 60 chars) and description (120 to 160 chars) per page
- [ ] **Canonical tags**: Self referencing canonical on every page
- [ ] **robots.txt**: Does not block CSS, JS, images, or important pages
- [ ] **XML sitemap**: Valid, submitted to GSC, referenced in robots.txt
- [ ] **Schema markup**: JSON-LD validated on key page types
- [ ] **Heading structure**: One H1 per page, logical hierarchy
- [ ] **Image optimization**: Alt text, width/height, WebP/AVIF format
- [ ] **Internal links**: Navigation in HTML, breadcrumbs present
- [ ] **Core Web Vitals**: LCP < 2.5s, INP < 200ms, CLS < 0.1 on staging
- [ ] **Mobile**: Correct rendering on mobile viewport
- [ ] **HTTPS**: All pages, no mixed content
- [ ] **Render test**: Key pages verified in Google Rich Results Test

## Post-deployment Verification

### Immediate (within 1 hour)
- [ ] Spot check 10 key pages: status codes, meta tags, canonicals
- [ ] Verify robots.txt and sitemap.xml accessible
- [ ] Check for 404 spikes
- [ ] Run 3 URLs through Rich Results Test

### First 24 hours
- [ ] Monitor GSC for crawl errors and Index Coverage spikes
- [ ] Monitor real user CWV data
- [ ] Test redirect chain integrity

### First 7 days
- [ ] Compare organic traffic to baseline
- [ ] Monitor indexing changes and ranking shifts
- [ ] Verify no CWV regressions

### First 30 days
- [ ] Full ranking comparison pre vs post
- [ ] Organic traffic trend analysis
- [ ] Index coverage: all important pages indexed
- [ ] CWV: all page groups in "Good" status
- [ ] Backlink integrity verified

## Git Workflow for SEO Changes

### Branch Naming

```
seo/[type]/[brief-description]
Types: fix, feat, perf, content
Examples: seo/fix/product-canonical-tags, seo/feat/faq-schema-markup
```

### PR Template

```markdown
## Summary
[Brief description of the change]

## SEO Impact
**Type**: [Fix / Feature / Performance / Content]
**Affected Pages**: [URL patterns affected]
**Expected Impact**: [What SEO metric this improves]

## SEO Checklist
- [ ] No new pages without meta tags
- [ ] No changes to robots.txt behavior
- [ ] Canonical tags verified
- [ ] Structured data validated (if applicable)
- [ ] No render blocking resources introduced
- [ ] CWV not regressed (Lighthouse tested)
- [ ] Redirects tested (if applicable)
```

## Common Developer Mistakes

### SPA Without Prerendering
**Problem**: SPAs render content via JavaScript; Googlebot may not see full content.
**Solution**: Use SSR/SSG for SEO critical pages. If not feasible, implement dynamic rendering. Test in Google Rich Results Test.

### JavaScript Dependent Meta Tags
**Problem**: Client side meta tags may not be read on first crawl pass.
**Solution**: All meta tags in initial HTML response. Verify with `curl` or "View Source."

### Improper Canonicals
Common mistakes: pointing to 404 or redirect, HTTP instead of HTTPS, missing on paginated pages, relative instead of absolute URLs, not matching self referencing URL exactly.

### Blocking CSS/JS in robots.txt
**Problem**: Prevents Googlebot from rendering correctly.
**Solution**: Never block CSS/JS files. Remove Disallow rules for /css/, /js/, /static/, /assets/.

## Framework Specific Patterns

SEO configuration patterns available for Next.js (SSR/SSG, redirects, headers), Nuxt 3 (routeRules, prerender), NetSuite SuiteCommerce (SuiteScript redirects), and Shopify (Liquid meta tags, pagination, JSON-LD).

For all framework code patterns, load: ${CLAUDE_SKILL_DIR}/references/framework-patterns.md
