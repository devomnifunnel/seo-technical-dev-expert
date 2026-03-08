# AEO Emerging Concepts and Future Trends

## Assistive Agent Optimization (AAO)

AAO is the newest evolution in AI visibility strategy, coined by Jason Barnard. It describes optimization for when AI systems recommend and act autonomously on behalf of users with no human review of the selection.

**The Algorithmic Trinity:**
All modern AI systems rely on three components working together:
1. Large Language Models (language understanding and generation)
2. Knowledge Graphs (structured entity relationships)
3. Traditional Search (content discovery and retrieval)

The balance differs by platform. ChatGPT leans heavily on LLMs while Google relies more on its Knowledge Graph.

**The 10 Gate Pipeline (DSCRI ARGDW):**

1. Discovered (bot finds you exist)
2. Selected (bot decides you are worth fetching)
3. Crawled (bot retrieves your content)
4. Rendered (bot translates content into readable format)
5. Indexed (algorithm commits content to memory)
6. Annotated (algorithm classifies meaning across 24+ dimensions)
7. Recruited (algorithm pulls content for use)
8. Grounded (engine verifies against other sources)
9. Displayed (engine presents you to user)
10. Won (perfect click at zero sum moment)

**Concentration data:** Top performers captured 59.5% of AI citation opportunities by February 2026, up from 30.9% in December. That is a 293% increase in concentration in just two months. Early adoption creates compounding advantages.

**Practical AAO implementation:**

- Expose APIs, booking calendars, or demo request endpoints that agents can call directly.
- Secure 2 to 3 high authority unlinked mentions that confirm positioning. Agents trust corroborated signals far more than self claimed ones.
- Ensure content is server side rendered (not dependent on JavaScript). Most AI agent bots do not render JavaScript.
- Use IndexNow for instant content notification.

Source: https://searchengineland.com/aao-assistive-agent-optimization-469919

## llms.txt

llms.txt is a proposed open standard (created by Jeremy Howard of Answer.AI in 2024) that provides AI systems with a curated set of priority pages, similar to robots.txt but designed specifically for AI bots.

**Current reality (as of Q1 2026):**

- Adoption remains limited. Only 0.1% of AI crawler requests touch /llms.txt over 90 days.
- 8 out of 9 sites in independent studies saw no measurable change in traffic after llms.txt implementation.
- No mainstream AI search or LLM provider has confirmed they meaningfully rely on llms.txt yet.

**Recommendation:** Implement llms.txt as a low effort, future proofing measure, but do not rely on it for current AI visibility. Focus instead on semantic HTML, structured data, clear taxonomy, and content quality.

Source: https://www.linkbuildinghq.com/blog/should-websites-implement-llms-txt-in-2026/

## AI Bot Crawling

OpenAI's GPTBot and Anthropic's ClaudeBot are two prominent LLM crawlers. Requests from GPTBot and ClaudeBot accounted for about 20% of Googlebot's volume in late 2024. 79% of major news publishers block AI training bots via robots.txt.

**Recommended approach:** Allow AI crawlers that drive citation traffic (GPTBot for ChatGPT citations, ClaudeBot for Claude citations) while blocking unwanted training only crawlers through robots.txt rules.

## IndexNow and MCP Protocol

**IndexNow:** Instant notification protocols like IndexNow and Indexing APIs are becoming essential for ensuring fresh content reaches AI systems quickly. Traditional crawling with multi day delays is insufficient for the pace of AI search.

**MCP (Model Context Protocol).** Created by Anthropic in late 2024 and donated to the Linux Foundation in December 2025. MCP is emerging as the standard protocol for agent communication, enabling a shift from chat based prompting to active agentic workflows. In 2026, it is expected to become the dominant infrastructure for contextual AI interaction.
