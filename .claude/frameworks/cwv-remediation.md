# Core Web Vitals Triage and Remediation

## Purpose
This framework provides a structured methodology for diagnosing, prioritizing, and remediating Core Web Vitals (CWV) issues. It defines target thresholds, diagnostic decision trees, and before/after measurement protocols. All CWV analysis tasks reference this document.

---

## 1. Target Thresholds

| Metric | Good           | Needs Improvement | Poor           |
|--------|----------------|-------------------|----------------|
| LCP    | Under 2.5s     | 2.5s to 4.0s      | Over 4.0s      |
| INP    | Under 200ms    | 200ms to 500ms    | Over 500ms     |
| CLS    | Under 0.1      | 0.1 to 0.25       | Over 0.25      |

These thresholds apply to the 75th percentile of page loads, measured across both mobile and desktop. Field data (real user measurements) is the definitive source. Lab data (Lighthouse, WebPageTest) is used for diagnosis and pre deployment validation.

---

## 2. CWV Triage Framework

### Step 1: Measure
- Pull field data from Chrome User Experience Report (CrUX) via PageSpeed Insights or BigQuery
- Pull GSC Core Web Vitals report to identify pages and page groups failing thresholds
- Run Lighthouse on representative pages for lab baseline
- Record baseline metrics with timestamps for before/after comparison

### Step 2: Identify the Bottleneck
- Determine which metric is failing: LCP, INP, CLS, or multiple
- For pages failing multiple metrics, prioritize by this order: LCP first (most common ranking factor), then CLS (often easiest to fix), then INP (often most complex)
- Identify whether the issue is sitewide or isolated to specific page types

### Step 3: Fix Highest Impact First
- Address sitewide issues before page specific issues
- Prioritize fixes that affect the most URLs (e.g., a shared header causing CLS across all pages)
- Estimate the number of affected pages and the severity of the failure for each issue
- Implement fixes in order of impact per effort

---

## 3. LCP Optimization Decision Tree

LCP measures the render time of the largest visible element (typically a hero image, video, or large text block). Walk through each node in order.

### Node 1: Server Response Time (TTFB)
**Check**: Is TTFB over 800ms?
- Optimize server configuration (caching, database queries, application logic)
- Implement a CDN for static assets and consider edge caching for dynamic pages
- Enable HTTP/2 or HTTP/3
- Reduce server side processing (optimize SuiteScript for NetSuite, reduce WordPress plugin load)
- Target: TTFB under 800ms, ideally under 200ms

### Node 2: Render Blocking Resources
**Check**: Are CSS or JS files blocking the initial render?
- Inline critical CSS (the CSS needed for above the fold content)
- Defer non critical CSS using `media="print"` with `onload` swap or async loading
- Defer non critical JavaScript using `defer` or `async` attributes
- Remove unused CSS and JS (audit with Chrome DevTools Coverage tab)
- Target: No render blocking resources for above the fold content

### Node 3: Resource Load Time
**Check**: Is the LCP element (image or video) slow to load?
- Preload the LCP image using `<link rel="preload" as="image">`
- Serve images in modern formats (WebP, AVIF) with appropriate compression
- Use responsive images with `srcset` and `sizes` attributes
- Implement a CDN for image delivery
- Avoid lazy loading the LCP image (it should be eagerly loaded)
- Reduce image file size (target under 200KB for hero images)
- Target: LCP resource loads within 1 second of navigation start

### Node 4: Element Render Time
**Check**: Is the LCP element present in HTML but slow to render?
- Ensure the LCP element is in the initial HTML, not injected by JavaScript
- Minimize DOM size (target under 1,500 elements)
- Avoid CSS properties that trigger expensive layout or paint operations on the LCP element
- Check for web font loading delays if the LCP element is text based
- Target: LCP element renders within 500ms of resource load completion

---

## 4. INP Diagnosis Methodology

INP (Interaction to Next Paint) measures the responsiveness of a page to user interactions (clicks, taps, key presses). A good INP means the page responds to interactions within 200ms.

