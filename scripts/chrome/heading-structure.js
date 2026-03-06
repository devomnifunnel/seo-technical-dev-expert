/**
 * Heading Structure Analyzer
 * Analyzes H1-H6 hierarchy and content structure of the current page.
 * Returns heading tree, hierarchy issues, and content metrics.
 * ES5 compatible - runs via mcp__claude-in-chrome__javascript_tool
 */
(function() {
  "use strict";

  var results = {
    url: window.location.href,
    timestamp: new Date().toISOString(),
    headings: [],
    headingCounts: { h1: 0, h2: 0, h3: 0, h4: 0, h5: 0, h6: 0 },
    hierarchyIssues: [],
    contentMetrics: {
      wordCount: 0,
      paragraphCount: 0,
      listCount: 0,
      imageCount: 0,
      tableCount: 0,
      videoCount: 0,
      iframeCount: 0
    },
    warnings: [],
    summary: {}
  };

  // --- Extract all headings in DOM order ---
  var headingEls = document.querySelectorAll("h1, h2, h3, h4, h5, h6");
  var previousLevel = 0;

  for (var i = 0; i < headingEls.length; i++) {
    var el = headingEls[i];
    var tagName = el.tagName.toLowerCase();
    var level = parseInt(tagName.charAt(1), 10);
    var text = el.textContent.trim().replace(/\s+/g, " ");
    var isHidden = false;

    // Check if heading is visually hidden
    var style = window.getComputedStyle(el);
    if (style.display === "none" || style.visibility === "hidden" || style.opacity === "0") {
      isHidden = true;
    }

    results.headings.push({
      tag: tagName,
      level: level,
      text: text.substring(0, 200),
      hidden: isHidden,
      id: el.id || null
    });

    results.headingCounts[tagName]++;

    // --- Hierarchy validation ---
    if (previousLevel > 0 && level > previousLevel + 1) {
      results.hierarchyIssues.push({
        issue: "Skipped heading level",
        detail: "Jumped from H" + previousLevel + " to H" + level + " (missing H" + (previousLevel + 1) + ")",
        headingText: text.substring(0, 80),
        index: i
      });
    }

    if (i === 0 && level !== 1) {
      results.hierarchyIssues.push({
        issue: "First heading is not H1",
        detail: "Page starts with " + tagName.toUpperCase() + " instead of H1",
        headingText: text.substring(0, 80),
        index: 0
      });
    }

    previousLevel = level;
  }

  // --- H1 count validation ---
  if (results.headingCounts.h1 === 0) {
    results.warnings.push("CRITICAL: No H1 tag found on the page.");
  } else if (results.headingCounts.h1 > 1) {
    results.warnings.push("Multiple H1 tags found (" + results.headingCounts.h1 + "). Best practice is exactly one H1.");
  }

  if (headingEls.length === 0) {
    results.warnings.push("No headings found on the page. Add heading structure for accessibility and SEO.");
  }

  // --- Content Metrics ---
  // Attempt to identify main content area
  var mainContent = document.querySelector("main, [role='main'], article, #content, .content, #main, .main");
  var contentRoot = mainContent || document.body;

  // Word count - extract visible text from content area
  var textContent = contentRoot.innerText || contentRoot.textContent || "";
  var words = textContent.trim().split(/\s+/).filter(function(w) { return w.length > 0; });
  results.contentMetrics.wordCount = words.length;

  // Paragraph count
  results.contentMetrics.paragraphCount = contentRoot.querySelectorAll("p").length;

  // List count (ul + ol)
  results.contentMetrics.listCount =
    contentRoot.querySelectorAll("ul").length +
    contentRoot.querySelectorAll("ol").length;

  // Image count
  results.contentMetrics.imageCount = contentRoot.querySelectorAll("img").length;

  // Table count
  results.contentMetrics.tableCount = contentRoot.querySelectorAll("table").length;

  // Video count (video elements + common embed iframes)
  results.contentMetrics.videoCount = contentRoot.querySelectorAll("video").length;
  var iframes = contentRoot.querySelectorAll("iframe");
  results.contentMetrics.iframeCount = iframes.length;
  for (var vi = 0; vi < iframes.length; vi++) {
    var src = iframes[vi].getAttribute("src") || "";
    if (src.indexOf("youtube") !== -1 || src.indexOf("vimeo") !== -1 || src.indexOf("wistia") !== -1) {
      results.contentMetrics.videoCount++;
    }
  }

  // --- Content warnings ---
  if (results.contentMetrics.wordCount < 300) {
    results.warnings.push("Thin content detected: only " + results.contentMetrics.wordCount + " words. Consider adding more content (300+ words minimum).");
  }

  if (results.contentMetrics.paragraphCount > 0 && results.contentMetrics.imageCount === 0) {
    results.warnings.push("No images found in content area. Visual content can improve engagement.");
  }

  // --- Summary ---
  results.summary = {
    totalHeadings: headingEls.length,
    hierarchyIssueCount: results.hierarchyIssues.length,
    warningCount: results.warnings.length,
    hasProperH1: results.headingCounts.h1 === 1,
    contentArea: mainContent ? mainContent.tagName.toLowerCase() : "body (fallback)"
  };

  return JSON.stringify(results, null, 2);
})();
