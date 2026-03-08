---
name: ecommerce-seo
description: "Product page and category SEO for ecommerce platforms. Use when optimizing product listings, category pages, or faceted navigation for search. Trigger on: product SEO, category SEO, ecommerce, faceted navigation, product schema, shopping, PDP, PLP."
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch
argument-hint: "[ecommerce URL or domain]"
---

# Ecommerce SEO Optimization

## Product Page Optimization

### Title Tag Formula

```
[Product Name] - [Key Feature/Modifier] | [Brand Name]
```

Guidelines: under 60 characters, primary keyword first, differentiating attribute, brand at end.

### Meta Description Formula

```
[Value proposition]. [Key feature/benefit]. [Call to action]. [Trust signal].
```

Guidelines: 120 to 160 characters, primary keyword naturally, CTA, trust signals (ratings, reviews, guarantees).

### Unique Product Descriptions

Every product needs unique descriptive content (never manufacturer copy verbatim). Minimum 150 to 300 words covering: what it is, who it is for, key features, materials/specs, use cases. Use bullet points for scannable feature lists.

### Product Schema

Product schema enables rich results (price, availability, ratings). Required properties: `name`, `image`, `offers` (with `price`, `priceCurrency`, `availability`). Recommended: `sku`, `brand`, `aggregateRating`, `review`, `gtin13`/`mpn`. Include shippingDetails and hasMerchantReturnPolicy for enhanced visibility.

For full Product schema JSON-LD template with all properties, load: ${CLAUDE_SKILL_DIR}/references/schema-examples.md

## Category Page SEO

### Taxonomy Design

Maximum 3 levels: Department > Category > Subcategory. Each category targets a distinct keyword cluster. Use clear, keyword rich names with short descriptive URLs.

### Category Page Content

- **H1**: Keyword rich category name
- **Introductory text**: 100 to 200 words above product grid
- **Buying guide**: 200 to 400 words below product grid
- **FAQ section**: 3 to 5 questions with FAQ schema

### Pagination

Three options: (1) rel next/prev with paginated pages, (2) Load More button with noscript fallback (recommended), (3) infinite scroll with noscript fallback and URL updates. Ensure products are discoverable via sitemap regardless of approach.

For pagination HTML examples and Load More implementation, load: ${CLAUDE_SKILL_DIR}/references/schema-examples.md

## Faceted Navigation Management

### The Problem

Faceted navigation (color, size, price, brand, rating filters) generates thousands of URL variations causing: crawl budget waste, duplicate content, index bloat, diluted ranking signals.

### Crawl Budget Strategy

**Tier 1: Index (high search volume filters):** Create dedicated SEO optimized pages for single high value filters. Include in sitemap, allow crawling and indexing.

**Tier 2: Allow crawl, prevent indexing:** Useful but low volume filter combinations. Apply `noindex, follow`. Do NOT include in sitemap.

**Tier 3: Block crawling:** Multi facet combos, sort orders, price ranges. Block in robots.txt or use URL parameter handling. Do NOT include in sitemap.

### Implementation Approaches

1. **Canonical to base category** + noindex on filtered URLs
2. **robots.txt blocking** for multi facet and sort parameter URLs
3. **JavaScript based filtering** (no server side URLs, cleanest crawl profile)
4. **AJAX with pushState** (update URL for UX, no crawlable page created)

### URL Parameter Handling

| Parameter | Type | Crawl Behavior |
|-----------|------|---------------|
| color, size | Filter | Noindex or canonical to base |
| brand | Filter | Allow if high volume, else noindex |
| price, sort | Sort/filter | Block or noindex, canonical to base |
| page | Paginate | Allow, self referencing canonical |

For faceted navigation code examples and robots.txt patterns, load: ${CLAUDE_SKILL_DIR}/references/schema-examples.md

## Internal Search SEO

Do NOT index search results pages (default). Apply `noindex, follow` on all search results. Exception: when search creates curated, content rich pages with significant search demand and unique editorial content.

## Out of Stock Product Handling

| Scenario | Action |
|----------|--------|
| Temporarily out of stock | Keep live, show status, update schema availability, add "notify me" |
| Permanently discontinued, no replacement | Keep 6 months with "discontinued" notice + links to similar. Then 301 to parent category. |
| Permanently discontinued, has replacement | 301 to replacement immediately |
| Seasonal, will return | Keep live year round, update availability in schema, add "back in [season]" |

## Product Review Schema

Reviews must be from your own site, about a specific product, visible on the page. Mark up both individual reviews and aggregate rating.

For full review schema templates, load: ${CLAUDE_SKILL_DIR}/references/schema-examples.md

## Shopping Feed Optimization

### Google Merchant Center Required Attributes

| Attribute | Format |
|-----------|--------|
| id | SKU or internal ID |
| title | Max 150 chars, brand + key attributes |
| description | Max 5,000 chars, unique and detailed |
| link | Full canonical URL |
| image_link | Min 100x100px, no watermarks |
| availability | in_stock, out_of_stock, preorder, backorder |
| price | Number with currency |
| brand | Required for branded products |
| gtin | UPC, EAN, or ISBN |
| condition | new, refurbished, used |

**Feed title rules:** No all caps, no promotional text, most important attributes first, include color/size/material when relevant, max 150 characters.

## Seasonal and Promotional Pages

1. Create 2 to 3 months before the event
2. Use evergreen URLs (`/deals/black-friday` not `/deals/black-friday-2026`)
3. Add substantial content (buying guide, top picks, FAQ, comparison tables)
4. Build internal links from relevant category/product pages
5. Post season: update with next year info when available, keep URL intact

## Site Architecture for Large Catalogs

### Flat Architecture (Recommended)

Target: 95% of product pages within 3 clicks of homepage. No product page more than 4 clicks deep. Use pagination, related products, and cross selling to reduce depth.

### Breadcrumbs

Implement on every page with BreadcrumbList schema (JSON-LD recommended). Last item should not include `item` property. Positions start at 1 and increment sequentially.

For breadcrumb HTML/JSON-LD examples, load: ${CLAUDE_SKILL_DIR}/references/schema-examples.md

### Mega Navigation

SEO requirements: render in HTML, semantic `<nav>` with `aria-label`, include top and second level categories, keyword rich anchor text, keep total links under 150 to 200, ensure mobile version equally crawlable.

### ProductGroup Schema (Variants)

Use ProductGroup for products with color/size/material variants sharing one page. Includes `variesBy` and `hasVariant` with individual Product entries. Enables variant specific info in search results.

For ProductGroup JSON-LD template, load: ${CLAUDE_SKILL_DIR}/references/schema-examples.md