### Step 1: Identify Slow Interactions
- Use Chrome DevTools Performance panel to record user interactions
- Check the INP attribution data in CrUX for the specific interaction types causing failures
- Use the Web Vitals JavaScript library with attribution build to log slow interactions in the field
- Common culprits: form submissions, dropdown menus, search inputs, add to cart buttons, accordion toggles

### Step 2: Break Down the Interaction
Every interaction has three phases. Identify which phase is the bottleneck:

#### Input Delay (time before processing starts)
- Caused by long tasks running on the main thread when the user interacts
- Identify long tasks (over 50ms) using Chrome DevTools Performance panel
- Common causes: large JavaScript bundles executing, third party scripts (analytics, chat widgets, ad scripts), expensive DOM operations
- Fix: Break long tasks into smaller chunks using `requestIdleCallback`, `setTimeout`, or yielding patterns

#### Processing Time (event handler execution)
- Caused by expensive logic in event handlers
- Profile event handlers using Chrome DevTools
- Common causes: synchronous DOM reads/writes, complex state calculations, unoptimized loops
- Fix: Optimize event handler logic, debounce rapid fire events, move heavy computation to Web Workers

#### Presentation Delay (rendering the visual update)
- Caused by expensive layout, paint, or compositing after the event handler completes
- Common causes: forced reflows (reading layout properties after DOM writes), animating expensive CSS properties (width, height, top, left), large DOM updates
- Fix: Use CSS transforms and opacity for animations, batch DOM reads and writes, reduce the scope of style recalculations

### Step 3: Remediate
- Address the largest phase first
- Test interactions after each fix to verify improvement
- Monitor field INP data over the following 28 days (CrUX rolling average window)

---

## 5. CLS Root Cause Analysis

CLS measures unexpected layout shifts during the page lifecycle. Each layout shift is scored based on the fraction of the viewport affected and the distance elements moved.

### Root Cause 1: Images and Videos Without Dimensions
- **Symptom**: Content jumps when images or video load and push surrounding elements down
- **Fix**: Always include `width` and `height` attributes on `<img>` and `<video>` elements
- **Alternative**: Use CSS `aspect-ratio` property to reserve space
- **Verification**: Load the page on a throttled connection and observe if the layout shifts when media loads

### Root Cause 2: Dynamic Content Injection
- **Symptom**: Banners, notifications, cookie consent bars, or promotional elements inject above existing content, pushing it down
- **Fix**: Reserve space for dynamic elements using CSS (min-height on containers), or overlay dynamic elements rather than inserting them into the flow
- **Common offenders**: Cookie consent banners, email signup popups, promotional header bars, A/B testing scripts that modify DOM structure
- **Best practice**: Insert dynamic content below the fold or use overlay/modal patterns that do not shift existing content

### Root Cause 3: Web Font Loading
- **Symptom**: Text renders in a fallback font, then shifts when the custom font loads (Flash of Unstyled Text, or FOUT)
- **Fix**: Use `font-display: swap` combined with a closely matched fallback font to minimize shift
- **Advanced fix**: Use `font-display: optional` if the brand font is not critical, or preload key font files using `<link rel="preload" as="font" crossorigin>`
- **Measurement**: Compare the layout of the fallback font vs the custom font; adjust fallback font size using CSS `size-adjust`, `ascent-override`, and `descent-override`

### Root Cause 4: Late Loading Advertisements and Embeds
- **Symptom**: Ad slots collapse to zero height, then expand when the ad loads
- **Fix**: Define fixed dimensions for ad containers (min-height matching the ad size)
- **For responsive ads**: Set a minimum height based on the smallest expected ad size
- **Third party embeds** (YouTube, Twitter, maps): Use a placeholder container with defined dimensions, then load the embed within it

### Root Cause 5: Dynamically Resized Elements
- **Symptom**: Elements change size after user interaction or asynchronous data load
- **Fix**: Use CSS containment (`contain: layout`) to prevent layout shifts from propagating
- **Fix**: Animate size changes using CSS transforms rather than changing actual dimensions

---

## 6. Performance Budget Methodology

### Establishing a Performance Budget

