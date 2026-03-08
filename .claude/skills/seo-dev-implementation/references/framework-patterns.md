# Framework-Specific SEO Patterns

## React (Next.js SSR/SSG)

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

## Vue (Nuxt 3)

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

## NetSuite SuiteCommerce (SuiteScript)

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

## Shopify (Liquid)

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
