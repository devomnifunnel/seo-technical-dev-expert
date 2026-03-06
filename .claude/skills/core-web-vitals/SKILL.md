---
name: core-web-vitals
description: "Diagnosing and optimizing LCP, INP, and CLS with code examples. Use when performance is poor, Core Web Vitals are failing, or page speed needs improvement. Trigger on: Core Web Vitals, CWV, LCP, INP, CLS, page speed, performance budget, TTFB, slow pages, Lighthouse score."
argument-hint: "[url]"
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

LCP measures the time it takes for the largest visible content element (image, video, or text block) to render on screen.

### Preload Hero Images

The LCP element is frequently a hero image. Preloading ensures the browser fetches it as early as possible.

```html
<!-- Preload the LCP image in the <head> -->
<link rel="preload" as="image" href="/images/hero-banner.webp" type="image/webp" fetchpriority="high" />

<!-- On the image element itself -->
<img src="/images/hero-banner.webp"
     alt="Spring sale promotional banner"
     width="1200"
     height="600"
     fetchpriority="high"
     decoding="sync" />
```

**Key points:**

- Use `fetchpriority="high"` on the LCP image to prioritize its download.
- Do NOT use `loading="lazy"` on the LCP image. Lazy loading delays the LCP element.
- Use `decoding="sync"` or omit the `decoding` attribute for the LCP image. Using `decoding="async"` can delay paint.
- Serve images in WebP or AVIF format for smaller file sizes.

### Optimize Server Response Time (TTFB)

A slow Time to First Byte delays everything. Target TTFB under 200ms.

**Server side optimizations:**

```nginx
# Nginx: Enable gzip compression
gzip on;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml text/javascript image/svg+xml;
gzip_min_length 256;
gzip_vary on;

# Enable HTTP/2
listen 443 ssl http2;

# Server-side caching
location ~* \.(jpg|jpeg|png|gif|webp|avif|ico|css|js|woff2)$ {
    expires 1y;
    add_header Cache-Control "public, immutable";
}

# Enable Brotli compression (if module installed)
brotli on;
brotli_types text/plain text/css application/json application/javascript text/xml application/xml text/javascript image/svg+xml;
brotli_comp_level 6;
```

**CDN configuration:**

- Use a CDN to serve static assets from edge locations close to users.
- Configure appropriate cache TTLs: 1 year for versioned assets, shorter for HTML.
- Enable early hints (HTTP 103) if your CDN supports it.

### Eliminate Render Blocking Resources

CSS and synchronous JavaScript in the `<head>` block rendering until they are downloaded and parsed.

**Critical CSS inlining:**

```html
<head>
    <!-- Inline critical CSS for above-the-fold content -->
    <style>
        /* Critical CSS: only styles needed for initial viewport */
        body { margin: 0; font-family: system-ui, sans-serif; }
        .hero { position: relative; width: 100%; height: 60vh; }
        .hero img { width: 100%; height: 100%; object-fit: cover; }
        .nav { display: flex; padding: 16px 24px; background: #fff; }
        /* ... minimal above-the-fold styles ... */
    </style>

    <!-- Load full CSS asynchronously -->
    <link rel="preload" href="/css/main.css" as="style" onload="this.onload=null;this.rel='stylesheet'" />
    <noscript><link rel="stylesheet" href="/css/main.css" /></noscript>
</head>
```

**Defer non critical JavaScript:**

```html
<!-- Bad: render-blocking -->
<script src="/js/analytics.js"></script>

<!-- Good: deferred (downloads in parallel, executes after parsing) -->
<script src="/js/analytics.js" defer></script>

<!-- Good: async (downloads in parallel, executes when ready) -->
<script src="/js/non-critical-widget.js" async></script>
```

**Decision guide:**

- `defer`: Use for scripts that need the full DOM and should execute in order.
- `async`: Use for independent scripts that do not depend on DOM or other scripts (analytics, ads).
- Inline `<script>`: Use only for tiny, critical scripts (under 1KB).

### Optimize the Largest Element

If the LCP element is a text block, ensure fonts load quickly:

```html
<!-- Preload the primary web font -->
<link rel="preload" href="/fonts/inter-v12-latin-regular.woff2" as="font" type="font/woff2" crossorigin />
```

If the LCP element is a background image set via CSS, preload it explicitly:

```html
<link rel="preload" as="image" href="/images/hero-bg.webp" type="image/webp" />
```

**Responsive image optimization for LCP:**

