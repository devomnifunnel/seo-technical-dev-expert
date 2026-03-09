# SEO & Technical Dev Expert: Complete Setup Guide

This guide covers every MCP server, API credential, OAuth configuration, and environment setting required to run this project from scratch. Follow each section in order.

## Table of Contents

1. [Prerequisites](#1-prerequisites)
2. [Clone and Initialize](#2-clone-and-initialize)
3. [Global Settings](#3-global-settings)
4. [Google Cloud Platform Setup](#4-google-cloud-platform-setup)
5. [MCP Server Installation](#5-mcp-server-installation)
6. [Claude AI Connectors](#6-claude-ai-connectors)
7. [Browser Extensions](#7-browser-extensions)
8. [Environment Variables](#8-environment-variables)
9. [Security Configuration](#9-security-configuration)
10. [Validation](#10-validation)
11. [Troubleshooting](#11-troubleshooting)
12. [MCP Quick Reference](#12-mcp-quick-reference)

---

## 1. Prerequisites

### Required Software

| Software | Minimum Version | Purpose |
|----------|----------------|---------|
| Claude Code CLI | Latest | Core platform |
| Node.js | 18+ | MCP server runtime |
| npm | 9+ | Package management |
| Git | 2.30+ | Version control |
| Google Chrome | Latest | Browser automation |
| Python 3 | 3.8+ | Hook scripts |
| Bash | 4+ | Validation scripts (Git Bash on Windows) |

### Required Accounts

| Account | Tier | Purpose |
|---------|------|---------|
| Anthropic (Claude) | Pro or Team | Claude Code access |
| Google Cloud Platform | Free tier works | GSC, GA4, Google Ads API access |
| Semrush | Guru or Business | SEO analytics (API access required) |
| Asana | Free or Premium | Project and task management |
| Zapier | Free or Starter | Workflow automation and integrations |

### Optional Accounts

| Account | Purpose |
|---------|---------|
| Firecrawl | Web crawling API (pending integration) |

---

## 2. Clone and Initialize

```bash
git clone https://github.com/YOUR_ORG/seo-technical-dev-expert.git
cd seo-technical-dev-expert
```

Verify the project structure:

```bash
ls .claude/agents/    # 9 specialist agents
ls .claude/skills/    # 32 skills
ls .claude/rules/     # 6 rule files
ls .claude/hooks/     # 4 hook scripts
ls .claude/frameworks/ # 10 frameworks
```

---

## 3. Global Settings

Configure Claude Code global settings at `~/.claude/settings.json`:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1",
    "CLAUDE_CODE_EFFORT_LEVEL": "high",
    "SLASH_COMMAND_TOOL_CHAR_BUDGET": "30000"
  },
  "alwaysThinkingEnabled": true
}
```

| Setting | Purpose |
|---------|---------|
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | Enables multi agent team orchestration with Shift+Tab delegate mode |
| `CLAUDE_CODE_EFFORT_LEVEL` | Sets reasoning depth to high for complex SEO analysis |
| `SLASH_COMMAND_TOOL_CHAR_BUDGET` | Increases skill output budget for detailed audit results |
| `alwaysThinkingEnabled` | Enables extended thinking for all prompts |

---

## 4. Google Cloud Platform Setup

A Google Cloud project is required for Google Search Console, Google Analytics 4, and Google Ads MCP servers. All three share the same OAuth credentials.

### 4.1 Create a Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Click **New Project** in the top bar
3. Name it (e.g., `claude-code-seo-tools`)
4. Note the **Project ID** for later use

### 4.2 Enable Required APIs

Navigate to **APIs & Services > Library** and enable each of these:

| API | Used By |
|-----|---------|
| Google Search Console API | GSC MCP server |
| Google Analytics Data API | GA4 MCP server |
| Google Analytics Admin API | GA4 MCP server |
| Google Ads API | Google Ads MCP server |
| PageSpeed Insights API | PageSpeed MCP server |

### 4.3 Create OAuth 2.0 Credentials (Desktop App)

This is the recommended approach for individual users running Claude Code locally.

1. Go to **APIs & Services > Credentials**
2. Click **Create Credentials > OAuth client ID**
3. Select **Desktop app** as the application type
4. Name it (e.g., `Claude Code MCP`)
5. Download the JSON file
6. Save it to a secure location outside the project directory (e.g., `~/.config/gcloud/claude-code-oauth.json`)

**Important**: Never commit OAuth credential files to git. The project's `.gitignore` and security hooks block credential files automatically.

### 4.4 Create a Service Account (Alternative for Server/CI Use)

If you prefer service account auth (better for shared environments):

1. Go to **IAM & Admin > Service Accounts**
2. Click **Create Service Account**
3. Name it (e.g., `claude-code-mcp-reader`)
4. Grant these roles:
   - For GSC: No IAM role needed, but add the service account email as a user in each Search Console property
   - For GA4: Grant **Viewer** role on each GA4 property
   - For Google Ads: Grant read access via Google Ads UI
5. Create a JSON key and download it
6. Save to a secure location (e.g., `~/.config/gcloud/service-account.json`)

### 4.5 Create a PageSpeed Insights API Key

1. Go to **APIs & Services > Credentials**
2. Click **Create Credentials > API Key**
3. Restrict the key to **PageSpeed Insights API** only
4. Copy the key value for the environment variable setup in Section 8

---

## 5. MCP Server Installation

Install each MCP server using the `claude mcp add` command. Run these from the project root directory.

### 5.1 Semrush MCP (Official Remote Server)

```bash
claude mcp add semrush https://mcp.semrush.com/v1/mcp -t http
```

**Authentication**: After adding, authenticate via OAuth:
1. Run Claude Code
2. Type `/mcp`
3. Select **Semrush MCP**
4. Select **Authenticate**
5. Complete the OAuth flow in your browser (logs into your Semrush account)

**Requirements**: Active Semrush subscription with API access (Guru plan or higher)

**Tool prefix**: `mcp__semrush__`

**Available tools**: `keyword_research`, `organic_research`, `backlink_research`, `siteaudit_research`, `overview_research`, `tracking_research`, `trends_research`, `url_research`, `subdomain_research`, `subfolder_research`, `projects_research`, `execute_report`, `get_report_schema`

**Source**: https://developer.semrush.com/api/basics/semrush-mcp/

---

### 5.2 Google Search Console MCP

Two community implementations are available. Choose one based on your needs.

#### Option A: Single Account (Simpler Setup)

```bash
claude mcp add google-search-console -- npx -y @anthropic-ai/mcp-server-google-search-console
```

If the above package name is unavailable, try:

```bash
npm install -g mcp-server-gsc
claude mcp add google-search-console -- mcp-server-gsc
```

#### Option B: Multi Account (Best for Agencies)

```bash
git clone https://github.com/MattiooFR/mcp-gsc-multi-account.git
cd mcp-gsc-multi-account
npm install
claude mcp add google-search-console -- node /path/to/mcp-gsc-multi-account/index.js
```

**Authentication**: Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to point to your service account JSON file (see Section 4.4).

For OAuth desktop credentials, some implementations require setting `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` from your OAuth client JSON.

**Adding properties**: After authentication, verify access by running `mcp__google-search-console__list_sites` in Claude Code. If properties are missing, add the service account email as a user in Google Search Console for each property.

**Tool prefix**: `mcp__google-search-console__`

**Available tools**: `list_sites`, `search_analytics`, `enhanced_search_analytics`, `detect_quick_wins`, `index_inspect`, `list_sitemaps`, `get_sitemap`, `submit_sitemap`

**Sources**:
- https://github.com/ahonn/mcp-server-gsc
- https://github.com/MattiooFR/mcp-gsc-multi-account

---

### 5.3 Google Analytics 4 MCP

```bash
claude mcp add google-analytics -- npx -y @anthropic-ai/mcp-server-google-analytics
```

If the above package is unavailable, search for community implementations:

```bash
npx -y mcp-server-google-analytics
```

**Authentication**: Uses the same Google Cloud credentials as GSC. Set `GOOGLE_APPLICATION_CREDENTIALS` for service account auth, or configure OAuth credentials as prompted during first use.

**Required API Scopes**:
- `https://www.googleapis.com/auth/analytics.readonly`
- `https://www.googleapis.com/auth/analytics.edit` (only if you need admin operations)

**Tool prefix**: `mcp__google-analytics__`

**Available tools**: `get_account_summaries`, `run_report`, `run_realtime_report`, `get_property_details`, `get_custom_dimensions_and_metrics`, `list_google_ads_links`

---

### 5.4 Google Ads MCP

```bash
claude mcp add google-ads -- npx -y mcp-server-google-ads
```

**Authentication**: Google Ads API requires:
1. A Google Cloud project with Google Ads API enabled (Section 4.2)
2. OAuth credentials (Section 4.3)
3. A **Developer Token** from the Google Ads API Center:
   - Sign into your Google Ads manager account
   - Go to **Tools & Settings > API Center**
   - Apply for a developer token (Basic access is sufficient for read operations)
4. Set environment variables:
   - `GOOGLE_ADS_DEVELOPER_TOKEN`
   - `GOOGLE_ADS_CLIENT_ID` (from OAuth client JSON)
   - `GOOGLE_ADS_CLIENT_SECRET` (from OAuth client JSON)
   - `GOOGLE_ADS_REFRESH_TOKEN` (obtained during OAuth flow)
   - `GOOGLE_ADS_LOGIN_CUSTOMER_ID` (your manager account ID, no dashes)

**Tool prefix**: `mcp__google-ads__`

**Available tools**: `list_accounts`, `execute_gaql_query`, `run_gaql`, `get_campaign_performance`, `get_ad_performance`, `get_ad_creatives`, `list_resources`, `get_account_currency`, `get_image_assets`, `analyze_image_assets`, `download_image_asset`, `get_asset_usage`

---

### 5.5 PageSpeed Insights MCP

```bash
claude mcp add pagespeed -- npx -y mcp-server-pagespeed
```

**Authentication**: Requires a Google PageSpeed Insights API key (free tier available, generous rate limits).

Set the environment variable:
```bash
export PAGESPEED_API_KEY="your-api-key-here"
```

Or pass it when adding the MCP:
```bash
claude mcp add pagespeed -e PAGESPEED_API_KEY=your-api-key-here -- npx -y mcp-server-pagespeed
```

**Tool prefix**: `mcp__pagespeed__`

**Available tools**: `analyze_pagespeed`

**Source**: https://github.com/enemyrr/mcp-server-pagespeed

---

### 5.6 Lighthouse MCP

```bash
claude mcp add lighthouse -- npx -y @anthropic-ai/mcp-server-lighthouse
```

If the above package is unavailable:

```bash
npx -y mcp-server-lighthouse
```

**Authentication**: None required. Lighthouse runs locally using your Chrome installation.

**Requirements**: Google Chrome must be installed. On headless environments, install Chromium.

**Tool prefix**: `mcp__lighthouse__`

**Available tools**: `run_audit`, `get_performance_score`, `get_core_web_vitals`, `get_lcp_opportunities`, `get_accessibility_score`, `get_seo_analysis`, `get_security_audit`, `find_unused_javascript`, `analyze_resources`, `compare_mobile_desktop`, `check_performance_budget`, `check_pwa_readiness`

---

### 5.7 Chrome DevTools MCP

```bash
claude mcp add chrome-devtools -- npx -y @anthropic-ai/mcp-server-chrome-devtools
```

**Authentication**: None required. Connects to Chrome via the DevTools Protocol.

**Requirements**: Chrome must be running with remote debugging enabled:

```bash
# Windows
"C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222

# macOS
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

**Tool prefix**: `mcp__chrome-devtools__`

**Available tools**: `evaluate_script`, `list_network_requests`, `get_network_request`, `list_console_messages`, `get_console_message`, `lighthouse_audit`, `performance_start_trace`, `performance_stop_trace`, `performance_analyze_insight`, `take_screenshot`, `take_snapshot`, `take_memory_snapshot`, `navigate_page`, `new_page`, `close_page`, `list_pages`, `select_page`, `click`, `fill`, `fill_form`, `press_key`, `hover`, `type_text`, `drag`, `upload_file`, `resize_page`, `emulate`, `wait_for`, `handle_dialog`

---

## 6. Claude AI Connectors

These MCP servers are managed through Claude's built in connector system. They use OAuth handled entirely by Anthropic's infrastructure, so no local credential management is needed.

### 6.1 Asana Connector

1. In Claude Code, type `/mcp`
2. Select **Add Claude AI Connector**
3. Choose **Asana**
4. Authorize with your Asana account
5. Grant access to the workspace where your project board lives

The project expects an Asana board named "Claude" with specific sections. See `.claude/CLAUDE.md` for the board GID and section GIDs.

**Tool prefix**: `mcp__claude_ai_Asana__`

**Key tools**: `asana_create_task`, `asana_update_task`, `asana_get_task`, `asana_search_tasks`, `asana_create_task_story`, `asana_list_workspaces`, `asana_get_project`, `asana_get_project_sections`

---

### 6.2 Zapier Connector

1. In Claude Code, type `/mcp`
2. Select **Add Claude AI Connector**
3. Choose **Zapier**
4. Authorize with your Zapier account
5. Configure the actions you want available (via the Zapier MCP configuration URL)

Zapier provides bridge access to additional platforms including ActiveCampaign, Microsoft Outlook, and more. Configure individual actions in the Zapier dashboard.

**Tool prefix**: `mcp__claude_ai_Zapier__`

**Configuration URL**: After setup, use the `get_configuration_url` tool to get your personal config page.

---

## 7. Browser Extensions

### 7.1 Claude in Chrome Extension

This extension enables browser automation through Claude Code.

1. Install the **Claude in Chrome** extension from the Chrome Web Store
2. Once installed, the MCP server is automatically available in Claude Code
3. No additional configuration or API keys required
4. The extension creates a tab group for MCP controlled tabs

**Tool prefix**: `mcp__claude-in-chrome__`

**Key tools**: `tabs_context_mcp`, `tabs_create_mcp`, `navigate`, `read_page`, `get_page_text`, `javascript_tool`, `form_input`, `computer`, `find`, `gif_creator`, `read_console_messages`, `read_network_requests`

**Important**: Always call `tabs_context_mcp` at the start of each browser automation session to get current tab state. Create new tabs for each conversation rather than reusing existing ones.

---

## 8. Environment Variables

### Required Variables

Set these in your shell profile (`~/.bashrc`, `~/.zshrc`, or Windows environment):

```bash
# Google Cloud (for GSC, GA4, Google Ads)
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account.json"

# PageSpeed Insights
export PAGESPEED_API_KEY="your-pagespeed-api-key"

# Google Ads (if using standalone MCP, not Zapier bridge)
export GOOGLE_ADS_DEVELOPER_TOKEN="your-dev-token"
export GOOGLE_ADS_CLIENT_ID="your-client-id"
export GOOGLE_ADS_CLIENT_SECRET="your-client-secret"
export GOOGLE_ADS_REFRESH_TOKEN="your-refresh-token"
export GOOGLE_ADS_LOGIN_CUSTOMER_ID="1234567890"
```

### Optional Variables

```bash
# Firecrawl (pending integration)
export FIRECRAWL_API_KEY="your-firecrawl-api-key"
```

### Passing Variables to MCP Servers

You can pass environment variables directly when adding MCP servers:

```bash
claude mcp add pagespeed -e PAGESPEED_API_KEY=your-key -- npx -y mcp-server-pagespeed
```

Or set them globally in `~/.claude/settings.json`:

```json
{
  "env": {
    "PAGESPEED_API_KEY": "your-key",
    "GOOGLE_APPLICATION_CREDENTIALS": "/path/to/credentials.json"
  }
}
```

---

## 9. Security Configuration

The project includes security hooks that prevent accidental credential exposure and destructive operations.

### 9.1 Pre Configured Protections

These are defined in `.claude/settings.local.json` and activate automatically:

**File Protection Hook** (`block-protected-files.sh`):
Blocks Edit and Write operations on:
- `.env`, `.env.*` files
- `credentials.json`, `secrets.*`
- `.ssh/`, `.aws/` directories
- `.pem`, `.key`, `.p12`, `.pfx` certificate files

**GTM Protection Hook** (`block-gtm-modifications.sh`):
Blocks direct GTM container modifications (tags, triggers, variables) to prevent unauthorized changes.

**Permission Denials**:
- `rm -rf` commands
- `git push --force`
- `git reset --hard`
- `git clean -f`

### 9.2 Git Safety

The pre commit hook runs the full validation suite (322+ checks) before allowing commits:

```bash
# Test the validation manually
bash scripts/eval/validate-all.sh
```

Ensure your `.gitignore` includes:

```
.env
.env.*
*.pem
*.key
*.p12
*.pfx
credentials.json
service-account*.json
token.json
auth.json
node_modules/
```

---

## 10. Validation

After completing setup, verify everything works:

### 10.1 Run the Project Validation Suite

```bash
bash scripts/eval/validate-all.sh
```

Expected output: **322 passed, 0 failed, 0 warnings**

### 10.2 Run Operational Validation

```bash
bash scripts/eval/validate-operational.sh
```

Expected output: **52 passed, 0 failed** (4 warnings are expected for background agents without write tools)

### 10.3 Test MCP Connectivity

In Claude Code, test each MCP server with a lightweight call:

| MCP Server | Test Command |
|------------|-------------|
| Semrush | `mcp__semrush__overview_research` (returns available reports) |
| Google Search Console | `mcp__google-search-console__list_sites` (returns verified properties) |
| Google Analytics | `mcp__google-analytics__get_account_summaries` (returns GA4 accounts) |
| Google Ads | `mcp__google-ads__list_accounts` (returns accessible accounts) |
| PageSpeed | `mcp__pagespeed__analyze_pagespeed` with any URL |
| Lighthouse | `mcp__lighthouse__get_performance_score` with any URL |
| Chrome DevTools | `mcp__chrome-devtools__list_pages` (returns open pages) |
| Claude in Chrome | `mcp__claude-in-chrome__tabs_context_mcp` (returns tab group) |
| Asana | `mcp__claude_ai_Asana__asana_list_workspaces` (returns workspaces) |
| Zapier | `mcp__claude_ai_Zapier__get_configuration_url` (returns config URL) |

All 10 should return data successfully. If any fail, see the Troubleshooting section.

---

## 11. Troubleshooting

### MCP Server Not Found

```
Error: MCP server "server-name" not found
```

**Fix**: Re add the server with `claude mcp add`. Verify it appears in your config with `claude mcp list`.

### Authentication Failures

**Google Cloud services** (GSC, GA4, Google Ads):
- Verify `GOOGLE_APPLICATION_CREDENTIALS` points to a valid JSON file
- Confirm the required APIs are enabled in your Google Cloud project
- For GSC: ensure the service account email is added as a user on each Search Console property
- For GA4: ensure the service account has Viewer access on each GA4 property
- For Google Ads: verify the developer token is approved and not in test mode

**Semrush**:
- Re authenticate via `/mcp` > Semrush > Authenticate
- Confirm your Semrush plan includes API access (Guru or higher)

**Asana / Zapier**:
- Remove and re add the Claude AI connector
- Re authorize through the OAuth flow

### Chrome DevTools Connection Refused

```
Error: connect ECONNREFUSED 127.0.0.1:9222
```

**Fix**: Start Chrome with remote debugging enabled:
```bash
chrome --remote-debugging-port=9222
```

### Claude in Chrome Not Responding

- Verify the extension is installed and enabled in Chrome
- Check that the MCP tab group exists (the extension icon should show active status)
- Try closing and reopening the MCP tab group
- If a dialog was triggered accidentally, manually dismiss it in the browser

### Validation Suite Failures

```bash
# Run individual validators to isolate the issue
bash scripts/eval/validate-skills.sh
bash scripts/eval/validate-agents.sh
bash scripts/eval/validate-rules.sh
bash scripts/eval/validate-hooks.sh
bash scripts/eval/validate-settings.sh
bash scripts/eval/validate-refs.sh
bash scripts/eval/validate-operational.sh
```

### Hook Script Errors on Windows

The hook scripts use bash and Python. On Windows:
- Use Git Bash (installed with Git for Windows)
- Ensure Python 3 is in your PATH
- The `block-protected-files.sh` hook uses Python for JSON parsing (bash `grep` has regex bugs on Windows)

---

## 12. MCP Quick Reference

### Complete Server Inventory

| # | MCP Server | Tool Prefix | Auth Type | Credentials Needed |
|---|-----------|-------------|-----------|-------------------|
| 1 | Google Search Console | `mcp__google-search-console__` | Service Account / OAuth | Google Cloud JSON |
| 2 | Google Analytics 4 | `mcp__google-analytics__` | Service Account / OAuth | Google Cloud JSON |
| 3 | Google Ads | `mcp__google-ads__` | OAuth + Dev Token | Google Cloud JSON + Developer Token |
| 4 | Semrush | `mcp__semrush__` | OAuth 2.1 | Semrush account (Guru+) |
| 5 | PageSpeed Insights | `mcp__pagespeed__` | API Key | Free Google API key |
| 6 | Lighthouse | `mcp__lighthouse__` | None | Chrome installed locally |
| 7 | Chrome DevTools | `mcp__chrome-devtools__` | None | Chrome with remote debugging |
| 8 | Claude in Chrome | `mcp__claude-in-chrome__` | None | Chrome extension installed |
| 9 | Asana | `mcp__claude_ai_Asana__` | Claude AI OAuth | Asana account |
| 10 | Zapier | `mcp__claude_ai_Zapier__` | Claude AI OAuth | Zapier account |

### Which Agents Use Which MCP Tools

| Agent | MCP Tools |
|-------|-----------|
| search-console-analyst | GSC, GA4 |
| technical-seo-auditor | GSC, Lighthouse, PageSpeed |
| pagespeed-optimizer | PageSpeed, Lighthouse |
| competitor-intelligence | Semrush, Google Ads |
| content-strategist | Semrush, GA4 |
| aeo-specialist | GA4, GSC |
| link-strategist | Semrush |
| schema-architect | Lighthouse |
| netsuite-seo-developer | GSC, Lighthouse |

### Which Skills Use Which MCP Tools

| Skill | MCP Tools |
|-------|-----------|
| search-console | GSC, GA4 |
| semrush-analytics | Semrush |
| core-web-vitals | PageSpeed, Lighthouse |
| pagespeed-optimization | PageSpeed, Lighthouse |
| competitor-seo | Semrush, Google Ads |
| keyword-research | Semrush |
| content-optimization | GSC, GA4 |
| technical-seo | GSC, Lighthouse, PageSpeed |

### Installation Quick Start (Copy/Paste Block)

```bash
# 1. Semrush (official, OAuth)
claude mcp add semrush https://mcp.semrush.com/v1/mcp -t http

# 2. PageSpeed Insights (free API key)
claude mcp add pagespeed -e PAGESPEED_API_KEY=YOUR_KEY -- npx -y mcp-server-pagespeed

# 3. Lighthouse (no auth)
claude mcp add lighthouse -- npx -y @anthropic-ai/mcp-server-lighthouse

# 4. Chrome DevTools (no auth, needs Chrome with --remote-debugging-port=9222)
claude mcp add chrome-devtools -- npx -y @anthropic-ai/mcp-server-chrome-devtools

# 5. Google Search Console (service account)
claude mcp add google-search-console -e GOOGLE_APPLICATION_CREDENTIALS=/path/to/sa.json -- npx -y mcp-server-gsc

# 6. Google Analytics 4 (service account)
claude mcp add google-analytics -e GOOGLE_APPLICATION_CREDENTIALS=/path/to/sa.json -- npx -y mcp-server-google-analytics

# 7. Google Ads (OAuth + dev token)
claude mcp add google-ads -e GOOGLE_ADS_DEVELOPER_TOKEN=TOKEN -e GOOGLE_ADS_CLIENT_ID=ID -e GOOGLE_ADS_CLIENT_SECRET=SECRET -e GOOGLE_ADS_REFRESH_TOKEN=TOKEN -e GOOGLE_ADS_LOGIN_CUSTOMER_ID=ACCT_ID -- npx -y mcp-server-google-ads

# 8. Claude in Chrome: Install extension from Chrome Web Store (no CLI command)

# 9. Asana: /mcp > Add Claude AI Connector > Asana

# 10. Zapier: /mcp > Add Claude AI Connector > Zapier
```

---

## Cost Considerations

| MCP Server | Cost |
|------------|------|
| Semrush | Included with Guru+ subscription ($129.95+/mo) |
| Google Search Console | Free |
| Google Analytics 4 | Free |
| Google Ads API | Free (requires active Google Ads account) |
| PageSpeed Insights API | Free (2,500 queries/day default quota) |
| Lighthouse | Free (runs locally) |
| Chrome DevTools | Free (runs locally) |
| Claude in Chrome | Free (Chrome extension) |
| Asana | Free tier works, Premium for advanced features |
| Zapier | Free tier includes 100 tasks/month |

---

## Next Steps

After completing setup:

1. Run `bash scripts/eval/validate-all.sh` to confirm project integrity
2. Test each MCP server using the connectivity checks in Section 10.3
3. Read `.claude/CLAUDE.md` for project conventions and operating procedures
4. Check the `clients/` directory for existing client data
5. Review `.claude/agents/` to understand the specialist agent roles
6. Start a Claude Code session and the system will automatically read the Asana board and resume any in progress work
