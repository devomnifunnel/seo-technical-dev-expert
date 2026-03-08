---
name: schema-markup
description: "JSON-LD structured data implementation and validation. Use when adding schema, fixing rich results, or implementing structured data. Trigger on: schema, structured data, JSON-LD, rich snippets, rich results, Product schema, FAQ schema, Organization, BreadcrumbList, HowTo."
allowed-tools: Read, Glob, Grep, Bash, Write, WebFetch
argument-hint: "[URL or page type]"
---

# Structured Data and Schema Markup Implementation Guide
## Dynamic ContextWhen invoked with a URL ($ARGUMENTS), gather existing schema before recommending changes:- Fetch MCP: extract page HTML and parse existing JSON-LD blocks- Chrome MCP: run scripts/chrome/schema-validator.js on the live page- Cross reference with Google Rich Results Test requirements for the detected schema types

## JSON-LD Fundamentals

### Syntax Basics

JSON-LD (JavaScript Object Notation for Linked Data) is the recommended format for schema markup. Place in a `<script type="application/ld+json">` tag in `<head>` or `<body>`.

**Key structural elements:**
- `@context`: Always `"https://schema.org"`
- `@type`: The schema type (Product, Organization, Article, etc.)
- `@id`: Unique identifier for cross referencing entities across blocks
- Nested objects: Properties that are themselves schema types

### Multiple Schema Types on One Page

Use separate `<script>` tags or combine in a `@graph` array:

```json
{
    "@context": "https://schema.org",
    "@graph": [
        { "@type": "WebPage", "@id": "...#webpage", "name": "..." },
        { "@type": "BreadcrumbList", "@id": "...#breadcrumb", "itemListElement": [] },
        { "@type": "Product", "@id": "...#product", "name": "..." }
    ]
}
```

## Schema Types Summary

### Product Schema
Enables rich results: price, availability, ratings, review counts. Required: `name`, `image`, `offers` (with `price`, `priceCurrency`, `availability`). Recommended: `sku`, `brand`, `aggregateRating`, `review`, `gtin13`/`mpn`. Include `shippingDetails` and `hasMerchantReturnPolicy` for enhanced results. Place on all product pages.

### Organization Schema
Establishes brand entity recognition and can trigger Knowledge Panel. Include: name, url, logo, description, foundingDate, address, contactPoint, sameAs (social profiles). Place on homepage and About page.

### Article Schema
For news articles, blog posts, editorial content. Include: headline, author (with Person type, credentials, sameAs), publisher, datePublished, dateModified, image (provide 1:1, 4:3, 16:9 ratios; min 1200px wide for Discover).

### BreadcrumbList Schema
Enables breadcrumb rich results. Last item omits `item` property. Positions start at 1. URLs must match canonicals.

### FAQPage Schema
Generates expandable FAQ rich results. FAQ content must be visible on page. Do not use for advertising content.

### HowTo Schema
Step by step rich results with optional images. Include: name, description, totalTime (ISO 8601), tool, supply, step (with position, name, text, optional image/url).

### Review and AggregateRating
`ratingCount` = total ratings; `reviewCount` = ratings with written text. Include both when available. AggregateRating typically nested within Product/LocalBusiness/Organization.

### VideoObject Schema
Video rich results with thumbnails, duration, upload date. Duration in ISO 8601 (PT15M30S). Use `hasPart` with Clip type for timestamp segments.

### WebSite with SearchAction
Sitelinks searchbox. Homepage only. Requires functional internal search. `urlTemplate` must contain `{search_term_string}`.

For complete JSON-LD templates for all schema types, load: ${CLAUDE_SKILL_DIR}/references/schema-templates.md

## Validation Process

### Google Rich Results Test
1. Navigate to `https://search.google.com/test/rich-results`
2. Enter URL or paste code snippet
3. Review detected types, errors, warnings
4. Fix all errors before deploying; warnings are recommended but not blocking

### Schema.org Validator
1. Navigate to `https://validator.schema.org/`
2. Paste JSON-LD code
3. Checks schema.org compliance but not Google specific requirements

### Google Search Console
After deployment: check Enhancements for errors/warnings/valid items. Use URL Inspection for specific pages. Request indexing after fixes.

## Common Mistakes and How to Avoid Them

1. **Markup for invisible content.** Every schema property must correspond to visible content on the page. Google may issue manual actions.
2. **AggregateRating without reviews.** Only include when you have genuine collected ratings.
3. **Missing required properties.** Always check Google docs for required properties per type.
4. **Outdated price/availability.** Generate schema dynamically from product database so it updates in real time.
5. **Duplicate schema blocks.** One block per type per entity. Use `ItemList` for category pages with multiple products.
6. **Microdata instead of JSON-LD.** Use JSON-LD for all new implementations. Easier to validate, maintain, and debug.
7. **No @id for cross referencing.** Use `@id` with unique URIs to link entities across blocks.

## Implementation Checklist

1. Deploy Organization schema on homepage and about page
2. Add Product schema to all product pages with price, availability, reviews
3. Implement Article schema on all blog posts and editorial content
4. Add BreadcrumbList schema to every page with breadcrumbs
5. Deploy FAQPage schema on pages with FAQ sections
6. Add HowTo schema to tutorial and step by step pages
7. Implement VideoObject schema on pages with embedded videos
8. Add WebSite schema with SearchAction on homepage
9. Validate all schema using Google Rich Results Test before deployment
10. Monitor GSC Enhancements report weekly after launch
11. Audit schema quarterly for accuracy (prices, availability, ratings)
12. Update implementations when Google announces new supported types
