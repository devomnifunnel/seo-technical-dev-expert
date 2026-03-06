---
name: pagespeed-optimization
description: "Image, JavaScript, CSS, caching, and server optimization techniques. Use when improving page load times, reducing bundle sizes, or optimizing resource delivery. Trigger on: image optimization, JS optimization, CSS optimization, caching, font loading, resource hints, lazy loading, bundle size, CDN."
argument-hint: "[url]"
---

# Page Speed Optimization

## Image Optimization

### Format Selection

| Format | Best For | Browser Support | Compression |
|--------|----------|----------------|-------------|
| WebP | Photos, illustrations, transparency | 97%+ browsers | 25 to 35% smaller than JPEG |
| AVIF | Photos (best compression) | 92%+ browsers | 50% smaller than JPEG |
| SVG | Icons, logos, simple graphics | Universal | Vector, infinitely scalable |
| PNG | Screenshots, text in images, transparency needed | Universal | Lossless, larger file sizes |

### Responsive Images with srcset

```html
<picture>
  <!-- AVIF for browsers that support it -->
  <source
    type="image/avif"
    srcset="
      /images/hero-400.avif 400w,
      /images/hero-800.avif 800w,
      /images/hero-1200.avif 1200w,
      /images/hero-1600.avif 1600w
    "
    sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 800px"
  />
  <!-- WebP fallback -->
  <source
    type="image/webp"
    srcset="
      /images/hero-400.webp 400w,
      /images/hero-800.webp 800w,
      /images/hero-1200.webp 1200w,
      /images/hero-1600.webp 1600w
    "
    sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 800px"
  />
  <!-- JPEG fallback for oldest browsers -->
  <img
    src="/images/hero-800.jpg"
    srcset="
      /images/hero-400.jpg 400w,
      /images/hero-800.jpg 800w,
      /images/hero-1200.jpg 1200w,
      /images/hero-1600.jpg 1600w
    "
    sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 800px"
    alt="Descriptive alt text for SEO and accessibility"
    width="800"
    height="450"
    loading="lazy"
    decoding="async"
  />
</picture>
```

### Lazy Loading Implementation

```html
<!-- Above the fold: do NOT lazy load, use fetchpriority high for LCP image -->
<img
  src="/images/hero.webp"
  alt="Hero banner"
  width="1200"
  height="600"
  fetchpriority="high"
  decoding="async"
/>

<!-- Below the fold: lazy load -->
<img
  src="/images/product.webp"
  alt="Product photo"
  width="400"
  height="300"
  loading="lazy"
  decoding="async"
/>
```

### Compression Targets

| Image Type | Target File Size | Quality Setting |
|------------|-----------------|-----------------|
| Hero/banner (full width) | < 150 KB | WebP quality 75 to 80 |
| Product photos | < 80 KB | WebP quality 75 to 80 |
| Thumbnails | < 30 KB | WebP quality 70 to 75 |
| Icons/logos | < 10 KB | SVG preferred, or WebP quality 80 |
| Background images | < 100 KB | WebP quality 70 to 75 |

## JavaScript Optimization

### Bundle Analysis

Identify oversized bundles using webpack bundle analyzer:

```bash
# Install and run bundle analyzer
npx webpack-bundle-analyzer stats.json

# For Next.js projects
ANALYZE=true npm run build
```

**Target bundle sizes**:
- Initial JS bundle: < 150 KB (gzipped)
- Per route chunk: < 50 KB (gzipped)
- Total JS on first load: < 300 KB (gzipped)

### Code Splitting

```javascript
// Route-based code splitting (React/Next.js)
import dynamic from 'next/dynamic';

const HeavyComponent = dynamic(() => import('../components/HeavyComponent'), {
  loading: () => <div className="skeleton" />,
  ssr: false  // Skip server-side rendering if not needed for SEO
});

// Conditional import based on user action
const loadEditor = async () => {
  const { Editor } = await import('./editor');
  return new Editor('#container');
};

document.getElementById('edit-btn').addEventListener('click', loadEditor);
```

### Tree Shaking

```javascript
// BAD: Imports entire library (100+ KB)
import _ from 'lodash';
const result = _.debounce(handler, 300);

// GOOD: Import only what you need (4 KB)
import debounce from 'lodash/debounce';
const result = debounce(handler, 300);

// BAD: Barrel imports pull in everything
import { Button, Modal, Tooltip } from './components';

// GOOD: Direct imports enable tree shaking
import { Button } from './components/Button';
```

