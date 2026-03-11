# MCP Response Efficiency Rules

These rules govern how verbose MCP tool responses are handled to prevent context window bloat.

---

## Response Size Awareness

MCP tools like Google Ads GAQL queries, Semrush reports, and Google Analytics data can return
responses exceeding 50,000 tokens. A single verbose response can consume 25% or more of the
context window, degrading performance for the rest of the session.

## Handling Large Responses

When an MCP tool returns a response larger than approximately 200 lines:

1. **Extract key metrics first.** Pull the specific numbers, scores, or data points needed
   for the current analysis. Do not attempt to reason about the entire response at once.

2. **Summarize before proceeding.** Write a brief summary of findings to your working notes
   (task_plan.md, findings.md, or Asana comment) before moving to the next tool call. This
   preserves the data even if context compacts.

3. **Use subagents for bulk data.** When pulling large datasets (full keyword lists, complete
   backlink profiles, multi-account ad performance), delegate to a subagent. The subagent
   processes the data in its own context window and returns only the actionable summary.

4. **Limit GAQL queries.** When querying Google Ads via mcp__google-ads__run_gaql, include
   LIMIT clauses and WHERE filters. Never pull all campaigns or all keywords without filtering.

5. **Paginate Semrush requests.** Use offset and limit parameters on mcp__semrush__ calls.
   Pull 50 results at a time rather than full datasets.

## Tools Most Likely to Produce Verbose Output

- mcp__google-ads__run_gaql: GAQL query results (campaigns, keywords, ad groups)
- mcp__google-ads__execute_gaql_query: Same as above
- mcp__semrush__organic_research: Full keyword lists
- mcp__semrush__backlink_research: Complete backlink profiles
- mcp__google-analytics__run_report: Multi-dimension reports
- mcp__google-search-console__search_analytics: Full query performance data
