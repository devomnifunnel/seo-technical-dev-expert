---
name: pagespeed-optimization
description: "Image, JavaScript, CSS, caching, and server optimization techniques. Use when improving page load times, reducing bundle sizes, or optimizing resource delivery. Trigger on: image optimization, JS optimization, CSS optimization, caching, font loading, resource hints, lazy loading, bundle size, CDN."
allowed-tools: Read, Write, Edit, Bash, Grep, Glob, WebFetch
argument-hint: "[url]"
---

# Page Speed Optimization

## Image Optimization

### Format Selection

| Format | Best For | Browser Support | Compression |
|--------|----------|----------------|-------------|
| WebP | Photos, illustrations, transparency | 97%+ | 25 to 35% smaller than JPEG |
| AVIF | Photos (best compression) | 92%+ | 50% smaller than JPEG |
| SVG | Icons, logos, simple graphics | Universal | Vector, infinitely scalable |
| PNG | Screenshots, text in images | Universal | Lossless, larger files |

### Lazy Loading

Use `fetchpriority="high"` and NO lazy loading on the LCP image (above fold). Use `loading="lazy"` and `decoding="async"` on all below fold images.

### Compression Targets

| Image Type | Target Size | Quality |
|------------|------------|---------|
| Hero/banner (full width) | < 150 KB | WebP 75 to 80 |
| Product photos | < 80 KB | WebP 75 to 80 |
| Thumbnails | < 30 KB | WebP 70 to 75 |
| Icons/logos | < 10 KB | SVG preferred |
| Background images | < 100 KB | WebP 70 to 75 |

For responsive image srcset/picture implementation, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## JavaScript Optimization

### Bundle Analysis

Target sizes (gzipped): initial JS < 150 KB, per route chunk < 50 KB, total first load < 300 KB.

### Key Strategies

1. **Code splitting**: route based with dynamic imports, load on user action
2. **Tree shaking**: import specific functions not entire libraries, avoid barrel imports
3. **Defer/async**: `defer` for ordered DOM dependent scripts, `async` for independent scripts
4. **Remove unused JS**: Chrome DevTools Coverage tool, target files with >50% unused code

For code splitting, tree shaking, and defer/async examples, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## CSS Optimization

### Key Strategies

1. **Critical CSS**: extract above the fold styles, inline in `<head>`, async load full stylesheet
2. **Remove unused CSS**: PurgeCSS with safelist for dynamic classes
3. **CSS containment**: `contain: layout style paint` and `content-visibility: auto` for independent sections

Tools for critical CSS: `critical` npm package, `critters` webpack plugin, Penthouse.

For critical CSS, PurgeCSS config, and containment examples, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Caching Strategy

### Browser Cache Headers

- Images, CSS, JS, fonts (fingerprinted): `Cache-Control: public, max-age=31536000, immutable` (1 year)
- HTML pages: `Cache-Control: public, max-age=0, must-revalidate`

### Service Worker

Stale While Revalidate strategy: serve cached version immediately, fetch fresh copy in background, update cache for next visit.

For Apache .htaccess, Nginx config, and service worker code, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Server Optimization

### TTFB Targets

| TTFB | Rating | Action |
|------|--------|--------|
| < 200ms | Good | None needed |
| 200 to 500ms | Needs Improvement | Optimize server, add caching |
| 500 to 1000ms | Poor | Major optimization needed |
| > 1000ms | Critical | Architecture change likely needed |

### Key Strategies

- Enable HTTP/2 (multiplexing) and HTTP/3 (QUIC) where supported
- Brotli compression preferred (15 to 20% smaller than gzip), gzip as fallback
- CDN for static assets from edge locations

For Nginx HTTP/2/3 and compression config, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Font Optimization

### font-display Strategies

| Value | CLS Impact | Best For |
|-------|-----------|----------|
| `swap` | May cause CLS | Body text (with size adjusted fallback) |
| `optional` | Zero CLS | Body text (best for CLS) |
| `fallback` | Minimal CLS | Headings |

### Key Rules

- Preload only 1 to 2 critical fonts used above the fold
- `crossorigin` attribute required even for same origin fonts
- Font subsetting reduces file 50 to 80% (Latin subset of Inter: ~20KB vs ~300KB full)
- System font stack is fastest option when brand permits

For font preloading, subsetting, and system font stack examples, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Third Party Scripts

### Audit Methodology

1. Chrome DevTools Network tab, filter "3rd-party"
2. Record: URL, file size, load time, blocking behavior
3. Performance tab: identify long tasks from third parties
4. Categorize: essential, important, nice to have, unnecessary

### Impact Assessment

| Category | Typical Impact | Action |
|----------|---------------|--------|
| Analytics (GA4, GTM) | 30 to 80 KB | Keep, defer |
| Chat widgets | 200 to 500 KB | Facade, load on interaction |
| Social embeds | 100 to 300 KB | Facade, load on scroll |
| A/B testing | 50 to 150 KB | Minimize, async |
| Ad scripts | 200 to 800 KB | Load after LCP, lazy below fold |
| CRM/marketing pixels | 20 to 100 KB | Consolidate via GTM, defer |

For facade pattern (chat, YouTube) and delayed loading code, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Resource Loading Priority

### fetchpriority Attribute

- LCP image: `fetchpriority="high"`
- Below fold images: `fetchpriority="low"` + `loading="lazy"`
- Critical script: `fetchpriority="high"`
- Non critical: `fetchpriority="low"` + `defer`

### Resource Hints

| Hint | Cost | When to Use |
|------|------|-------------|
| `dns-prefetch` | Low | Third parties that might be needed |
| `preconnect` | Medium | Third parties definitely needed (limit 2 to 4) |
| `preload` | High | Critical resources for current page (use within 3s) |
| `prefetch` | Low | Resources for next likely navigation |
| `modulepreload` | High | ES modules for current page |

For resource hint HTML examples and priority guidelines, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md

## Performance Budget

| Metric | Budget |
|--------|--------|
| Total page weight | < 1.5 MB uncompressed |
| HTML | < 100 KB |
| CSS (total) | < 100 KB |
| JavaScript (total) | < 300 KB compressed |
| Images (total) | < 1 MB optimized |
| Fonts | < 100 KB WOFF2 |
| Third party | < 200 KB compressed |
| HTTP requests | < 50 |
| LCP | < 2.5s (75th percentile) |
| INP | < 200ms (75th percentile) |
| CLS | < 0.1 (75th percentile) |
| TTFB | < 800ms (75th percentile) |

For Performance Observer API monitoring code, load: ${CLAUDE_SKILL_DIR}/references/code-examples.md
