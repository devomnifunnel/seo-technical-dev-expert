# Content Strategy and Architecture Methodology

## Purpose
This framework defines the methodology for designing content architecture, building topic clusters, optimizing internal linking, and maintaining content quality. It establishes standards for content planning, creation, and ongoing management that align with SEO objectives and E-E-A-T principles.

---

## 1. Topic Cluster Model

### Definition
The topic cluster model organizes content into groups centered around a broad pillar topic. Each cluster consists of a pillar page, supporting cluster content, and a network of internal links connecting them.

### Pillar Pages
- Cover a broad topic comprehensively (2,000 to 5,000 words)
- Target the highest volume keyword in the cluster (typically a head term with high difficulty)
- Structured with clear H2 sections that each address a subtopic
- Link out to every piece of cluster content from relevant sections
- Serve as the definitive resource on the topic for the site

### Cluster Content
- Individual articles or pages that dive deep into a specific subtopic of the pillar
- Target long tail or medium tail keywords related to the pillar topic
- Typically 1,000 to 2,500 words, focused on a single subtopic
- Link back to the pillar page using descriptive anchor text
- Link to related cluster content where contextually appropriate

### Internal Linking Within Clusters
- Every cluster content page links to the pillar page (mandatory)
- The pillar page links to every cluster content page (mandatory)
- Cluster content pages link to 2 to 3 related cluster content pages (recommended)
- Anchor text should be descriptive and include the target keyword of the destination page
- Avoid generic anchor text like "click here" or "read more"

### Example Cluster Structure
```
Pillar: "Complete Guide to Core Web Vitals"
  |
  +-- Cluster: "How to Improve LCP Score"
  +-- Cluster: "INP Optimization Techniques"
  +-- Cluster: "Fixing CLS Issues on WordPress"
  +-- Cluster: "Core Web Vitals Tools Comparison"
  +-- Cluster: "How CWV Affects SEO Rankings"
  +-- Cluster: "Mobile vs Desktop CWV Differences"
```

---

## 2. Hub and Spoke Content Strategy

### Hub Pages
Hub pages serve as navigational and topical anchors for major content categories. They differ from pillar pages in that they are often shorter, more navigational in nature, and designed to guide users to the most relevant spoke content.

### Hub Design Principles
- Organize spokes by user intent or journey stage (awareness, consideration, decision)
- Include brief summaries (2 to 3 sentences) of each spoke page with links
- Feature the most important or highest performing spokes prominently
- Update hub pages when new spokes are published
- Include a clear H1 that targets the primary keyword for the hub topic

### Spoke Content
- Each spoke addresses a distinct angle, question, or subtopic
- Spoke content should stand alone as a complete, valuable resource
- Every spoke links back to the hub page
- Spokes can link laterally to related spokes within the same hub

### Hub vs Pillar: When to Use Each
| Use Case                                    | Recommended Model |
|---------------------------------------------|-------------------|
| Broad educational topic with deep subtopics | Pillar + Cluster  |
| Product or service category with many variations | Hub + Spoke  |
| Resource center or knowledge base           | Hub + Spoke       |
| Single complex topic requiring comprehensive coverage | Pillar + Cluster |

---

## 3. Content Refresh and Pruning Methodology

### Content Audit Process
1. Export all indexed URLs from GSC or Screaming Frog
2. Pull performance data: organic sessions, impressions, clicks, rankings, backlinks
3. Categorize each page into one of four actions: Update, Consolidate, Redirect, or Remove

### Action Framework

#### Update (Refresh)
**Criteria**: The page has traffic potential, existing backlinks, or current rankings but content is outdated or underperforming.
- Refresh statistics, examples, and references
- Expand thin sections or add new sections based on current SERP analysis
- Update the publication date and add a "last updated" notice
- Re optimize title tag and meta description based on current keyword data
- Add structured data if missing
- Target: Complete within 2 to 4 hours per page

#### Consolidate (Merge)
**Criteria**: Multiple pages cover the same topic, causing cannibalization or diluting authority.
- Identify the strongest page (most traffic, backlinks, or rankings) as the consolidation target
- Merge unique content from weaker pages into the target page
- 301 redirect all weaker page URLs to the consolidated page
- Update internal links to point to the consolidated URL
- Target: Complete within 3 to 6 hours per consolidation

