---
name: international-seo
description: "URL structure, hreflang, and content localization for multi market SEO. Use when expanding internationally or fixing hreflang issues. Trigger on: hreflang, international SEO, multilingual, geo targeting, localization, ccTLD, subdomain, subfolder."
context: fork
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch
argument-hint: "[domain with multi-language/region]"
agent: Explore
---

# International and Multilingual SEO

## URL Structure Options

### ccTLD (Country Code Top Level Domain)

**Structure**: `example.de`, `example.fr`, `example.co.uk`

**Pros**:
- Strongest geo targeting signal to search engines
- Users trust local domain extensions (builds click through confidence)
- Each domain can be hosted locally for optimal speed
- Complete isolation: issues on one domain do not affect others

**Cons**:
- Most expensive: separate domain registration, hosting, and maintenance per country
- Domain authority starts from zero for each new ccTLD
- Backlinks are siloed across domains (link equity does not transfer)
- Requires separate GSC properties per domain
- Most complex to manage at scale

**Best for**: Large enterprises with dedicated resources per market, businesses where local trust is paramount (financial services, government).

### Subdomain

**Structure**: `de.example.com`, `fr.example.com`, `uk.example.com`

**Pros**:
- Easy to set up and manage independently per market
- Can be hosted on different servers/CDNs per region
- GSC allows geo targeting per subdomain
- Free (no additional domain registration)

**Cons**:
- Google treats subdomains as semi separate entities (limited authority sharing)
- Weaker geo targeting signal than ccTLD
- Users less likely to recognize geo targeting from subdomain
- Backlinks to one subdomain provide limited benefit to others

**Best for**: Businesses wanting some separation between markets without the cost of ccTLDs.

### Subdirectory (Recommended for Most Cases)

**Structure**: `example.com/de/`, `example.com/fr/`, `example.com/uk/`

**Pros**:
- All link equity flows to a single domain (strongest authority consolidation)
- Simplest to maintain: one hosting setup, one CMS, one analytics property
- Domain authority benefits all language versions
- Single GSC property with international targeting per subdirectory
- Cheapest to operate

**Cons**:
- Server must handle all languages (single point of failure)
- Cannot host locally per region (use CDN to compensate)
- Slightly weaker geo targeting signal than ccTLD
- More complex URL routing and CMS configuration

**Best for**: Small to mid size businesses, companies with limited international SEO resources, sites where consolidating domain authority is the priority.

### Decision Matrix

| Factor | ccTLD | Subdomain | Subdirectory |
|--------|-------|-----------|-------------|
| Geo targeting strength | Strong | Medium | Medium |
| Domain authority sharing | None | Limited | Full |
| Setup cost | High | Medium | Low |
| Maintenance effort | High | Medium | Low |
| Hosting flexibility | Full | Full | Limited (use CDN) |
| Link equity | Siloed | Semi siloed | Consolidated |
| Best for scale | Enterprise | Mid market | SMB to mid market |

## Hreflang Implementation

### Syntax

Hreflang tags tell search engines which language and country version of a page to serve to users in different locales.

**Format**: `<link rel="alternate" hreflang="[language]-[country]" href="[URL]" />`

**Language codes**: ISO 639-1 (two letter: en, fr, de, es, ja)
**Country codes**: ISO 3166-1 Alpha-2 (two letter: US, GB, FR, DE, JP)

### Common Language/Country Combinations

| Target Audience | hreflang Value |
|----------------|---------------|
| English (US) | en-us |
| English (UK) | en-gb |
| English (Australia) | en-au |
| English (generic) | en |
| French (France) | fr-fr |
| French (Canada) | fr-ca |
| German (Germany) | de-de |
| German (Austria) | de-at |
| Spanish (Spain) | es-es |
| Spanish (Mexico) | es-mx |
| Portuguese (Brazil) | pt-br |
| Chinese Simplified | zh-hans |
| Japanese | ja |

### x-default

The `x-default` value specifies the default page for users whose language/country does not match any specific hreflang entry. Typically points to the English version or a language selector page.

```html
<link rel="alternate" hreflang="x-default" href="https://example.com/" />
```

### Self Referencing Rule

Every page MUST include a hreflang tag pointing to itself. This is a critical requirement that is frequently overlooked.

