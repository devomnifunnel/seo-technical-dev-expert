---
name: ecommerce-seo
description: "Product page and category SEO for ecommerce platforms. Use when optimizing product listings, category pages, or faceted navigation for search. Trigger on: product SEO, category SEO, ecommerce, faceted navigation, product schema, shopping, PDP, PLP."
---

# Ecommerce SEO Optimization

## Product Page Optimization

### Title Tag Formula

```
[Product Name] - [Key Feature/Modifier] | [Brand Name]

Examples:
"Men's Waterproof Hiking Boots - Size 7 to 14 | TrailMaster"
"Organic Green Tea Matcha Powder (100g) | PureTea Co"
"Industrial Stainless Steel Shelf Unit 48x24x72 | StoragePro"
```

**Guidelines**:
- Keep under 60 characters
- Include primary keyword (product name/type) at the beginning
- Add a differentiating attribute (size range, material, use case)
- Brand name at the end (or beginning if the brand is well known)

### Meta Description Formula

```
[Value proposition]. [Key feature/benefit]. [Call to action]. [Trust signal].

Examples:
"Premium waterproof hiking boots with Vibram soles and Gore-Tex lining.
 Available in sizes 7 to 14. Free shipping on orders over $50.
 4.8 star rating from 2,300+ reviews."
```

**Guidelines**:
- Keep between 120 and 160 characters
- Include primary keyword naturally
- Add a call to action (Shop now, Free shipping, Order today)
- Include trust signals (ratings, reviews, guarantees, free returns)

### Unique Product Descriptions

Every product page needs unique descriptive content. Never use manufacturer descriptions verbatim (duplicate content across retailers).

**Minimum content requirements**:
- 150 to 300 words of unique description
- Include primary and secondary keywords naturally
- Cover: what it is, who it is for, key features, materials/specifications, use cases
- Use bullet points for scannable feature lists
- Include comparison to similar products if applicable

### Product Schema Markup

```json
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "Men's Waterproof Hiking Boots",
  "image": [
    "https://example.com/images/boots-front.webp",
    "https://example.com/images/boots-side.webp",
    "https://example.com/images/boots-sole.webp"
  ],
  "description": "Premium waterproof hiking boots with Vibram outsole and Gore-Tex lining. Designed for all terrain comfort in sizes 7 to 14.",
  "sku": "HB-WP-2026",
  "mpn": "TM-HB-2026-BRN",
  "gtin13": "0012345678905",
  "brand": {
    "@type": "Brand",
    "name": "TrailMaster"
  },
  "category": "Footwear > Hiking Boots > Men's",
  "color": "Brown",
  "material": "Full-grain leather, Gore-Tex membrane",
  "weight": {
    "@type": "QuantitativeValue",
    "value": "1.8",
    "unitCode": "LBR"
  },
  "offers": {
    "@type": "Offer",
    "url": "https://example.com/products/mens-waterproof-hiking-boots",
    "priceCurrency": "USD",
    "price": "189.99",
    "priceValidUntil": "2026-12-31",
    "availability": "https://schema.org/InStock",
    "itemCondition": "https://schema.org/NewCondition",
    "seller": {
      "@type": "Organization",
      "name": "TrailMaster Outdoor"
    },
    "shippingDetails": {
      "@type": "OfferShippingDetails",
      "shippingRate": {
        "@type": "MonetaryAmount",
        "value": "0",
        "currency": "USD"
      },
      "shippingDestination": {
        "@type": "DefinedRegion",
        "addressCountry": "US"
      },
      "deliveryTime": {
        "@type": "ShippingDeliveryTime",
        "handlingTime": {
          "@type": "QuantitativeValue",
          "minValue": "0",
          "maxValue": "1",
          "unitCode": "DAY"
        },
        "transitTime": {
          "@type": "QuantitativeValue",
          "minValue": "3",
          "maxValue": "7",
          "unitCode": "DAY"
        }
      }
    },
    "hasMerchantReturnPolicy": {
      "@type": "MerchantReturnPolicy",
      "applicableCountry": "US",
      "returnPolicyCategory": "https://schema.org/MerchantReturnFiniteReturnWindow",
      "merchantReturnDays": "30",
      "returnMethod": "https://schema.org/ReturnByMail",
      "returnFees": "https://schema.org/FreeReturn"
    }
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "reviewCount": "2347",
    "bestRating": "5",
    "worstRating": "1"
  },
  "review": [
    {
      "@type": "Review",
      "reviewRating": {
        "@type": "Rating",
        "ratingValue": "5",
        "bestRating": "5"
      },
      "author": {
        "@type": "Person",
        "name": "John D."
      },
      "datePublished": "2026-01-15",
      "reviewBody": "Best hiking boots I have ever owned. Completely waterproof after 6 months of heavy trail use."
    }
  ]
}
```

