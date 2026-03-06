# Link Acquisition and Management Methodology

## Purpose
This framework defines the methodology for evaluating link quality, acquiring new backlinks, optimizing internal links, and managing toxic links. It establishes standards for link building strategy, outreach, digital PR, and ongoing link profile maintenance.

---

## 1. Link Quality Assessment Criteria

Not all links are equal. Evaluate every backlink (existing or prospective) against these five criteria:

### Relevance
- Is the linking site topically related to your site or industry?
- Is the specific page contextually related to the linked content?
- Would the link make sense to a human reader in that context?
- **Score**: Highly relevant (same industry/topic) = strong. Tangentially related = moderate. Completely unrelated = weak or harmful.

### Authority
- What is the domain authority/domain rating of the linking site? (Use Ahrefs DR, Moz DA, or Semrush Authority Score)
- Does the linking site have its own strong backlink profile?
- Is the linking site a recognized brand or publication in its space?
- **Thresholds**: DR/DA 60+ = high authority. 30 to 59 = moderate authority. Under 30 = low authority.

### Traffic
- Does the linking page receive organic traffic? (Check in Ahrefs or Semrush)
- A link from a page with traffic signals that search engines value and crawl that page regularly
- Links from zero traffic pages provide diminished value
- **Threshold**: Pages with 100+ organic visits per month are high value link targets.

### Placement
- Is the link within the main body content (editorial/contextual) or in the sidebar, footer, author bio, or comment section?
- Contextual links within the body content carry the most weight
- Header/footer links and blogroll links carry less weight and may appear manipulative at scale
- **Ideal**: Contextual placement within the first half of the content body

### Anchor Text
- Is the anchor text natural and descriptive?
- Does it include a relevant keyword without being over optimized?
- Is the anchor text distribution across all backlinks varied and natural looking?
- **Risk**: Excessive exact match anchor text is a manipulation signal and can trigger penalties

### Link Quality Scoring Matrix
| Criterion   | Strong (3 pts) | Moderate (2 pts) | Weak (1 pt)   | Harmful (0 pts)     |
|-------------|-----------------|-------------------|----------------|---------------------|
| Relevance   | Same industry    | Related industry   | Tangential     | Completely unrelated |
| Authority   | DR 60+           | DR 30 to 59        | DR 10 to 29    | DR under 10          |
| Traffic     | 100+ visits/mo   | 10 to 99 visits/mo | Under 10       | Zero traffic         |
| Placement   | Body contextual  | Author bio         | Sidebar/footer | Comment/forum spam   |
| Anchor text | Natural, varied  | Slightly optimized | Generic only   | Exact match spam     |

**Score interpretation**: 12 to 15 = excellent link. 8 to 11 = good link. 5 to 7 = marginal link. Under 5 = avoid or disavow.

---

## 2. Outreach Strategy Framework

### Phase 1: Prospecting
Identify potential link targets using these methods:
- **Competitor backlink analysis**: Export competitors' backlinks from Ahrefs or Semrush; identify sites that link to multiple competitors but not to you
- **Resource page discovery**: Search `"keyword" + "resources"` or `"keyword" + "useful links"` to find curated resource lists
- **Broken link discovery**: Use Ahrefs Broken Backlinks report on competitors to find opportunities to offer replacement content
- **Guest posting targets**: Identify industry blogs and publications that accept contributor content
- **Unlinked brand mentions**: Use brand monitoring tools to find sites that mention your brand but do not link to you

### Phase 2: Qualifying
Filter prospects through quality criteria before outreach:
- [ ] Domain Rating/Authority above 30
- [ ] Site is topically relevant to your industry
- [ ] Site publishes original, quality content (not a link farm or PBN)
- [ ] Site has real organic traffic (check in Semrush or Ahrefs)
- [ ] Contact information is available (email, contact form, or social media)
- [ ] Site is actively maintained (recent posts within the last 3 months)

### Phase 3: Personalized Outreach
- Reference a specific article or resource on the prospect's site
- Explain why your content is relevant to their audience
- Offer genuine value: a better resource, updated data, expert quote, or complementary content
- Keep the initial email concise (under 150 words)
- Do not use mass email templates with generic flattery
- Subject lines should be specific and relevant, not clickbait