### Complete HTML Example

```html
<!-- On the page: https://example.com/products/widget -->
<head>
  <!-- Self-referencing (English US - the current page) -->
  <link rel="alternate" hreflang="en-us" href="https://example.com/products/widget" />

  <!-- English UK version -->
  <link rel="alternate" hreflang="en-gb" href="https://example.com/uk/products/widget" />

  <!-- French version -->
  <link rel="alternate" hreflang="fr-fr" href="https://example.com/fr/products/widget" />

  <!-- German version -->
  <link rel="alternate" hreflang="de-de" href="https://example.com/de/products/widget" />

  <!-- Spanish version -->
  <link rel="alternate" hreflang="es-es" href="https://example.com/es/products/widget" />

  <!-- Default fallback -->
  <link rel="alternate" hreflang="x-default" href="https://example.com/products/widget" />

  <!-- Canonical (self-referencing) -->
  <link rel="canonical" href="https://example.com/products/widget" />
</head>
```

**Critical**: The French page (`/fr/products/widget`) must have the EXACT same set of hreflang tags, including a self referencing tag for `fr-fr`. Every page in the cluster must reference every other page in the cluster.

## Implementation Methods

### Method 1: HTML Link Elements (Most Common)

Place hreflang tags in the `<head>` of every page. Best for sites with fewer than 50 language/country combinations per page.

```html
<head>
  <link rel="alternate" hreflang="en" href="https://example.com/page" />
  <link rel="alternate" hreflang="fr" href="https://example.com/fr/page" />
  <link rel="alternate" hreflang="de" href="https://example.com/de/page" />
  <link rel="alternate" hreflang="x-default" href="https://example.com/page" />
</head>
```

**Pros**: Easy to implement, easy to audit, widely supported
**Cons**: Adds to HTML size, can bloat `<head>` with many language versions

### Method 2: HTTP Headers

Use HTTP response headers for non HTML files (PDFs, documents) or when you cannot modify HTML.

```
HTTP/1.1 200 OK
Link: <https://example.com/page>; rel="alternate"; hreflang="en",
      <https://example.com/fr/page>; rel="alternate"; hreflang="fr",
      <https://example.com/de/page>; rel="alternate"; hreflang="de",
      <https://example.com/page>; rel="alternate"; hreflang="x-default"
```

**Nginx configuration**:

```nginx
location /documents/guide.pdf {
    add_header Link '<https://example.com/documents/guide.pdf>; rel="alternate"; hreflang="en", <https://example.com/fr/documents/guide.pdf>; rel="alternate"; hreflang="fr", <https://example.com/documents/guide.pdf>; rel="alternate"; hreflang="x-default"';
}
```

**Pros**: Works for non HTML content, does not bloat page source
**Cons**: Harder to maintain, harder to audit, requires server configuration access

### Method 3: XML Sitemap Hreflang (Best for Large Sites)

