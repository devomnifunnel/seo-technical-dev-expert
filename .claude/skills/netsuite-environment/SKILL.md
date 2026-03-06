---
name: netsuite-environment
auto_trigger: true
description: >
  Complete operational knowledge of the NetSuite account 606473 powering
  Verocious Motorsports and Austenitex. Use this skill whenever working on
  either site's backend, deploying extensions, debugging SuiteCommerce issues,
  navigating the NetSuite admin, or needing to know where anything lives in
  the account. This is the developer brain for this specific NetSuite instance.
  Use when exploring NetSuite account configuration, checking installed bundles, or understanding the SuiteCommerce environment. Trigger on: NetSuite account, bundles, scripts, SuiteCommerce config, account 606473.
---

# NetSuite Environment 606473 | Operational Knowledge

## Account Overview

- **Account ID:** 606473
- **Account URL:** https://606473.app.netsuite.com
- **Logged In As:** Tate, Michael (Administrator)
- **Role:** Shipping Warehouse / Administrator
- **Platform Version:** SuiteCommerce 2025.2.20 (bundle 572927)
- **Base Theme Bundle:** SuiteCommerce Base Theme 2025.2 (bundle 572857)
- **SuiteCommerce Type:** SuiteCommerce Standard (SCS / SC Lite) NOT SuiteCommerce Advanced

## Websites (4 total, 2 active SuiteCommerce)

### Verocious Motorsports (Site Builder, ID 1) — LEGACY, not active storefront
- Type: Site Builder
- Primary: Yes (historical)

### Austenitex (Site Builder, ID 2) — LEGACY, not active storefront
- Type: Site Builder

### Verocious Motors (SuiteCommerce, ID 3) — LIVE
- Internal Name: Verocious Motors
- Type: SuiteCommerce
- Primary Domain: www.verociousmotorsports.com
- URL: /app/site/setup/siteadmin.nl?id=3

### Austenitex SC (SuiteCommerce, ID 4) — LIVE
- Internal Name: Austenitex SC
- Type: SuiteCommerce
- Primary Domain: www.austenitex.com
- URL: /app/site/setup/siteadmin.nl?id=4

## Domain Configuration

### Verocious Motors Domains
| Domain | Type | Primary | CDN | Checkout Domain |
|--------|------|---------|-----|-----------------|
| https://verociousmotorsports.com | Secure Web Store | No | Yes | 606473.secure.netsuite.com |
| https://www.verociousmotorsports.com | Single Domain (Store + Checkout) | Yes | Yes | www.verociousmotorsports.com |

### Austenitex SC Domains
| Domain | Type | Primary | CDN | Checkout Domain |
|--------|------|---------|-----|-----------------|
| https://austenitex.com | Secure Web Store | No | Yes | 606473.secure.netsuite.com |
| http://beta.austenitex.com | Web Store Only | No | Yes | 606473.secure.netsuite.com |
| https://www.austenitex.com | Single Domain (Store + Checkout) | Yes | Yes | www.austenitex.com |

**ISSUE:** beta.austenitex.com uses HTTP not HTTPS.

## Extension Manager Deployments

### LIVE Production Deployments (both Completed)

**Verocious Motors (www.verociousmotorsports.com)**
- Theme: Summit 4.0.0
- Status: Completed
- Last Activation: 3/6/2026 10:26 am by Tate, Michael
- Extensions (33):
  Advanced Sign Up 1.0.5, Blog 2.1.3, **Beautiful Canonical URLs for SEO by OmniFunnelMarketing 1.0.0**,
  Columns 1.1.3, Cookie Consent 1.1.2, CookieConsentCSPv 1.0.0, Core Content Extension 1.0.8,
  Custom Fields 1.1.4, Custom Page Title Suffix 1.1.0, Featured Category 1.5.2,
  Featured Product 1.2.2, Gift Certificate Management 1.2.7, Grid Order 1.0.6,
  Hide Invoice 1.0.0, Image Text Overlay 1.0.3, Infinite Scroll 1.1.4,
  Inventory Display 1.2.9, Item Badges 1.1.5, Intelligent Item Recommendations 3.2.13,
  Live Chat 1.0.0, Logo List 1.1.1, MatrixQuickAddPv 1.0.0, Newsletter Sign Up 1.1.3,
  Order Status 1.0.4, Packeji Integration 1.0.3, Product Comparison 1.1.0,
  Product Page Printer 1.0.1, ReCaptcha 1.0.0, Reorder Size List 1.0.1,
  **Quantity URL Cleaner for SEO by OmniFunnelMarketing 1.0.0**,
  Shipping Bar 1.1.8, Summit Theme Extension 3.4.0, Testimonials 1.0.3

