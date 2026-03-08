# AEO Schema Markup Examples

## Article Schema Example

```json
{
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": "Complete Guide to Crawl Budget Optimization",
    "author": {
        "@type": "Person",
        "name": "Jane Smith",
        "jobTitle": "Senior SEO Engineer",
        "url": "https://www.example.com/team/jane-smith",
        "sameAs": [
            "https://www.linkedin.com/in/janesmith",
            "https://twitter.com/janeseo"
        ]
    },
    "publisher": {
        "@type": "Organization",
        "name": "Example SEO Agency",
        "logo": {
            "@type": "ImageObject",
            "url": "https://www.example.com/logo.png"
        }
    },
    "datePublished": "2026-01-15",
    "dateModified": "2026-03-01",
    "description": "Learn how to optimize crawl budget for large websites with actionable techniques and real examples."
}
```

## Organization Schema Example

```json
{
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Example Company",
    "url": "https://www.example.com",
    "logo": "https://www.example.com/logo.png",
    "sameAs": [
        "https://www.wikipedia.org/wiki/Example_Company",
        "https://www.wikidata.org/wiki/Q12345678",
        "https://www.linkedin.com/company/example-company",
        "https://twitter.com/examplecompany",
        "https://www.facebook.com/examplecompany",
        "https://www.crunchbase.com/organization/example-company"
    ],
    "foundingDate": "2010-05-01",
    "founder": {
        "@type": "Person",
        "name": "John Doe"
    },
    "numberOfEmployees": {
        "@type": "QuantitativeValue",
        "value": 150
    },
    "industry": "Digital Marketing"
}
```

## FAQ Schema Example

```json
{
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {
            "@type": "Question",
            "name": "What is the difference between crawl rate and crawl budget?",
            "acceptedAnswer": {
                "@type": "Answer",
                "text": "Crawl rate is the maximum number of requests per second that Googlebot makes to your site without overloading it. Crawl budget is the total number of URLs Google decides to crawl based on crawl rate limit combined with crawl demand, which reflects how important and fresh your content is."
            }
        }
    ]
}
```

## HowTo Schema Example

```json
{
    "@context": "https://schema.org",
    "@type": "HowTo",
    "name": "How to Implement Canonical Tags",
    "description": "A step by step guide to implementing canonical tags on your website to prevent duplicate content issues.",
    "totalTime": "PT30M",
    "estimatedCost": {
        "@type": "MonetaryAmount",
        "currency": "USD",
        "value": "0"
    },
    "step": [
        {
            "@type": "HowToStep",
            "position": 1,
            "name": "Identify Duplicate Pages",
            "text": "Use Screaming Frog or Sitebulb to crawl your site and identify pages with duplicate or near duplicate content.",
            "url": "https://www.example.com/guide/canonical-tags#step-1"
        },
        {
            "@type": "HowToStep",
            "position": 2,
            "name": "Determine the Preferred URL",
            "text": "For each set of duplicate pages, choose the version that should be indexed. This is typically the page with the cleanest URL and the most backlinks.",
            "url": "https://www.example.com/guide/canonical-tags#step-2"
        },
        {
            "@type": "HowToStep",
            "position": 3,
            "name": "Add the Canonical Tag",
            "text": "Insert a link rel canonical tag in the head section of each duplicate page, pointing to the preferred URL.",
            "url": "https://www.example.com/guide/canonical-tags#step-3"
        }
    ]
}
```
