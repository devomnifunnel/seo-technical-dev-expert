---
name: netsuite-seo-audit
description: >
  Use when someone asks to run a NetSuite audit, SuiteCommerce SEO audit, NetSuite SEO review,
  or SPA audit for a NetSuite site. Trigger on: "NetSuite audit", "SuiteCommerce SEO",
  "NetSuite SEO", "SPA audit", "SuiteCommerce audit", "NetSuite rendering issues",
  "SCA SEO audit", "SC Standard SEO", "faceted navigation audit", "prerendering audit",
  "NetSuite product page SEO", "SuiteCommerce performance". This is the NetSuite SuiteCommerce
  specific SEO audit workflow covering SPA rendering, prerendering status, URL structure,
  faceted navigation, product schema, and SuiteScript implementation specs.
disable-model-invocation: true
argument-hint: "[client-name] [website-url] [suitecommerce-version: SCA or SC-Standard]"
allowed-tools: Read, Glob, Grep, Bash, WebFetch, WebSearch, Agent, Write
---

# NetSuite SuiteCommerce SEO Audit

NetSuite SuiteCommerce specific SEO review covering SPA rendering, prerendering status, URL structure, faceted navigation, and product schema. This deploys the NetSuite SEO Developer alongside technical SEO agents to produce a report with SuiteScript implementation specs.

## Context

The user wants an SEO audit specifically tailored to a NetSuite SuiteCommerce site. SuiteCommerce Advanced (SCA) and SuiteCommerce Standard present unique SEO challenges due to their single page application architecture, client side rendering, and NetSuite specific URL patterns. This audit goes beyond generic technical SEO to address SPA rendering pipelines, prerendering service configuration, faceted navigation crawl budget issues, and NetSuite module level optimization opportunities.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Website URL (required)
- SuiteCommerce version: SCA (SuiteCommerce Advanced) or SC Standard (required)
- SuiteCommerce theme and version (optional, if known)
- Known NetSuite SEO issues (optional, e.g., "pages not indexing," "duplicate URLs from facets")

## Instructions

### Step 0: Initialize Audit Tracking

Use TaskCreate to set up the audit task list:
- Create a parent task: "[Client] NetSuite SuiteCommerce SEO Audit" with description of scope
- Create subtasks for each phase: Client Context, SC Recon, Agent Deployment, Report Generation, Save Results
- Update each task status as you progress through phases

### Step 1: Load Client Context

Check `clients/{client-name}/` for existing profile and previous findings. Read any prior NetSuite specific analysis. If the client does not exist, create the directory structure. Note any previous SuiteCommerce configuration details.

### Step 2: SuiteCommerce Reconnaissance

Using Chrome tools, perform NetSuite specific site inspection:

1. Navigate to the homepage and observe initial page load behavior (SPA bootstrap sequence)
2. Navigate between pages and confirm SPA routing (no full page reloads)
3. View page source to check for server rendered vs client rendered content
4. Test a product page, category page, and content page for rendered HTML vs JavaScript shell
5. Check if a prerendering service is active (inspect User-Agent handling, check for prerender headers)
6. Review robots.txt for SuiteCommerce specific directives
7. Load XML sitemap and verify it includes all product, category, and content URLs
8. Test faceted navigation URLs for crawlability and canonical handling
9. Check URL structure patterns (e.g., /product/, /category/, hash fragments vs clean URLs)

### Step 3: Parallel Agent Deployment

Launch the following analyses simultaneously using subagents:

