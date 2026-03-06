/**
 * SEO Meta Audit Script
 * Extracts all SEO meta information from the current page.
 * Returns structured JSON with findings, warnings, and recommendations.
 * ES5 compatible - runs via mcp__claude-in-chrome__javascript_tool
 */
(function() {
  "use strict";

  var results = {
    url: window.location.href,
    timestamp: new Date().toISOString(),
    title: { value: null, length: 0, warnings: [] },
    metaDescription: { value: null, length: 0, warnings: [] },
    canonical: null,
    robots: { meta: null, xRobotsTag: null, directives: [] },
    openGraph: {},
    twitterCard: {},
    allMetaTags: [],
    warnings: [],
    summary: { total_issues: 0 }
  };

  // --- Page Title ---
  var titleEl = document.querySelector("title");
  if (titleEl && titleEl.textContent) {
    results.title.value = titleEl.textContent.trim();
    results.title.length = results.title.value.length;
    if (results.title.length < 30) {
      results.title.warnings.push("Title is too short (under 30 characters).");
    }
    if (results.title.length > 60) {
      results.title.warnings.push("Title is too long (over 60 characters). May be truncated in SERPs.");
    }
  } else {
    results.title.warnings.push("CRITICAL: No <title> tag found on the page.");
  }

  // --- Meta Description ---
  var descEl = document.querySelector('meta[name="description"]');
  if (descEl && descEl.getAttribute("content")) {
    results.metaDescription.value = descEl.getAttribute("content").trim();
    results.metaDescription.length = results.metaDescription.value.length;
    if (results.metaDescription.length < 70) {
      results.metaDescription.warnings.push("Meta description is too short (under 70 characters).");
    }
    if (results.metaDescription.length > 160) {
      results.metaDescription.warnings.push("Meta description is too long (over 160 characters). May be truncated.");
    }
  } else {
    results.metaDescription.warnings.push("CRITICAL: No meta description found.");
  }

  // --- Canonical URL ---
  var canonicalEl = document.querySelector('link[rel="canonical"]');
  if (canonicalEl) {
    results.canonical = canonicalEl.getAttribute("href");
    if (results.canonical && results.canonical !== window.location.href) {
      results.warnings.push("Canonical URL differs from current page URL.");
    }
  } else {
    results.warnings.push("No canonical URL specified.");
  }

  // --- Robots Meta Tag ---
  var robotsMeta = document.querySelector('meta[name="robots"]');
  if (robotsMeta) {
    results.robots.meta = robotsMeta.getAttribute("content");
    results.robots.directives = results.robots.meta.split(",").map(function(d) {
      return d.trim().toLowerCase();
    });
    if (results.robots.directives.indexOf("noindex") !== -1) {
      results.warnings.push("WARNING: Page has noindex directive.");
    }
    if (results.robots.directives.indexOf("nofollow") !== -1) {
      results.warnings.push("WARNING: Page has nofollow directive.");
    }
  }

  // --- Open Graph Tags ---
  var ogTags = document.querySelectorAll('meta[property^="og:"]');
  var ogRequired = ["og:title", "og:description", "og:image", "og:url", "og:type"];
  for (var i = 0; i < ogTags.length; i++) {
    var prop = ogTags[i].getAttribute("property");
    results.openGraph[prop] = ogTags[i].getAttribute("content");
  }
  for (var j = 0; j < ogRequired.length; j++) {
    if (!results.openGraph[ogRequired[j]]) {
      results.warnings.push("Missing Open Graph tag: " + ogRequired[j]);
    }
  }

  // --- Twitter Card Tags ---
  var twTags = document.querySelectorAll('meta[name^="twitter:"], meta[property^="twitter:"]');
  for (var t = 0; t < twTags.length; t++) {
    var twName = twTags[t].getAttribute("name") || twTags[t].getAttribute("property");
    results.twitterCard[twName] = twTags[t].getAttribute("content");
  }
  if (!results.twitterCard["twitter:card"]) {
    results.warnings.push("Missing twitter:card meta tag.");
  }

  // --- All Meta Tags Inventory ---
  var allMetas = document.querySelectorAll("meta[name], meta[property], meta[http-equiv]");
  var seenMetas = {};
  for (var m = 0; m < allMetas.length; m++) {
    var meta = allMetas[m];
    var key = meta.getAttribute("name") || meta.getAttribute("property") || meta.getAttribute("http-equiv");
    var content = meta.getAttribute("content") || "";
    results.allMetaTags.push({ attribute: key, content: content });
    // Duplicate detection
    if (seenMetas[key]) {
      results.warnings.push("Duplicate meta tag detected: " + key);
    }
    seenMetas[key] = true;
  }

  // --- Check for multiple canonical tags ---
  var allCanonicals = document.querySelectorAll('link[rel="canonical"]');
  if (allCanonicals.length > 1) {
    results.warnings.push("CRITICAL: Multiple canonical tags found (" + allCanonicals.length + ").");
  }

  // --- Summary ---
  results.summary.total_issues =
    results.title.warnings.length +
    results.metaDescription.warnings.length +
    results.warnings.length;

  return JSON.stringify(results, null, 2);
})();
