---
name: local-seo
description: "Google Business Profile and local search optimization. Use when optimizing for local pack, managing citations, or building local authority. Trigger on: local SEO, Google Business Profile, GBP, citations, NAP, local pack, reviews, multi location, service area."
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch
argument-hint: "[business name or location]"
---

# Local SEO Optimization

## Google Business Profile Optimization

### Complete Listing Requirements

A fully optimized Google Business Profile (GBP) is the foundation of local SEO. Every field should be completed accurately.

**Essential fields:**

| Field | Best Practice | Impact |
|-------|--------------|--------|
| Business Name | Exact legal name, no keyword stuffing | High |
| Primary Category | Most specific category available | High |
| Secondary Categories | Add all relevant (up to 9 additional) | Medium |
| Address | Exact match with all other citations | High |
| Phone Number | Local phone number, not toll free | High |
| Website URL | Location specific landing page | High |
| Hours of Operation | Accurate, including holidays | Medium |
| Business Description | 750 characters, include keywords naturally | Medium |
| Services/Products | List all with descriptions and prices | Medium |
| Attributes | Complete all applicable attributes | Low to Medium |
| Photos | Minimum 10 high quality images | Medium |

### Category Selection

Choose your primary category carefully. It is the strongest ranking signal in the local pack.

**Category research process:**

1. Search your main keyword in Google and examine what categories your top 3 local pack competitors use.
2. Use the GMB Category tool (pleper.com) to find all available categories.
3. Select the most specific primary category. For example, "Personal Injury Attorney" is better than "Lawyer."
4. Add secondary categories for additional services you offer.

**Common mistakes to avoid:**

- Adding categories for services you do not actually provide.
- Using broad categories when specific ones exist.
- Stuffing keywords into the business name field.

### Photo Optimization

Upload at minimum:

- 1 cover photo (the main image displayed in search).
- 1 logo image.
- 3+ interior photos showing the business environment.
- 3+ exterior photos (building, signage, storefront).
- 3+ team/staff photos.
- Product or service photos as applicable.

**Photo specifications:** Minimum 720 x 720 pixels. JPEG or PNG format. File name should include location and business name (e.g., `smith-law-office-lobby-dallas-tx.jpg`).

Upload new photos monthly to signal activity to Google.

### Google Business Profile Posts

Publish GBP posts weekly. Post types include:

1. **Update posts:** Business news, announcements, tips.
2. **Offer posts:** Promotions with start/end dates and redemption details.
3. **Event posts:** Upcoming events with dates and descriptions.

**Post writing guidelines:**

- 150 to 300 words per post.
- Include a call to action button (Learn More, Call Now, Book, etc.).
- Add a relevant image to every post.
- Include local keywords naturally.
- Posts expire after 6 months, so maintain a regular publishing cadence.

## Local Citation Building

### NAP Consistency

NAP (Name, Address, Phone) must be identical across every online listing. Even minor variations (St. vs Street, Ste vs Suite) can confuse search engines and weaken local ranking signals.

**Canonical NAP format (establish once, use everywhere):**

```
Business Name: Smith & Associates Law Firm
Address: 1234 Main Street, Suite 500
City: Dallas
State: TX
Zip: 75201
Phone: (214) 555-0123
Website: https://www.smithlawdallas.com
```

### Key Directories

**Tier 1 (Essential, complete within first month):**

1. Google Business Profile
2. Bing Places for Business
3. Apple Maps Connect
4. Yelp
5. Facebook Business Page
6. Better Business Bureau (BBB)

**Tier 2 (Important, complete within first quarter):**

7. Yellow Pages (yp.com)
8. Foursquare
9. Nextdoor Business Page
10. Mapquest
11. TomTom / Waze
12. Chamber of Commerce listing

**Tier 3 (Industry specific):**

- Legal: Avvo, FindLaw, Justia, Martindale
- Medical: Healthgrades, Zocdoc, Vitals, WebMD
- Home Services: Angi, HomeAdvisor, Thumbtack
- Restaurants: OpenTable, TripAdvisor, Zomato
- Real Estate: Zillow, Realtor.com, Trulia

### Citation Audit Process

1. Search your business name in Moz Local, BrightLocal, or Whitespark.
2. Export all found citations.
3. Compare each citation against your canonical NAP format.
4. Flag inconsistencies (wrong address, old phone number, misspelled name).
5. Submit corrections to each platform.
6. Track correction status in a spreadsheet.
7. Re audit quarterly.

## Local Schema Markup

### LocalBusiness Schema

Every location page on your website should include LocalBusiness (or a more specific subtype) schema markup.