Include hreflang annotations in the XML sitemap. Best for sites with hundreds or thousands of international pages.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xhtml="http://www.w3.org/1999/xhtml">

  <!-- English US version -->
  <url>
    <loc>https://example.com/products/widget</loc>
    <xhtml:link rel="alternate" hreflang="en-us"
                href="https://example.com/products/widget" />
    <xhtml:link rel="alternate" hreflang="en-gb"
                href="https://example.com/uk/products/widget" />
    <xhtml:link rel="alternate" hreflang="fr-fr"
                href="https://example.com/fr/products/widget" />
    <xhtml:link rel="alternate" hreflang="de-de"
                href="https://example.com/de/products/widget" />
    <xhtml:link rel="alternate" hreflang="x-default"
                href="https://example.com/products/widget" />
    <lastmod>2026-02-15</lastmod>
  </url>

  <!-- English UK version -->
  <url>
    <loc>https://example.com/uk/products/widget</loc>
    <xhtml:link rel="alternate" hreflang="en-us"
                href="https://example.com/products/widget" />
    <xhtml:link rel="alternate" hreflang="en-gb"
                href="https://example.com/uk/products/widget" />
    <xhtml:link rel="alternate" hreflang="fr-fr"
                href="https://example.com/fr/products/widget" />
    <xhtml:link rel="alternate" hreflang="de-de"
                href="https://example.com/de/products/widget" />
    <xhtml:link rel="alternate" hreflang="x-default"
                href="https://example.com/products/widget" />
    <lastmod>2026-02-15</lastmod>
  </url>

  <!-- French version -->
  <url>
    <loc>https://example.com/fr/products/widget</loc>
    <xhtml:link rel="alternate" hreflang="en-us"
                href="https://example.com/products/widget" />
    <xhtml:link rel="alternate" hreflang="en-gb"
                href="https://example.com/uk/products/widget" />
    <xhtml:link rel="alternate" hreflang="fr-fr"
                href="https://example.com/fr/products/widget" />
    <xhtml:link rel="alternate" hreflang="de-de"
                href="https://example.com/de/products/widget" />
    <xhtml:link rel="alternate" hreflang="x-default"
                href="https://example.com/products/widget" />
    <lastmod>2026-02-15</lastmod>
  </url>

  <!-- German version -->
  <url>
    <loc>https://example.com/de/products/widget</loc>
    <xhtml:link rel="alternate" hreflang="en-us"
                href="https://example.com/products/widget" />
    <xhtml:link rel="alternate" hreflang="en-gb"
                href="https://example.com/uk/products/widget" />
    <xhtml:link rel="alternate" hreflang="fr-fr"
                href="https://example.com/fr/products/widget" />
    <xhtml:link rel="alternate" hreflang="de-de"
                href="https://example.com/de/products/widget" />
    <xhtml:link rel="alternate" hreflang="x-default"
                href="https://example.com/products/widget" />
    <lastmod>2026-02-15</lastmod>
  </url>

