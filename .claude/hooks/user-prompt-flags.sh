#!/bin/bash
# UserPromptSubmit Hook: Agency flag system for SEO & Technical Dev Expert
# Parses flags from user prompt and outputs context injection instructions
# Flags: -v (VMS), -a (Austenitex), -bp (Blessed), -sn (State N Nation),
#         -asap (ASAP Translate), -audit (full SEO audit), -cwv (Core Web Vitals),
#         -ns (NetSuite), -schema (Schema markup), -aeo (AEO/AI search),
#         -u (ultrathink), * (bypass)
# Exit 0 = proceed, stdout = additional context for Claude

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"

# Hook Profile: skip flag parsing in minimal mode (reduces overhead on simple operations)
PROFILE="${OFM_HOOK_PROFILE:-standard}"
case "$PROFILE" in
  minimal) exit 0 ;;
esac

# Read the prompt from stdin (JSON: {"prompt": "..."})
INPUT=$(cat)
PROMPT=$(echo "$INPUT" | python -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('prompt', ''))
except:
    print('')
" 2>/dev/null)

# Bypass: if prompt starts with * or / or #, pass through with no overhead
case "$PROMPT" in
  \**) exit 0 ;;
  /*) exit 0 ;;
  \#*) exit 0 ;;
esac

# Track which flags were found
found_flags=false

# Client context flags
if echo "$PROMPT" | grep -qiw "\-v\|\-vms"; then
  found_flags=true
  echo "[FLAG: VMS] Loading Verocious Motorsports context."
  echo "Read clients/verocious-motorsports/CLAUDE.md and history.md before proceeding."
  echo "Load skills: netsuite-environment, suitecommerce-seo, core-web-vitals"
  echo "Load frameworks: netsuite-seo-architecture.md, cwv-remediation.md"
  echo "Asana parent task GID: 1213570306882419"
  echo "Key: SCS Standard (NOT SCA), Summit 4.0.0, seoSupport=false, GTM-57T4T5BW, GA4 G-862KMNBJX6"
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-a\|\-aux"; then
  found_flags=true
  echo "[FLAG: AUX] Loading Austenitex context."
  echo "Read clients/austenitex/CLAUDE.md and history.md before proceeding."
  echo "Load skills: netsuite-environment, suitecommerce-seo"
  echo "Asana parent task GID: 1213570306761300"
  echo "Key: Shares NetSuite account 606473 with VMS, Website ID 4, GA4 G-TRYJ3FTG3K, NO GTM container"
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-bp"; then
  found_flags=true
  echo "[FLAG: BP] Loading Blessed Performance context."
  echo "Read clients/blessed-performance/ if exists, otherwise check Asana."
  echo "Asana parent task GID: 1213570306692994"
  echo "Key: BigCommerce, TikTok/Meta retargeting, Matt Story contact"
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-sn"; then
  found_flags=true
  echo "[FLAG: SN] Loading State N Nation context."
  echo "Read clients/state-n-nation/ if exists, otherwise check Asana."
  echo "Key: New Shopify build"
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-asap"; then
  found_flags=true
  echo "[FLAG: ASAP] Loading ASAP Translate context."
  echo "Read clients/asap-translate/ if exists, otherwise check Asana."
  echo "Asana parent task GID: 1213570306776372"
  echo "Key: Webflow platform"
  echo ""
fi

# Mode flags
if echo "$PROMPT" | grep -qiw "\-audit"; then
  found_flags=true
  echo "[FLAG: AUDIT] Full SEO audit mode activated."
  echo "Load framework: seo-audit-methodology.md"
  echo "Audit order: crawlability > indexation > technical > content > links > UX > local > AI search"
  echo "Priority tiers: Critical (blocks indexing/revenue), High (significant impact), Medium (optimization), Low (best practice)"
  echo "Deliverable format: Executive Summary, Score Snapshot, Issue Inventory by Priority, Detailed Findings, Action Plan"
  echo "Test 3+ page types. Cross reference against existing profile data. Produce developer handoff spec."
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-cwv"; then
  found_flags=true
  echo "[FLAG: CWV] Core Web Vitals focus mode."
  echo "Load framework: cwv-remediation.md"
  echo "Load skills: core-web-vitals, pagespeed-optimization"
  echo "Targets: LCP < 2.5s, INP < 200ms, CLS < 0.1"
  echo "Use both PSI (mcp__pagespeed__) and Lighthouse (mcp__lighthouse__) for field + lab data."
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-ns"; then
  found_flags=true
  echo "[FLAG: NS] NetSuite/SuiteCommerce focus mode."
  echo "Load skills: netsuite-environment, netsuite-seo, suitecommerce-seo"
  echo "Load framework: netsuite-seo-architecture.md"
  echo "Key: SPA rendering, Backbone.js, RequireJS, ES5 only, prerendering critical"
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-schema"; then
  found_flags=true
  echo "[FLAG: SCHEMA] Schema markup focus mode."
  echo "Load skill: schema-markup"
  echo "JSON-LD only. Validate against Google Rich Results Test."
  echo "Product, Organization, FAQ, HowTo, Article, BreadcrumbList, Review, Video, Event."
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-aeo"; then
  found_flags=true
  echo "[FLAG: AEO] Answer Engine Optimization mode."
  echo "Load skills: aeo-ai-seo, ai-citation-tracking"
  echo "Load framework: aeo-methodology.md"
  echo "Platforms: ChatGPT, Perplexity, Gemini, Claude, Google AI Overviews"
  echo "Focus: entity SEO, citation optimization, semantic search, structured data"
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-content"; then
  found_flags=true
  echo "[FLAG: CONTENT] Content optimization mode."
  echo "Load skills: content-optimization, keyword-research"
  echo "Load frameworks: content-architecture.md, keyword-strategy.md"
  echo "Score against E-E-A-T framework. Check for thin content, cannibalization, decay."
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-links"; then
  found_flags=true
  echo "[FLAG: LINKS] Link building and backlink analysis mode."
  echo "Load skill: link-building (disable-model-invocation, use context fork)"
  echo "Load framework: link-building-methodology.md"
  echo ""
fi

if echo "$PROMPT" | grep -qiw "\-tech"; then
  found_flags=true
  echo "[FLAG: TECH] Technical SEO deep dive mode."
  echo "Load skills: technical-seo, seo-dev-implementation"
  echo "Load framework: technical-seo-dev.md"
  echo "Focus: crawlability, indexation, canonicalization, redirects, security headers"
  echo ""
fi

# Ultrathink flag
if echo "$PROMPT" | grep -qiw "\-u"; then
  found_flags=true
  echo "[FLAG: ULTRATHINK] High effort reasoning mode activated."
  echo "Use extended thinking. Consider all angles before responding."
  echo ""
fi

# Inject current date (always useful, minimal overhead)
if [ "$found_flags" = true ]; then
  echo "Current date: $(date +%Y-%m-%d)"
fi

exit 0
