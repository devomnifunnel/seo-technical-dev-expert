# NetSuite SuiteScript SEO Code Examples

## Dynamic Meta Tag Generation (UserEvent Script, beforeLoad)

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

## Automated Redirect Management (Scheduled Script)

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

## XML Sitemap Generation (Suitelet)

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

## Faceted Navigation SEO Module

### Noindex/Nofollow for Multi-Facet URLs

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

### Filter URL Configuration

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

### Pagination Canonical Logic

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

## Backbone.js Virtual Pageview Tracking

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
