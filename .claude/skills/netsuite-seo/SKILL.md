---
name: netsuite-seo
description: "SEO implementation for NetSuite SuiteCommerce platforms. Use when working on SuiteCommerce URL optimization, prerendering, or meta tag generation. Trigger on: NetSuite SEO, SuiteCommerce, SCA, SuiteScript, prerender, Backbone.js, SC Advanced, faceted navigation SEO."
---

# NetSuite SuiteCommerce SEO Implementation

## SuiteCommerce Advanced SPA Architecture Overview

SuiteCommerce Advanced (SCA) is a single page application built on Backbone.js. The core architecture consists of:

1. **Backbone.js Router:** Handles client side URL routing without full page reloads.
2. **Backbone Views and Models:** Render product, category, and content pages dynamically.
3. **Shopping, My Account, and Checkout applications:** Three separate SCA applications with independent entry points.
4. **SuiteScript Backend:** Server side scripts handle data retrieval, custom logic, and API endpoints.

The SPA architecture presents a fundamental SEO challenge: search engine crawlers receive a minimal HTML shell with JavaScript that renders content client side. Without prerendering, crawlers may see an empty or incomplete page.

## Prerendering Setup

### Prerender.io Integration

Prerendering intercepts requests from search engine bots and serves a fully rendered HTML snapshot of the page.

**Step 1: Configure middleware in your SCA deployment.**

Add prerender middleware to the SCA server configuration. This is typically done in the `server.js` or custom Express middleware layer.

```javascript
// Prerender middleware configuration
const prerender = require('prerender-node');

app.use(prerender
    .set('prerenderToken', 'YOUR_PRERENDER_TOKEN')
    .set('protocol', 'https')
    .set('host', 'www.example.com')
    .blacklisted([
        '/checkout',
        '/my-account',
        '/cart'
    ])
);
```

**Step 2: Configure user agent detection.**

The middleware detects bots by user agent string. Ensure the following crawlers are included:

- Googlebot
- Bingbot
- Slurp (Yahoo)
- DuckDuckBot
- facebookexternalhit
- LinkedInBot
- Twitterbot

**Step 3: Validate prerendered output.**

Test by appending `?_escaped_fragment_=` to your URLs or by using the Prerender.io dashboard to inspect cached pages. Verify that:

- Title tags render correctly.
- Meta descriptions are present.
- Canonical tags appear in the HTML.
- Schema markup is included in the rendered output.
- HTTP status codes match expectations (200, 301, 404).

### Self Hosted Prerender Alternative

For organizations that prefer on premises solutions:

```javascript
// Self-hosted prerender server
const prerender = require('prerender');
const server = prerender({
    chromeLocation: '/usr/bin/google-chrome',
    port: 3000,
    logRequests: true,
    pageDoneCheckInterval: 500,
    pageLoadTimeout: 20000,
    waitAfterLastRequest: 500
});

server.use(prerender.sendPrerenderHeader());
server.use(prerender.removeScriptTags());
server.use(prerender.httpHeaders());
server.start();
```

## URL Structure Optimization for SCA

### Removing Hash Fragments

By default, SCA uses hash based routing (e.g., `example.com/#/products/widget`). Search engines treat everything after the hash as a fragment and ignore it. Switching to HTML5 pushState is essential.

**In the SCA configuration file (SC.Configuration):**

```javascript
SC.Configuration = {
    // Enable HTML5 pushState for clean URLs
    defined: {
        'History.useHTML5': true
    }
};
```

This converts URLs from `/#/products/widget` to `/products/widget`.

### Clean URL Structure

Configure SCA URL components to follow SEO best practices:

```javascript
// URL component configuration in distro.json or ns.package.json
{
    "ProductDetails": {
        "urlPattern": "/products/:slug",
        "generateUrl": function(model) {
            return '/products/' + model.get('urlcomponent');
        }
    },
    "CategoryBrowse": {
        "urlPattern": "/category/:path",
        "generateUrl": function(model) {
            return '/category/' + model.get('fullurl');
        }
    }
}
```

## SuiteScript Examples

### Dynamic Meta Tag Generation (UserEvent Script, beforeLoad)

This SuiteScript 2.0 UserEvent script dynamically generates meta tags for product pages based on NetSuite item record fields.

