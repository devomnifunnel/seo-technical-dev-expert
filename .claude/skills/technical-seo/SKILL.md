---
name: technical-seo
description: "Technical SEO covering crawl optimization, canonicalization, redirects, and security headers. Use when auditing technical SEO infrastructure, fixing crawl issues, or implementing redirects. Trigger on: robots.txt, sitemap, canonical, redirect, 404, crawl budget, HTTPS, security headers, indexation, URL structure."
allowed-tools: Read, Glob, Grep, Bash, WebSearch, WebFetch, Agent
---

# Technical SEO Implementation Guide

## Bundled Chrome Scripts

The following ES5 scripts can be executed via Chrome DevTools MCP for live page analysis:
- [scripts/chrome/seo-meta-audit.js](scripts/chrome/seo-meta-audit.js): Extract all meta tags, title, canonical, robots directives
- [scripts/chrome/heading-structure.js](scripts/chrome/heading-structure.js): Audit H1-H6 hierarchy and nesting
- [scripts/chrome/image-seo-audit.js](scripts/chrome/image-seo-audit.js): Check alt text, dimensions, lazy loading, format
- [scripts/chrome/internal-links.js](scripts/chrome/internal-links.js): Map internal link structure and anchor text
- [scripts/chrome/schema-validator.js](scripts/chrome/schema-validator.js): Extract and validate JSON-LD structured data
- [scripts/chrome/js-rendering-check.js](scripts/chrome/js-rendering-check.js): Compare pre-render vs post-render DOM
- [scripts/chrome/resource-loading.js](scripts/chrome/resource-loading.js): Audit resource hints, loading priorities, render-blocking
- [scripts/chrome/cwv-diagnostics.js](scripts/chrome/cwv-diagnostics.js): Measure CWV metrics in real time

Use `${CLAUDE_SKILL_DIR}/scripts/chrome/<script>.js` to reference these scripts from any working directory.

## Dynamic Context

When invoked with a URL ($ARGUMENTS), use available MCP tools to gather live data:
- Lighthouse MCP: run full audit for crawlability, security headers, and technical issues
- Fetch MCP: extract page content as clean markdown for analysis
- Chrome DevTools MCP: check network requests, JS errors, and rendering behavior
- Chrome MCP: navigate to the URL and inspect live DOM, meta tags, and schema

## Crawl Optimization

### robots.txt Best Practices

The robots.txt file lives at the root of your domain and controls which paths search engine crawlers may access. Always include a reference to your XML sitemap.

```txt
# robots.txt for example.com

User-agent: *
Allow: /
Disallow: /admin/
Disallow: /cart/
Disallow: /checkout/
Disallow: /account/
Disallow: /search?
Disallow: /*?sort=
Disallow: /*?filter=
Disallow: /*&sessionid=

# Block specific crawlers from resource-heavy sections
User-agent: AhrefsBot
Crawl-delay: 10

User-agent: SemrushBot
Crawl-delay: 10

# Sitemap reference
Sitemap: https://www.example.com/sitemap_index.xml
```

Key rules for robots.txt:
1. Place the file at the exact path `/robots.txt` on the root domain.
2. Use `Disallow` to block crawlers from low value or duplicate content paths.
3. Never block CSS or JavaScript files that are required for rendering page content.
4. Include a `Sitemap` directive pointing to your XML sitemap or sitemap index.
5. Test with Google Search Console's robots.txt Tester before deploying changes.

### XML Sitemap Structure

A well formed XML sitemap helps search engines discover and prioritize your pages.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
  <url>
    <loc>https://www.example.com/</loc>
    <lastmod>2026-03-01</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://www.example.com/products/widget-pro</loc>
    <lastmod>2026-02-28</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
    <image:image>
      <image:loc>https://www.example.com/images/widget-pro.jpg</image:loc>
      <image:title>Widget Pro Product Image</image:title>
    </image:image>
  </url>
