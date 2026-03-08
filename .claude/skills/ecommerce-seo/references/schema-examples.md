# Ecommerce Schema Markup Examples

## Full Product Schema

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

## Breadcrumb Schema (HTML and JSON-LD)

### HTML Microdata

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

### JSON-LD (recommended)

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

## ProductGroup Schema (for Variants)

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

## Pagination HTML Examples

### Option 1: rel next/prev

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

### Option 2: Load More button

```html
<div id="product-grid">
  <!-- Products rendered server-side for initial load -->
</div>
<button id="load-more" data-next-page="2">Load More Products</button>

<noscript>
  <!-- Fallback pagination for bots and no-JS users -->
  <a href="?page=2">Next Page</a>
</noscript>
```

## Faceted Navigation Code Examples

### AJAX Filtering with pushState

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

### Faceted URL Canonical and Noindex

```html
<!-- On /shoes/hiking-boots?color=brown&size=10 -->
<link rel="canonical" href="https://example.com/shoes/hiking-boots" />
<meta name="robots" content="noindex, follow" />
```

### robots.txt for Multi-Facet Blocking

```
# robots.txt
# Block multi-facet and sort parameter URLs
User-agent: *
Disallow: /*?*&*&*
Disallow: /*?sort=
Disallow: /*?page=*&sort=
```

## Shopping Feed Title Formula

```
Feed title formula:
[Brand] + [Product Name] + [Key Attribute 1] + [Key Attribute 2] + [Size/Color if applicable]

Examples:
"TrailMaster Men's Waterproof Hiking Boots Brown Leather Size 10"
"PureTea Organic Matcha Green Tea Powder 100g Ceremonial Grade"
"StoragePro Industrial Steel Shelving Unit 48x24x72 5 Tier Chrome"
```