```javascript
/**
 * @NApiVersion 2.1
 * @NScriptType UserEventScript
 * @NModuleScope SameAccount
 */
define(['N/record', 'N/search', 'N/log'], function(record, search, log) {

    function beforeLoad(context) {
        if (context.type !== context.UserEventType.VIEW) return;

        var item = context.newRecord;
        var itemName = item.getValue({ fieldId: 'itemid' });
        var storeDisplayName = item.getValue({ fieldId: 'storedisplayname' }) || itemName;
        var storeDescription = item.getValue({ fieldId: 'storedescription' }) || '';
        var metaDescription = item.getValue({ fieldId: 'metadescription' }) || '';
        var pageTitle = item.getValue({ fieldId: 'pagetitle' }) || '';
        var brand = item.getValue({ fieldId: 'custitem_brand' }) || '';

        // Generate SEO title if pagetitle field is empty
        if (!pageTitle) {
            pageTitle = storeDisplayName;
            if (brand) {
                pageTitle = storeDisplayName + ' by ' + brand;
            }
            pageTitle += ' | Example Store';
        }

        // Generate meta description if empty
        if (!metaDescription) {
            metaDescription = storeDescription.substring(0, 155);
            if (storeDescription.length > 155) {
                metaDescription = metaDescription.substring(0, metaDescription.lastIndexOf(' ')) + '...';
            }
        }

        // Set computed fields for SCA frontend consumption
        var form = context.form;
        form.addField({
            id: 'custpage_seo_title',
            type: 'text',
            label: 'SEO Title'
        }).defaultValue = pageTitle;

        form.addField({
            id: 'custpage_seo_description',
            type: 'text',
            label: 'SEO Description'
        }).defaultValue = metaDescription;

        log.debug('SEO Meta Generated', 'Title: ' + pageTitle);
    }

    return { beforeLoad: beforeLoad };
});
```

### Automated Redirect Management (Scheduled Script)

This scheduled script audits URL changes and creates redirect records automatically.

```javascript
/**
 * @NApiVersion 2.1
 * @NScriptType ScheduledScript
 * @NModuleScope SameAccount
 */
define(['N/search', 'N/record', 'N/log', 'N/runtime'], function(search, record, log, runtime) {

    function execute(context) {
        // Search for items where URL component was recently changed
        var itemSearch = search.create({
            type: search.Type.ITEM,
            filters: [
                ['modified', 'within', 'lastBusinessWeek'],
                'AND',
                ['isinactive', 'is', 'F']
            ],
            columns: [
                'itemid',
                'urlcomponent',
                'custitem_previous_url'
            ]
        });

        itemSearch.run().each(function(result) {
            var currentUrl = result.getValue('urlcomponent');
            var previousUrl = result.getValue('custitem_previous_url');

            if (previousUrl && previousUrl !== currentUrl) {
                try {
                    // Create a redirect record (custom record type)
                    var redirectRecord = record.create({
                        type: 'customrecord_seo_redirects'
                    });
                    redirectRecord.setValue({
                        fieldId: 'custrecord_redirect_from',
                        value: '/products/' + previousUrl
                    });
                    redirectRecord.setValue({
                        fieldId: 'custrecord_redirect_to',
                        value: '/products/' + currentUrl
                    });
                    redirectRecord.setValue({
                        fieldId: 'custrecord_redirect_type',
                        value: '301'
                    });
                    redirectRecord.save();

                    log.audit('Redirect Created',
                        'From: /products/' + previousUrl +
                        ' To: /products/' + currentUrl);
                } catch (e) {
                    log.error('Redirect Creation Failed', e.message);
                }
            }

            return true; // continue iteration
        });
    }

    return { execute: execute };
});
```

### XML Sitemap Generation (Suitelet)

A Suitelet that dynamically generates an XML sitemap from NetSuite item and category records.