</urlset>
```

Sitemap index for large sites (over 50,000 URLs or 50MB per file):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <sitemap>
    <loc>https://www.example.com/sitemap-products.xml</loc>
    <lastmod>2026-03-01</lastmod>
  </sitemap>
  <sitemap>
    <loc>https://www.example.com/sitemap-categories.xml</loc>
    <lastmod>2026-02-15</lastmod>
  </sitemap>
  <sitemap>
    <loc>https://www.example.com/sitemap-blog.xml</loc>
    <lastmod>2026-03-03</lastmod>
  </sitemap>
</sitemapindex>
```

### Crawl Budget Management

Crawl budget matters most for sites with over 10,000 pages. Strategies to optimize:

1. **Remove low quality pages from the index.** Use `noindex` on thin pages, parameter variations, and internal search results.
2. **Fix crawl errors promptly.** Monitor Google Search Console for 404s, 500s, and redirect errors.
3. **Flatten site architecture.** Keep important pages within 3 clicks from the homepage.
4. **Improve server response time.** Target under 200ms TTFB for crawled pages.
5. **Avoid soft 404s.** Return proper 404 status codes for pages that no longer exist.
6. **Consolidate duplicate content.** Use canonical tags to point crawlers to the preferred version.

## Canonical Tag Implementation

### Self Referencing Canonicals

Every indexable page should include a self referencing canonical tag. This protects against duplicate content caused by URL parameters, tracking codes, or protocol variations.

```html
<!-- On page: https://www.example.com/products/widget -->
<link rel="canonical" href="https://www.example.com/products/widget" />
```

### Cross Domain Canonicals

When the same content appears on multiple domains, use a cross domain canonical to consolidate ranking signals.

```html
<!-- On syndicated-site.com -->
<link rel="canonical" href="https://www.example.com/blog/original-article" />
```

### Paginated Content Canonicals

For paginated series, each page should self reference. Do not canonical all paginated pages back to page 1.

```html
<!-- Page 2 of a category listing -->
<link rel="canonical" href="https://www.example.com/category/shoes?page=2" />
```

Google no longer supports `rel="prev"` and `rel="next"`, so rely on self referencing canonicals and ensure all paginated pages are linked from the sitemap or internal navigation.

## Redirect Management

### 301 vs 302 Redirects

| Redirect Type | Purpose | SEO Signal Transfer |
|---------------|---------|---------------------|
| 301 | Permanent move | Passes full link equity |
| 302 | Temporary move | Retains equity on original URL |
| 307 | Temporary (HTTP/1.1) | Preserves request method |
| 308 | Permanent (HTTP/1.1) | Preserves request method |

Use 301 for permanent URL changes, site migrations, and domain consolidation. Use 302 only for genuinely temporary situations such as A/B tests or maintenance pages.

### Redirect Chain Resolution

Redirect chains (A redirects to B redirects to C) waste crawl budget and dilute link equity. Audit and flatten all chains so every redirect points directly to the final destination.

**Maximum acceptable chain length:** 1 hop. Google will follow up to 5 hops but recommends a single redirect.

### Apache .htaccess Redirect Examples

```apache
# Single 301 redirect
Redirect 301 /old-page https://www.example.com/new-page

# Regex redirect: entire directory
RedirectMatch 301 ^/blog/2024/(.*)$ https://www.example.com/blog/$1

# Force HTTPS
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Force www
RewriteCond %{HTTP_HOST} ^example\.com [NC]
RewriteRule ^(.*)$ https://www.example.com/$1 [L,R=301]

# Remove trailing slashes
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)/$ /$1 [L,R=301]
```

### Nginx Redirect Examples

```nginx
server {
    # Force HTTPS
    listen 80;
    server_name example.com www.example.com;
    return 301 https://www.example.com$request_uri;
}

server {
    listen 443 ssl;
    server_name example.com;
    # Force www
    return 301 https://www.example.com$request_uri;
}

server {
    listen 443 ssl;
    server_name www.example.com;

    # Single redirect
    location = /old-page {
        return 301 /new-page;
    }

    # Regex redirect
    location ~* ^/blog/2024/(.*)$ {
        return 301 /blog/$1;
    }

    # Remove trailing slashes
    rewrite ^/(.*)/$ /$1 permanent;
}
```

