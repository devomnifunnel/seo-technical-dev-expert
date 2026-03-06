---
name: pagespeed-audit
description: >
  Use when someone asks about pagespeed, Core Web Vitals, CWV audit, page speed issues,
  performance audit, or specific metrics like LCP, CLS, or INP. Trigger on: "pagespeed",
  "Core Web Vitals", "CWV audit", "page speed", "performance audit", "LCP", "CLS", "INP",
  "site is slow", "speed optimization", "Lighthouse audit", "web vitals", "TTFB",
  "page load time", "render blocking", "JavaScript bundle size", "third party scripts slow".
  This is the deep dive CWV and page speed performance audit covering LCP, INP, CLS diagnosis,
  resource auditing, rendering analysis, and third party script impact with code level fixes.
disable-model-invocation: true
argument-hint: "[client-name] [website-url]"
allowed-tools: Read, Glob, Grep, Bash, WebFetch, WebSearch, Agent, Write
---

# PageSpeed and Core Web Vitals Audit

Deep dive into Core Web Vitals and page speed performance covering LCP, INP, CLS diagnosis, resource auditing, rendering analysis, and third party script impact. This deploys the PageSpeed Optimizer as the primary agent with Technical SEO Auditor in a supporting role.

## Context

The user wants a focused performance audit when Core Web Vitals are failing, page load times are unacceptable, or when Google Search Console is flagging CWV issues. This audit goes beyond surface level speed scores to diagnose root causes at the code level and produce specific, implementable fixes with a performance budget.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Website URL (required)
- Specific pages to test (optional, defaults to key page templates: homepage, product/service page, category/listing page, blog post, contact page)
- Known speed issues (optional, e.g., "LCP failing on mobile," "CLS spikes on product pages")

## Instructions

### Step 0: Initialize Audit Tracking

Use TaskCreate to set up the audit task list:
- Create a parent task: "[Client] PageSpeed and CWV Audit" with description of scope
- Create subtasks: Client Context, Performance Baseline, PageSpeed Agent, Technical Agent, Report Generation, Save Results
- Update each task status as you progress through phases

### Step 1: Load Client Context

Check `clients/{client-name}/` for existing profile and previous performance data. Read any prior CWV reports to establish baseline. If the client does not exist, create the directory structure.

### Step 2: Performance Baseline Capture

Using Chrome tools, establish current performance baselines:

1. Navigate to each target page template and observe load behavior
2. Capture the visible loading sequence: what appears first, what shifts, what loads late
3. Identify the LCP element on each page (hero image, heading, product image)
4. Note any visible layout shifts during page load
5. Test interactive elements for responsiveness (buttons, menus, forms)
6. Check network waterfall for resource loading order and bottlenecks
7. Identify render blocking resources in the document head
8. Note third party scripts loading during initial page render

### Step 3: Parallel Agent Deployment

Launch the following analyses simultaneously using subagents:

**Agent 1: PageSpeed Optimizer (primary)**
- Read `.claude/agents/pagespeed-optimizer.md` for full methodology
- **LCP Diagnosis:** Identify the LCP element on each page template. Trace the critical path from initial request to LCP render. Measure TTFB, resource load time, render delay. Identify specific bottlenecks (slow server response, large images, render blocking CSS/JS, late discovered resources).
- **INP Diagnosis:** Identify the slowest interactions on each page. Measure input delay, processing time, and presentation delay. Check for long tasks blocking the main thread. Analyze JavaScript execution patterns during user interaction.
- **CLS Diagnosis:** Identify all layout shift sources. Check for images and iframes without dimensions. Detect dynamically injected content above the fold. Analyze font loading behavior (FOIT/FOUT causing shifts). Check ad slots and third party embeds for dimension reservation.
- **Resource Audit:** Catalog all JavaScript files with bundle sizes. Identify unused JavaScript and CSS. Check image formats (WebP/AVIF adoption), compression, and responsive sizing (srcset). Analyze CSS delivery (critical CSS extraction, unused CSS).
- **Server and Caching:** Measure TTFB across page templates. Check browser caching headers (Cache-Control, ETag). Assess CDN configuration and edge caching. Review compression (Brotli/Gzip).
- **Third Party Impact:** Catalog all third party scripts with load timing and main thread impact. Identify scripts that block rendering or delay interactivity. Recommend loading strategies (defer, async, facade patterns).
- **Font Optimization:** Check font loading strategy (display swap, preload). Identify font file sizes and format (WOFF2). Check for font subsetting opportunities.

**Agent 2: Technical SEO Auditor (supporting)**
- Read `.claude/agents/technical-seo-auditor.md` for methodology
- Cross reference CWV findings with GSC Core Web Vitals report data
- Verify that CWV issues align with index coverage patterns (poor CWV affecting crawl budget)
- Check whether mobile vs desktop performance differences impact mobile first indexing
- Assess resource hint usage (preconnect, prefetch, preload, dns-prefetch)

### Step 4: Report Generation

Compile findings into a CWV performance report:

1. **Executive Summary** with current CWV pass/fail status and top performance bottlenecks
2. **CWV Scorecard** with LCP, INP, CLS scores for each tested page template (mobile and desktop)
3. **LCP Analysis** with element identification, critical path breakdown, and specific fixes
4. **INP Analysis** with interaction profiling, long task identification, and optimization steps
5. **CLS Analysis** with shift source identification, dimension fixes, and loading order corrections
6. **Resource Audit Results** with JavaScript, CSS, image, and font optimization opportunities
7. **Third Party Script Report** with impact assessment and recommended loading strategies
8. **Server and Caching Assessment** with TTFB findings and caching improvements
9. **Performance Budget** defining target budgets for JavaScript, images, CSS, fonts, and total page weight
10. **Prioritized Fix List** with each fix including code level implementation instructions and expected CWV improvement

### Step 5: Save Results

1. Save the report to `clients/{client-name}/reports/{date}-pagespeed-audit.md`
2. Save individual findings to `clients/{client-name}/findings/`
3. Update `clients/{client-name}/open-items.md` with all performance action items

## Output

The final deliverable is a Core Web Vitals performance report with specific code level fixes for LCP, INP, and CLS issues. Each fix includes the current metric value, expected improvement, implementation code or configuration change, and testing instructions. The report includes a performance budget for ongoing monitoring and a prioritized implementation order designed to achieve CWV "Good" thresholds (LCP < 2.5s, INP < 200ms, CLS < 0.1) as efficiently as possible.

## Dependencies

- Requires Chrome browser access to navigate pages and inspect network/rendering behavior
- Requires the CWV remediation framework at .claude/frameworks/cwv-remediation.md
