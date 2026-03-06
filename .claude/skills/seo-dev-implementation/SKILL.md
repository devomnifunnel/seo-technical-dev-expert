---
name: seo-dev-implementation
description: "Developer handoff standards and code patterns for SEO. Use when creating implementation specs, writing SEO code, or preparing developer handoffs. Trigger on: developer handoff, implementation spec, SEO code, deployment checklist, framework SEO, technical implementation."
---

# SEO Developer Handoff and Implementation

## Developer Handoff Document Structure

Every SEO recommendation delivered to a developer must follow this standardized format:

### Template

```
## SEO Implementation Ticket

**Issue**: [Clear, specific description of the SEO problem]
**Impact**: [Critical/High/Medium/Low] — [Explanation of SEO/business impact]
**Affected URLs**: [Specific URLs or URL patterns affected]

### Acceptance Criteria
- [ ] [Specific, testable requirement 1]
- [ ] [Specific, testable requirement 2]
- [ ] [Specific, testable requirement 3]

### Implementation Steps
1. [Step by step technical instructions]
2. [Include file paths, code snippets, configuration changes]
3. [Reference relevant documentation]

### Testing
- [ ] [How to verify the fix works]
- [ ] [Edge cases to check]
- [ ] [Tools to use for validation]

### References
- [Link to relevant documentation]
- [Link to PageSpeed/GSC report showing the issue]
```

### Example Handoff

```
## SEO Implementation Ticket

**Issue**: Missing canonical tags on product pages with URL parameters
**Impact**: High — Duplicate content risk across 2,400 product pages.
  Faceted navigation generates parameter variations that Google is
  indexing as separate pages, diluting ranking signals.
**Affected URLs**: /products/* pages with query parameters
  (e.g., ?color=red, ?size=large, ?sort=price)

### Acceptance Criteria
- [ ] All /products/* pages include a self-referencing canonical
      pointing to the clean URL (no parameters)
- [ ] Canonical tag renders in the initial HTML (not injected via JS)
- [ ] Canonical URL uses HTTPS and includes trailing slash
- [ ] Parameter variations return the same canonical (the clean URL)

### Implementation Steps
1. In the product page template, add canonical tag in <head>:
   <link rel="canonical" href="https://example.com{{ page.clean_path }}" />
2. Strip all query parameters from the canonical URL
3. Ensure canonical renders server side, not client side
4. Test with 5 product URLs including parameter variations

### Testing
- [ ] View source on 5 product pages: canonical tag present and correct
- [ ] Add parameters to URL: canonical still points to clean URL
- [ ] Run URL through Google Rich Results Test: canonical visible
- [ ] Validate with Screaming Frog crawl of /products/ section

### References
- GSC Index Coverage: 3,200 "Duplicate, Google chose different canonical"
- Screaming Frog crawl export attached
```

## Code Patterns for SEO

### Meta Tag Management

**Next.js (App Router)**:
```typescript
// app/products/[slug]/page.tsx
import { Metadata } from 'next';

interface Props {
  params: { slug: string };
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const product = await getProduct(params.slug);

  return {
    title: `${product.name} | Brand Name`,
    description: product.metaDescription || product.shortDescription,
    alternates: {
      canonical: `https://example.com/products/${params.slug}`,
    },
    openGraph: {
      title: product.name,
      description: product.shortDescription,
      images: [{ url: product.image, width: 1200, height: 630 }],
      type: 'website',
    },
    robots: {
      index: product.isActive,
      follow: true,
    },
  };
}
```

**Nuxt 3 (Vue)**:
```vue
<!-- pages/products/[slug].vue -->
<script setup>
const route = useRoute();
const { data: product } = await useFetch(`/api/products/${route.params.slug}`);

