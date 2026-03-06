---
name: schema-markup
description: "JSON-LD structured data implementation and validation. Use when adding schema, fixing rich results, or implementing structured data. Trigger on: schema, structured data, JSON-LD, rich snippets, rich results, Product schema, FAQ schema, Organization, BreadcrumbList, HowTo."
allowed-tools: Read, Glob, Grep, Bash, Write, WebFetch
---

# Structured Data and Schema Markup Implementation Guide
## Dynamic ContextWhen invoked with a URL ($ARGUMENTS), gather existing schema before recommending changes:- Fetch MCP: extract page HTML and parse existing JSON-LD blocks- Chrome MCP: run scripts/chrome/schema-validator.js on the live page- Cross reference with Google Rich Results Test requirements for the detected schema types

## JSON-LD Fundamentals

### Syntax Basics

JSON-LD (JavaScript Object Notation for Linked Data) is the recommended format for implementing schema markup. Place JSON-LD in a `<script>` tag within the `<head>` or `<body>` of your HTML.

```html
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "WebPage",
    "name": "Page Title",
    "description": "Page description"
}
</script>
```

**Key structural elements:**

- `@context`: Always set to `"https://schema.org"`. Defines the vocabulary being used.
- `@type`: Specifies the schema type (Product, Organization, Article, etc.).
- `@id`: A unique identifier for the entity. Useful when referencing the same entity across multiple schema blocks.
- Nested objects: Properties that are themselves schema types are nested as objects with their own `@type`.

### Multiple Schema Types on One Page

You can include multiple schema blocks on a single page by using separate `<script>` tags or by combining them in a `@graph` array:

```json
{
    "@context": "https://schema.org",
    "@graph": [
        {
            "@type": "WebPage",
            "@id": "https://www.example.com/products/widget#webpage",
            "name": "Widget Pro",
            "url": "https://www.example.com/products/widget"
        },
        {
            "@type": "BreadcrumbList",
            "@id": "https://www.example.com/products/widget#breadcrumb",
            "itemListElement": []
        },
        {
            "@type": "Product",
            "@id": "https://www.example.com/products/widget#product",
            "name": "Widget Pro"
        }
    ]
}
```

## Product Schema

Product schema enables rich results in Google Search including price, availability, ratings, and review counts.

```json
{
    "@context": "https://schema.org",
    "@type": "Product",
    "name": "Widget Pro 3000",
    "description": "Professional grade widget with titanium construction and 5 year warranty. Ideal for industrial applications requiring precision and durability.",
    "sku": "WP3000-BLU",
    "mpn": "WP3000",
    "gtin13": "0123456789012",
    "brand": {
        "@type": "Brand",
        "name": "WidgetCorp"
    },
    "image": [
        "https://www.example.com/images/widget-pro-front.jpg",
        "https://www.example.com/images/widget-pro-side.jpg",
        "https://www.example.com/images/widget-pro-detail.jpg"
    ],
    "url": "https://www.example.com/products/widget-pro-3000",
    "offers": {
        "@type": "Offer",
        "url": "https://www.example.com/products/widget-pro-3000",
        "priceCurrency": "USD",
        "price": "149.99",
        "priceValidUntil": "2026-12-31",
        "availability": "https://schema.org/InStock",
        "itemCondition": "https://schema.org/NewCondition",
        "seller": {
            "@type": "Organization",
            "name": "Example Store"
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
                    "minValue": 0,
                    "maxValue": 1,
                    "unitCode": "DAY"
                },
                "transitTime": {
                    "@type": "QuantitativeValue",
                    "minValue": 3,
                    "maxValue": 7,
                    "unitCode": "DAY"
                }
            }
        },
        "hasMerchantReturnPolicy": {
            "@type": "MerchantReturnPolicy",
            "applicableCountry": "US",
            "returnPolicyCategory": "https://schema.org/MerchantReturnFiniteReturnWindow",
            "merchantReturnDays": 30,
            "returnMethod": "https://schema.org/ReturnByMail",
            "returnFees": "https://schema.org/FreeReturn"
        }
    },
    "aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": "4.7",
        "bestRating": "5",
        "worstRating": "1",
        "ratingCount": "312",
        "reviewCount": "189"
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
            "datePublished": "2026-02-15",
            "reviewBody": "Excellent quality widget. The titanium construction feels incredibly solid and the precision is outstanding for industrial use."
        }
    ]
}
```