```html
<img srcset="/images/hero-400.webp 400w,
             /images/hero-800.webp 800w,
             /images/hero-1200.webp 1200w,
             /images/hero-1600.webp 1600w"
     sizes="100vw"
     src="/images/hero-1200.webp"
     alt="Product showcase"
     width="1600"
     height="800"
     fetchpriority="high" />
```

## INP Optimization

INP (Interaction to Next Paint) measures the latency from user interaction (click, tap, keypress) to the next visual update. It replaced FID in March 2024.

### Break Up Long Tasks

Any JavaScript task running longer than 50ms is a "long task" that blocks the main thread and delays interactions.

**Before (long task):**

```javascript
// This processes all items in one synchronous block
function processAllItems(items) {
    items.forEach(item => {
        // Heavy computation per item
        calculateMetrics(item);
        updateDOM(item);
        logAnalytics(item);
    });
}
```

**After (broken into smaller chunks):**

```javascript
// Process items in batches, yielding to the main thread between batches
async function processAllItems(items) {
    const BATCH_SIZE = 10;
    for (let i = 0; i < items.length; i += BATCH_SIZE) {
        const batch = items.slice(i, i + BATCH_SIZE);
        batch.forEach(item => {
            calculateMetrics(item);
            updateDOM(item);
            logAnalytics(item);
        });
        // Yield to the main thread
        await yieldToMain();
    }
}

function yieldToMain() {
    return new Promise(resolve => {
        setTimeout(resolve, 0);
    });
}
```

### Yield to the Main Thread

Use `scheduler.yield()` (where supported) or `setTimeout` to break up work:

```javascript
// Modern approach using scheduler.yield (with fallback)
async function handleExpensiveClick() {
    // Phase 1: Critical visual update
    updateButtonState();

    // Yield so the browser can paint
    if ('scheduler' in window && 'yield' in scheduler) {
        await scheduler.yield();
    } else {
        await new Promise(resolve => setTimeout(resolve, 0));
    }

    // Phase 2: Non-critical work
    sendAnalyticsEvent();
    updateRecommendations();
}
```

### Reduce JavaScript Execution

**Code splitting:** Only load the JavaScript needed for the current page.

```javascript
// Dynamic import: load modules only when needed
document.getElementById('search-btn').addEventListener('click', async () => {
    const { initSearch } = await import('./search-module.js');
    initSearch();
});
```

**Tree shaking:** Ensure your bundler eliminates unused code.

```javascript
// webpack.config.js
module.exports = {
    mode: 'production', // Enables tree shaking
    optimization: {
        usedExports: true,
        sideEffects: true,
        splitChunks: {
            chunks: 'all',
            maxSize: 50000 // Split chunks larger than 50KB
        }
    }
};
```

### Optimize Event Handlers

**Debounce rapid fire events:**

```javascript
// Debounce scroll and resize handlers
function debounce(fn, delay) {
    let timer;
    return function(...args) {
        clearTimeout(timer);
        timer = setTimeout(() => fn.apply(this, args), delay);
    };
}

window.addEventListener('scroll', debounce(handleScroll, 100));
window.addEventListener('resize', debounce(handleResize, 150));
```

**Use passive event listeners for touch and scroll:**

```javascript
// Passive listeners tell the browser the handler won't call preventDefault()
// This allows scrolling to proceed without waiting for the handler
document.addEventListener('touchstart', handleTouch, { passive: true });
document.addEventListener('wheel', handleWheel, { passive: true });
```

**Use `requestAnimationFrame` for visual updates:**

```javascript
// Schedule visual updates to align with browser paint cycles
function onScroll() {
    requestAnimationFrame(() => {
        updateStickyHeader();
        updateScrollProgress();
    });
}
```

## CLS Optimization

CLS measures unexpected visual shifts during the page lifecycle. Every time a visible element moves without user initiation, it contributes to the CLS score.

### Set Explicit Dimensions on Images and Videos

The most common CLS cause is images and videos loading without reserved space.

```html
<!-- Always include width and height attributes -->
<img src="product.webp" alt="Product photo" width="800" height="600" loading="lazy" />

<!-- For responsive images, use CSS aspect-ratio -->
<style>
    .responsive-img {
        width: 100%;
        height: auto;
        aspect-ratio: 4 / 3;
    }
</style>
<img class="responsive-img" src="product.webp" alt="Product photo" loading="lazy" />

<!-- Video embeds -->
<div style="aspect-ratio: 16 / 9; width: 100%;">
    <iframe src="https://www.youtube.com/embed/abc123"
            style="width: 100%; height: 100%;"
            loading="lazy"
            title="Tutorial video"></iframe>
</div>
```

### Avoid Dynamic Content Injection Above the Fold

Banners, cookie notices, and ads injected above existing content push everything down.