### Defer and Async Loading

```html
<!-- Critical JS: no defer/async, load in head (rare, avoid when possible) -->
<script src="/js/critical.js"></script>

<!-- Important JS: defer (maintains execution order, runs after HTML parsing) -->
<script src="/js/app.js" defer></script>
<script src="/js/analytics-init.js" defer></script>

<!-- Independent JS: async (loads and executes as soon as ready, no order guarantee) -->
<script src="/js/analytics.js" async></script>
<script src="/js/chat-widget.js" async></script>

<!-- Non-critical JS: load after page is interactive -->
<script>
  window.addEventListener('load', () => {
    const script = document.createElement('script');
    script.src = '/js/non-critical-feature.js';
    document.body.appendChild(script);
  });
</script>
```

### Removing Unused JavaScript

1. Run Chrome DevTools Coverage tool (Ctrl+Shift+P > "Coverage")
2. Load the page and interact with key user flows
3. Red bars indicate unused code
4. Target files with >50% unused code for splitting or removal
5. Remove polyfills for features with 95%+ browser support (e.g., Promise, fetch)

## CSS Optimization

### Critical CSS Extraction

Extract above the fold CSS and inline it:

```html
<head>
  <!-- Inline critical CSS for immediate rendering -->
  <style>
    /* Only styles needed for above-the-fold content */
    body { margin: 0; font-family: system-ui, sans-serif; }
    .header { background: #fff; padding: 16px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    .hero { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
    .hero h1 { font-size: 2.5rem; line-height: 1.2; }
  </style>

  <!-- Load full CSS asynchronously -->
  <link rel="preload" href="/css/styles.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
  <noscript><link rel="stylesheet" href="/css/styles.css"></noscript>
</head>
```

**Tools for critical CSS extraction**:
- `critical` npm package (automated extraction)
- `critters` webpack plugin (build time extraction)
- Penthouse (Node.js based)

### Removing Unused CSS

```bash
# Using PurgeCSS with a build tool
npm install purgecss --save-dev
```

PurgeCSS configuration:

```javascript
// purgecss.config.js
module.exports = {
  content: ['./src/**/*.html', './src/**/*.js', './src/**/*.jsx'],
  css: ['./src/css/**/*.css'],
  safelist: {
    standard: [/^modal/, /^tooltip/, /active$/, /open$/],
    deep: [/data-theme/],
  },
  output: './dist/css/'
};
```

### CSS Containment

```css
/* Tell the browser this element's rendering is independent */
.product-card {
  contain: layout style paint;
  content-visibility: auto;
  contain-intrinsic-size: 0 300px; /* estimated height for CLS prevention */
}

/* For long lists or grids of items */
.product-grid .item {
  content-visibility: auto;
  contain-intrinsic-size: 250px 350px;
}
```

## Caching Strategy

### Browser Cache Headers

```
# Apache .htaccess
<IfModule mod_expires.c>
  ExpiresActive On

  # Images: cache for 1 year (use fingerprinted filenames)
  ExpiresByType image/webp "access plus 1 year"
  ExpiresByType image/avif "access plus 1 year"
  ExpiresByType image/jpeg "access plus 1 year"
  ExpiresByType image/png "access plus 1 year"
  ExpiresByType image/svg+xml "access plus 1 year"

  # CSS and JS: cache for 1 year (use fingerprinted filenames)
  ExpiresByType text/css "access plus 1 year"
  ExpiresByType application/javascript "access plus 1 year"

  # Fonts: cache for 1 year
  ExpiresByType font/woff2 "access plus 1 year"

  # HTML: no cache or short cache
  ExpiresByType text/html "access plus 0 seconds"
</IfModule>

# Cache-Control headers
<IfModule mod_headers.c>
  # Immutable assets (fingerprinted filenames)
  <FilesMatch "\.(js|css|woff2|webp|avif)$">
    Header set Cache-Control "public, max-age=31536000, immutable"
  </FilesMatch>

  # HTML pages
  <FilesMatch "\.html$">
    Header set Cache-Control "public, max-age=0, must-revalidate"
  </FilesMatch>
</IfModule>
```

```nginx
# Nginx configuration
location ~* \.(js|css|woff2|webp|avif|jpg|png|svg)$ {
    expires 1y;
    add_header Cache-Control "public, immutable";
    add_header Vary "Accept-Encoding";
}

location ~* \.html$ {
    expires 0;
    add_header Cache-Control "public, no-cache, must-revalidate";
}
```