#### Redirect
**Criteria**: The page is outdated, irrelevant, or duplicate but has backlinks or external references.
- Identify the most relevant existing page on the site
- Implement a 301 redirect from the old URL to the relevant page
- If no relevant page exists, redirect to the nearest category or parent page
- Document all redirects in a redirect map
- Target: Complete within 30 minutes per redirect

#### Remove (Noindex or Delete)
**Criteria**: The page has no traffic, no backlinks, no business value, and no relevant redirect target.
- Set the page to noindex or remove it entirely
- If removing, ensure no internal links point to the deleted URL
- Monitor for 404 errors in GSC after removal
- Target: Complete within 15 minutes per page

### Pruning Schedule
- Full content audit: Annually
- Quick performance review of underperforming content: Quarterly
- Freshness review of high traffic content: Monthly

---

## 4. Internal Linking Hierarchy

### Silo Structure
Organize the site into topical silos where related content is grouped under common parent pages:

```
Homepage
  |
  +-- Category A (Hub/Pillar)
  |     +-- Subcategory A1
  |     |     +-- Content Page A1a
  |     |     +-- Content Page A1b
  |     +-- Subcategory A2
  |           +-- Content Page A2a
  |
  +-- Category B (Hub/Pillar)
        +-- Subcategory B1
              +-- Content Page B1a
              +-- Content Page B1b
```

### Silo Linking Rules
- Pages within the same silo link to each other freely
- Cross silo links should be contextually relevant and used sparingly
- Every page should be reachable within 3 clicks from the homepage
- Deeper pages should link up to their parent category/subcategory

### Contextual Links
- Place links within the body content where they add value for the reader
- Use descriptive anchor text that includes the target keyword of the destination page
- Aim for 3 to 5 internal links per 1,000 words of content
- Prioritize linking to high value pages (conversion pages, pillar content, underperforming pages with potential)

### Breadcrumbs
- Implement breadcrumb navigation on all pages below the homepage level
- Use BreadcrumbList schema markup on all breadcrumbs
- Breadcrumbs should reflect the site hierarchy: Home > Category > Subcategory > Page
- Breadcrumb text should be concise but descriptive (use the primary keyword of each parent page)

### Internal Link Audit Checklist
- [ ] All pages are reachable within 3 clicks from the homepage
- [ ] No orphan pages exist (pages with zero internal links pointing to them)
- [ ] High priority pages have the most internal links pointing to them
- [ ] Anchor text is descriptive and varied (not all links use the same text)
- [ ] Broken internal links are identified and fixed quarterly
- [ ] Internal link distribution aligns with business priorities

---

## 5. Content Quality Scoring Rubric (E-E-A-T Aligned)

### Scoring Dimensions (Each 0 to 25, Total 0 to 100)

#### Experience (0 to 25)
| Score   | Criteria                                                                |
|---------|-------------------------------------------------------------------------|
| 21 to 25 | Author demonstrates firsthand experience; includes personal examples, case studies, original photos |
| 16 to 20 | Author references relevant experience; includes some original examples  |
| 11 to 15 | Content suggests familiarity with the topic but lacks specific experience evidence |
| 6 to 10  | Generic content with no evidence of firsthand experience                |
| 0 to 5   | Content appears auto generated or scraped with no experience signals    |

#### Expertise (0 to 25)
| Score   | Criteria                                                                |
|---------|-------------------------------------------------------------------------|
| 21 to 25 | Deep technical accuracy; comprehensive coverage; addresses edge cases; cites primary sources |
| 16 to 20 | Accurate and thorough; covers the topic well; references credible sources |
| 11 to 15 | Generally accurate but surface level; misses important nuances          |
| 6 to 10  | Contains inaccuracies or significant gaps in coverage                   |
| 0 to 5   | Factually unreliable or extremely superficial                           |

#### Authoritativeness (0 to 25)
| Score   | Criteria                                                                |
|---------|-------------------------------------------------------------------------|
| 21 to 25 | Published on a recognized authority site; author is a known expert; content is widely cited |
| 16 to 20 | Published on a credible domain; author has relevant credentials displayed |
| 11 to 15 | Domain has moderate authority; author credentials are present but limited |
| 6 to 10  | Low domain authority; no author attribution or credentials              |
| 0 to 5   | Unknown or untrustworthy source; no editorial oversight apparent        |

