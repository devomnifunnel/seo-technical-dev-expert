---
name: technical-audit
description: >
  Use when someone asks for a technical audit, technical SEO audit, crawlability review,
  or indexation audit. Trigger on: "technical audit", "technical SEO audit", "crawlability",
  "indexation audit", "technical health check", "crawl errors", "rendering issues",
  "robots.txt audit", "sitemap audit", "redirect audit", "site migration audit",
  "pages not being indexed", "technical SEO review", "infrastructure audit".
  This is the focused technical SEO audit workflow covering crawlability, indexation,
  rendering, page speed, structured data, and security without the broader content,
  link, or competitive analysis.
disable-model-invocation: true
argument-hint: "[client-name] [website-url]"
allowed-tools: Read, Glob, Grep, Bash, WebFetch, WebSearch, Agent, Write
---

# Technical SEO Audit

Focused technical SEO audit covering crawlability, indexation, rendering, page speed, structured data, and security. This deploys the three core technical agents to produce a prioritized fix list with implementation specs.

## Context

The user wants a technical SEO audit without the broader content, link, or competitive analysis. This is appropriate when there are known technical issues, after a site migration, when diagnosing ranking drops caused by infrastructure problems, or as a periodic technical health check.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Website URL (required)
- Specific technical concerns (optional, e.g., "site was recently migrated," "pages not being indexed," "slow load times")

## Instructions

### Step 0: Initialize Audit Tracking

Use TaskCreate to set up the audit task list:
- Create a parent task: "[Client] Technical SEO Audit" with description of scope
- Create subtasks: Client Context, Browser Inspection, Technical Agent, PageSpeed Agent, Schema Agent, Report Generation, Save Results
- Update each task status as you progress through phases

### Step 1: Load Client Context

Check `clients/{client-name}/` for existing profile and previous audit findings. If the client exists, read their full history to understand what has already been identified and fixed. If not, create the client directory structure.

### Step 2: Browser Based Technical Inspection

Using Chrome tools, perform initial technical reconnaissance:

1. Navigate to the homepage and key landing pages
2. Check robots.txt for unintended blocks or misconfiguration
3. Load XML sitemap(s) and verify accessibility
4. Inspect page source for rendering behavior (SPA vs server rendered)
5. Check HTTP response headers for caching, security, and redirect behavior
6. Note the tech stack: CMS, JavaScript frameworks, CDN, hosting provider
7. Test mobile rendering by resizing the viewport

### Step 3: Parallel Agent Deployment

Launch the following analyses simultaneously using subagents:

**Agent 1: Technical SEO Auditor (primary)**
- Read `.claude/agents/technical-seo-auditor.md` for full methodology
- Crawlability: robots.txt, XML sitemaps, crawl budget, internal link structure
- Indexation: canonical tags, meta robots, noindex directives, index coverage
- Rendering: JavaScript rendering, SPA issues, Googlebot compatibility
- URL structure: redirect chains, 404 errors, orphan pages, parameter handling
- Mobile: responsive design, mobile usability, viewport configuration
- Security: HTTPS, mixed content, security headers, HSTS
- International: hreflang implementation (if applicable)

**Agent 2: PageSpeed Optimizer (supporting)**
- Read `.claude/agents/pagespeed-optimizer.md` for methodology
- Core Web Vitals measurement: LCP, INP, CLS for key page templates
- Resource audit: JavaScript bundle sizes, CSS delivery, image optimization
- Server response: TTFB analysis, caching headers, CDN configuration
- Third party impact: identify performance draining external scripts
- Render blocking resources and critical rendering path analysis

**Agent 3: Schema Architect (supporting)**
- Read `.claude/agents/schema-architect.md` for methodology
- Extract and validate all existing JSON-LD structured data
- Check for schema errors, warnings, and missing required properties
- Assess rich result eligibility for each page template
- Identify missing schema opportunities (Organization, Product, BreadcrumbList, FAQ)

### Step 4: Report Generation

Compile findings into a technical audit report:

1. **Executive Summary** with top 5 technical issues ranked by SEO impact
2. **Crawlability Assessment** with robots.txt, sitemap, and crawl budget findings
3. **Indexation Health** with canonical, meta robots, and coverage analysis
4. **Rendering Analysis** with JavaScript rendering and SPA specific findings
5. **Core Web Vitals Report** with LCP, INP, CLS scores and fix specifications
6. **Structured Data Audit** with validation results and rich result eligibility
7. **Security and Headers** with HTTPS, HSTS, and security header status
8. **Prioritized Fix List** with each issue categorized as Critical, High, Medium, or Low
9. **Implementation Specs** with code level fixes and developer handoff details

### Step 5: Save Results

1. Save the report to `clients/{client-name}/reports/{date}-technical-audit.md`
2. Save individual findings to `clients/{client-name}/findings/`
3. Update `clients/{client-name}/open-items.md` with all technical action items

## Output

The final deliverable is a technical SEO audit report with a prioritized fix list. Each issue includes severity ranking, SEO impact explanation, and specific implementation instructions suitable for direct developer handoff. Critical issues that block indexing or revenue are flagged at the top for immediate action.
