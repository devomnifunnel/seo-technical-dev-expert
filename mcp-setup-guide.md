# MCP Server Setup Guide for SEO & Technical Dev Expert

## 1. Semrush MCP (Official Remote Server)

The official Semrush MCP server provides secure access to Semrush APIs via OAuth 2.1.

**Install command:**
```
claude mcp add semrush https://mcp.semrush.com/v1/mcp -t http
```

**Authentication:**
After adding, run `/mcp` in Claude Code, select Semrush MCP, select Authenticate. OAuth flow redirects to Semrush login.

**Capabilities:** Domain analytics, keyword research, backlink data, position tracking, site audit data, competitive analysis

**Requirements:** Active Semrush subscription with API access

**Source:** https://developer.semrush.com/api/basics/semrush-mcp/

---

## 2. Google Search Console MCP

Multiple community implementations available. Recommended options:

### Option A: ahonn/mcp-server-gsc (TypeScript, most popular)
```
claude mcp add gsc -- npx -y @anthropic-ai/mcp-server-gsc
```
Or if that package name is incorrect, install from GitHub:
```
npm install -g mcp-server-gsc
claude mcp add gsc -- mcp-server-gsc
```

**Setup:** Requires Google Cloud service account with Search Console API access. Place credentials JSON in a secure location and set GOOGLE_APPLICATION_CREDENTIALS env var.

### Option B: MattiooFR/mcp-gsc-multi-account (Best for agencies)
Designed for managing multiple client GSC properties from a single AI assistant.

**Capabilities:** Query search analytics (queries, clicks, impressions, CTR, position), check URL indexing status, list sites and properties, mobile usability checks

**Requirements:** Google Cloud project with Search Console API enabled, service account or OAuth credentials

**Sources:**
- https://github.com/ahonn/mcp-server-gsc
- https://github.com/MattiooFR/mcp-gsc-multi-account

---

## 3. PageSpeed Insights MCP

### enemyrr/mcp-server-pagespeed (Most popular)
```
claude mcp add pagespeed -- npx -y mcp-server-pagespeed
```

**Capabilities:** Real time PageSpeed Insights analysis, Core Web Vitals metrics, FCP/LCP/CLS/INP scoring, performance/accessibility/best practices/SEO audits, structured JSON output with prioritized improvement suggestions

**Requirements:** Google PageSpeed Insights API key (free tier available at https://developers.google.com/speed/docs/insights/v5/get-started). Set as PAGESPEED_API_KEY env var.

**Source:** https://github.com/enemyrr/mcp-server-pagespeed

---

## Installation Order

1. Semrush MCP (simplest, official OAuth)
2. PageSpeed Insights MCP (free API key, quick setup)
3. Google Search Console MCP (requires Google Cloud service account setup)

## Notes

All MCP servers are added to ~/.claude/settings.json under mcpServers. They will be available across all Claude Code projects including both the Paid Media and SEO projects.

Michael must provide or approve:
- Semrush account credentials (OAuth login)
- Google Cloud project with Search Console API enabled
- PageSpeed Insights API key