#### Trustworthiness (0 to 25)
| Score   | Criteria                                                                |
|---------|-------------------------------------------------------------------------|
| 21 to 25 | HTTPS; clear editorial policy; sources cited; transparent about sponsorships; contact info available |
| 16 to 20 | HTTPS; sources generally cited; about page and contact info present     |
| 11 to 15 | HTTPS present; limited sourcing; basic about page                       |
| 6 to 10  | Missing trust signals; no clear editorial standards                     |
| 0 to 5   | No HTTPS; deceptive practices; misleading content                       |

---

## 6. Content Brief Template

Every piece of new content should be produced from a content brief that includes:

### Section 1: Target Keyword Data
- Primary keyword and monthly search volume
- Secondary keywords (3 to 5) with search volume
- Supporting terms (10 to 20) for semantic depth
- Search intent classification (informational, navigational, transactional, commercial investigation)

### Section 2: SERP Analysis
- Top 5 ranking pages: URL, title, word count, content format, key topics covered
- SERP features present: featured snippet, PAA, knowledge panel, video, images
- Content gaps: topics or angles that top ranking pages miss

### Section 3: Content Specifications
- Recommended title tag (under 60 characters, primary keyword included)
- Recommended meta description (under 155 characters)
- Recommended URL slug (short, descriptive, primary keyword included)
- Target word count (based on SERP analysis of top ranking content)
- Content format: guide, list, comparison, tutorial, or other
- Required heading structure (H1, H2s, H3s with suggested text)

### Section 4: Content Requirements
- Key questions the content must answer
- Required sections or subtopics
- Data, statistics, or examples to include
- Internal links to include (specific URLs and anchor text)
- External sources to reference
- Images or media to include (with alt text suggestions)
- Schema markup type to implement (FAQ, HowTo, Article, etc.)

### Section 5: E-E-A-T Requirements
- Author assignment (who should write or review this content)
- Author credentials to display
- Experience signals to include (case studies, examples, original data)
- Sources to cite
- Trust signals to include

---

## 7. Duplicate Content Identification and Resolution

### Detection Methods
- Use Screaming Frog to identify pages with identical or near identical title tags, meta descriptions, or body content
- Use Semrush Site Audit to detect duplicate content issues
- Check for URL parameter variations serving the same content (e.g., with and without trailing slash, www vs non www)
- Search `site:domain.com "exact phrase"` for specific content passages to find duplicates

### Common Duplicate Content Scenarios
| Scenario                                  | Resolution                                                |
|-------------------------------------------|-----------------------------------------------------------|
| HTTP and HTTPS versions accessible        | 301 redirect all HTTP to HTTPS; set canonical to HTTPS    |
| www and non www versions accessible       | 301 redirect one to the other; set canonical consistently  |
| Trailing slash inconsistency              | Choose one format; 301 redirect the other; set canonical   |
| URL parameters creating duplicates        | Canonical to the clean URL; configure parameter handling in GSC |
| Printer friendly or AMP versions          | Set canonical to the primary version                       |
| Syndicated content from third parties     | Use canonical to the original source; add noindex if needed |
| Pagination creating near duplicate pages  | Use rel=canonical to page 1, or rel=prev/next              |

---

## 8. Thin Content Remediation Strategies

### Identifying Thin Content
- Pages with fewer than 300 words and no unique visual or interactive value
- Pages with high bounce rates and low time on page relative to site averages
- Pages generating zero organic traffic over a 6 month period
- Pages flagged by Semrush or Screaming Frog as thin content

### Remediation Options

#### Expand
- Add substantive content: more detail, examples, data, FAQ sections
- Target: Increase to at least 600 words for informational pages, 300 words for product/category pages
- Add supporting media: images, videos, infographics, tables
- Implement relevant schema markup

#### Consolidate
- Merge thin pages covering related subtopics into one comprehensive page
- 301 redirect merged URLs to the consolidated page
- Best for: multiple thin blog posts on similar topics, overlapping product or service pages

#### Differentiate
- If the page serves a legitimate purpose but is thin, add unique value specific to that page
- For product pages: add unique descriptions (not manufacturer copy), customer reviews, usage guides, comparison data
- For location pages: add unique local content, local testimonials, area specific information

#### Remove
- If the page has no traffic, no backlinks, and no business value, remove it
- Set to noindex or 301 redirect to the most relevant remaining page
- Monitor GSC for any impact after removal

### Thin Content Prevention
- Establish minimum content length requirements: 600 words for blog posts, 300 words for product descriptions, 150 words for category introductions
- Require content briefs (Section 6) before content creation
- Include content depth in the editorial review process
- Audit new pages against the E-E-A-T scoring rubric (Section 5) before publication