```javascript
/**
 * @NApiVersion 2.1
 * @NScriptType Suitelet
 * @NModuleScope SameAccount
 */
define(['N/search', 'N/log', 'N/xml'], function(search, log, xml) {

    function onRequest(context) {
        var baseUrl = 'https://www.example.com';
        var urls = [];

        // Add homepage
        urls.push({
            loc: baseUrl + '/',
            lastmod: new Date().toISOString().split('T')[0],
            changefreq: 'daily',
            priority: '1.0'
        });

        // Fetch active items
        var itemSearch = search.create({
            type: search.Type.ITEM,
            filters: [
                ['isinactive', 'is', 'F'],
                'AND',
                ['isonline', 'is', 'T'],
                'AND',
                ['type', 'anyof', 'InvtPart', 'NonInvtPart', 'Kit', 'Group']
            ],
            columns: [
                'urlcomponent',
                'lastmodifieddate',
                search.createColumn({ name: 'storedisplayname', sort: search.Sort.ASC })
            ]
        });

        var pagedResults = itemSearch.runPaged({ pageSize: 1000 });
        pagedResults.pageRanges.forEach(function(pageRange) {
            pagedResults.fetch({ index: pageRange.index }).data.forEach(function(result) {
                var urlComponent = result.getValue('urlcomponent');
                var lastModified = result.getValue('lastmodifieddate');

                if (urlComponent) {
                    urls.push({
                        loc: baseUrl + '/products/' + urlComponent,
                        lastmod: formatDate(lastModified),
                        changefreq: 'weekly',
                        priority: '0.8'
                    });
                }
            });
        });

        // Build XML output
        var sitemapXml = '<?xml version="1.0" encoding="UTF-8"?>\n';
        sitemapXml += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n';

        urls.forEach(function(entry) {
            sitemapXml += '  <url>\n';
            sitemapXml += '    <loc>' + escapeXml(entry.loc) + '</loc>\n';
            sitemapXml += '    <lastmod>' + entry.lastmod + '</lastmod>\n';
            sitemapXml += '    <changefreq>' + entry.changefreq + '</changefreq>\n';
            sitemapXml += '    <priority>' + entry.priority + '</priority>\n';
            sitemapXml += '  </url>\n';
        });

        sitemapXml += '</urlset>';

        context.response.setHeader({
            name: 'Content-Type',
            value: 'application/xml'
        });
        context.response.write(sitemapXml);
    }

    function formatDate(nsDate) {
        if (!nsDate) return new Date().toISOString().split('T')[0];
        var d = new Date(nsDate);
        return d.toISOString().split('T')[0];
    }

    function escapeXml(str) {
        return str.replace(/&/g, '&amp;')
                  .replace(/</g, '&lt;')
                  .replace(/>/g, '&gt;')
                  .replace(/"/g, '&quot;')
                  .replace(/'/g, '&apos;');
    }

    return { onRequest: onRequest };
});
```

## Faceted Navigation SEO

Faceted navigation on category pages creates massive URL proliferation. A category with 5 facets, each with 10 options, can generate over 100,000 URL combinations.

### Noindex/Nofollow Patterns

Apply `noindex, follow` to filtered URLs that combine multiple facets:

```javascript
// In the SCA View module for category pages
define(['Backbone', 'underscore'], function(Backbone, _) {
    return {
        mountToApp: function(application) {
            var layout = application.getLayout();

            layout.on('afterAppendView', function(view) {
                var currentUrl = Backbone.history.getFragment();
                var facetCount = (currentUrl.match(/\//g) || []).length;

                // If more than 2 facets are applied, set noindex
                if (facetCount > 3) {
                    $('meta[name="robots"]').attr('content', 'noindex, follow');
                }
            });
        }
    };
});
```

### Canonical Management for Facets

Set the canonical tag on faceted pages to the base category URL:

```javascript
// Canonical tag management in faceted navigation view
updateCanonical: function() {
    var baseCategoryUrl = this.model.get('category').get('fullurl');
    var canonicalUrl = 'https://www.example.com/category/' + baseCategoryUrl;

    // Remove existing canonical
    $('link[rel="canonical"]').remove();

    // Add clean canonical pointing to base category
    $('head').append('<link rel="canonical" href="' + canonicalUrl + '" />');
}
```

### Crawl Budget Protection

1. Block faceted URLs in robots.txt: `Disallow: /*?facet=`
2. Add `noindex` to pages with more than 2 active filters.
3. Limit the number of indexable filter combinations to high traffic patterns only.
4. Use `rel="canonical"` on all filtered pages pointing to the parent category.

## Product Page Optimization