**Austenitex SC (www.austenitex.com)**
- Theme: Summit 4.0.0
- Status: Completed
- Last Activation: 3/3/2026 10:39 am by Tate, Michael
- Extensions: Same set as Verocious Motors including both OFM SEO extensions
- Additional: Klaviyo 1.0.0 (has Klaviyo integration)

### Test/Beta Deployments (both ERROR, old)

**Verocious Motors test (test.verociousmotorsports.com)**
- Theme: Horizon 3.2.0 (old theme, no longer in production)
- Status: ERROR
- Last Activation: 1/29/2025 by Conforti, Alexander N.

**Austenitex SC beta (beta.austenitex.com)**
- Theme: Summit 3.5.3
- Status: ERROR
- Last Activation: 1/22/2025 by Montesdeoca, Nicolas

## Custom OmniFunnel Marketing Extensions

Two custom SuiteCommerce extensions built by OFM are deployed on both sites:

1. **Beautiful Canonical URLs for SEO** (v1.0.0) — Generates clean canonical URLs
2. **Quantity URL Cleaner for SEO** (v1.0.0) — Removes quantity parameters from URLs to prevent duplicate content

These are critical for SEO and should never be removed without understanding the impact.

## Website Setup Configuration

### Shared Settings (both sites)
- Price Level: Online Price
- Descriptive URLs Format: Item-name
- Use File Extension: Yes
- Scriptable Cart and Checkout: Yes
- Scripting Template (CC): Standard Online Order - Cash Sale
- Scripting Template (Invoice): Standard Online Order - Invoice
- Credit Sales Reps for Website Orders: Yes
- PayPal Account: PayPal
- Payment Processing Profiles: Fortis, MES API, MES Payment Gateway
- Checkout URL: 606473.secure.netsuite.com (for non-Single Domain entries)
- Cookie Consent Banner: Off
- GA Integration: Enabled
- Show Uncategorized Items: No

### Verocious Motors Specific
- Default Customer Category: 1: Automotive - Retail
- Google Site Verification: E8wN0dviqbGFQiljolxhc9H2NgLda4xX2QrauGQxLPw
- Include Out of Stock Items: Yes
- Shopping Cart Sharing Mode: Individual carts per customer contact
- Sales Order Type: Per Customer Basis
- CC Form: Verocious Sales Order - Web Cash Sale
- Invoice Form: Verocious Sales Order
- Default Shipping: UPS Ground
- Ships to All Countries: No (specific country list)
- Auto-Apply Promotions: Yes
- Customer Registration: Optional

### Austenitex SC Specific
- Default Customer Category: 2: Process - Retail
- Google Site Verification: NONE (not configured — needs setup)
- Otherwise mirrors Verocious settings

## Touch Points (both sites)
| Name | Web Application | Path |
|------|----------------|------|
| Log In | SuiteCommerce Standard | /scs/checkout.ssp |
| Log Out | SuiteCommerce Standard | /scs/logOut.ssp |
| Proceed to Checkout | SuiteCommerce Standard | /scs/checkout.ssp |
| Register | SuiteCommerce Standard | /scs/checkout.ssp |
| View Cart | SuiteCommerce Standard | /scs/goToCart.ssp |
| View Customer Center | SuiteCommerce Standard | /scs/my_account.ssp |
| View Homepage | SuiteCommerce Standard | /scs/shopping.ssp |

## Search Index Configuration (Verocious Motors)