### Service Worker Caching

```javascript
// service-worker.js - Stale While Revalidate strategy for speed + freshness
const CACHE_NAME = 'site-cache-v1';
const PRECACHE_URLS = [
  '/',
  '/css/styles.css',
  '/js/app.js',
  '/images/logo.webp'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(PRECACHE_URLS))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(cached => {
      const fetchPromise = fetch(event.request).then(response => {
        const clone = response.clone();
        caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
        return response;
      });
      return cached || fetchPromise;
    })
  );
});
```

## Server Optimization

### TTFB Reduction Targets

| TTFB Range | Rating | Action |
|-----------|--------|--------|
| < 200ms | Good | No action needed |
| 200 to 500ms | Needs Improvement | Optimize server, add caching |
| 500 to 1000ms | Poor | Major server optimization needed |
| > 1000ms | Critical | Architecture change likely needed |

### HTTP/2 and HTTP/3

```nginx
# Nginx HTTP/2 configuration
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    # Enable HTTP/3 (QUIC)
    listen 443 quic reuseport;
    add_header Alt-Svc 'h3=":443"; ma=86400';

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
}
```

### Compression Configuration

```nginx
# Nginx Brotli + Gzip configuration
# Brotli (preferred, 15-20% smaller than gzip)
brotli on;
brotli_comp_level 6;
brotli_types text/html text/css application/javascript application/json
             image/svg+xml application/xml text/plain;

# Gzip fallback
gzip on;
gzip_comp_level 6;
gzip_types text/html text/css application/javascript application/json
           image/svg+xml application/xml text/plain;
gzip_vary on;
gzip_min_length 256;
```

## Font Optimization

### font-display Descriptor

```css
@font-face {
  font-family: 'CustomFont';
  src: url('/fonts/custom-font.woff2') format('woff2');
  font-weight: 400;
  font-style: normal;
  font-display: swap; /* Show fallback immediately, swap when loaded */
}

/* For icon fonts or decorative fonts, use optional to avoid layout shift */
@font-face {
  font-family: 'IconFont';
  src: url('/fonts/icons.woff2') format('woff2');
  font-display: optional; /* Only use if loaded quickly, otherwise skip */
}
```

### Font Preloading

```html
<head>
  <!-- Preload critical fonts (only fonts used above the fold) -->
  <link
    rel="preload"
    href="/fonts/main-font-regular.woff2"
    as="font"
    type="font/woff2"
    crossorigin
  />
  <link
    rel="preload"
    href="/fonts/main-font-bold.woff2"
    as="font"
    type="font/woff2"
    crossorigin
  />
  <!-- Do NOT preload more than 2-3 fonts; it hurts more than it helps -->
</head>
```

### Font Subsetting

```bash
# Using pyftsubset (fonttools)
# Subset to Latin characters only (reduces file 50-80%)
pyftsubset MyFont.ttf \
  --output-file=MyFont-subset.woff2 \
  --flavor=woff2 \
  --layout-features='kern,liga' \
  --unicodes="U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD"
```

### System Font Stack (Fastest Option)

```css
/* Eliminate custom font loading entirely when brand permits */
body {
  font-family:
    system-ui,
    -apple-system,
    'Segoe UI',
    Roboto,
    'Helvetica Neue',
    Arial,
    sans-serif;
}
```

## Third Party Scripts

### Audit Methodology

1. Open Chrome DevTools > Network tab > filter by "3rd-party"
2. Record: script URL, file size, load time, blocking behavior
3. Open Performance tab > record page load > identify long tasks caused by third parties
4. Categorize each script: essential, important, nice to have, unnecessary

### Script Impact Assessment

| Script Category | Typical Impact | Action |
|----------------|---------------|--------|
| Analytics (GA4, GTM) | 30 to 80 KB, moderate | Keep, defer loading |
| Chat widgets | 200 to 500 KB, heavy | Facade pattern, load on interaction |
| Social embeds | 100 to 300 KB each | Facade pattern, load on scroll |
| A/B testing | 50 to 150 KB, render blocking | Minimize experiments, async load |
| Ad scripts | 200 to 800 KB, very heavy | Load after LCP, lazy load below fold |
| CRM/marketing pixels | 20 to 100 KB each | Consolidate through GTM, defer |

### Facade Pattern Implementation