</urlset>
```

**Pros**: Centralized management, does not bloat HTML, scales well
**Cons**: More complex XML structure, sitemap can get very large, harder to validate

## Content Localization vs Translation

### Translation Only (Minimum Viable)

Direct translation of existing content into target languages. Acceptable for:
- Product descriptions where features are universal
- Legal/policy pages
- Technical documentation

**Quality requirements**:
- Professional human translation (not machine translation for public facing content)
- Native speaker review for tone, idiom, and cultural appropriateness
- Maintain the same keyword strategy (do not just translate keywords; research local search terms)

### Full Localization (Recommended)

Adapting content to the target market's culture, search behavior, and competitive landscape. Required for:
- Blog content and thought leadership
- Landing pages and marketing copy
- Category and navigation labels
- Pricing, currency, units of measurement, date formats

**Localization checklist**:
- [ ] Local keyword research (search behavior varies by market)
- [ ] Currency and pricing in local format
- [ ] Date format (MM/DD/YYYY vs DD/MM/YYYY)
- [ ] Measurement units (imperial vs metric)
- [ ] Cultural references and imagery
- [ ] Local testimonials, case studies, and social proof
- [ ] Local contact information and support hours
- [ ] Payment methods relevant to the market
- [ ] Legal compliance (GDPR for EU, CCPA for California, etc.)

## Geo Targeting in GSC

### Setting Country Targets

1. Open Google Search Console
2. Select the property (must be subdirectory or subdomain, not full domain)
3. Navigate to Settings > International Targeting
4. Select the target country from the dropdown

**Important notes**:
- Only works for generic TLDs (.com, .net, .org). ccTLDs are automatically geo targeted.
- Set per property: `example.com/fr/` targets France, `example.com/de/` targets Germany
- If using subdirectory structure, create separate GSC properties for each subdirectory
- If no country target is set, Google uses signals like hreflang, server location, and backlinks

### GSC Property Setup for International Sites

```
Properties to create (subdirectory approach):
- https://example.com/        (main property, target: United States)
- https://example.com/uk/     (target: United Kingdom)
- https://example.com/fr/     (target: France)
- https://example.com/de/     (target: Germany)
- https://example.com/es/     (target: Spain)
```

## International Keyword Research

### Market Specific Search Behavior

Search behavior varies significantly by country and language:

- **Volume differences**: A term popular in the US may have minimal search volume in Germany
- **Terminology**: "mobile phone" (UK) vs "cell phone" (US), "flat" (UK) vs "apartment" (US)
- **Search engines**: Yandex dominates Russia, Baidu dominates China, Naver dominates South Korea
- **Device distribution**: Mobile search share is much higher in emerging markets
- **Seasonal patterns**: Summer/winter seasons are reversed between hemispheres

### Process for Each Market

1. Do not simply translate English keywords. Start with local seed keywords.
2. Use Semrush with the target country's database selected
3. Engage native speakers to validate keyword relevance and search intent
4. Analyze local SERPs to understand what type of content ranks
5. Check Google Trends for the target country to identify seasonal patterns
6. Review local competitor sites for keyword and content ideas

### Local Terminology Examples

| Concept | US English | UK English | German | French |
|---------|-----------|------------|--------|--------|
| Apartment | apartment | flat | Wohnung | appartement |
| Cell phone | cell phone | mobile phone | Handy | portable |
| Sneakers | sneakers | trainers | Turnschuhe | baskets |
| Vacation | vacation | holiday | Urlaub | vacances |
| Truck | truck | lorry | LKW | camion |

## Technical Considerations

### CDN for Global Delivery

Use a CDN with global points of presence (PoPs) to serve content quickly regardless of user location.

**CDN configuration for international sites**:
- Edge caching: Cache HTML, CSS, JS, and images at edge nodes closest to users
- Geo routing: Direct users to the nearest server automatically
- Cache key: Include language/country in cache key to serve the correct version

```nginx
# Vary header to ensure CDN caches per language
location / {
    add_header Vary "Accept-Language";
    add_header Cache-Control "public, max-age=3600";
}
```

### Server Location

- For single server setups, choose a location central to your primary markets
- For multi server setups, deploy in each target region
- CDN largely negates server location for static assets, but TTFB for dynamic content is still affected

### Page Speed by Region

Test page speed from multiple geographic locations:
- Use WebPageTest with location set to target countries
- Use Google PageSpeed Insights (uses global CrUX data)
- Set up RUM (Real User Monitoring) to track actual performance per country
- Target: TTFB < 800ms from all target markets

## Common Mistakes

### Missing Self Referencing Hreflang

**Wrong**: The French page only references other language versions but not itself.

```html
<!-- On https://example.com/fr/page - WRONG -->
<link rel="alternate" hreflang="en" href="https://example.com/page" />
<link rel="alternate" hreflang="de" href="https://example.com/de/page" />
<!-- Missing: hreflang="fr" pointing to self -->
```

**Correct**:
```html
<!-- On https://example.com/fr/page - CORRECT -->
<link rel="alternate" hreflang="en" href="https://example.com/page" />
<link rel="alternate" hreflang="fr" href="https://example.com/fr/page" />
<link rel="alternate" hreflang="de" href="https://example.com/de/page" />
<link rel="alternate" hreflang="x-default" href="https://example.com/page" />
```

### Incorrect Language/Country Codes

**Common errors**:
- Using `en-uk` instead of `en-gb` (UK is not a valid ISO 3166-1 code; use GB)
- Using `jp` instead of `ja` (jp is the country code; ja is the language code for Japanese)
- Using `zh-cn` for Chinese (should use `zh-hans` for Simplified Chinese)
- Using three letter codes (`eng` instead of `en`)

### Orphan Hreflang Entries

**Problem**: Page A references Page B with hreflang, but Page B does not reference Page A back. Hreflang must be bidirectional.

**Detection**: Crawl all language versions and verify that every hreflang reference is reciprocated.

**Resolution**: Ensure all pages in a language cluster reference all other pages in the cluster, including themselves.

### Other Common Mistakes

- **Using hreflang on noindexed pages**: If a page has noindex, hreflang is ignored. Remove noindex or remove hreflang.
- **Hreflang pointing to redirected URLs**: Hreflang URLs must be the final destination, not a URL that redirects.
- **Mixing implementation methods**: Do not use both HTML tags and sitemap for the same page. Choose one method and be consistent.
- **Auto redirecting by IP/language**: Do not force redirect users based on IP geolocation or browser language. This blocks Googlebot (usually US based) from crawling international versions. Instead, show a language suggestion banner and let users choose.
- **Duplicate content across languages without hreflang**: If you have English content on both `.com` and `.co.uk` without hreflang, Google may treat it as duplicate content.
- **Forgetting x-default**: Always include x-default to handle users who do not match any specific language/country version.