```json
{
    "@context": "https://schema.org",
    "@type": "LegalService",
    "name": "Smith & Associates Law Firm",
    "description": "Personal injury law firm serving Dallas and surrounding areas with over 20 years of experience in auto accident, workplace injury, and medical malpractice cases.",
    "url": "https://www.smithlawdallas.com",
    "telephone": "+1-214-555-0123",
    "email": "contact@smithlawdallas.com",
    "image": "https://www.smithlawdallas.com/images/office-exterior.jpg",
    "logo": "https://www.smithlawdallas.com/images/logo.png",
    "priceRange": "$$",
    "address": {
        "@type": "PostalAddress",
        "streetAddress": "1234 Main Street, Suite 500",
        "addressLocality": "Dallas",
        "addressRegion": "TX",
        "postalCode": "75201",
        "addressCountry": "US"
    },
    "geo": {
        "@type": "GeoCoordinates",
        "latitude": 32.7767,
        "longitude": -96.7970
    },
    "openingHoursSpecification": [
        {
            "@type": "OpeningHoursSpecification",
            "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
            "opens": "08:00",
            "closes": "18:00"
        },
        {
            "@type": "OpeningHoursSpecification",
            "dayOfWeek": "Saturday",
            "opens": "09:00",
            "closes": "13:00"
        }
    ],
    "sameAs": [
        "https://www.facebook.com/smithlawdallas",
        "https://www.linkedin.com/company/smith-associates-law",
        "https://www.yelp.com/biz/smith-associates-law-firm-dallas",
        "https://twitter.com/smithlawdallas"
    ],
    "areaServed": [
        {
            "@type": "City",
            "name": "Dallas",
            "sameAs": "https://www.wikidata.org/wiki/Q16557"
        },
        {
            "@type": "City",
            "name": "Fort Worth"
        },
        {
            "@type": "City",
            "name": "Plano"
        },
        {
            "@type": "City",
            "name": "Arlington"
        }
    ],
    "aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": "4.8",
        "reviewCount": "127",
        "bestRating": "5"
    },
    "hasMap": "https://maps.google.com/?cid=1234567890"
}
```

### GeoCoordinates

Always include precise latitude and longitude values. Obtain these from Google Maps by right clicking on your exact location.

### OpeningHoursSpecification

Specify hours for each day. If the business is closed on a particular day, omit that day from the specification. For businesses that are open 24 hours:

```json
{
    "@type": "OpeningHoursSpecification",
    "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
    "opens": "00:00",
    "closes": "23:59"
}
```

### Service Area Business Schema

For businesses that serve customers at their location (plumbers, electricians, mobile services):

```json
{
    "@context": "https://schema.org",
    "@type": "Plumber",
    "name": "DFW Plumbing Experts",
    "url": "https://www.dfwplumbingexperts.com",
    "telephone": "+1-972-555-0456",
    "areaServed": {
        "@type": "GeoCircle",
        "geoMidpoint": {
            "@type": "GeoCoordinates",
            "latitude": 32.7767,
            "longitude": -96.7970
        },
        "geoRadius": "50000"
    },
    "address": {
        "@type": "PostalAddress",
        "addressLocality": "Dallas",
        "addressRegion": "TX",
        "postalCode": "75201",
        "addressCountry": "US"
    }
}
```

## Local Keyword Strategy

### City + Service Patterns

Build your local keyword list using this framework:

```
[Primary Service] + [City]
[Primary Service] + [Neighborhood]
[Primary Service] + near me
[Primary Service] + [City] + [State]
best + [Primary Service] + in + [City]
[Primary Service] + near + [Landmark]
affordable + [Primary Service] + [City]
emergency + [Primary Service] + [City]
```

**Example keyword matrix for a personal injury lawyer in Dallas:**

| Service Term | Location Modifier | Full Keyword |
|-------------|-------------------|-------------|
| personal injury lawyer | Dallas | personal injury lawyer Dallas |
| personal injury attorney | Dallas TX | personal injury attorney Dallas TX |
| car accident lawyer | near me | car accident lawyer near me |
| workplace injury attorney | Fort Worth | workplace injury attorney Fort Worth |
| personal injury lawyer | Uptown Dallas | personal injury lawyer Uptown Dallas |

### Near Me Optimization

"Near me" queries are driven by proximity signals, not on page keyword usage. To rank for "near me" queries:

1. Ensure your Google Business Profile is fully optimized with accurate address.
2. Build strong local citations with consistent NAP.
3. Embed Google Maps on your location pages.
4. Include city and neighborhood names in title tags, H1s, and body content.
5. Create locally relevant content that naturally references your service area.

## Review Management Strategy

### Review Generation

**Systematic approach to generating reviews:**

1. **Identify the right moment.** Ask for reviews after a positive interaction, completed service, or successful outcome.
2. **Make it easy.** Provide a direct link to your Google review form. Generate the short link from your GBP dashboard.
3. **Send a follow up.** Email or text customers within 24 to 48 hours of service completion.
4. **Diversify platforms.** While Google reviews are most impactful, also encourage reviews on Yelp, Facebook, and industry specific platforms.

**Review request email template:**

```
Subject: How was your experience with [Business Name]?

Hi [Customer Name],

Thank you for choosing [Business Name]. We hope you had a great experience.

If you have a moment, we would appreciate you sharing your feedback with a
Google review. It helps other customers find us and helps us continue to
improve our service.

[Leave a Review Button/Link]

If there is anything we could have done better, please let us know directly
at [email] and we will make it right.

Thank you,
[Your Name]
[Business Name]
```

**Target metrics:**