## Category Page SEO

### Taxonomy Design

**Hierarchy principles**:
- Maximum 3 levels deep: Department > Category > Subcategory
- Every category page should target a distinct keyword cluster
- Use clear, keyword rich names (not internal jargon)
- Keep URLs short and descriptive

**Example taxonomy**:
```
/shoes/                          (Department: 12,000 vol)
/shoes/hiking-boots/             (Category: 3,200 vol)
/shoes/hiking-boots/waterproof/  (Subcategory: 1,400 vol)
/shoes/running-shoes/            (Category: 5,800 vol)
/shoes/running-shoes/trail/      (Subcategory: 2,100 vol)
```

### Category Page Content

Every category page needs unique content beyond just product listings:

- **H1**: Keyword rich category name (e.g., "Men's Waterproof Hiking Boots")
- **Introductory text**: 100 to 200 words above the product grid explaining the category, who it is for, and what differentiates your selection
- **Buying guide section**: 200 to 400 words below the product grid with purchasing guidance, comparison information, and FAQ
- **FAQ section**: 3 to 5 commonly asked questions with FAQ schema markup

### Pagination

**Option 1: rel next/prev with paginated pages (traditional)**

```html
<!-- Page 1 -->
<link rel="canonical" href="https://example.com/shoes/hiking-boots" />
<link rel="next" href="https://example.com/shoes/hiking-boots?page=2" />

<!-- Page 2 -->
<link rel="canonical" href="https://example.com/shoes/hiking-boots?page=2" />
<link rel="prev" href="https://example.com/shoes/hiking-boots" />
<link rel="next" href="https://example.com/shoes/hiking-boots?page=3" />

<!-- Page 3 (last) -->
<link rel="canonical" href="https://example.com/shoes/hiking-boots?page=3" />
<link rel="prev" href="https://example.com/shoes/hiking-boots?page=2" />
```

Note: Google has stated rel next/prev is no longer used as an indexing signal, but other search engines may still use it, and it is a helpful accessibility signal.

**Option 2: Load More button (recommended for UX + SEO)**

```html
<!-- Initial page loads first 24 products -->
<!-- "Load More" button appends next 24 via JavaScript -->
<!-- All products live at the canonical URL -->
<!-- For Googlebot: ensure all products are accessible via pagination links or sitemap -->

<div id="product-grid">
  <!-- Products rendered server-side for initial load -->
</div>
<button id="load-more" data-next-page="2">Load More Products</button>

<noscript>
  <!-- Fallback pagination for bots and no-JS users -->
  <a href="?page=2">Next Page</a>
</noscript>
```

**Option 3: Infinite scroll (use with caution)**

If implementing infinite scroll, you must also provide:
- A `<noscript>` fallback with traditional pagination links
- Or ensure products are discoverable via XML sitemap
- Intersection Observer based loading so URLs update as user scrolls
- Google can struggle with infinite scroll that does not update the URL

### Faceted Navigation SEO (Detailed Below)

## Faceted Navigation Management

### The Problem

Faceted navigation (filters for color, size, price, brand, rating, etc.) generates thousands of URL variations from a single category page. Without controls, this creates:

- Massive crawl budget waste (Googlebot crawling thousands of low value filtered URLs)
- Duplicate or near duplicate content (same products, different filter order)
- Index bloat (thousands of thin, filtered pages in the index)
- Diluted ranking signals across filter variations

### Crawl Budget Strategy

**Tier 1: Index these (high search volume filter combinations)**
- Single high value filters that have search demand: `/shoes/hiking-boots/waterproof`
- Create dedicated, SEO optimized pages for these with unique content
- Include in XML sitemap, allow crawling and indexing