### IIS web.config Redirect Examples

```xml
<configuration>
  <system.webServer>
    <rewrite>
      <rules>
        <!-- Force HTTPS -->
        <rule name="HTTPS Redirect" stopProcessing="true">
          <match url="(.*)" />
          <conditions>
            <add input="{HTTPS}" pattern="off" />
          </conditions>
          <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
        </rule>
        <!-- Single redirect -->
        <rule name="Old to New Page" stopProcessing="true">
          <match url="^old-page$" />
          <action type="Redirect" url="/new-page" redirectType="Permanent" />
        </rule>
      </rules>
    </rewrite>
  </system.webServer>
</configuration>
```

## URL Structure Best Practices

### Flat Architecture

Keep URLs short and descriptive. Target a maximum depth of 3 levels from the root.

```
Good:  /products/widget-pro
Good:  /blog/technical-seo-guide
Bad:   /store/catalog/department/subcategory/products/widget-pro
Bad:   /p?id=12345&cat=7&ref=homepage
```

### Semantic URL Guidelines

1. Use lowercase letters only.
2. Separate words with hyphens (the one appropriate use of hyphens in URLs).
3. Avoid underscores, spaces, and special characters.
4. Include the primary keyword naturally.
5. Keep URLs under 75 characters when possible.
6. Avoid unnecessary stop words (the, and, of) unless they aid readability.

### Parameter Handling

URL parameters create duplicate content issues. Address them by:

1. Using canonical tags to point parameterized URLs to the clean version.
2. Blocking parameter patterns in robots.txt (e.g., `Disallow: /*?sort=`).
3. Configuring URL Parameters in Google Search Console (if available).
4. Implementing server side parameter stripping for analytics parameters before rendering.

## HTTP Status Codes for SEO

| Code | Meaning | SEO Usage |
|------|---------|-----------|
| 200 | OK | Standard successful response for live pages |
| 301 | Moved Permanently | Permanent URL change; passes link equity |
| 302 | Found (Temporary) | Temporary URL change; retains original URL in index |
| 304 | Not Modified | Caching signal; reduces server load for crawlers |
| 404 | Not Found | Page removed; Google will eventually deindex |
| 410 | Gone | Permanently removed; Google deindexes faster than 404 |
| 503 | Service Unavailable | Temporary downtime; tells Google to return later |

Use 410 instead of 404 when a page is permanently removed and will never return. Use 503 during planned maintenance to prevent Google from deindexing pages during downtime.

## Security Headers for SEO

Security headers indirectly affect SEO by protecting against attacks, improving user trust, and supporting HTTPS ranking signals.

```nginx
# Nginx security headers configuration
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline' https://www.googletagmanager.com; style-src 'self' 'unsafe-inline';" always;
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Permissions-Policy "camera=(), microphone=(), geolocation=()" always;
```

**HSTS (HTTP Strict Transport Security):** Forces HTTPS connections. Submit your domain to the HSTS preload list at hstspreload.org for maximum protection.

**CSP (Content Security Policy):** Restricts which resources can load on your pages. Start with report only mode to identify violations before enforcing.

**X-Frame-Options:** Prevents clickjacking by controlling whether your site can be embedded in iframes. Set to `SAMEORIGIN` unless embedding is required by partners.

## Implementation Checklist

1. Deploy robots.txt with accurate disallow rules and sitemap reference.
2. Generate and submit XML sitemaps covering all indexable pages.
3. Add self referencing canonical tags to every indexable page.
4. Audit and flatten all redirect chains to single hops.
5. Implement HTTPS with HSTS headers.
6. Verify all removed pages return 404 or 410 status codes.
7. Validate URL structure follows semantic, flat architecture.
8. Configure security headers (HSTS, CSP, X-Frame-Options).
9. Monitor crawl stats in Google Search Console weekly.
10. Run monthly technical audits using Screaming Frog or Sitebulb.