### Phase 4: Follow Up
- Send a follow up email 5 to 7 business days after the initial outreach if no response
- Add new information or a different angle in the follow up (do not just resend the same email)
- Limit follow ups to 2 total (initial + one follow up)
- Track all outreach in a CRM or spreadsheet: date sent, response, outcome

### Outreach Metrics
| Metric                 | Benchmark       |
|------------------------|-----------------|
| Response rate          | 5% to 15%       |
| Link placement rate    | 2% to 8%        |
| Average emails per link| 15 to 50         |
| Time to placement      | 2 to 6 weeks    |

---

## 3. Digital PR Methodology

### Newsworthy Content Types
- **Original research and data studies**: Surveys, data analysis, industry reports with proprietary findings
- **Expert commentary**: Timely responses to industry news, regulatory changes, or trending topics
- **Data visualization**: Interactive tools, calculators, or infographics that journalists embed or reference
- **Trend reports**: Annual or quarterly industry trend analysis with data backed insights
- **Controversial or contrarian takes**: Well reasoned perspectives that challenge conventional wisdom (backed by evidence)

### HARO and Journalist Outreach
- Monitor HARO (Help a Reporter Out), Qwoted, and SourceBottle for relevant journalist queries
- Respond within 2 hours of query publication (speed is critical)
- Provide concise, quotable responses with specific data points or examples
- Include author credentials and a brief bio
- Follow up only if the journalist has indicated interest

### Digital PR Process
1. **Ideation**: Generate 3 to 5 campaign concepts per quarter based on industry trends, seasonal topics, and data availability
2. **Creation**: Produce the content asset (research report, data study, interactive tool)
3. **Media list**: Build a targeted list of 50 to 100 journalists and publications that cover the relevant beat
4. **Pitch**: Craft personalized pitches that lead with the newsworthy angle, not the link request
5. **Distribution**: Send pitches, follow up, and manage placements
6. **Amplification**: Promote earned coverage on social media and through email newsletters

### Digital PR Success Metrics
| Metric                   | Target per Campaign |
|--------------------------|---------------------|
| Media placements         | 10 to 30            |
| Links earned             | 5 to 20             |
| Average linking domain DR| 50+                 |
| Social shares            | 100+                |
| Referral traffic         | Measurable increase |

---

## 4. Internal Linking Optimization

### Crawl Depth Reduction
- Ensure high priority pages are accessible within 2 clicks from the homepage
- Add prominent category and subcategory links in main navigation
- Use breadcrumbs to provide upward navigation paths
- Add "related content" or "related products" sections to push link equity to deeper pages
- Review crawl depth report in Screaming Frog; flag any priority page at depth 4+

### PageRank Distribution
- Link from high authority pages (homepage, top landing pages) to priority pages that need ranking improvement
- Avoid distributing link equity to low value pages (privacy policy, terms of service) through excessive internal linking
- Use `rel="nofollow"` on internal links to login pages, cart pages, and other non indexable pages (optional, as Google may treat this as a hint)
- Monitor internal link distribution using Screaming Frog or Sitebulb; identify pages with disproportionately few inbound internal links

### Contextual Relevance
- Internal links should be editorially relevant to the surrounding content
- Anchor text should describe the destination page content, not just "click here" or "learn more"
- Vary anchor text slightly across different linking pages to avoid over optimization
- Place the most important internal links higher in the content where they are more likely to be seen and clicked

### Internal Link Audit Process
1. Crawl the site with Screaming Frog or Sitebulb
2. Export the internal linking report
3. Identify orphan pages (0 inbound internal links)
4. Identify high priority pages with fewer than 5 inbound internal links
5. Map new internal links from topically relevant, high authority pages
6. Implement changes and verify in the next crawl

---

## 5. Toxic Link Identification

### Spam Signals
- Links from sites with extremely high outbound link counts (100+ external links per page)
- Links from sites in unrelated languages or countries with no business connection
- Links from known link networks or private blog networks (PBNs)
- Links with exact match anchor text from irrelevant sites
- Links from sites with no organic traffic and no real content
- Links from pages that exist solely to host outbound links (link directories, link exchange pages)

### Link Network Indicators
- Multiple linking domains share the same IP address or hosting provider
- Linking sites have nearly identical designs, content structures, or footprints
- All links use the same anchor text or link to the same target page
- Linking sites were registered around the same time with similar WHOIS data