**Required properties for rich results:** `name`, `image`, `offers` (with `price`, `priceCurrency`, `availability`).

**Recommended additions:** `sku`, `brand`, `aggregateRating`, `review`, `gtin13` or `mpn`.

## Organization Schema

Organization schema establishes brand entity recognition and can trigger a Knowledge Panel.

```json
{
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Example Digital Agency",
    "alternateName": "Example Agency",
    "url": "https://www.example.com",
    "logo": {
        "@type": "ImageObject",
        "url": "https://www.example.com/images/logo.png",
        "width": 600,
        "height": 120
    },
    "image": "https://www.example.com/images/office-photo.jpg",
    "description": "Full service digital marketing agency specializing in SEO, paid media, and web development for ecommerce brands.",
    "foundingDate": "2015-06-01",
    "founder": {
        "@type": "Person",
        "name": "Jane Smith",
        "jobTitle": "CEO"
    },
    "numberOfEmployees": {
        "@type": "QuantitativeValue",
        "value": 45
    },
    "address": {
        "@type": "PostalAddress",
        "streetAddress": "100 Commerce Street, Suite 200",
        "addressLocality": "Dallas",
        "addressRegion": "TX",
        "postalCode": "75202",
        "addressCountry": "US"
    },
    "contactPoint": [
        {
            "@type": "ContactPoint",
            "telephone": "+1-214-555-0100",
            "contactType": "customer service",
            "availableLanguage": ["English", "Spanish"],
            "areaServed": "US"
        },
        {
            "@type": "ContactPoint",
            "telephone": "+1-214-555-0101",
            "contactType": "sales",
            "availableLanguage": "English"
        }
    ],
    "sameAs": [
        "https://www.facebook.com/exampleagency",
        "https://twitter.com/exampleagency",
        "https://www.linkedin.com/company/example-agency",
        "https://www.instagram.com/exampleagency",
        "https://www.youtube.com/c/exampleagency",
        "https://www.crunchbase.com/organization/example-agency"
    ]
}
```

**Place Organization schema on:** The homepage and the "About Us" page.

## Article Schema

Article schema helps Google understand news articles, blog posts, and editorial content.

```json
{
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": "How to Optimize Core Web Vitals for Ecommerce Sites",
    "description": "A comprehensive guide to improving LCP, INP, and CLS scores on ecommerce websites with practical code examples and real case studies.",
    "image": [
        "https://www.example.com/images/cwv-guide-1x1.jpg",
        "https://www.example.com/images/cwv-guide-4x3.jpg",
        "https://www.example.com/images/cwv-guide-16x9.jpg"
    ],
    "author": {
        "@type": "Person",
        "name": "Jane Smith",
        "url": "https://www.example.com/team/jane-smith",
        "jobTitle": "Senior SEO Engineer",
        "sameAs": [
            "https://www.linkedin.com/in/janesmith",
            "https://twitter.com/janeseo"
        ]
    },
    "publisher": {
        "@type": "Organization",
        "name": "Example Digital Agency",
        "logo": {
            "@type": "ImageObject",
            "url": "https://www.example.com/images/logo.png"
        }
    },
    "datePublished": "2026-01-15T08:00:00+00:00",
    "dateModified": "2026-03-01T14:30:00+00:00",
    "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": "https://www.example.com/blog/core-web-vitals-ecommerce"
    },
    "wordCount": 3500,
    "articleSection": "Technical SEO",
    "keywords": ["core web vitals", "ecommerce SEO", "page speed", "LCP optimization"]
}
```

**Google image requirements for Article schema:** Provide images in multiple aspect ratios (1:1, 4:3, 16:9). Minimum width: 1200 pixels for optimal display in Google Discover.

## BreadcrumbList Schema

Breadcrumb schema enables breadcrumb rich results showing the page hierarchy in search listings.