useHead({
  title: `${product.value.name} | Brand Name`,
  meta: [
    { name: 'description', content: product.value.metaDescription },
    { property: 'og:title', content: product.value.name },
    { property: 'og:description', content: product.value.shortDescription },
    { property: 'og:image', content: product.value.image },
    { name: 'robots', content: product.value.isActive ? 'index, follow' : 'noindex, follow' },
  ],
  link: [
    { rel: 'canonical', href: `https://example.com/products/${route.params.slug}` },
  ],
});
</script>
```

**NetSuite SuiteCommerce (SuiteScript 2.0)**:
```javascript
// Modules/extensions/SEOMetaTags@1.0.0/JavaScript/SEOMetaTags.View.js
define('SEOMetaTags.View', [
  'Backbone',
  'SC.Configuration'
], function (Backbone, Configuration) {
  'use strict';

  return Backbone.View.extend({
    initialize: function (options) {
      this.model = options.model;
    },

    getMetaTags: function () {
      var item = this.model;
      return {
        title: item.get('pagetitle') || item.get('itemid') + ' | ' + Configuration.get('siteSettings.displayname'),
        description: item.get('metadescription') || item.get('storedetaileddescription', '').substring(0, 160),
        canonical: Configuration.get('siteSettings.touchpoints.home') + '/product/' + item.get('urlcomponent'),
        robots: item.get('isinactive') ? 'noindex, follow' : 'index, follow'
      };
    }
  });
});
```

### Canonical URL Logic

```javascript
// Middleware for canonical URL generation (Express.js)
function canonicalMiddleware(req, res, next) {
  // Build canonical URL
  let canonical = `${req.protocol}://${req.hostname}${req.path}`;

  // Force HTTPS
  canonical = canonical.replace('http://', 'https://');

  // Remove trailing slash except for root
  if (canonical.length > 1 && canonical.endsWith('/')) {
    canonical = canonical.slice(0, -1);
  }

  // Strip query parameters (canonical should be the clean URL)
  // Exception: paginated pages keep the page parameter
  const allowedParams = ['page'];
  const url = new URL(canonical);
  const filteredParams = new URLSearchParams();
  for (const [key, value] of url.searchParams) {
    if (allowedParams.includes(key)) {
      filteredParams.set(key, value);
    }
  }
  url.search = filteredParams.toString();
  canonical = url.toString();

  // Force lowercase
  canonical = canonical.toLowerCase();

  res.locals.canonical = canonical;
  next();
}
```

### Redirect Middleware

```javascript
// Express.js redirect middleware
const redirectMap = require('./redirects.json');
// redirects.json format: { "/old-path": "/new-path", ... }

function redirectMiddleware(req, res, next) {
  const path = req.path.toLowerCase();

  // Check static redirect map
  if (redirectMap[path]) {
    return res.redirect(301, redirectMap[path]);
  }

  // Force HTTPS
  if (req.headers['x-forwarded-proto'] === 'http') {
    return res.redirect(301, `https://${req.hostname}${req.originalUrl}`);
  }

  // Force www or non-www (pick one, be consistent)
  if (req.hostname === 'example.com') {
    return res.redirect(301, `https://www.example.com${req.originalUrl}`);
  }

  // Remove trailing slash (except root)
  if (req.path.length > 1 && req.path.endsWith('/')) {
    const newPath = req.path.slice(0, -1);
    const query = req.originalUrl.slice(req.path.length);
    return res.redirect(301, newPath + query);
  }

  next();
}

// IMPORTANT: Apply redirect middleware before route handlers
app.use(redirectMiddleware);
```

### Sitemap Generation

```javascript
// Dynamic XML sitemap generator (Node.js/Express)
const { SitemapStream, streamToPromise } = require('sitemap');
const { createGzip } = require('zlib');