| Resource Type     | Budget (Mobile)  | Budget (Desktop) | Notes                                      |
|-------------------|------------------|------------------|--------------------------------------------|
| Total page weight | Under 1.5 MB     | Under 3 MB       | Compressed transfer size                   |
| JavaScript        | Under 300 KB     | Under 500 KB     | Compressed; under 1 MB uncompressed        |
| CSS               | Under 100 KB     | Under 150 KB     | Compressed                                 |
| Images            | Under 800 KB     | Under 1.5 MB     | Total for above the fold and visible images|
| Web fonts         | Under 100 KB     | Under 150 KB     | Limit to 2 to 3 font files                |
| Third party       | Under 200 KB     | Under 300 KB     | Total for all third party scripts          |

### Budget Enforcement
- Integrate performance budgets into CI/CD pipeline using Lighthouse CI or bundlesize
- Fail builds that exceed JavaScript or total page weight budgets
- Review third party script additions against the third party budget before deployment
- Audit page weight quarterly and after major feature releases

### Third Party Script Management
- Inventory all third party scripts with their purpose, load method, and resource cost
- Categorize as essential (analytics, payment), important (chat, reviews), or optional (social widgets, non critical tracking)
- Defer or lazy load non essential third party scripts
- Load third party scripts after the `load` event or on user interaction (scroll, click)
- Monitor third party performance impact using Chrome DevTools Network panel and Performance panel

---

## 7. Before/After Measurement Protocol

### Pre Fix Baseline (Required Before Any Remediation)
1. Record CrUX field data for affected pages (LCP, INP, CLS at 75th percentile)
2. Run Lighthouse on affected pages (minimum 3 runs, use median scores)
3. Run WebPageTest on affected pages (3 runs, median, mobile 4G throttling)
4. Screenshot the GSC Core Web Vitals report
5. Document the date, URL, device type, and connection speed for each test
6. Save all raw data and reports

### Post Fix Validation
1. **Lab validation (immediate)**: Run Lighthouse and WebPageTest with identical settings to baseline
2. **Staging verification**: Test on staging before deploying to production
3. **Production lab test**: Run Lighthouse and WebPageTest on production within 24 hours of deployment
4. **Field data monitoring**: Monitor CrUX data over the following 28 days (the CrUX rolling window)
5. **GSC verification**: Check GSC Core Web Vitals report after 28 days for reclassification

### Reporting the Results
| Metric | Baseline (Before) | Target     | Result (After) | Status     |
|--------|--------------------|------------|----------------|------------|
| LCP    | [value]            | Under 2.5s | [value]        | Pass/Fail  |
| INP    | [value]            | Under 200ms| [value]        | Pass/Fail  |
| CLS    | [value]            | Under 0.1  | [value]        | Pass/Fail  |

Include:
- Absolute improvement (e.g., LCP improved from 4.2s to 2.1s)
- Percentage improvement (e.g., 50% reduction in LCP)
- Number of URLs reclassified from Poor/Needs Improvement to Good in GSC

---

## 8. Common CWV Fixes Quick Reference

| Issue                              | Metric | Fix                                                  | Effort   |
|------------------------------------|--------|-------------------------------------------------------|----------|
| Unoptimized hero image             | LCP    | Compress, convert to WebP, preload                    | Low      |
| Render blocking CSS/JS             | LCP    | Inline critical CSS, defer non critical resources     | Medium   |
| Slow TTFB                          | LCP    | CDN, server caching, optimize backend                 | High     |
| LCP image lazy loaded              | LCP    | Remove lazy loading from LCP image                    | Low      |
| Images without dimensions          | CLS    | Add width/height attributes                           | Low      |
| Cookie banner injection            | CLS    | Overlay or reserve space                              | Low      |
| Web font FOUT                      | CLS    | Preload fonts, use font-display: swap with fallback   | Medium   |
| Ad slots without min-height        | CLS    | Define container dimensions                           | Low      |
| Heavy third party scripts          | INP    | Defer, lazy load, or remove                           | Medium   |
| Expensive event handlers           | INP    | Optimize logic, debounce, use Web Workers             | High     |
| Large DOM size                     | INP    | Reduce DOM elements, virtualize lists                 | High     |
| Synchronous DOM reads in handlers  | INP    | Batch reads/writes, use requestAnimationFrame         | Medium   |
