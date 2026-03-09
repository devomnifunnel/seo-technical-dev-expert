---
name: core-web-vitals
description: "Diagnosing and optimizing LCP, INP, and CLS with code examples. Use when performance is poor, Core Web Vitals are failing, or page speed needs improvement. Trigger on: Core Web Vitals, CWV, LCP, INP, CLS, page speed, performance budget, TTFB, slow pages, Lighthouse score."
argument-hint: "[URL to analyze]"
allowed-tools: Read, Write, Edit, Bash, Grep, Glob, WebFetch, mcp__pagespeed__, mcp__lighthouse__
---

# Core Web Vitals Diagnosis and Optimization
## Dynamic Context (auto-populated when invoked with URL)If a URL is provided via $ARGUMENTS, gather live data before analysis:- PageSpeed API: !`curl -s "https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=$ARGUMENTS&strategy=mobile&key=$PAGESPEED_API_KEY" 2>/dev/null | python -c "import sys,json;d=json.load(sys.stdin);c=d.get('lighthouseResult',{}).get('categories',{});print('Performance:',c.get('performance',{}).get('score','N/A'))" 2>/dev/null || echo "PageSpeed data not available"`- Use Lighthouse MCP and Chrome DevTools MCP for detailed metrics when available

## Metric Thresholds

| Metric | Good | Needs Improvement | Poor |
|--------|------|-------------------|------|
| LCP (Largest Contentful Paint) | 2.5s or less | 2.5s to 4.0s | Over 4.0s |
| INP (Interaction to Next Paint) | 200ms or less | 200ms to 500ms | Over 500ms |
| CLS (Cumulative Layout Shift) | 0.1 or less | 0.1 to 0.25 | Over 0.25 |

These thresholds apply to the 75th percentile of page loads, measured across both mobile and desktop traffic.

## LCP Optimization

LCP measures the time for the largest visible content element to render.

### Key Strategies

1. **Preload hero images** with `fetchpriority="high"`. Do NOT use `loading="lazy"` on LCP image. Use `decoding="sync"` or omit. Serve WebP/AVIF.
2. **Optimize TTFB** (target under 200ms): enable gzip/Brotli compression, HTTP/2, server side caching, CDN with edge locations, early hints (HTTP 103).
3. **Eliminate render blocking resources**: inline critical CSS, async load full stylesheet, defer/async non critical JS.
4. **Optimize fonts**: preload primary web font, preload CSS background images used for LCP.
5. **Responsive images**: use `srcset` and `sizes` to serve appropriately sized images.

For detailed code examples (Nginx config, critical CSS inlining, responsive images), load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## INP Optimization

INP measures latency from user interaction to next visual update. Replaced FID in March 2024.

### Key Strategies

1. **Break up long tasks** (anything over 50ms). Process in batches, yielding to main thread between batches.
2. **Yield to main thread** using `scheduler.yield()` (with setTimeout fallback) between critical visual updates and non critical work.
3. **Code splitting**: only load JS needed for current page. Dynamic imports for user triggered features.
4. **Tree shaking**: ensure bundler eliminates unused code. Target chunks under 50KB.
5. **Optimize event handlers**: debounce scroll/resize, passive listeners for touch/wheel, `requestAnimationFrame` for visual updates.

For code examples (task chunking, scheduler.yield, webpack config, debounce), load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## CLS Optimization

CLS measures unexpected visual shifts during the page lifecycle.

### Key Strategies

1. **Set explicit dimensions** on all images and videos (`width`/`height` attributes or CSS `aspect-ratio`).
2. **Reserve space** for dynamic content (banners, ads, cookie notices) using `min-height`.
3. **Use CSS containment** (`contain: layout style`, `content-visibility: auto`).
4. **Font loading**: use `font-display: optional` (zero CLS) or `swap` with size adjusted fallback. Preload 1 to 2 critical fonts only.
5. **Avoid injecting content above the fold** after initial render.

