---
name: suitecommerce-seo
description: >
  Expert-level SEO, performance, and technical audit skill for NetSuite SuiteCommerce
  and SuiteCommerce Advanced (SCA) websites. Use this skill whenever the user mentions
  SuiteCommerce, SCA, NetSuite ecommerce, or is working on any client running a NetSuite
  storefront. Also trigger when the user asks about page speed, Core Web Vitals, technical
  SEO, schema markup, duplicate content, faceted navigation, or developer handoff documents
  in the context of any ecommerce site — SuiteCommerce has unique architecture that makes
  generic SEO tools produce wrong diagnoses. Always load this skill before doing any SEO,
  performance, or tracking audit on a SuiteCommerce site. If there is any chance the client
  is on NetSuite or SuiteCommerce, load this skill first.
  Trigger on: SuiteCommerce, SC Advanced, SC Standard, Summit theme, SCA SEO, NetSuite frontend, commerce categories, commerce items.
---

# SuiteCommerce SEO and Performance Skill

## What This Skill Does

SuiteCommerce Advanced is a Single Page Application (SPA) built on Backbone.js connected
directly to the NetSuite ERP backend. Every generic SEO tool — Lighthouse, PageSpeed
Insights, SEOmator, and all other audit engines installed in this project — produces
misleading results on SuiteCommerce because they do not understand the platform architecture.

This skill gives Claude the expertise to diagnose SuiteCommerce SEO and performance issues
correctly, produce developer handoff documents that NetSuite developers can actually
execute, and avoid the most common mistakes that waste hours of audit time.

## Reference Files — Load These When Needed

All detailed reference content is in the references/ folder. Load the relevant file
for the specific task rather than loading all of them at once.

| File | Load When |
|------|-----------|
| references/architecture.md | Starting any audit or when client is new — understand the platform first |
| references/seo-issues.md | Diagnosing SEO problems: rankings, indexing, duplicate content, schema, meta tags |
| references/performance-issues.md | Diagnosing page speed, Core Web Vitals, TTFB, or Lighthouse score issues |
| references/diagnostic-workflow.md | Running a full audit — follow this step by step |
| references/developer-handoff.md | Writing fix documentation to hand off to a NetSuite developer |

---

## Core Principles — Always Apply These

**Before running any audit tool on a SuiteCommerce site, read references/architecture.md.**
The three rendering modes (SSR uncached, SSR cached, SPA client-side) determine what
every audit tool is actually measuring. Without this context, findings will be wrong.

**TTFB is almost always the primary issue.** If PageSpeed Insights shows a poor score
on a SuiteCommerce site, check Time to First Byte before looking at anything else.
CDN caching configuration is the most common root cause and the highest-leverage fix.

**NetSuite APM is the correct server-side diagnostic tool.** Lighthouse shows front-end
symptoms. APM shows what SuiteScript is actually doing on the server. Both are needed
for a complete picture.

**The SEO Page Generator debug log shows what Google actually sees.** Append
`?nsgdebug=T` to any page URL while logged into NetSuite as an administrator to see
exactly what the crawler receives. This is the ground truth for any indexing problem.

**Faceted navigation duplicate content is the most impactful SEO issue on high-SKU stores.**
On a motorsports or automotive parts store with hundreds of products and dozens of filter
options, facet URL bleed can create thousands of duplicate pages. Check this before
any content or on-page optimization work.

---

## Audit Workflow Summary

For a full audit, load references/diagnostic-workflow.md and follow it in sequence.

The short version:
1. Check the SEO Page Generator debug log on homepage, category, and product page
2. Check sitemap.xml for faceted navigation URL bleed
3. Run PageSpeed Insights — note TTFB specifically
4. Check CDN cache response headers in Chrome DevTools
5. Open NetSuite APM for server-side performance data
6. Run Google Rich Results Test on a product page
7. Inspect HTML source (not rendered DOM) of a filtered category page for canonical tags
8. Check image sizes in Chrome DevTools network tab
9. Check GTM container in Preview mode for synchronous tag loading
10. Compile findings into OFM developer handoff format

---

## Red Flags — Flag These as Critical Immediately

Do not wait to complete an audit before flagging these. Surface them the moment they
are found and treat them as the highest priority:

- SEO Page Generator returning 500 errors on any page type
- CDN caching completely disabled (every crawler request hits SSR with no cache)
- Canonical tags pointing to wrong URLs at scale
- SuiteScript log level set to Debug in production (actively degrading every request)
- Faceted navigation URLs present in the XML sitemap without canonical protection
- Product schema prices not matching visible page prices (risks rich result suspension)
- GTM firing synchronously in the document head on SuiteCommerce pages

---

## OFM Client Notes

**Verocious Motorsports** is the primary SuiteCommerce Advanced client. Key known issues
from prior work: duplicate content was previously identified across a large volume of pages,
meta descriptions and title tags were addressed but should be verified for regression on
each engagement, Klaviyo frontend event tracking gaps were repaired and should be
verified on any site audit. Always load the Verocious Motorsports client file from
.claude/clients/verocious-motorsports.md before starting any audit work on this account.

For any new SuiteCommerce client, create a client knowledge file before starting audit
work and populate the tech stack section with the SCA version, active extensions, CDN
provider, and GTM container status.