**Bad pattern (causes CLS):**

```javascript
// Injecting a banner at the top pushes all content down
const banner = document.createElement('div');
banner.innerHTML = 'Special announcement!';
document.body.prepend(banner);
```

**Good pattern (reserve space):**

```html
<!-- Reserve space in the HTML even before content loads -->
<div id="announcement-slot" style="min-height: 60px;">
    <!-- Banner content will load here without shifting -->
</div>
```

```css
/* Reserve space for ad slots */
.ad-container {
    min-height: 250px; /* Match expected ad height */
    min-width: 300px;
    background: #f0f0f0; /* Placeholder background */
    contain: layout;
}
```

### Use CSS Containment

CSS `contain` property limits the scope of layout recalculations:

```css
/* Contain layout changes within specific sections */
.product-card {
    contain: layout style;
}

.sidebar-widget {
    contain: layout paint;
}

/* content-visibility improves rendering performance for below-fold content */
.below-fold-section {
    content-visibility: auto;
    contain-intrinsic-size: auto 500px; /* Estimated height */
}
```

### Preload Fonts to Prevent FOIT/FOUT

Font swaps cause layout shifts when the web font replaces the fallback font.

```css
/* Use font-display: optional to eliminate font swap CLS entirely */
@font-face {
    font-family: 'Inter';
    src: url('/fonts/inter-regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
    font-display: optional; /* No swap = no CLS from fonts */
}

/* Alternative: font-display: swap with size-adjusted fallback */
@font-face {
    font-family: 'Inter';
    src: url('/fonts/inter-regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
    font-display: swap;
}

/* Size-adjusted fallback reduces CLS from font swap */
@font-face {
    font-family: 'Inter Fallback';
    src: local('Arial');
    size-adjust: 107%;
    ascent-override: 90%;
    descent-override: 22%;
    line-gap-override: 0%;
}

body {
    font-family: 'Inter', 'Inter Fallback', system-ui, sans-serif;
}
```

## Measurement Tools

### Lab Tools (Simulated Conditions)

| Tool | Best For | Access |
|------|----------|--------|
| Lighthouse | Quick audits with actionable recommendations | Chrome DevTools, CLI, PageSpeed Insights |
| PageSpeed Insights | Combined lab + field data per URL | web.dev/measure |
| WebPageTest | Advanced waterfall analysis, multi step tests, video comparison | webpagetest.org |
| Chrome DevTools Performance Panel | Frame by frame performance analysis, long task identification | Chrome F12 |

### Field Tools (Real User Data)

| Tool | Best For | Access |
|------|----------|--------|
| CrUX (Chrome User Experience Report) | Real world CWV data at origin and URL level | BigQuery, PageSpeed Insights, Search Console |
| Google Search Console | CWV status for all indexed pages, grouped by issue | Search Console > Core Web Vitals |
| web-vitals.js | Custom real user monitoring on your own site | npm package or CDN |

### Implementing web-vitals.js

```html
<!-- Load the web-vitals library -->
<script type="module">
    import { onLCP, onINP, onCLS } from 'https://unpkg.com/web-vitals@4/dist/web-vitals.attribution.js?module';

    function sendToAnalytics(metric) {
        const body = JSON.stringify({
            name: metric.name,
            value: metric.value,
            rating: metric.rating,
            delta: metric.delta,
            id: metric.id,
            navigationType: metric.navigationType,
            attribution: metric.attribution
        });

        // Use sendBeacon for reliable delivery
        if (navigator.sendBeacon) {
            navigator.sendBeacon('/api/vitals', body);
        } else {
            fetch('/api/vitals', { body, method: 'POST', keepalive: true });
        }
    }

    onLCP(sendToAnalytics);
    onINP(sendToAnalytics);
    onCLS(sendToAnalytics);
</script>
```

## Field Data vs Lab Data

### Key Differences

| Aspect | Lab Data | Field Data |
|--------|----------|------------|
| Source | Simulated in controlled environment | Real user browsers and devices |
| Conditions | Fixed device, network, and location | Varies by user device, connection, and geography |
| Metric | LCP, CLS, TBT (proxy for INP) | LCP, INP, CLS |
| Speed | Immediate results | Requires 28 day data collection |
| Use Case | Debugging, pre deployment testing | Performance monitoring, ranking signals |
| Accuracy | Useful for relative comparison | Reflects actual user experience |

### When to Use Which

**Use lab data when:**

- Debugging a specific performance issue.
- Testing the impact of a change before deployment.
- Running A/B comparisons between two code versions.
- Setting up performance monitoring in CI/CD pipelines.

