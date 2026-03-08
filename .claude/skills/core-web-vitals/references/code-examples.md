# Core Web Vitals Code Examples

## LCP: Server Side Optimizations (Nginx)

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

## LCP: Critical CSS Inlining

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

## LCP: Responsive Image Optimization

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

## INP: Breaking Long Tasks

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

## INP: Scheduler Yield

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

## INP: Code Splitting and Tree Shaking

```javascript
// Dynamic import: load modules only when needed
document.getElementById('search-btn').addEventListener('click', async () => {
    const { initSearch } = await import('./search-module.js');
    initSearch();
});

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

## INP: Event Handler Optimization

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

// Passive listeners tell the browser the handler won't call preventDefault()
document.addEventListener('touchstart', handleTouch, { passive: true });
document.addEventListener('wheel', handleWheel, { passive: true });

// Schedule visual updates to align with browser paint cycles
function onScroll() {
    requestAnimationFrame(() => {
        updateStickyHeader();
        updateScrollProgress();
    });
}
```

## CLS: Explicit Dimensions and Aspect Ratios

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

## CLS: Reserve Space for Dynamic Content

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

## CLS: CSS Containment

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

## CLS: Font Loading (Size-Adjusted Fallback)

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

## Font Subsetting

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

## Implementing web-vitals.js

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

## Performance Budgets JSON

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

## Lighthouse CI GitHub Actions

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

## Third Party Script Delayed Loading

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

## YouTube Facade

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

## Resource Hints

```html
<!-- Preconnect to CDN -->
<link rel="preconnect" href="https://cdn.example.com" />

<!-- Preconnect to font provider -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

<!-- Preconnect to analytics -->
<link rel="preconnect" href="https://www.google-analytics.com" />

<!-- Prefetch resources likely needed on the next page -->
<link rel="prefetch" href="/js/product-detail.js" />
<link rel="prefetch" href="/css/product-detail.css" />
<link rel="prefetch" href="/api/related-products.json" />

<!-- Preload critical resources for the current page -->
<link rel="preload" href="/fonts/inter-regular.woff2" as="font" type="font/woff2" crossorigin />
<link rel="preload" href="/images/hero.webp" as="image" type="image/webp" />
<link rel="preload" href="/css/critical.css" as="style" />

<!-- DNS prefetch for resources that might be needed -->
<link rel="dns-prefetch" href="https://third-party-widget.com" />
<link rel="dns-prefetch" href="https://ad-network.com" />
```