app.get('/sitemap.xml', async (req, res) => {
  try {
    res.header('Content-Type', 'application/xml');
    res.header('Content-Encoding', 'gzip');

    const smStream = new SitemapStream({
      hostname: 'https://www.example.com'
    });
    const pipeline = smStream.pipe(createGzip());

    // Static pages
    const staticPages = [
      { url: '/', changefreq: 'daily', priority: 1.0 },
      { url: '/about', changefreq: 'monthly', priority: 0.5 },
      { url: '/contact', changefreq: 'monthly', priority: 0.5 },
    ];

    staticPages.forEach(page => smStream.write(page));

    // Dynamic pages from database
    const products = await db.query(
      'SELECT slug, updated_at FROM products WHERE active = true'
    );
    products.forEach(product => {
      smStream.write({
        url: `/products/${product.slug}`,
        lastmod: product.updated_at.toISOString(),
        changefreq: 'weekly',
        priority: 0.8,
      });
    });

    const categories = await db.query(
      'SELECT slug, updated_at FROM categories WHERE active = true'
    );
    categories.forEach(cat => {
      smStream.write({
        url: `/category/${cat.slug}`,
        lastmod: cat.updated_at.toISOString(),
        changefreq: 'weekly',
        priority: 0.7,
      });
    });

    smStream.end();

    const sitemap = await streamToPromise(pipeline);
    res.send(sitemap);
  } catch (err) {
    console.error('Sitemap generation error:', err);
    res.status(500).end();
  }
});
```

## Testing SEO Implementations

### Automated Testing with Playwright

```javascript
// tests/seo.spec.js
const { test, expect } = require('@playwright/test');

test.describe('SEO Requirements', () => {
  test('homepage has correct meta tags', async ({ page }) => {
    await page.goto('https://staging.example.com/');

    // Title tag
    const title = await page.title();
    expect(title).toBeTruthy();
    expect(title.length).toBeGreaterThan(20);
    expect(title.length).toBeLessThan(65);

    // Meta description
    const description = await page.$eval(
      'meta[name="description"]',
      el => el.content
    );
    expect(description).toBeTruthy();
    expect(description.length).toBeGreaterThan(50);
    expect(description.length).toBeLessThan(165);

    // Canonical
    const canonical = await page.$eval(
      'link[rel="canonical"]',
      el => el.href
    );
    expect(canonical).toBe('https://www.example.com/');

    // Robots
    const robots = await page.$eval(
      'meta[name="robots"]',
      el => el.content
    );
    expect(robots).toContain('index');
    expect(robots).toContain('follow');
  });

  test('product page has structured data', async ({ page }) => {
    await page.goto('https://staging.example.com/products/sample-product');

    // Extract JSON-LD
    const jsonLd = await page.$$eval(
      'script[type="application/ld+json"]',
      scripts => scripts.map(s => JSON.parse(s.textContent))
    );

    // Find Product schema
    const productSchema = jsonLd.find(s => s['@type'] === 'Product');
    expect(productSchema).toBeTruthy();
    expect(productSchema.name).toBeTruthy();
    expect(productSchema.offers).toBeTruthy();
    expect(productSchema.offers.price).toBeTruthy();
    expect(productSchema.offers.priceCurrency).toBeTruthy();
  });

  test('no broken internal links', async ({ page }) => {
    await page.goto('https://staging.example.com/');

    const links = await page.$$eval('a[href^="/"]', anchors =>
      anchors.map(a => a.href)
    );

    for (const link of links.slice(0, 50)) {
      const response = await page.request.get(link);
      expect(response.status()).toBeLessThan(400);
    }
  });

  test('images have alt text and dimensions', async ({ page }) => {
    await page.goto('https://staging.example.com/');

    const images = await page.$$eval('img', imgs =>
      imgs.map(img => ({
        src: img.src,
        alt: img.alt,
        width: img.getAttribute('width'),
        height: img.getAttribute('height'),
      }))
    );

    for (const img of images) {
      expect(img.alt, `Missing alt text: ${img.src}`).toBeTruthy();
      expect(img.width, `Missing width: ${img.src}`).toBeTruthy();
      expect(img.height, `Missing height: ${img.src}`).toBeTruthy();
    }
  });

  test('heading hierarchy is valid', async ({ page }) => {
    await page.goto('https://staging.example.com/');

    const h1Count = await page.$$eval('h1', h1s => h1s.length);
    expect(h1Count).toBe(1);

    // Verify no heading level is skipped
    const headings = await page.$$eval(
      'h1, h2, h3, h4, h5, h6',
      els => els.map(el => parseInt(el.tagName[1]))
    );

    for (let i = 1; i < headings.length; i++) {
      const jump = headings[i] - headings[i - 1];
      expect(jump, 'Heading level skipped').toBeLessThanOrEqual(1);
    }
  });
});
```

### Pre-deployment SEO Checks Script

```bash
#!/bin/bash
# pre-deploy-seo-check.sh
# Run against staging before promoting to production