```json
{
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
        {
            "@type": "ListItem",
            "position": 1,
            "name": "Home",
            "item": "https://www.example.com/"
        },
        {
            "@type": "ListItem",
            "position": 2,
            "name": "Products",
            "item": "https://www.example.com/products/"
        },
        {
            "@type": "ListItem",
            "position": 3,
            "name": "Widgets",
            "item": "https://www.example.com/products/widgets/"
        },
        {
            "@type": "ListItem",
            "position": 4,
            "name": "Widget Pro 3000"
        }
    ]
}
```

**Rules:**

- The last item in the list (current page) should not include the `item` property.
- `position` must start at 1 and increment sequentially.
- Use the exact URLs that match your canonical tags.

## FAQPage Schema

FAQPage schema generates expandable FAQ rich results directly in search listings.

```json
{
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {
            "@type": "Question",
            "name": "What are Core Web Vitals?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "Core Web Vitals are a set of three performance metrics that Google uses to measure user experience: Largest Contentful Paint (LCP) measures loading speed, Interaction to Next Paint (INP) measures interactivity responsiveness, and Cumulative Layout Shift (CLS) measures visual stability. These metrics are part of Google's page experience ranking signals."
            }
        },
        {
            "@type": "Question",
            "name": "What is a good LCP score?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "A good LCP score is 2.5 seconds or less. Scores between 2.5 and 4.0 seconds need improvement, and scores above 4.0 seconds are considered poor. LCP measures how long it takes for the largest visible content element to render on screen."
            }
        },
        {
            "@type": "Question",
            "name": "How do Core Web Vitals affect SEO rankings?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "Core Web Vitals are a confirmed Google ranking factor as part of the page experience signal. While content relevance and backlinks remain stronger signals, pages with good Core Web Vitals scores may receive a ranking boost over pages with poor scores when other ranking factors are similar. The impact is most noticeable for competitive queries where multiple results have similar content quality."
            }
        }
    ]
}
```

**Eligibility rules:** The FAQ content must be visible on the page. Hidden or accordion content is acceptable as long as it is in the HTML source. Do not use FAQPage schema for content that is only for advertising purposes.

## HowTo Schema

HowTo schema generates step by step rich results with optional images for each step.

```json
{
    "@context": "https://schema.org",
    "@type": "HowTo",
    "name": "How to Implement Canonical Tags on Your Website",
    "description": "A step by step guide to implementing canonical tags to prevent duplicate content issues and consolidate ranking signals.",
    "image": "https://www.example.com/images/canonical-tag-guide.jpg",
    "totalTime": "PT45M",
    "estimatedCost": {
        "@type": "MonetaryAmount",
        "currency": "USD",
        "value": "0"
    },
    "tool": [
        {
            "@type": "HowToTool",
            "name": "Screaming Frog SEO Spider"
        },
        {
            "@type": "HowToTool",
            "name": "Google Search Console"
        }
    ],
    "supply": [
        {
            "@type": "HowToSupply",
            "name": "Access to website CMS or HTML files"
        }
    ],
    "step": [
        {
            "@type": "HowToStep",
            "position": 1,
            "name": "Crawl Your Site for Duplicate Content",
            "text": "Use Screaming Frog to crawl your entire website. Export the results and sort by page title and content hash to identify pages with duplicate or near duplicate content.",
            "url": "https://www.example.com/guides/canonical-tags#step-1",
            "image": "https://www.example.com/images/step-1-crawl.jpg"
        },
        {
            "@type": "HowToStep",
            "position": 2,
            "name": "Identify the Preferred URL for Each Duplicate Set",
            "text": "For each group of duplicate pages, choose the canonical version. Prefer the URL with the most backlinks, the cleanest URL structure, and the highest organic traffic.",
            "url": "https://www.example.com/guides/canonical-tags#step-2",
            "image": "https://www.example.com/images/step-2-identify.jpg"
        },
        {
            "@type": "HowToStep",
            "position": 3,
            "name": "Add the Canonical Tag to the Page Head",
            "text": "In the <head> section of each duplicate page, add a link element with rel='canonical' pointing to the preferred URL. Example: <link rel='canonical' href='https://www.example.com/preferred-page' />",
            "url": "https://www.example.com/guides/canonical-tags#step-3",
            "image": "https://www.example.com/images/step-3-implement.jpg"
        },
        {
            "@type": "HowToStep",
            "position": 4,
            "name": "Add Self Referencing Canonicals",
            "text": "Ensure every indexable page on your site includes a self referencing canonical tag. This protects against duplication caused by URL parameters, tracking codes, or protocol variations.",
            "url": "https://www.example.com/guides/canonical-tags#step-4"
        },
        {
            "@type": "HowToStep",
            "position": 5,
            "name": "Validate and Monitor",
            "text": "Use Google Search Console's URL Inspection tool to verify that Google recognizes your canonical tags. Check for canonical conflicts where Google selects a different canonical than the one you specified.",
            "url": "https://www.example.com/guides/canonical-tags#step-5"
        }
    ]
}
```

