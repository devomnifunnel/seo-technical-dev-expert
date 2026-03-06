---
name: aeo-audit
description: >
  Use when someone asks to run an AEO audit, AI search audit, answer engine optimization review,
  or AI visibility assessment. Trigger on: "AEO audit", "AI search audit", "answer engine",
  "AI visibility", "how do we show up in ChatGPT", "how do we show up in Perplexity",
  "how do we show up in Gemini", "AI citation audit", "AI Overview presence check",
  "are we being cited by AI", "generative engine optimization audit". This is the full
  AEO assessment workflow covering AI Overview presence, citation eligibility, entity authority,
  and conversational content readiness.
disable-model-invocation: true
argument-hint: "[client-name] [website-url] [brand-name] [key-products-or-services]"
allowed-tools: Read, Glob, Grep, Bash, WebFetch, WebSearch, Agent, Write
---

# AEO (Answer Engine Optimization) Audit

AI search optimization assessment covering AI Overview presence, citation eligibility, entity authority, and conversational content readiness. This deploys the AEO Specialist, Schema Architect, and Content Strategist to produce an AI search readiness report.

## Context

The user wants to evaluate how well a client's website is positioned for AI powered search experiences including Google AI Overviews, ChatGPT search, Perplexity, Gemini, and Claude. This audit assesses whether the site's content, structure, and authority signals make it eligible for citation by AI systems. This is critical as AI search continues to capture an increasing share of information queries.

## Arguments

$ARGUMENTS should include:
- Client name (required)
- Website URL (required)
- Brand name (required, used for AI brand mention monitoring)
- Key products or services (required, used for entity and citation analysis)
- Target topics or queries (optional, specific questions the client wants to appear in AI answers for)

## Instructions

### Step 0: Initialize Audit Tracking

Use TaskCreate to set up the audit task list:
- Create a parent task: "[Client] AEO Audit" with description of scope
- Create subtasks for each phase: Client Context, AI Search Recon, Agent Deployment, Report Generation, Save Results
- Update each task status as you progress through phases

### Step 1: Load Client Context

Check `clients/{client-name}/` for existing profile and previous findings. Read any prior AEO, content, or schema analysis. If the client does not exist, create the directory structure.

### Step 2: AI Search Reconnaissance

Using Chrome tools and web search, perform initial AI search landscape assessment:

1. Search for the client's brand name in Google to check for AI Overview triggers
2. Search for key product/service queries to observe AI Overview behavior
3. Note which competitors are being cited in AI Overviews for target queries
4. Check whether the client's brand appears in knowledge panels or entity cards
5. Test conversational queries related to the client's industry ("What is the best...", "How do I...")
6. Review the client's content for AI extractability (clear answers, structured formatting, authoritative sourcing)

### Step 3: Parallel Agent Deployment

Launch the following analyses simultaneously using subagents:

**Agent 1: AEO Specialist (primary)**
- Read `.claude/agents/aeo-specialist.md` for full methodology
- **AI Overview Presence:** Test a broad set of queries to determine current visibility in Google AI Overviews
- **Citation Eligibility:** Assess content structure, authority signals, and formatting for AI citation potential
- **Entity Authority:** Evaluate the brand's entity strength in Google's Knowledge Graph and across AI platforms
- **Conversational Content Readiness:** Score content for natural language query matching and direct answer formatting
- **Knowledge Graph Optimization:** Check for entity connections, structured data supporting entity recognition
- **Brand Mention Monitoring:** Search AI platforms (ChatGPT, Perplexity, Gemini) for brand mentions and accuracy
- **FAQ and How To Optimization:** Identify opportunities for FAQ and instructional content that AI systems favor

**Agent 2: Schema Architect (supporting)**
- Read `.claude/agents/schema-architect.md` for methodology
- Audit structured data that supports AI entity recognition (Organization, Product, FAQPage, HowTo, Article)
- Validate schema for completeness and accuracy of entity properties
- Identify missing schema types that would strengthen AI system understanding of the brand and its offerings
- Check for SameAs properties linking to authoritative profiles (Wikipedia, LinkedIn, social platforms)

**Agent 3: Content Strategist (supporting)**
- Read `.claude/agents/content-strategist.md` for methodology
- Evaluate content depth and authority signals that make content citation worthy
- Assess E-E-A-T signals that AI systems use to determine source credibility
- Identify content format opportunities (comparison tables, step by step guides, definitive answers)
- Review content for semantic clarity and topic coverage completeness

### Step 4: Report Generation

Compile findings into an AEO readiness report:

1. **Executive Summary** with overall AI search readiness score and top priorities
2. **AI Overview Visibility Report** with query by query analysis showing current presence and competitor citations
3. **Citation Eligibility Assessment** scoring content sections on AI citation potential
4. **Entity Authority Profile** with Knowledge Graph status, brand entity strength, and authority gaps
5. **Conversational Content Scorecard** rating content readiness for natural language queries
6. **Schema and Structured Data Assessment** with entity supporting markup findings
7. **Brand Mention Audit** across AI platforms with accuracy assessment
8. **AEO Optimization Roadmap** with prioritized actions organized by impact
9. **Content Creation Recommendations** for new content specifically designed for AI citation

### Step 5: Save Results

1. Save the report to `clients/{client-name}/reports/{date}-aeo-audit.md`
2. Save individual findings to `clients/{client-name}/findings/`
3. Update `clients/{client-name}/open-items.md` with all AEO action items

## Output

The final deliverable is an AEO readiness report with an overall AI search readiness score, query level visibility analysis, entity authority profile, and a prioritized optimization roadmap. The report includes specific content restructuring recommendations, schema additions, and entity strengthening actions designed to increase the client's visibility and citation rate across all major AI search platforms.