**Tier 2: Allow crawling, prevent indexing**
- Useful filter combinations but low search volume: `/shoes/hiking-boots?color=brown`
- Allow Googlebot to crawl (do not block in robots.txt)
- Apply `noindex, follow` meta tag
- Do NOT include in sitemap

**Tier 3: Block crawling entirely**
- Multi facet combinations, sort orders, price ranges: `/shoes/hiking-boots?color=brown&size=10&sort=price`
- Block in robots.txt OR use URL parameter handling
- Do NOT include in sitemap

### Implementation Approaches

**Approach 1: Canonical to the base category**

```html
<!-- On /shoes/hiking-boots?color=brown&size=10 -->
<link rel="canonical" href="https://example.com/shoes/hiking-boots" />
<meta name="robots" content="noindex, follow" />
```

**Approach 2: robots.txt blocking for multi facets**

```
# robots.txt
# Block multi-facet and sort parameter URLs
User-agent: *
Disallow: /*?*&*&*
Disallow: /*?sort=
Disallow: /*?page=*&sort=
```

**Approach 3: JavaScript based filter URLs (no server side URLs)**

Use JavaScript to filter products without changing the URL. Googlebot will not see filtered states. Pros: cleanest crawl profile. Cons: filtered states are not bookmarkable or shareable.

**Approach 4: AJAX filtering with pushState**

```javascript
// Update URL for UX but prevent crawling
document.getElementById('color-filter').addEventListener('change', function(e) {
  const params = new URLSearchParams(window.location.search);
  params.set('color', e.target.value);

  // Update URL without creating a crawlable page
  history.pushState({}, '', `${window.location.pathname}?${params}`);

  // Fetch filtered products via AJAX
  fetchProducts(params);
});
```

### URL Parameter Handling

Configure parameter handling to signal intent to search engines:

| Parameter | Type | Crawl Behavior |
|-----------|------|---------------|
| color | Filters content | Noindex or canonical to base |
| size | Filters content | Noindex or canonical to base |
| brand | Filters content | Allow if high volume, else noindex |
| price | Sorts/filters | Block or noindex |
| sort | Reorders content | Canonical to base, noindex |
| page | Paginates | Allow crawling, canonical to self |

## Internal Search SEO

### When to Index Internal Search Results

**Do NOT index search results pages** (default recommendation):
- Low quality, dynamically generated content
- Risk of creating thousands of thin pages
- Google explicitly warns against indexing search results pages

```html
<!-- On all internal search results pages -->
<meta name="robots" content="noindex, follow" />
```

**Exception: Consider indexing search results when**:
- The search creates curated, content rich category like pages
- The pages have significant search demand (verified via keyword research)
- You add unique content (introductory text, FAQ, editorial content) to differentiate from pure search results
- In this case, treat them as category pages with full SEO optimization

## Out of Stock Product Handling

### Decision Framework

| Scenario | Recommendation |
|----------|---------------|
| Temporarily out of stock, will return | Keep page live. Show "Out of Stock" status. Update schema availability. Add "notify me" option. |
| Permanently discontinued, no replacement | Keep live for 6 months with "discontinued" notice and links to similar products. Then 301 redirect to parent category. |
| Permanently discontinued, has replacement | 301 redirect to the replacement product page immediately. |
| Seasonal product, will return next season | Keep page live year round. Update availability in schema. Add "back in [season]" messaging. |

### Implementation for Temporarily Out of Stock

```html
<!-- Keep the page fully functional -->
<meta name="robots" content="index, follow" />

<!-- Update schema availability -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "Product Name",
  "offers": {
    "@type": "Offer",
    "availability": "https://schema.org/OutOfStock",
    "price": "89.99",
    "priceCurrency": "USD"
  }
}
</script>
```

## Product Review Schema

```json
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "Product Name",
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.6",
    "reviewCount": "589",
    "bestRating": "5",
    "worstRating": "1"
  },
  "review": [
    {
      "@type": "Review",
      "reviewRating": {
        "@type": "Rating",
        "ratingValue": "5",
        "bestRating": "5",
        "worstRating": "1"
      },
      "author": {
        "@type": "Person",
        "name": "Sarah M."
      },
      "datePublished": "2026-02-20",
      "reviewBody": "Excellent quality. The material is durable and the sizing is accurate. Would definitely recommend.",
      "name": "Great quality product"
    },
    {
      "@type": "Review",
      "reviewRating": {
        "@type": "Rating",
        "ratingValue": "4",
        "bestRating": "5",
        "worstRating": "1"
      },
      "author": {
        "@type": "Person",
        "name": "Mike T."
      },
      "datePublished": "2026-02-10",
      "reviewBody": "Good product overall. Shipping was fast. Only concern is the color is slightly different from the photos.",
      "name": "Good but color slightly off"
    }
  ]
}
```