### Title Tag and Meta Description from NetSuite Fields

Map NetSuite fields to SEO elements:

| NetSuite Field | SEO Element | Fallback |
|----------------|-------------|----------|
| `pagetitle` | Title Tag | `storedisplayname` + brand |
| `metadescription` | Meta Description | First 155 chars of `storedescription` |
| `storedisplayname` | H1 Heading | `itemid` |
| `storedetaileddescription` | Body Content | None |

### Product Page SEO Template

```html
<!-- Product page SEO elements -->
<title>{{pageTitle}} | {{siteName}}</title>
<meta name="description" content="{{metaDescription}}" />
<link rel="canonical" href="https://www.example.com/products/{{urlComponent}}" />
<meta property="og:title" content="{{pageTitle}}" />
<meta property="og:description" content="{{metaDescription}}" />
<meta property="og:image" content="{{primaryImageUrl}}" />
<meta property="og:url" content="https://www.example.com/products/{{urlComponent}}" />
<meta property="og:type" content="product" />
```

## Category Page SEO

### Pagination Handling

For paginated category pages, use self referencing canonicals and ensure each page is accessible via internal links.

```javascript
// Pagination canonical logic in Category View
getPaginationCanonical: function() {
    var currentPage = this.options.page || 1;
    var baseUrl = 'https://www.example.com/category/' + this.model.get('fullurl');

    if (currentPage > 1) {
        return baseUrl + '?page=' + currentPage;
    }
    return baseUrl;
}
```

### Filter URL Management

Configure which filters produce indexable URLs:

```javascript
// SEO-friendly filter configuration
var indexableFilters = ['brand', 'size', 'color'];
var noindexFilters = ['price', 'rating', 'sort', 'display'];

function shouldIndexFilterUrl(appliedFilters) {
    var filterKeys = Object.keys(appliedFilters);

    // Only index single filter selections from the allowed list
    if (filterKeys.length !== 1) return false;
    return indexableFilters.indexOf(filterKeys[0]) !== -1;
}
```

## Backbone.js Router Integration for Analytics

### Virtual Pageview Tracking

Because SCA is an SPA, traditional pageview tracking misses navigation events. Integrate virtual pageview tracking with the Backbone router.

```javascript
/**
 * Virtual pageview tracking module for SCA
 */
define(['Backbone', 'underscore', 'jQuery'], function(Backbone, _, $) {

    var AnalyticsTracker = {
        mountToApp: function(application) {
            // Listen to Backbone route changes
            Backbone.history.on('route', function() {
                var currentUrl = '/' + Backbone.history.getFragment();
                var pageTitle = document.title;

                // Google Analytics 4 virtual pageview
                if (typeof gtag === 'function') {
                    gtag('event', 'page_view', {
                        page_location: window.location.origin + currentUrl,
                        page_title: pageTitle,
                        page_path: currentUrl
                    });
                }

                // Google Tag Manager dataLayer push
                window.dataLayer = window.dataLayer || [];
                window.dataLayer.push({
                    'event': 'virtualPageview',
                    'virtualPageURL': currentUrl,
                    'virtualPageTitle': pageTitle
                });
            });

            // Track initial page load
            var initialUrl = '/' + Backbone.history.getFragment();
            if (typeof gtag === 'function') {
                gtag('event', 'page_view', {
                    page_location: window.location.origin + initialUrl,
                    page_title: document.title,
                    page_path: initialUrl
                });
            }
        }
    };

    return AnalyticsTracker;
});
```

## Implementation Checklist

1. Enable HTML5 pushState to eliminate hash fragment URLs.
2. Configure Prerender.io or a self hosted prerender service for bot serving.
3. Set up SuiteScript UserEvent scripts for dynamic meta tag generation.
4. Create automated redirect management via scheduled scripts.
5. Deploy the Suitelet based XML sitemap generator and submit to Search Console.
6. Implement canonical tags on all product, category, and faceted navigation pages.
7. Apply noindex directives to multi facet filter combinations.
8. Integrate Backbone.js virtual pageview tracking for GA4 and GTM.
9. Map all critical NetSuite fields (pagetitle, metadescription, urlcomponent) to SEO elements.
10. Test prerendered output monthly using Google Search Console's URL Inspection tool.
