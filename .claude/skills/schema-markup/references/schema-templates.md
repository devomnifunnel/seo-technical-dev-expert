# Schema Markup Templates

## Product Schema (Full)

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

## Organization Schema (Full)

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

## Article Schema (Full)

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

## HowTo Schema (Full)

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

## Video Schema (Full)

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

## @id Cross-Referencing Pattern

Use `@id` to create a unique URI for each entity and reference it in other blocks:

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