**Use field data when:**

- Assessing the actual user experience on your site.
- Tracking Core Web Vitals for SEO ranking signals (Google uses field data).
- Identifying issues that only appear on real user devices or connections.
- Reporting performance to stakeholders.

**Important:** Google uses the 75th percentile of field data (CrUX) for ranking purposes. Lab scores that look good do not guarantee good field scores.

## Performance Budgets

### Setting Budgets

Define thresholds for key metrics that trigger alerts when exceeded:

```json
{
    "budgets": [
        {
            "resourceType": "script",
            "budget": 300
        },
        {
            "resourceType": "stylesheet",
            "budget": 100
        },
        {
            "resourceType": "image",
            "budget": 500
        },
        {
            "resourceType": "total",
            "budget": 1500
        },
        {
            "metric": "largest-contentful-paint",
            "budget": 2500
        },
        {
            "metric": "cumulative-layout-shift",
            "budget": 0.1
        },
        {
            "metric": "total-blocking-time",
            "budget": 200
        }
    ]
}
```

*All size budgets are in kilobytes.*

### Enforcing Budgets in CI/CD

```yaml
# GitHub Actions: Lighthouse CI performance budget check
name: Performance Budget
on: [pull_request]

jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Lighthouse CI
        uses: treosh/lighthouse-ci-action@v11
        with:
          urls: |
            https://staging.example.com/
            https://staging.example.com/products/widget
          budgetPath: ./performance-budget.json
          uploadArtifacts: true
```

## Third Party Script Impact Analysis

### Identification

Third party scripts (analytics, ads, chat widgets, social embeds) are often the largest contributors to poor CWV scores.

**Audit process:**

1. Open Chrome DevTools, go to the Network panel, and filter by third party domain.
2. Note the total transfer size and number of requests per third party.
3. In the Performance panel, record a page load and identify long tasks attributed to third party scripts.
4. Use the Coverage panel (Ctrl+Shift+P, type "coverage") to see how much of each script's code is actually executed.

### Mitigation Strategies

**Delay non essential scripts until user interaction:**

```javascript
// Load third-party scripts only after user interacts with the page
let thirdPartyLoaded = false;

function loadThirdPartyScripts() {
    if (thirdPartyLoaded) return;
    thirdPartyLoaded = true;

    // Chat widget
    const chatScript = document.createElement('script');
    chatScript.src = 'https://chat-provider.com/widget.js';
    chatScript.async = true;
    document.body.appendChild(chatScript);

    // Social sharing buttons
    const socialScript = document.createElement('script');
    socialScript.src = 'https://social-share.com/buttons.js';
    socialScript.async = true;
    document.body.appendChild(socialScript);
}

// Trigger on first user interaction
['scroll', 'click', 'touchstart', 'keydown'].forEach(event => {
    document.addEventListener(event, loadThirdPartyScripts, { once: true, passive: true });
});

// Fallback: load after 5 seconds if no interaction
setTimeout(loadThirdPartyScripts, 5000);
```

**Use facades for heavy embeds:**

```html
<!-- Instead of loading the full YouTube embed immediately -->
<!-- Use a lightweight facade that loads the iframe on click -->
<div class="youtube-facade" data-video-id="abc123" style="aspect-ratio: 16/9; cursor: pointer; position: relative;">
    <img src="https://img.youtube.com/vi/abc123/maxresdefault.jpg"
         alt="Video thumbnail"
         style="width: 100%; height: 100%; object-fit: cover;" loading="lazy" />
    <button aria-label="Play video" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
        ▶
    </button>
</div>

<script>
    document.querySelectorAll('.youtube-facade').forEach(facade => {
        facade.addEventListener('click', function() {
            const videoId = this.dataset.videoId;
            const iframe = document.createElement('iframe');
            iframe.src = `https://www.youtube.com/embed/${videoId}?autoplay=1`;
            iframe.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture';
            iframe.allowFullscreen = true;
            iframe.style.cssText = 'width: 100%; height: 100%; position: absolute; top: 0; left: 0;';
            this.innerHTML = '';
            this.style.position = 'relative';
            this.appendChild(iframe);
        }, { once: true });
    });