**Requirements for review rich results**:
- Reviews must be from your own site (not aggregated from other sites)
- Reviews must be about a specific product (not the store overall)
- Both individual reviews and aggregate rating should be marked up
- Review content must be visible on the page (not hidden in tabs or accordions that require interaction)

## Shopping Feed Optimization

### Google Merchant Center Feed Attributes

**Required attributes**:

| Attribute | Description | Format |
|-----------|-------------|--------|
| id | Unique product identifier | SKU or internal ID |
| title | Product title | Max 150 characters, include brand and key attributes |
| description | Product description | Max 5,000 characters, unique and detailed |
| link | Product page URL | Full canonical URL |
| image_link | Primary product image | Full URL, minimum 100x100px, no watermarks |
| availability | Stock status | in_stock, out_of_stock, preorder, backorder |
| price | Product price | Number with currency (e.g., 89.99 USD) |
| brand | Brand name | Required for all products with a brand |
| gtin | Global Trade Item Number | UPC, EAN, or ISBN |
| condition | Product condition | new, refurbished, used |

**Recommended attributes for better performance**:

| Attribute | Impact |
|-----------|--------|
| additional_image_link | Up to 10 additional images |
| sale_price | Shows strikethrough pricing in ads |
| product_type | Your own product categorization |
| google_product_category | Google's taxonomy ID |
| color | Improves matching for apparel |
| size | Required for apparel |
| material | Improves relevance matching |
| shipping | Override account level shipping |
| return_policy | Return policy details |

### Feed Title Optimization

```
Feed title formula:
[Brand] + [Product Name] + [Key Attribute 1] + [Key Attribute 2] + [Size/Color if applicable]

Examples:
"TrailMaster Men's Waterproof Hiking Boots Brown Leather Size 10"
"PureTea Organic Matcha Green Tea Powder 100g Ceremonial Grade"
"StoragePro Industrial Steel Shelving Unit 48x24x72 5 Tier Chrome"
```

**Feed title rules**:
- Do not use all caps or excessive capitalization
- Do not include promotional text ("free shipping," "best price," "sale")
- Put the most important attributes first (brand, product name)
- Include color, size, and material when relevant
- Do not exceed 150 characters (Google truncates at this point)

## Seasonal and Promotional Landing Pages

### Creation Strategy

1. **Create the page well in advance**: At least 2 to 3 months before the seasonal event
2. **Target the seasonal keyword**: "Black Friday [product category] deals," "Christmas gifts for [audience]"
3. **Keep the URL evergreen**: `/deals/black-friday` not `/deals/black-friday-2026`
4. **Add substantial content**: Buying guide, top picks, FAQ section, comparison tables
5. **Build internal links**: Link from relevant category and product pages
6. **Implement schema**: Use the appropriate schema (Offer, Event)

### Post Season Handling

**Do NOT**:
- Delete the page and create a new one each year (lose accumulated authority)
- Leave outdated content live without updating it

**Do**:
- Update the content with the next year's information when available
- In the interim, show a message like "Check back for [event] 2027 deals. Sign up for alerts."
- Keep all internal and external links pointing to the page intact
- Update the title tag and content annually, keeping the same URL

### Redirect Strategy for Expired Promotions

```
Scenario: Campaign-specific landing page that will never return
Action: 301 redirect to the most relevant evergreen page

/sale/summer-clearance-2025 -> 301 -> /sale (evergreen sale page)
/landing/product-launch-xyz  -> 301 -> /products/xyz (the product page)
```

## Site Architecture for Large Catalogs

### Flat vs Deep Architecture

**Flat architecture** (recommended for most ecommerce sites):
- All category pages within 2 clicks of homepage
- All product pages within 3 clicks of homepage
- Broad navigation with many category links