STAGING_URL="https://staging.example.com"
ERRORS=0

echo "=== SEO Pre-Deployment Check ==="

# 1. Check robots.txt is accessible and not blocking everything
echo "Checking robots.txt..."
ROBOTS=$(curl -s -o /dev/null -w "%{http_code}" "$STAGING_URL/robots.txt")
if [ "$ROBOTS" != "200" ]; then
  echo "ERROR: robots.txt returns $ROBOTS"
  ERRORS=$((ERRORS + 1))
fi

# 2. Check sitemap is accessible
echo "Checking sitemap.xml..."
SITEMAP=$(curl -s -o /dev/null -w "%{http_code}" "$STAGING_URL/sitemap.xml")
if [ "$SITEMAP" != "200" ]; then
  echo "ERROR: sitemap.xml returns $SITEMAP"
  ERRORS=$((ERRORS + 1))
fi

# 3. Check key pages return 200
PAGES=("/" "/products" "/about" "/contact")
for PAGE in "${PAGES[@]}"; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$STAGING_URL$PAGE")
  if [ "$STATUS" != "200" ]; then
    echo "ERROR: $PAGE returns $STATUS"
    ERRORS=$((ERRORS + 1))
  fi
done

# 4. Check HTTPS redirect
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -L "http://staging.example.com/")
if [ "$HTTP_STATUS" != "200" ]; then
  echo "ERROR: HTTP to HTTPS redirect failed"
  ERRORS=$((ERRORS + 1))
fi

echo "=== Check complete: $ERRORS errors found ==="
exit $ERRORS
```

## Pre-deployment SEO Checklist

### Before Launch

- [ ] **Redirects**: All old URLs have 301 redirects to new URLs (no chains, no loops)
- [ ] **Meta tags**: Every page has unique title tag (50 to 60 characters) and meta description (120 to 160 characters)
- [ ] **Canonical tags**: Every page has a self referencing canonical tag
- [ ] **robots.txt**: Verified it does not block CSS, JS, images, or important pages
- [ ] **XML sitemap**: Generated, valid XML, submitted to GSC, referenced in robots.txt
- [ ] **Schema markup**: JSON-LD validated on key page types (product, article, organization, breadcrumb)
- [ ] **Heading structure**: Every page has exactly one H1, logical heading hierarchy
- [ ] **Image optimization**: All images have alt text, width/height attributes, appropriate format (WebP/AVIF)
- [ ] **Internal links**: Navigation renders in HTML (not JS only), breadcrumbs present
- [ ] **Core Web Vitals baseline**: LCP < 2.5s, INP < 200ms, CLS < 0.1 on staging
- [ ] **Mobile responsiveness**: All pages render correctly on mobile viewport
- [ ] **HTTPS**: All pages served over HTTPS, no mixed content warnings
- [ ] **Render test**: Key pages render correctly in Google Rich Results Test (verifies Googlebot can see content)

## Post-deployment Verification

### Immediate (within 1 hour)

- [ ] Spot check 10 key pages: correct status codes, meta tags, canonical tags
- [ ] Verify robots.txt is accessible and correct
- [ ] Verify sitemap.xml is accessible and valid
- [ ] Check for 404 spikes in server logs or analytics
- [ ] Run 3 key URLs through Google Rich Results Test

### First 24 hours

- [ ] Monitor GSC for new crawl errors
- [ ] Check GSC Index Coverage for spikes in errors or excluded pages
- [ ] Monitor real user CWV data (if RUM is set up)
- [ ] Check redirect chain integrity (test 10 old URLs)
- [ ] Verify structured data in GSC Enhancements

### First 7 days

- [ ] Compare organic traffic to pre launch baseline
- [ ] Monitor GSC for indexing changes (new pages indexed, pages dropped)
- [ ] Check for ranking position shifts on top 20 keywords
- [ ] Verify no CWV regressions in GSC CWV report
- [ ] Monitor 404 page in GA4 for unexpected spikes

### First 30 days

- [ ] Full ranking comparison: pre vs post deployment
- [ ] Organic traffic trend analysis
- [ ] Index coverage: verify all important pages are indexed
- [ ] CWV status: all page groups in "Good" status
- [ ] Backlink integrity: verify inbound links still resolve correctly

## Git Workflow for SEO Changes

### Branch Naming Convention

```
seo/[type]/[brief-description]

