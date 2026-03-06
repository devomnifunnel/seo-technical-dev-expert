---
paths:
  - "clients/**"
---

# SEO Anomaly Detection & Flagging Rules

These rules define automatic anomaly detection triggers. During any analysis session,
the agent must proactively flag these conditions without waiting for the user to ask.

---

## Google Search Console Anomalies

- **Ranking drops**: Flag any keyword that drops more than 10 positions between reporting periods.
  Include the keyword, previous position, new position, and the page URL.
- **Index coverage errors**: Flag when index coverage errors spike by more than 20% week-over-week
  or when new error types appear that were not present in the prior period.
- **Core Web Vitals failing**: Flag any CWV metric that crosses from "Good" to "Needs Improvement"
  or "Poor" status. Include the metric name, previous value, new value, and affected URL group.
- **Manual actions**: Any manual action detected must be flagged immediately as CRITICAL priority.
  Include the action type, affected pages, and recommended remediation steps.
- **Impressions/clicks divergence**: Flag when impressions rise significantly (more than 30%) but
  clicks remain flat or decline, indicating potential CTR degradation or ranking position loss.
- **Crawl budget waste**: Flag pages consuming crawl budget that are non-indexable or low-value
  (parameter URLs, filtered views, internal search results).

## Semrush Anomalies

- **Visibility score drops**: Flag any visibility score decline greater than 10% between periods.
  Include the domain, old score, new score, and top losing keywords.
- **Toxic backlinks**: Flag when new toxic backlinks are detected. Include source domain,
  toxicity score, anchor text, and target page. Recommend disavow review if score exceeds 60.
- **Competitor ranking gains**: Flag when a tracked competitor gains top-10 positions on target
  keywords where the client previously held position. Include competitor domain, keyword, and
  position changes for both sides.
- **Keyword cannibalization**: Flag when Semrush data shows multiple client URLs ranking for
  the same keyword with fluctuating positions, indicating cannibalization.

## PageSpeed Insights / Core Web Vitals

- **CWV regressions**: Flag any metric that crosses a threshold boundary:
  - LCP: Good (under 2.5s) to Needs Improvement (2.5-4.0s) or Poor (over 4.0s)
  - CLS: Good (under 0.1) to Needs Improvement (0.1-0.25) or Poor (over 0.25)
  - INP: Good (under 200ms) to Needs Improvement (200-500ms) or Poor (over 500ms)
- **TTFB regression**: Flag when Time to First Byte exceeds 800ms. Include server location,
  hosting provider if known, and comparison to previous measurement.
- **Performance score drop**: Flag when Lighthouse performance score drops more than 10 points
  between measurements.

## Technical SEO Anomalies

- **robots.txt blocking critical pages**: Flag if robots.txt disallows crawling of pages that
  receive organic traffic or are in the sitemap. This is always a CRITICAL finding.
- **Noindex on important pages**: Flag if a page receiving meaningful organic traffic or linked
  in the sitemap has a noindex directive. Include the page URL and traffic volume.
- **Canonical errors**: Flag when a canonical tag points to a different URL that returns a 4xx/5xx
  status, is noindexed, or redirects to a third URL (canonical chain).
- **Redirect chains**: Flag redirect chains exceeding 2 hops. Include the full chain and
  recommend collapsing to a single redirect.
- **404 errors on high-value pages**: Flag 404 errors on pages that have backlinks, receive
  organic traffic, or are linked internally. Include the URL and estimated value lost.
- **Duplicate content**: Flag when multiple URLs serve substantially identical content without
  proper canonical tags. Include the affected URL groups.
- **Missing schema regression**: Flag when a page that previously had structured data markup no
  longer contains it. Include the schema type that was removed.
- **Sitemap issues**: Flag when sitemap contains URLs that return non-200 status codes, are
  noindexed, or are redirected.
- **Hreflang errors**: Flag mismatched or missing return hreflang tags, invalid language codes,
  or self-referencing hreflang omissions.

## Content Anomalies

- **Thin pages with traffic**: Flag pages with fewer than 300 words that are receiving organic
  traffic. These are at risk during core algorithm updates. Include the URL, word count, and
  monthly organic sessions.
- **Keyword cannibalization**: Flag when search console shows multiple pages from the same domain
  ranking for the same query with neither page holding a stable position. Include all competing
  URLs and their respective position history.
- **Content decay**: Flag pages where organic traffic has declined by more than 30% over a
  90-day period. Recommend content refresh analysis.

## NetSuite / SPA-Specific Anomalies

- **SPA rendering failures**: Flag when pre-rendered or server-rendered content differs
  significantly from JavaScript-rendered content. Include the page URL and the specific
  elements that are missing or different.
- **Prerender service downtime**: Flag if the prerender service (Prerender.io, Rendertron, or
  custom) returns errors or is unreachable. This is CRITICAL for SPA SEO.
- **JavaScript errors blocking content**: Flag when JavaScript console errors prevent critical
  SEO content from rendering. Include the error message and affected page elements.
- **Hash-based routing**: Flag if the site uses hash-based routing (example.com/#/page) instead
  of HTML5 History API, as hash URLs are not crawlable.
- **Dynamic rendering misconfiguration**: Flag when the user-agent detection for dynamic rendering
  fails to serve rendered content to Googlebot or other search engine crawlers.

## Flagging Protocol

1. Severity levels: CRITICAL, HIGH, MEDIUM, LOW
2. Always include: metric name, current value, threshold crossed, affected URL(s), recommended action
3. Group related anomalies together (e.g., multiple CWV failures on the same page)
4. When multiple anomalies are detected, present CRITICAL items first
5. Log all anomalies to the client history file for trend tracking
6. If the same anomaly persists across 3+ consecutive sessions, escalate severity by one level