```
Homepage (click depth 0)
├── Category A (depth 1)
│   ├── Product 1 (depth 2)
│   ├── Product 2 (depth 2)
│   └── Product 3 (depth 2)
├── Category B (depth 1)
│   ├── Subcategory B1 (depth 2)
│   │   ├── Product 4 (depth 3)
│   │   └── Product 5 (depth 3)
│   └── Product 6 (depth 2)
└── Category C (depth 1)
```

**Guidelines**:
- Target: 95% of product pages within 3 clicks of homepage
- No product page should be more than 4 clicks deep
- Use category page pagination, related products, and cross selling to reduce depth

### Breadcrumbs

Implement breadcrumbs on every page with BreadcrumbList schema:

```html
<nav aria-label="Breadcrumb">
  <ol itemscope itemtype="https://schema.org/BreadcrumbList">
    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a itemprop="item" href="https://example.com/">
        <span itemprop="name">Home</span>
      </a>
      <meta itemprop="position" content="1" />
    </li>
    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a itemprop="item" href="https://example.com/shoes/">
        <span itemprop="name">Shoes</span>
      </a>
      <meta itemprop="position" content="2" />
    </li>
    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a itemprop="item" href="https://example.com/shoes/hiking-boots/">
        <span itemprop="name">Hiking Boots</span>
      </a>
      <meta itemprop="position" content="3" />
    </li>
    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <span itemprop="name">Men's Waterproof Hiking Boots</span>
      <meta itemprop="position" content="4" />
    </li>
  </ol>
</nav>
```

**JSON-LD alternative** (cleaner, recommended):

```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "name": "Home",
      "item": "https://example.com/"
    },
    {
      "@type": "ListItem",
      "position": 2,
      "name": "Shoes",
      "item": "https://example.com/shoes/"
    },
    {
      "@type": "ListItem",
      "position": 3,
      "name": "Hiking Boots",
      "item": "https://example.com/shoes/hiking-boots/"
    },
    {
      "@type": "ListItem",
      "position": 4,
      "name": "Men's Waterproof Hiking Boots"
    }
  ]
}
```

### Mega Navigation

For large catalogs, mega navigation menus help both users and search engines discover categories:

**SEO requirements for mega navigation**:
- Render in HTML (not loaded via JavaScript on hover)
- Use semantic `<nav>` element with `aria-label`
- Include all top level and second level categories
- Use keyword rich anchor text for category links
- Keep total navigation links under 150 to 200 (avoid link dilution)
- Ensure mobile version is equally crawlable

### ProductGroup Schema (for Product Variants)

When a product has color, size, or other variants, use ProductGroup:

```json
{
  "@context": "https://schema.org",
  "@type": "ProductGroup",
  "name": "Men's Waterproof Hiking Boots",
  "description": "Premium waterproof hiking boots available in multiple colors and sizes.",
  "url": "https://example.com/products/mens-waterproof-hiking-boots",
  "brand": {
    "@type": "Brand",
    "name": "TrailMaster"
  },
  "productGroupID": "HB-WP-2026",
  "variesBy": [
    "https://schema.org/color",
    "https://schema.org/size"
  ],
  "hasVariant": [
    {
      "@type": "Product",
      "name": "Men's Waterproof Hiking Boots - Brown - Size 10",
      "color": "Brown",
      "size": "10",
      "sku": "HB-WP-2026-BRN-10",
      "image": "https://example.com/images/boots-brown.webp",
      "offers": {
        "@type": "Offer",
        "priceCurrency": "USD",
        "price": "189.99",
        "availability": "https://schema.org/InStock",
        "url": "https://example.com/products/mens-waterproof-hiking-boots?color=brown&size=10"
      }
    },
    {
      "@type": "Product",
      "name": "Men's Waterproof Hiking Boots - Black - Size 10",
      "color": "Black",
      "size": "10",
      "sku": "HB-WP-2026-BLK-10",
      "image": "https://example.com/images/boots-black.webp",
      "offers": {
        "@type": "Offer",
        "priceCurrency": "USD",
        "price": "189.99",
        "availability": "https://schema.org/InStock",
        "url": "https://example.com/products/mens-waterproof-hiking-boots?color=black&size=10"
      }
    }
  ]
}
```

**When to use ProductGroup**:
- Products with color, size, material, or pattern variants
- All variants share the same product page (variant selector on page)
- Helps Google understand the relationship between variants
- Enables variant specific information in search results (available sizes, colors)