## Review and AggregateRating Schema

### Individual Review

```json
{
    "@context": "https://schema.org",
    "@type": "Review",
    "itemReviewed": {
        "@type": "Product",
        "name": "Widget Pro 3000"
    },
    "reviewRating": {
        "@type": "Rating",
        "ratingValue": "4",
        "bestRating": "5",
        "worstRating": "1"
    },
    "author": {
        "@type": "Person",
        "name": "Sarah Johnson"
    },
    "datePublished": "2026-02-20",
    "reviewBody": "Solid product that delivers on its promises. The build quality is excellent and setup was straightforward. I took off one star because the documentation could be more detailed."
}
```

### AggregateRating

AggregateRating is typically nested within a Product, LocalBusiness, or Organization schema rather than used standalone.

```json
{
    "@type": "AggregateRating",
    "ratingValue": "4.6",
    "bestRating": "5",
    "worstRating": "1",
    "ratingCount": "485",
    "reviewCount": "312"
}
```

**Important distinction:** `ratingCount` is the total number of ratings (including those without written reviews). `reviewCount` is the number of ratings that include written review text. Include both when available.

## Video Schema

Video schema enables video rich results including thumbnails, duration, and upload date.

```json
{
    "@context": "https://schema.org",
    "@type": "VideoObject",
    "name": "Core Web Vitals Optimization Tutorial",
    "description": "Learn how to diagnose and fix LCP, INP, and CLS issues on your website. This tutorial covers practical optimization techniques with real examples.",
    "thumbnailUrl": "https://www.example.com/images/video-thumbnail-cwv.jpg",
    "uploadDate": "2026-02-01T08:00:00+00:00",
    "duration": "PT15M30S",
    "contentUrl": "https://www.example.com/videos/cwv-tutorial.mp4",
    "embedUrl": "https://www.youtube.com/embed/abc123xyz",
    "interactionStatistic": {
        "@type": "InteractionCounter",
        "interactionType": {
            "@type": "WatchAction"
        },
        "userInteractionCount": 15420
    },
    "publisher": {
        "@type": "Organization",
        "name": "Example Digital Agency",
        "logo": {
            "@type": "ImageObject",
            "url": "https://www.example.com/images/logo.png"
        }
    },
    "hasPart": [
        {
            "@type": "Clip",
            "name": "Understanding LCP",
            "startOffset": 0,
            "endOffset": 300,
            "url": "https://www.example.com/blog/cwv-tutorial#lcp"
        },
        {
            "@type": "Clip",
            "name": "Fixing INP Issues",
            "startOffset": 300,
            "endOffset": 600,
            "url": "https://www.example.com/blog/cwv-tutorial#inp"
        },
        {
            "@type": "Clip",
            "name": "Preventing CLS Problems",
            "startOffset": 600,
            "endOffset": 930,
            "url": "https://www.example.com/blog/cwv-tutorial#cls"
        }
    ]
}
```

**Duration format:** Use ISO 8601 duration format. `PT15M30S` means 15 minutes and 30 seconds. `PT1H5M` means 1 hour and 5 minutes.

## Sitelinks Searchbox Schema

Sitelinks Searchbox schema enables a search box within your sitelinks in Google Search results. This is only applicable for your homepage.