### Toxic Link Audit Process
1. Export the full backlink profile from Ahrefs, Semrush, and GSC
2. Combine and deduplicate the data
3. Flag links with Semrush Toxic Score above 60 or Ahrefs Spam Score above 30
4. Manually review flagged links to confirm toxicity (automated scores have false positives)
5. Categorize confirmed toxic links: spammy directories, PBNs, hacked sites, link farms, irrelevant foreign sites
6. Document all toxic links with evidence of toxicity

---

## 6. Disavow Process

### When to Disavow
- Only disavow when there is evidence of a manual penalty or algorithmic impact from toxic links
- Do not preemptively disavow links; Google's algorithms generally ignore low quality links without action needed
- Disavow when a manual action notification appears in GSC citing unnatural links
- Consider disavow if a significant negative SEO attack has been identified

### Disavow Process Steps
1. **Audit**: Complete the toxic link audit (Section 5)
2. **Outreach first**: Attempt to contact webmasters of toxic linking sites and request link removal. Document all outreach attempts.
3. **Document**: Create a spreadsheet documenting every toxic link: URL, domain, toxic score, outreach date, response
4. **Create disavow file**: Format the disavow file according to Google's specifications
   - Use `domain:example.com` to disavow all links from a domain
   - Use individual URLs only when some links from a domain are valuable
5. **Submit**: Upload the disavow file through Google Search Console's Disavow Tool
6. **Monitor**: Track ranking and traffic changes over the following 4 to 8 weeks
7. **Iterate**: Re audit quarterly; update the disavow file as needed

### Disavow File Format
```
# Disavow file for example.com
# Generated: [date]
# Reason: Manual action for unnatural inbound links

# Spammy directory links
domain:spamdirectory1.com
domain:spamdirectory2.com

# Individual toxic URLs from otherwise acceptable domains
https://example-site.com/spammy-guest-post
```

---

## 7. Anchor Text Distribution Targets

### Healthy Anchor Text Profile
A natural backlink profile contains a mix of anchor text types. Over optimization of exact match anchors is a penalty risk.

| Anchor Text Type   | Target Distribution | Description                                      |
|--------------------|---------------------|--------------------------------------------------|
| Branded            | 30% to 40%          | Company name, brand name, brand + keyword        |
| URL                | 15% to 25%          | Naked URL, shortened URL                         |
| Exact match        | 5% to 10%           | Exact target keyword                             |
| Partial match      | 10% to 15%          | Target keyword with additional words              |
| Generic            | 10% to 15%          | "Click here," "this article," "learn more"       |
| Topical/Natural    | 10% to 20%          | Natural phrases related to the topic              |

### Monitoring Anchor Text Distribution
- Export anchor text report from Ahrefs or Semrush monthly
- Compare against the target distribution above
- Flag any anchor text type that exceeds its target range
- If exact match anchors exceed 15%, investigate and consider diversifying future link building efforts

### Corrective Actions
- If exact match is over concentrated, focus future outreach on earning branded and natural anchor text links
- If generic anchors dominate, request descriptive anchor text in future placements where appropriate
- For existing over optimized anchors, contact webmasters to request anchor text updates (low success rate, but worth attempting for egregious cases)
- Diversify anchor text naturally by earning links through digital PR and content marketing, which naturally produce varied anchor text

---

## 8. Link Building Integration with SEO Strategy

### Alignment with Content Strategy
- Reference content-architecture.md for topic cluster and pillar page strategy
- Prioritize link building to pillar pages and key landing pages
- Create linkable assets (original research, tools, comprehensive guides) as part of the content plan
- Internal linking should amplify the value of external links by distributing equity to priority pages

### Link Building Cadence
| Activity                    | Frequency    | Expected Output            |
|-----------------------------|--------------|----------------------------|
| Competitor backlink analysis| Monthly      | 20 to 50 new prospects      |
| Outreach campaigns          | Ongoing      | 5 to 15 new links per month |
| Digital PR campaigns        | Quarterly    | 10 to 30 links per campaign |
| HARO/journalist responses   | Daily        | 2 to 5 links per month      |
| Internal link optimization  | Quarterly    | 50 to 100 new internal links|
| Toxic link audit            | Quarterly    | Clean backlink profile       |
| Anchor text review          | Monthly      | Balanced distribution        |
