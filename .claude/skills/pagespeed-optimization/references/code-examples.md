# Page Speed Optimization Code Examples

## Responsive Images with srcset

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

## Code Splitting (React/Next.js)

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

## Tree Shaking

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

## Defer and Async Loading

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

## Critical CSS Extraction

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

## PurgeCSS Configuration

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

## CSS Containment

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

## Browser Cache Headers

### Apache .htaccess

```
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresByType image/webp "access plus 1 year"
  ExpiresByType image/avif "access plus 1 year"
  ExpiresByType image/jpeg "access plus 1 year"
  ExpiresByType image/png "access plus 1 year"
  ExpiresByType image/svg+xml "access plus 1 year"
  ExpiresByType text/css "access plus 1 year"
  ExpiresByType application/javascript "access plus 1 year"
  ExpiresByType font/woff2 "access plus 1 year"
  ExpiresByType text/html "access plus 0 seconds"
</IfModule>

<IfModule mod_headers.c>
  <FilesMatch "\.(js|css|woff2|webp|avif)$">
    Header set Cache-Control "public, max-age=31536000, immutable"
  </FilesMatch>
  <FilesMatch "\.html$">
    Header set Cache-Control "public, max-age=0, must-revalidate"
  </FilesMatch>
</IfModule>
```

### Nginx

```nginx
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

## Service Worker Caching

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

## Server Optimization (Nginx HTTP/2 and HTTP/3)

```nginx
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

## Compression Configuration (Nginx)

```nginx
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

```css
@font-face {
  font-family: 'CustomFont';
  src: url('/fonts/custom-font.woff2') format('woff2');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

/* For icon fonts or decorative fonts, use optional to avoid layout shift */
@font-face {
  font-family: 'IconFont';
  src: url('/fonts/icons.woff2') format('woff2');
  font-display: optional;
}
```

```html
<head>
  <!-- Preload critical fonts (only fonts used above the fold) -->
  <link rel="preload" href="/fonts/main-font-regular.woff2" as="font" type="font/woff2" crossorigin />
  <link rel="preload" href="/fonts/main-font-bold.woff2" as="font" type="font/woff2" crossorigin />
  <!-- Do NOT preload more than 2-3 fonts; it hurts more than it helps -->
</head>
```

## Font Subsetting

```bash
# Using pyftsubset (fonttools)
# Subset to Latin characters only (reduces file 50-80%)
pyftsubset MyFont.ttf \
  --output-file=MyFont-subset.woff2 \
  --flavor=woff2 \
  --layout-features='kern,liga' \
  --unicodes="U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD"
```

## Facade Pattern (Chat Widget)

```html
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

## YouTube Facade (lite-youtube)

```html
<lite-youtube videoid="dQw4w9WgXcQ" playlabel="Play video">
  <a href="https://youtube.com/watch?v=dQw4w9WgXcQ" class="lty-playbtn" title="Play">
    <span class="lyt-visually-hidden">Play video</span>
  </a>
</lite-youtube>

<script src="/js/lite-youtube-embed.js" defer></script>
<link rel="stylesheet" href="/css/lite-youtube-embed.css" />
```

## Resource Hints and fetchpriority

```html
<head>
  <link rel="dns-prefetch" href="//fonts.googleapis.com" />
  <link rel="dns-prefetch" href="//www.google-analytics.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link rel="preconnect" href="https://cdn.example.com" crossorigin />
  <link rel="preload" href="/fonts/main.woff2" as="font" type="font/woff2" crossorigin />
  <link rel="preload" href="/css/critical.css" as="style" />
  <link rel="preload" href="/images/hero.webp" as="image" type="image/webp" />
  <link rel="prefetch" href="/js/product-page.js" />
  <link rel="prefetch" href="/api/popular-products.json" />
  <link rel="modulepreload" href="/js/app.mjs" />
</head>

<!-- LCP image: highest priority -->
<img src="/hero.webp" fetchpriority="high" alt="Hero" width="1200" height="600" />

<!-- Below-fold images: low priority -->
<img src="/product.webp" fetchpriority="low" loading="lazy" alt="Product" width="400" height="300" />
```

## Performance Budget Monitoring

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
