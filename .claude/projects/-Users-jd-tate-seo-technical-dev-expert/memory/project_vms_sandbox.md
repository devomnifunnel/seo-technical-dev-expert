---
name: VMS Sandbox Account Setup
description: VMS sandbox 606473-SB1 is configured and live with domain sandbox-checkout.verociousmotorsports.com
type: project
---

VMS NetSuite sandbox account is 606473-SB1 (URL: https://606473-sb1.app.netsuite.com).

**Why:** Sandbox set up for testing free shipping code, OPC migration, and general staging before pushing changes to production.

**How to apply:** Use this sandbox for all VMS code testing. Never deploy untested code directly to production account 606473.

Configuration as of 2026-03-26:
- Domain: sandbox-checkout.verociousmotorsports.com (Single Domain for Web Store and Checkout)
- Hosting Root: corrected to match production (was initially set to wrong folder)
- Website ID 3: Verocious Motors, SuiteCommerce type
- Theme: Summit 4.0.0
- All 33 extensions activated including PacejetIntegration 1.0.3
- PacejetIntegration.Pacejet.js exists at File Cabinet record 2841110 (OLD production version, does NOT contain free shipping code yet)
- SSL certificate: auto provisioning
- CDN Cache: enabled
- All bundles match production
- Two legacy ERROR deployments exist (test.verociousmotorsports.com, beta.austenitex.com from Jan 2025) can be cleaned up
- SuiteCommerce Configuration suitelet returned "invalid/disabled" when accessed. May need investigation for OPC toggle.

DNS CNAME records for sandbox:
- sandbox-checkout.verociousmotorsports.com → sandbox-checkout.verociousmotorsports.com.hosting.netsuite.com
- _acme-challenge.sandbox-checkout.verociousmotorsports.com → sandbox-checkout.verociousmotorsports.com.hosting-verify.netsuite.com