- Aim for 5+ new reviews per month per location.
- Maintain a 4.5+ average star rating.
- Achieve a response rate of 100% on all reviews.

### Review Response

Respond to every review within 24 to 48 hours.

**Positive review response framework:**

1. Thank the reviewer by name.
2. Reference a specific detail from their review.
3. Reinforce a key service or value proposition naturally.
4. Invite them back or mention another service.

**Negative review response framework:**

1. Acknowledge the concern and empathize.
2. Apologize for the experience without being defensive.
3. Take the conversation offline by providing direct contact information.
4. Follow up privately to resolve the issue.
5. Never argue, blame the customer, or disclose private details.

### Review Monitoring

Set up monitoring using:

- Google Business Profile notifications (automatic).
- Google Alerts for your business name.
- BrightLocal or ReviewTrackers for multi platform monitoring.
- Weekly manual checks of Yelp, Facebook, and industry directories.

## Local Link Building

### Chambers of Commerce

Join your local chamber of commerce. Membership typically includes a link from the chamber's member directory page, which carries strong local relevance signals. Many chambers also offer sponsorship opportunities, event listings, and feature articles that provide additional link opportunities.

### Local Media

**Strategies for earning local media links:**

1. **Press releases:** Announce new locations, community involvement, awards, or milestones to local news outlets.
2. **Expert commentary:** Offer yourself as a local expert source for journalists covering your industry.
3. **Sponsor local events:** Event pages typically link to sponsors.
4. **Local business features:** Many local news sites run "business spotlight" or "business of the week" features.

### Community Organizations

Build links through genuine community involvement:

- Sponsor local sports teams, school events, or charity fundraisers.
- Participate in community clean up days or volunteer events.
- Host educational workshops or seminars.
- Partner with local nonprofits for cause marketing initiatives.
- Join industry associations with local chapters.

Each of these activities generates natural, locally relevant links from organizations with high trust signals.

## Multi Location SEO

### Individual Location Pages

Each business location requires a dedicated, unique page on your website.

**Required elements per location page:**

1. Unique title tag: `[Service] in [City] | [Business Name] [Neighborhood/Area]`
2. Unique H1: `[Business Name] [City] Location`
3. Unique body content (minimum 500 words) covering services, staff, and local context.
4. Embedded Google Map for the specific location.
5. NAP information matching the Google Business Profile exactly.
6. LocalBusiness schema markup with location specific data.
7. Customer reviews or testimonials specific to that location.
8. Driving directions from major landmarks or intersections.

**URL structure for multi location sites:**

```
/locations/dallas-tx/
/locations/fort-worth-tx/
/locations/plano-tx/
/locations/arlington-tx/
```

### Location Schema for Multiple Locations

Implement separate schema markup on each location page. Do not combine all locations in a single schema block.

```json
{
    "@context": "https://schema.org",
    "@type": "Dentist",
    "name": "Bright Smile Dental, Dallas",
    "url": "https://www.brightsmile.com/locations/dallas-tx/",
    "telephone": "+1-214-555-0789",
    "address": {
        "@type": "PostalAddress",
        "streetAddress": "5678 Oak Lawn Avenue",
        "addressLocality": "Dallas",
        "addressRegion": "TX",
        "postalCode": "75219",
        "addressCountry": "US"
    },
    "geo": {
        "@type": "GeoCoordinates",
        "latitude": 32.8108,
        "longitude": -96.8103
    },
    "parentOrganization": {
        "@type": "Organization",
        "name": "Bright Smile Dental Group",
        "url": "https://www.brightsmile.com"
    },
    "openingHoursSpecification": [
        {
            "@type": "OpeningHoursSpecification",
            "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
            "opens": "07:00",
            "closes": "19:00"
        }
    ]
}
```

### Local Landing Page Template

For service area businesses that want to rank in multiple cities without physical locations:

**URL:** `/services/[service]/[city]-[state]/`

**Content structure:**

1. H1: `[Service] in [City], [State]`
2. Opening paragraph: Address the local audience directly, referencing the city and surrounding areas.
3. Service details: Describe what you offer in this specific market.
4. Local relevance content: Mention local landmarks, neighborhoods, or community details.
5. Social proof: Reviews or case studies from clients in that area.
6. Call to action: Location specific phone number or contact form.
7. FAQ section: Include locally relevant questions.

**Important:** Each city landing page must contain substantially unique content. Do not simply swap city names in boilerplate text. Google penalizes doorway pages with near identical content.

## Implementation Checklist

1. Claim and fully optimize Google Business Profile with all fields completed.
2. Establish canonical NAP format and audit all existing citations.
3. Submit to all Tier 1 directories within the first month.
4. Implement LocalBusiness schema markup on every location page.
5. Build local keyword matrix and assign target keywords to pages.
6. Set up a systematic review generation process.
7. Respond to all reviews within 48 hours.
8. Join the local chamber of commerce and pursue local media opportunities.
9. Create unique location pages for each physical location.
10. Publish weekly Google Business Profile posts.
11. Audit citations quarterly for NAP consistency.
12. Monitor local rankings for city + service keyword combinations monthly.