```json
{
    "@context": "https://schema.org",
    "@type": "WebSite",
    "name": "Example Store",
    "url": "https://www.example.com",
    "potentialAction": {
        "@type": "SearchAction",
        "target": {
            "@type": "EntryPoint",
            "urlTemplate": "https://www.example.com/search?q={search_term_string}"
        },
        "query-input": "required name=search_term_string"
    }
}
```

**Requirements:**

- Your site must have a functional internal search engine.
- The `urlTemplate` must contain the `{search_term_string}` placeholder.
- This schema should only appear on the homepage.
- Google decides whether to show the searchbox based on relevance and user behavior.

## Validation Process

### Google Rich Results Test

1. Navigate to `https://search.google.com/test/rich-results`.
2. Enter the URL or paste the code snippet.
3. Review detected schema types and any errors or warnings.
4. Fix all errors before deploying. Warnings are recommended improvements, not blockers.

### Schema.org Validator

1. Navigate to `https://validator.schema.org/`.
2. Paste your JSON-LD code.
3. Review the parsed output for structural correctness.
4. This validator checks schema.org compliance but does not test Google specific requirements.

### Google Search Console

After deployment:

1. Open Google Search Console and navigate to Enhancements.
2. Review each rich result type for errors, warnings, and valid items.
3. Use the URL Inspection tool to test specific pages.
4. Request indexing after fixing any issues.

## Common Mistakes and How to Avoid Them

### 1. Markup for Content Not Visible on the Page

**Mistake:** Adding schema for content that does not appear anywhere on the page.

**Fix:** Every property in your schema must correspond to visible content on the page. Google may issue a manual action for misleading structured data.

### 2. Incorrect Use of AggregateRating

**Mistake:** Adding AggregateRating to a page that has no actual reviews or ratings.

**Fix:** Only include AggregateRating when you have genuine, collected user ratings. The `ratingCount` must reflect real data.

### 3. Missing Required Properties

**Mistake:** Implementing Product schema without `offers`, `image`, or `name`.

**Fix:** Always check Google's documentation for required properties per schema type before deploying.

### 4. Outdated Price or Availability

**Mistake:** Hardcoding a price in schema that does not update when the product price changes.

**Fix:** Generate schema dynamically from your product database or CMS so prices and availability update in real time.

### 5. Duplicate Schema Blocks

**Mistake:** Including the same schema type multiple times on a page with conflicting data.

**Fix:** Use a single block per schema type per entity. If a page has multiple products (category page), use `ItemList` schema rather than multiple `Product` blocks.

### 6. Using Microdata When JSON-LD Is Available

**Mistake:** Implementing schema as inline Microdata attributes, which is harder to maintain and debug.

**Fix:** Use JSON-LD for all new implementations. It is easier to validate, maintain, and does not require changes to HTML structure.

### 7. Not Specifying @id for Cross Referencing

**Mistake:** Referencing the same entity (e.g., the author or organization) across multiple schema blocks without linking them.

**Fix:** Use `@id` to create a unique URI for each entity and reference it in other blocks:

```json
{
    "@type": "Person",
    "@id": "https://www.example.com/team/jane-smith#person",
    "name": "Jane Smith"
}
```

Then reference it elsewhere:

```json
{
    "author": {
        "@id": "https://www.example.com/team/jane-smith#person"
    }
}
```

## Implementation Checklist

1. Deploy Organization schema on the homepage and about page.
2. Add Product schema to all product pages with price, availability, and reviews.
3. Implement Article schema on all blog posts and editorial content.
4. Add BreadcrumbList schema to every page with breadcrumb navigation.
5. Deploy FAQPage schema on pages with FAQ sections.
6. Add HowTo schema to tutorial and step by step guide pages.
7. Implement VideoObject schema on pages with embedded videos.
8. Add WebSite schema with SearchAction on the homepage.
9. Validate all schema using Google Rich Results Test before deployment.
10. Monitor Google Search Console Enhancements report weekly after launch.
11. Audit schema quarterly for accuracy (prices, availability, ratings).
12. Update schema implementations when Google announces new supported types or requirements.