### Search Fields (relevance priority order)
Name (Starts With Exact) > Online Name (Starts With) > Online Name (Exact) >
Online Name (Keyword) > MFG Part VMS Custom (Keyword) > Detailed Description (Keyword) >
Search Keywords (Keyword) > Name (Fuzzy) > Online Name (Fuzzy) >
MFG Part VMS Custom (Fuzzy) > Name (Starts With) > Name (Exact) >
Label Owner Custom (Keyword)

### Facet Fields (35+ custom fields)
A/R, Bearing, Blanket, Bottle Size, Brand VMS, Classification VMS, Color, Comp Housing,
Configuration, Connection Type 2, Cover, Finish, Fits Turbo, Flange, Housing Inlet,
Insert Material, Internal Finish, Length, Material, Online Price, Pipe Size, Polished,
Pressure 4, Pressure Range, Quantity, Screen Mesh, Silicone Length 3 Ply, Size,
Style 2, TH Wheel, Thickness, Tube O.D. 8, Turbine Housing, Turbo, Valve Size,
Valves, WG Actuator, Wall Thickness, Wastegate

## Script Environment (726 total scripts)

### Script Type Distribution
| Type | Count |
|------|-------|
| Suitelet | 303 |
| User Event | 128 |
| Client | 65 |
| Scheduled | 64 |
| Map/Reduce | 63 |
| Bundle Installation | 45 |
| RESTlet | 31 |
| Portlet | 12 |
| SDF Installation | 7 |
| Workflow Action | 7 |
| Mass Update | 1 |

197 of 726 scripts are custom (non bundle). Major custom script categories:
Fortis Payment (~30), NSAPM (~50), Bank Feeds/Yodlee (~25), Celigo IO (~10),
Tenfold CRM (~4), SFTP (~6), Product Feeds (2), Web Store (~5).

### Custom Script Deployments (3 deployment records)

| Script | ID | Type | Deployed | Last Modified |
|--------|------|------|----------|---------------|
| **VMS SEO Sitemap Generator** | customdeploy_vms_sitemap_gen | Scheduled | **NO** | 2/19/2026 |
| MerchantE Chargeback Map Reduce | customdeploy_mes_cb_map_reduce_manual | Map/Reduce | Yes | 9/6/2023 |
| Fortis MR Paylink Async Notification | customdeploy_fp_ltp_async_notif_manual | Map/Reduce | Yes | 1/23/2025 |

**CRITICAL:** VMS SEO Sitemap Generator exists but is NOT deployed. Status is "Testing",
Deployed checkbox is unchecked. Scheduled daily at 3:00 AM, repeating every 1 day,
starting 2/19/2026, no end date. Execute as Role: Administrator.

### SEO and Sitemap Related Scripts

| Script Name | Type | Site | Notes |
|-------------|------|------|-------|
| VMS SEO Sitemap Generator | Scheduled | VMS | **NOT DEPLOYED (Testing)** |
| Category XML Sitemap Generator VMS | Scheduled | VMS | Generates category sitemaps |
| Category XML Sitemap Generator AUX | Scheduled | AUX | Generates category sitemaps |
| Item & Master XML Sitemap Generator VMS | Scheduled | VMS | Generates item sitemaps |
| Item & Master XML Sitemap Generator AUX | Scheduled | AUX | Generates item sitemaps |
| CS Commerce SEO Data Review Bundle | N/A | Both | Bundle 497799, saved searches/records (no scripts) |

### Other Web Store Related Scripts

| Script Name | Type | Notes |
|-------------|------|-------|
| Correct Webstore Sales Rep | User Event | Assigns sales rep on web orders |
| Webstore Sales Rep | User Event | Related to web store sales rep assignment |
| Create New Lead From Newsletter VMS | Suitelet | Newsletter lead capture for VMS |
| NS SC EXT SL Blog Post Searcher | Suitelet | Blog search functionality |
| NS SC EXT SL File URL Provider | Suitelet | File URL provider for SC extensions |
| Search Summary Service | Suitelet | Search service |
| Meta Checkout Handler | Suitelet | Checkout meta handling |
| sayt | Suitelet | Search as you type |
| Klaviyo Product Feed | Scheduled | Klaviyo product feed generation |
| Austenitex Product Feed | Scheduled | AUX product feed generation |