For code examples (aspect ratios, space reservation, containment, font fallbacks), load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Measurement Tools

### Lab Tools (Simulated)

| Tool | Best For |
|------|----------|
| Lighthouse | Quick audits with recommendations |
| PageSpeed Insights | Combined lab + field data |
| WebPageTest | Advanced waterfall, multi step tests |
| Chrome DevTools Performance | Frame by frame analysis, long tasks |

### Field Tools (Real User Data)

| Tool | Best For |
|------|----------|
| CrUX | Real world CWV at origin/URL level |
| Google Search Console | CWV status for all indexed pages |
| web-vitals.js | Custom RUM on your own site |

**Important:** Google uses 75th percentile of field data (CrUX) for ranking. Good lab scores do not guarantee good field scores.

### Field Data vs Lab Data

| Aspect | Lab Data | Field Data |
|--------|----------|------------|
| Source | Simulated | Real user browsers |
| Metric | LCP, CLS, TBT (proxy for INP) | LCP, INP, CLS |
| Speed | Immediate | 28 day collection |
| Use Case | Debugging, pre deployment | Monitoring, ranking signals |

For web-vitals.js implementation code, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Performance Budgets

Recommended budgets (KB): script 300, stylesheet 100, image 500, total 1500. Metric budgets: LCP 2500ms, CLS 0.1, TBT 200ms. Enforce in CI/CD using Lighthouse CI GitHub Actions.

For budget JSON config and GitHub Actions YAML, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Third Party Script Impact

Third party scripts (analytics, ads, chat, social) are often the largest CWV offenders.

**Audit process:** Network panel filter by third party > note transfer sizes > Performance panel for long tasks > Coverage panel for unused code.

**Mitigation strategies:**
1. Delay non essential scripts until first user interaction
2. Use facades for heavy embeds (YouTube, maps, chat)
3. Set 5 second fallback timeout
4. Categorize: essential, important, nice to have, unnecessary

For third party delay pattern and YouTube facade code, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Font Loading

| font-display Value | CLS Impact | Best For |
|-------------------|-----------|----------|
| `swap` | May cause CLS | Body text (with size adjusted fallback) |
| `optional` | Zero CLS | Body text (best for CLS) |
| `fallback` | Minimal CLS | Headings |
| `block` | No CLS but invisible text | Icon fonts only |

Preload only 1 to 2 critical fonts. `crossorigin` required even for same origin. Subsetting reduces size 50 to 80%.

## Resource Hints Decision Guide

| Hint | Cost | When to Use |
|------|------|-------------|
| `dns-prefetch` | Low (DNS only) | Third parties that might be needed |
| `preconnect` | Medium (DNS+TCP+TLS) | Third parties definitely needed |
| `preload` | High (full download) | Critical resources for current page |
| `prefetch` | Low (idle) | Resources for next likely page |

Limit preconnect to 2 to 4 hints. Only preload resources used within 3 seconds.

For resource hint HTML examples, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Implementation Checklist

### Immediate Wins (Week 1)
1. Add `width`/`height` to all images and videos
2. Preload LCP image with `fetchpriority="high"`
3. Add `loading="lazy"` to all below fold images
4. Set `font-display: swap` or `optional` on all @font-face
5. Add 2 to 4 `preconnect` hints for critical third party origins

### Short Term (Weeks 2 to 4)
6. Inline critical CSS and async load full stylesheet
7. Defer or async all non critical JavaScript
8. Implement responsive images with `srcset`/`sizes`
9. Reserve space for ad slots and dynamic content
10. Delay non essential third party scripts

### Medium Term (Month 2)
11. Enable Brotli/gzip compression
12. Configure CDN with cache headers
13. Subset and preload web fonts
14. Implement code splitting
15. Use facades for heavy embeds

### Ongoing
16. Set up web-vitals.js RUM
17. Configure performance budgets in CI/CD
18. Review CrUX data monthly
19. Audit third party impact quarterly
20. Test CWV after every major deployment
