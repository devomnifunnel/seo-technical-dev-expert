# Image SEO Reference

## Alt Text Writing

Alt text serves accessibility and SEO purposes. Write descriptive alt text that conveys the image content naturally.

**Rules:**

1. Describe the image content accurately in 5 to 15 words.
2. Include the target keyword once if naturally relevant.
3. Do not start with "Image of" or "Picture of."
4. Avoid keyword stuffing.
5. Leave decorative images with empty alt attributes (`alt=""`).

**Examples:**

```html
<!-- Good -->
<img src="widget-pro-blue.jpg" alt="Widget Pro product in blue finish on white background" />

<!-- Good -->
<img src="seo-audit-dashboard.png" alt="Screaming Frog crawl results showing 404 error distribution" />

<!-- Bad: keyword stuffed -->
<img src="widget.jpg" alt="widget buy widget best widget cheap widget online" />

<!-- Bad: non-descriptive -->
<img src="product-1.jpg" alt="product" />
```

## File Naming

Name image files with descriptive, keyword rich filenames before uploading.

```
Good:  core-web-vitals-lcp-optimization.png
Good:  netsuite-suitecommerce-product-page.jpg
Bad:   IMG_4523.jpg
Bad:   screenshot-2026-03-01.png
```

## Compression and Format Selection

| Format | Best For | Target Quality |
|--------|----------|---------------|
| WebP | Photos and illustrations (modern browsers) | 75 to 85 quality |
| AVIF | Photos (best compression, growing support) | 60 to 75 quality |
| JPEG | Photos (universal fallback) | 80 to 85 quality |
| PNG | Graphics with transparency | Use only when transparency needed |
| SVG | Icons, logos, simple graphics | Minify and optimize |

Target file sizes: under 100KB for standard images, under 200KB for hero images.

## Lazy Loading

Apply lazy loading to images below the fold. Never lazy load the LCP (Largest Contentful Paint) image.

```html
<!-- Hero image: load eagerly, preload for LCP -->
<img src="hero-banner.webp" alt="Spring sale promotional banner" fetchpriority="high" />

<!-- Below-fold images: lazy load -->
<img src="product-thumbnail-1.webp" alt="Widget Pro in red" loading="lazy" decoding="async" />
<img src="product-thumbnail-2.webp" alt="Widget Pro in green" loading="lazy" decoding="async" />
```