## Installed Bundles (61 total, key ones listed)

### SuiteCommerce Core
| Bundle | ID | Version |
|--------|-----|---------|
| SuiteCommerce | 572927 | 2025.2.20 |
| SuiteCommerce Base Theme | 572857 | 2025.2.6 |
| SuiteCommerce Configuration | 381166 | 2021.1.2 |
| SuiteCommerce Extension Management | 521562 | 2025.1.0 |
| NetSuite Ecommerce Edition S2.01 | 4833 | 52.01.2009.11.13 |
| SC Summit Theme | 312836 | 4.0.1 |
| SC Horizon Theme | 312825 | 4.0.0 |

### SuiteCommerce Extension Bundles
SC Advanced Sign Up (334830), SC Blog (350138), SC Columns (248283),
SC Cookie Consent (402703), SC Custom Fields (247468), SC Featured Category (250732),
SC Featured Product (250724), SC Gift Certificate Management (243341),
SC Google Tag Manager Editor (250341 v1.4.4), SC Grid Order (251806),
SC Image Text Overlay (249292), SC Infinite Scroll (251799),
SC Intelligent Item Recommendations (317102), SC Inventory Display (251783),
SC Item Badges (251246), SC Logo List (248750), SC Newsletter Sign Up (249935),
SC Order Status (251693), SC Photo Gallery (244422), SC Product Comparison (251558),
SC Product Page Printer (344598), SC Shipping Bar (249983), SC Size Chart (249416),
SC Stock Notifications (250991), SC Testimonials (248760)

### SEO Specific
| Bundle | ID | Version | Notes |
|--------|-----|---------|-------|
| CS Commerce SEO Data Review Bundle | 497799 | 1.0 | SEO data review tools |
| Product Merchandising | 49476 | 1.02.6 | Category/product display rules |
| SMT Core Content Types | 564580 | 1.0.8 | Site Management Tools content |

### Integration Bundles
| Bundle | ID | Version | Purpose |
|--------|-----|---------|---------|
| Avalara AvaTax Basic | 1894 | 6.9.2 | Tax calculation |
| Celigo Amazon Connector | 169116 | 1.41.0.0 | Amazon marketplace |
| Celigo eBay Connector | 170343 | 1.13.0.0 | eBay marketplace |
| Celigo integrator.io | 29038 | 1.38.6.0 | Integration platform |
| Packeji Shipping | 283623 | 25.1.0 | Multi-carrier shipping |
| Recurrency Integrator | 526804 | 1.05 | Inventory intelligence |
| MerchantE Payment Gateway | 317221 | 3.2.12 | Payment processing |
| Electronic Bank Payments | 533670 | 2024.2.4 | Banking |
| 1099 Vendor Payment Report | 250920 | 1.00.5 | Tax reporting |

### SuiteSuccess
| Bundle | ID | Version |
|--------|-----|---------|
| SuiteSuccess Add On Configuration S4C | 380861 | 1.242.0 |
| SuiteSuccess Add On Customization S4C | 380859 | 1.254.0 |
| SB2SC Migration Tools | 394636 | 1.0.1 |

## File Cabinet Structure

### Key Folders
| Folder | Size | Purpose |
|--------|------|---------|
| Web Site Hosting Files | 4.01 GB | SuiteCommerce themes, SSP apps, extensions |
| SuiteScripts | 191 MB | Custom SuiteScript files |
| Images | 677 MB | Product and site images |
| Templates | 5.47 GB | Email/document templates |
| SuiteApps | 19.72 MB | SuiteApp files |
| SuiteBundles | 119 B | Bundle metadata |
| Klaviyo Product Feed | 26.73 MB | Product feed for Klaviyo |
| SSL Certificates | 31.51 KB | SSL cert files |
| ssp_libraries | 148.31 KB | SSP library files |
| js | 1.95 MB | JavaScript files |

## Navigation Paths (NetSuite Admin)