```html
<!-- Chat widget facade: shows a fake button, loads real widget on click -->
<div id="chat-facade" onclick="loadChat()" style="
  position: fixed; bottom: 20px; right: 20px;
  width: 60px; height: 60px; border-radius: 50%;
  background: #0066cc; cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
">
  <svg width="24" height="24" fill="white" viewBox="0 0 24 24">
    <path d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2z"/>
  </svg>
</div>

<script>
  function loadChat() {
    document.getElementById('chat-facade').remove();
    const script = document.createElement('script');
    script.src = 'https://chat-provider.com/widget.js';
    script.onload = () => window.ChatWidget.open();
    document.body.appendChild(script);
  }
</script>
```

### YouTube Facade (lite-youtube)

```html
<!-- Instead of embedding a full YouTube iframe (1+ MB) -->
<lite-youtube videoid="dQw4w9WgXcQ" playlabel="Play video">
  <a href="https://youtube.com/watch?v=dQw4w9WgXcQ" class="lty-playbtn" title="Play">
    <span class="lyt-visually-hidden">Play video</span>
  </a>
</lite-youtube>

<script src="/js/lite-youtube-embed.js" defer></script>
<link rel="stylesheet" href="/css/lite-youtube-embed.css" />
```

## Resource Loading Priority

### fetchpriority Attribute

```html
<!-- LCP image: highest priority -->
<img src="/hero.webp" fetchpriority="high" alt="Hero" width="1200" height="600" />

<!-- Below-fold images: low priority -->
<img src="/product.webp" fetchpriority="low" loading="lazy" alt="Product" width="400" height="300" />

<!-- Critical script -->
<script src="/js/critical.js" fetchpriority="high"></script>

<!-- Non-critical script -->
<script src="/js/deferred.js" fetchpriority="low" defer></script>
```

### Resource Hints

```html
<head>
  <!-- dns-prefetch: resolve DNS early for third-party domains -->
  <link rel="dns-prefetch" href="//fonts.googleapis.com" />
  <link rel="dns-prefetch" href="//www.google-analytics.com" />

  <!-- preconnect: establish connection early (DNS + TCP + TLS) -->
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link rel="preconnect" href="https://cdn.example.com" crossorigin />

  <!-- preload: fetch critical resources early -->
  <link rel="preload" href="/fonts/main.woff2" as="font" type="font/woff2" crossorigin />
  <link rel="preload" href="/css/critical.css" as="style" />
  <link rel="preload" href="/images/hero.webp" as="image" type="image/webp" />

  <!-- prefetch: fetch resources likely needed for next navigation -->
  <link rel="prefetch" href="/js/product-page.js" />
  <link rel="prefetch" href="/api/popular-products.json" />

  <!-- modulepreload: preload ES modules -->
  <link rel="modulepreload" href="/js/app.mjs" />
</head>
```

### Priority Guidelines

| Resource | fetchpriority | Loading Strategy |
|----------|--------------|-----------------|
| LCP image | high | Eager, preload |
| Hero CSS | high | Inline critical |
| Main JS bundle | high | defer |
| Web fonts (above fold) | high | preload |
| Below fold images | low | lazy |
| Third party analytics | low | async |
| Chat widget | low | Facade, load on interaction |
| Prefetch resources | low | prefetch |

## Performance Budget

### Recommended Budgets

| Metric | Budget | Measurement |
|--------|--------|-------------|
| Total page weight | < 1.5 MB | Uncompressed |
| HTML | < 100 KB | Uncompressed |
| CSS (total) | < 100 KB | Uncompressed |
| JavaScript (total) | < 300 KB | Compressed |
| Images (total) | < 1 MB | Optimized |
| Fonts | < 100 KB | WOFF2 |
| Third party | < 200 KB | Compressed |
| HTTP requests | < 50 | Total |
| LCP | < 2.5s | 75th percentile |
| INP | < 200ms | 75th percentile |
| CLS | < 0.1 | 75th percentile |
| TTFB | < 800ms | 75th percentile |

### Monitoring Performance Budgets

```javascript
// Using the Performance Observer API
const observer = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    if (entry.entryType === 'largest-contentful-paint') {
      console.log('LCP:', entry.startTime);
      if (entry.startTime > 2500) {
        console.warn('LCP exceeds budget of 2500ms');
      }
    }
  }
});
observer.observe({ type: 'largest-contentful-paint', buffered: true });
```
