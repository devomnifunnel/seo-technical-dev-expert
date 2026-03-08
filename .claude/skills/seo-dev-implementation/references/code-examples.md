# SEO Developer Code Examples

## Meta Tag Management

### Next.js (App Router)

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

### Nuxt 3 (Vue)

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

### NetSuite SuiteCommerce (SuiteScript 2.0)

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

## Canonical URL Logic

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

## Redirect Middleware

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

## Sitemap Generation

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

## Automated Testing with Playwright

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

## Pre-deployment SEO Checks Script

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