Types:
  fix     - Fixing an SEO issue (broken redirects, missing canonicals)
  feat    - New SEO feature (schema markup, new sitemap)
  perf    - Performance optimization (image optimization, CWV fix)
  content - Content related SEO changes (meta tags, heading structure)

Examples:
  seo/fix/product-canonical-tags
  seo/feat/faq-schema-markup
  seo/perf/image-lazy-loading
  seo/content/category-meta-descriptions
```

### PR Template with SEO Impact Section

```markdown
## Summary
[Brief description of the change]

## SEO Impact
**Type**: [Fix / Feature / Performance / Content]
**Affected Pages**: [URL patterns affected]
**Expected Impact**: [What SEO metric this improves and by how much]

## SEO Checklist
- [ ] No new pages without meta tags
- [ ] No changes to robots.txt behavior
- [ ] Canonical tags verified on affected pages
- [ ] Structured data validated (if applicable)
- [ ] No render blocking resources introduced
- [ ] CWV not regressed (tested in Lighthouse)
- [ ] Redirects tested (if applicable)

## Testing
[How to verify the SEO implementation is correct]
```

## Common Developer Mistakes

### SPA Without Prerendering

**Problem**: Single page applications render content via JavaScript. Googlebot may not see the full content, or indexing may be delayed and incomplete.

**Solution**:
- Use SSR (Server Side Rendering) or SSG (Static Site Generation) for all SEO critical pages
- If full SSR is not feasible, implement dynamic rendering (serve prerendered HTML to bots)
- Test every page type in Google Rich Results Test to verify Googlebot sees the content

### JavaScript Dependent Meta Tags

**Problem**: Meta tags (title, description, canonical, robots) injected via client side JavaScript may not be read by Googlebot on the first crawl pass.

**Solution**:
- All meta tags must be present in the initial HTML response
- Use server side rendering or prerendering for meta tag injection
- Verify with `curl` or "View Source" (not DevTools Elements tab, which shows post JS DOM)

### Improper Canonicals

**Common mistakes**:
- Canonical pointing to a 404 page
- Canonical pointing to a redirected URL
- Canonical using HTTP instead of HTTPS
- Canonical missing on paginated pages
- Relative canonical URLs instead of absolute
- Canonical not matching the self referencing URL exactly

### Blocking CSS/JS in robots.txt

**Problem**: Blocking CSS or JavaScript files in robots.txt prevents Googlebot from rendering the page correctly. Google cannot evaluate page layout, content visibility, or CWV.

**Solution**: Never block CSS or JS files in robots.txt. Remove any Disallow rules for /css/, /js/, /static/, /assets/ paths.

## Framework Specific Patterns

### React (Next.js SSR/SSG)

```typescript
// next.config.js - SEO-friendly configuration
module.exports = {
  // Force trailing slash consistency
  trailingSlash: false,

  // Generate sitemap at build time
  async rewrites() {
    return [
      { source: '/sitemap.xml', destination: '/api/sitemap' },
    ];
  },

  // SEO-friendly redirects
  async redirects() {
    return [
      {
        source: '/old-page',
        destination: '/new-page',
        permanent: true, // 301
      },
      {
        source: '/blog/:slug*',
        destination: '/articles/:slug*',
        permanent: true,
      },
    ];
  },

  // Custom headers for caching
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          { key: 'X-Content-Type-Options', value: 'nosniff' },
          { key: 'X-Frame-Options', value: 'DENY' },
        ],
      },
    ];
  },
};
```

### Vue (Nuxt 3)

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  app: {
    head: {
      htmlAttrs: { lang: 'en' },
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      ],
    },
  },

  routeRules: {
    // Static pages: prerender at build time
    '/': { prerender: true },
    '/about': { prerender: true },

    // Dynamic pages: server-side render
    '/products/**': { ssr: true },

    // Redirects
    '/old-path': { redirect: '/new-path' },
  },

  nitro: {
    prerender: {
      routes: ['/sitemap.xml'],
    },
  },
});
```