### Commerce Menu
- Commerce > Websites > Website List — /app/site/setup/sitelist.nl
- Commerce > Websites > Configuration — SuiteCommerce JSON config
- Commerce > Extensions > Extension Manager — Deploy/manage SC extensions
- Commerce > Hosting — Web hosting file management
- Commerce > Content Management — CMS pages/content
- Commerce > Marketing — Promotions, campaigns

### CWV and Performance Configuration Paths
| Setting | Navigation Path | Current Value | Notes |
|---------|----------------|---------------|-------|
| GA4 Integration | Commerce > Websites > Configuration > Integrations > Google Analytics 4 | G-MDZKSYLJ1B (VMS) | TO REMOVE: old GA4, active one managed via GTM |
| Facebook Integration | Commerce > Websites > Configuration > Integrations > Facebook | Unchecked | FB handled via GTM Stape CAPI |
| GTM Integration | Commerce > Websites > Configuration > Integrations > Google Tag Manager | Active | GTM-57T4T5BW |
| Web Fonts Async | Commerce > Configuration > Summit Theme > Web Fonts | DISABLED | 1 min fix: check "LOAD WEB FONTS SCRIPT ASYNCHRONOUSLY" |
| Cache TTL | Commerce > Configuration > Advanced > Cache | 7,200s (2 hours) | Target: 31,536,000s (1 year) or CDN override |
| Infoblock Images | Commerce > Configuration > Summit Theme > Home > Infoblocks | 8 JPG images | Convert to WebP for 30-50% savings |
| Domain Config | Commerce > Websites > Configuration > [select domain] | Active | non-www to www redirect costs 780ms on mobile |

### Customization Menu
- Customization > Scripting — Script records and deployments
- Customization > SuiteBundler — Bundle management
- Customization > Lists, Records & Fields — Custom fields, records
- Customization > Forms — Transaction/entry forms
- Customization > Workflow — Workflow automations

### Key Direct URLs
- Website Setup (VMS): /app/site/setup/siteadmin.nl?id=3
- Website Setup (AUS): /app/site/setup/siteadmin.nl?id=4
- Extension Manager: /app/site/hosting/scriptlet.nl?script=1290&deploy=1
- File Cabinet: /app/common/media/mediaitemfolders.nl
- Installed Bundles: /app/bundler/bundlelist.nl?type=I
- Script Deployments: /app/common/scripting/scriptrecordlist.nl
- Scripts List: /app/common/scripting/scriptlist.nl

## Third Party Integrations

| System | Purpose | Status |
|--------|---------|--------|
| Avalara AvaTax | Tax calculation | Active (bundle 1894) |
| Celigo / integrator.io | Amazon + eBay marketplace sync | Active |
| Packeji | Multi-carrier shipping (LTL, parcel, 3PL) | Active |
| MerchantE / Fortis | Payment gateway | Active (MES API primary) |
| Recurrency | Inventory intelligence/demand planning | Active |
| Klaviyo | Email marketing, product feeds | Active |
| Slaask | Live chat widget | Active on VMS |
| PayPal | Payment processing | Active |
| GTM | Tag management | Active (SC GTM Editor bundle) |
| Stape | Server-side GTM | Active (visible in browser tabs) |
| Google Ads | PPC | Active (gtag detected) |
| Facebook/Meta | Pixel + CAPI | Active |
| Bing UET | Microsoft Ads | Active |

## Known Issues and Flags

### CRITICAL
1. **seoSupport: false** on both sites — SuiteCommerce SEO module is disabled
2. **VMS SEO Sitemap Generator not deployed** — Custom sitemap script exists but is off
3. **Test/beta extension deployments in ERROR state** — Old deployments from Jan 2025

### HIGH
4. **No Google Site Verification on Austenitex** — webstoremetatags field is empty
5. **beta.austenitex.com on HTTP** — Not using HTTPS, security and SEO issue
6. **Both OFM custom SEO extensions are v1.0.0** — May need updates as sites evolve

### MEDIUM
7. **Horizon 3.2.0 theme still present** — Old theme bundle still installed, no longer in use
8. **726 total scripts** — Heavy script environment, mostly from bundles (Avalara dominates)
9. **SuiteCommerce Configuration bundle is v2021.1.2** — Older version, may limit config options