</script>
```

## Font Loading Optimization

### font-display Strategies

| Value | Behavior | CLS Impact | Best For |
|-------|----------|-----------|----------|
| `swap` | Shows fallback immediately, swaps when font loads | May cause CLS | Body text (with size adjusted fallback) |
| `optional` | Uses font only if already cached, no swap | Zero CLS | Body text (best for CLS) |
| `fallback` | Short block period, then swap | Minimal CLS | Headings |
| `block` | Invisible text for up to 3 seconds | No CLS but invisible text | Icon fonts only |

### Preload Critical Fonts

```html
<!-- Preload only the fonts used above the fold (1-2 maximum) -->
<link rel="preload" href="/fonts/inter-regular.woff2" as="font" type="font/woff2" crossorigin />
<link rel="preload" href="/fonts/inter-bold.woff2" as="font" type="font/woff2" crossorigin />
```

**The `crossorigin` attribute is required even for same origin fonts.** Omitting it causes a double download.

### Font Subsetting

Reduce font file size by including only the characters you need:

```bash
# Using pyftsubset (from fonttools package)
# Subset to Latin characters only
pyftsubset Inter-Regular.ttf \
    --output-file=inter-regular-latin.woff2 \
    --flavor=woff2 \
    --layout-features='kern,liga' \
    --unicodes="U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD"
```

**Typical size reduction:** A full Inter Regular font is ~300KB. Latin subset WOFF2 is ~20KB.

## Resource Hints

### preconnect

Establishes early connections (DNS + TCP + TLS) to third party origins. Use for critical third party resources.

```html
<!-- Preconnect to CDN -->
<link rel="preconnect" href="https://cdn.example.com" />

<!-- Preconnect to font provider -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

<!-- Preconnect to analytics -->
<link rel="preconnect" href="https://www.google-analytics.com" />
```

**Limit to 2 to 4 preconnect hints.** Each connection consumes resources. Only preconnect to origins that deliver critical resources.

### prefetch

Downloads resources that will be needed for future navigations (next page).

```html
<!-- Prefetch resources likely needed on the next page -->
<link rel="prefetch" href="/js/product-detail.js" />
<link rel="prefetch" href="/css/product-detail.css" />
<link rel="prefetch" href="/api/related-products.json" />
```

**Use prefetch for:** Resources needed on the next likely navigation target, not the current page. Prefetched resources are stored in the HTTP cache with low priority.

### preload

Downloads resources needed for the current page with high priority.

```html
<!-- Preload critical resources for the current page -->
<link rel="preload" href="/fonts/inter-regular.woff2" as="font" type="font/woff2" crossorigin />
<link rel="preload" href="/images/hero.webp" as="image" type="image/webp" />
<link rel="preload" href="/css/critical.css" as="style" />
```

**Important:** Only preload resources that are used within 3 seconds of page load. Unused preloads waste bandwidth and trigger console warnings.

### dns-prefetch

Resolves DNS only (no TCP/TLS connection). Lower cost than preconnect, suitable for resources that may be needed.

```html
<!-- DNS prefetch for resources that might be needed -->
<link rel="dns-prefetch" href="https://third-party-widget.com" />
<link rel="dns-prefetch" href="https://ad-network.com" />
```

**Use dns-prefetch for:** Third party origins that are used on some pages but not guaranteed to be needed on the current page.

### Resource Hints Decision Guide

| Hint | Connection Cost | When to Use | Priority |
|------|----------------|-------------|----------|
| `dns-prefetch` | Low (DNS only) | Third parties that might be needed | Low |
| `preconnect` | Medium (DNS + TCP + TLS) | Third parties definitely needed on this page | Medium |
| `preload` | High (full download) | Critical resources for current page | High |
| `prefetch` | Low (idle download) | Resources for the next likely page | Low |

## Implementation Checklist

### Immediate Wins (Week 1)

1. Add `width` and `height` attributes to all images and videos.
2. Preload the LCP image with `fetchpriority="high"`.
3. Add `loading="lazy"` to all below fold images.
4. Set `font-display: swap` or `font-display: optional` on all @font-face declarations.
5. Add 2 to 4 `preconnect` hints for critical third party origins.

### Short Term Improvements (Weeks 2 to 4)

6. Inline critical CSS and async load the full stylesheet.
7. Defer or async all non critical JavaScript.
8. Implement responsive images with `srcset` and `sizes`.
9. Reserve space for ad slots and dynamic content with `min-height`.
10. Delay non essential third party scripts until user interaction.

### Medium Term Optimizations (Month 2)

11. Enable server side compression (Brotli preferred, gzip fallback).
12. Configure CDN with appropriate cache headers.
13. Subset and preload web fonts.
14. Implement code splitting for JavaScript bundles.
15. Use facades for heavy embeds (YouTube, maps, chat widgets).

### Ongoing Monitoring

16. Set up real user monitoring with web-vitals.js.
17. Configure performance budgets in CI/CD.
18. Review CrUX data in Search Console monthly.
19. Audit third party script impact quarterly.
20. Test CWV after every major deployment.