### NetSuite SuiteCommerce (SuiteScript)

```javascript
// SuiteScript 2.0 - Custom SEO redirect module
/**
 * @NApiVersion 2.x
 * @NScriptType Suitelet
 * @NModuleScope SameAccount
 */
define(['N/redirect', 'N/search', 'N/log'], function (redirect, search, log) {
  function onRequest(context) {
    var requestUrl = context.request.url;

    // Search for redirect mapping in custom record
    var redirectSearch = search.create({
      type: 'customrecord_seo_redirects',
      filters: [
        ['custrecord_old_url', 'is', requestUrl]
      ],
      columns: ['custrecord_new_url', 'custrecord_redirect_type']
    });

    var results = redirectSearch.run().getRange({ start: 0, end: 1 });

    if (results.length > 0) {
      var newUrl = results[0].getValue('custrecord_new_url');
      var redirectType = results[0].getValue('custrecord_redirect_type');

      context.response.sendRedirect({
        type: redirectType === '301' ? 'PERMANENT' : 'TEMPORARY',
        url: newUrl
      });
    }
  }

  return { onRequest: onRequest };
});
```

### Shopify (Liquid)

```liquid
{% comment %} theme.liquid - SEO meta tag block {% endcomment %}
<head>
  <title>
    {%- if template == 'index' -%}
      {{ shop.name }} | {{ shop.description }}
    {%- elsif template contains 'product' -%}
      {{ product.title }} | {{ shop.name }}
    {%- elsif template contains 'collection' -%}
      {{ collection.title }} | {{ shop.name }}
    {%- elsif template == 'page' -%}
      {{ page.title }} | {{ shop.name }}
    {%- elsif template contains 'blog' -%}
      {{ article.title | default: blog.title }} | {{ shop.name }}
    {%- else -%}
      {{ page_title }} | {{ shop.name }}
    {%- endif -%}
  </title>

  <meta name="description" content="{{ page_description | escape }}">
  <link rel="canonical" href="{{ canonical_url }}">

  {%- if current_tags -%}
    <meta name="robots" content="noindex, follow">
  {%- endif -%}

  {% comment %} Pagination canonical handling {% endcomment %}
  {%- if current_page > 1 -%}
    <link rel="prev" href="{{ canonical_url | append: '?page=' | append: current_page | minus: 1 }}">
  {%- endif -%}
  {%- if current_page < pages -%}
    <link rel="next" href="{{ canonical_url | append: '?page=' | append: current_page | plus: 1 }}">
  {%- endif -%}

  {% comment %} Product JSON-LD {% endcomment %}
  {%- if template contains 'product' -%}
    <script type="application/ld+json">
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "name": {{ product.title | json }},
        "description": {{ product.description | strip_html | truncate: 500 | json }},
        "image": {{ product.featured_image | image_url: width: 1200 | json }},
        "sku": {{ product.selected_or_first_available_variant.sku | json }},
        "brand": {
          "@type": "Brand",
          "name": {{ product.vendor | json }}
        },
        "offers": {
          "@type": "Offer",
          "url": "{{ shop.url }}{{ product.url }}",
          "priceCurrency": {{ shop.currency | json }},
          "price": {{ product.price | money_without_currency | json }},
          "availability": "https://schema.org/{% if product.available %}InStock{% else %}OutOfStock{% endif %}"
        }
      }
    </script>
  {%- endif -%}
</head>
```