**Agent 1: NetSuite SEO Developer (primary)**
- Read `.claude/agents/netsuite-seo-developer.md` for full methodology
- **SPA Rendering Audit:** Verify Googlebot can fully render all critical content. Compare pre-render vs post-render HTML. Identify content that only appears after JavaScript execution.
- **Prerendering Service Assessment:** Check configuration, cache freshness, coverage, and response codes. Verify prerendered pages match live rendered pages.
- **URL Structure Analysis:** Audit SuiteCommerce URL patterns, parameter handling, and hash fragment usage. Identify URL canonicalization issues.
- **Faceted Navigation SEO:** Analyze how filters and facets generate URLs. Check for crawl budget waste from facet combinations. Verify canonical and noindex directives on facet pages.
- **NetSuite SEO Module Configuration:** Review meta tag handling, title tag templates, description generation, and canonical tag logic within NetSuite.
- **SuiteScript Opportunities:** Identify where custom SuiteScript can automate SEO improvements (dynamic meta tags, redirect management, sitemap generation).

**Agent 2: Technical SEO Auditor (supporting)**
- Read `.claude/agents/technical-seo-auditor.md` for methodology
- Standard technical SEO checks applied through the NetSuite lens
- Crawlability analysis with attention to SPA specific crawl traps
- Indexation audit checking for pages stuck in "Discovered, currently not indexed" due to rendering failures
- Mobile usability verification for SuiteCommerce responsive behavior
- Redirect handling within the SPA routing layer

**Agent 3: PageSpeed Optimizer (supporting)**
- Read `.claude/agents/pagespeed-optimizer.md` for methodology
- Core Web Vitals analysis with focus on SPA specific performance patterns
- JavaScript bundle analysis for SuiteCommerce frontend code
- Third party script impact (NetSuite tracking, payment processors, reviews)
- LCP optimization specific to SuiteCommerce product image loading
- CLS diagnosis for SuiteCommerce layout shift patterns (facet loading, product grid rendering)

**Agent 4: Schema Architect (supporting)**
- Read `.claude/agents/schema-architect.md` for methodology
- Product schema audit for NetSuite product pages (price, availability, reviews, SKU)
- BreadcrumbList schema for SuiteCommerce category hierarchy
- Organization schema with NetSuite specific implementation notes
- Verify schema is rendered in HTML (not just injected via JavaScript that Googlebot may miss)

### Step 4: Report Generation

Compile findings into a NetSuite specific SEO report:

1. **Executive Summary** with top issues specific to the SuiteCommerce implementation
2. **SPA Rendering Assessment** with pre-render vs post-render comparison and Googlebot rendering status
3. **Prerendering Service Status** with configuration findings and cache coverage
4. **URL Structure and Canonicalization** with SuiteCommerce URL pattern analysis
5. **Faceted Navigation Impact** with crawl budget analysis and recommended directives
6. **NetSuite Module Configuration** with current SEO settings and recommended changes
7. **Core Web Vitals for SuiteCommerce** with SPA specific performance findings
8. **Product Schema Compliance** with schema validation and rich result eligibility
9. **SuiteScript Implementation Specs** with custom code recommendations for SEO automation
10. **Prioritized Fix List** organized by Critical, High, Medium, Low with NetSuite specific implementation instructions

### Step 5: Save Results

1. Save the report to `clients/{client-name}/reports/{date}-netsuite-seo-audit.md`
2. Save individual findings to `clients/{client-name}/findings/`
3. Update `clients/{client-name}/profile.md` with SuiteCommerce version and configuration details
4. Update `clients/{client-name}/open-items.md` with all NetSuite SEO action items

## Output

The final deliverable is a NetSuite SuiteCommerce specific SEO report with SPA rendering analysis, prerendering assessment, faceted navigation recommendations, and a prioritized fix list. Each recommendation includes SuiteScript code snippets or NetSuite configuration steps where applicable. The report is designed for handoff to NetSuite developers who understand the SuiteCommerce platform.

## Dependencies

- Requires the NetSuite SEO Developer agent at .claude/agents/netsuite-seo-developer.md
- Requires Chrome browser access to navigate the SuiteCommerce site and inspect rendering behavior
- Requires the NetSuite SEO architecture framework at .claude/frameworks/netsuite-seo-architecture.md
