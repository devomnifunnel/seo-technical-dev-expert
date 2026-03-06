/**
 * Internal Links Mapper
 * Maps all internal and external links on the current page.
 * Classifies links, extracts anchor text, and identifies link issues.
 * ES5 compatible - runs via mcp__claude-in-chrome__javascript_tool
 */
(function() {
  "use strict";

  var results = {
    url: window.location.href,
    timestamp: new Date().toISOString(),
    internalLinks: [],
    externalLinks: [],
    linkIssues: [],
    anchorTextDistribution: {},
    summary: {
      totalLinks: 0,
      internalCount: 0,
      externalCount: 0,
      nofollowCount: 0,
      issueCount: 0,
      uniqueInternalTargets: 0,
      uniqueExternalDomains: 0
    }
  };

  var currentHost = window.location.hostname;
  var currentOrigin = window.location.origin;
  var allAnchors = document.querySelectorAll("a[href]");
  var seenInternalUrls = {};
  var seenExternalDomains = {};

  for (var i = 0; i < allAnchors.length; i++) {
    var anchor = allAnchors[i];
    var href = anchor.getAttribute("href") || "";
    var rel = anchor.getAttribute("rel") || "";
    var target = anchor.getAttribute("target") || "";
    var rawText = (anchor.textContent || "").trim().replace(/\s+/g, " ");

    // Determine anchor text - check for image-only links
    var imgs = anchor.querySelectorAll("img");
    var isImageOnly = imgs.length > 0 && rawText.length === 0;
    var anchorText = rawText;
    var imageAlt = "";

    if (isImageOnly) {
      imageAlt = imgs[0].getAttribute("alt") || "";
      anchorText = imageAlt ? "[img: " + imageAlt + "]" : "[img: no alt]";
    }

    // Detect link issues
    var issues = [];

    if (href === "#" || href === "") {
      issues.push("Empty or hash-only href");
    }
    if (href.indexOf("javascript:") === 0) {
      issues.push("JavaScript href (not crawlable)");
    }
    if (!anchorText && !isImageOnly) {
      issues.push("Link has no anchor text");
    }
    if (isImageOnly && !imageAlt) {
      issues.push("Image-only link with no alt text");
    }

    // Parse rel attributes
    var relAttrs = rel.toLowerCase().split(/\s+/);
    var hasNofollow = relAttrs.indexOf("nofollow") !== -1;
    var hasSponsored = relAttrs.indexOf("sponsored") !== -1;
    var hasUgc = relAttrs.indexOf("ugc") !== -1;
    var hasNoopener = relAttrs.indexOf("noopener") !== -1;
    var hasNoreferrer = relAttrs.indexOf("noreferrer") !== -1;

    if (hasNofollow) results.summary.nofollowCount++;

    // Classify as internal or external
    var isInternal = false;
    var resolvedUrl = "";

    try {
      var linkUrl = new URL(href, currentOrigin);
      resolvedUrl = linkUrl.href;
      isInternal = linkUrl.hostname === currentHost;
    } catch (e) {
      // Relative URLs or malformed
      if (href.indexOf("mailto:") === 0 || href.indexOf("tel:") === 0) {
        // Skip mailto and tel links from internal/external classification
        continue;
      }
      if (href.indexOf("javascript:") === 0 || href === "#") {
        isInternal = true;
        resolvedUrl = href;
      }
    }

    var linkData = {
      href: href,
      resolvedUrl: resolvedUrl,
      anchorText: anchorText.substring(0, 150),
      rel: rel || null,
      target: target || null,
      nofollow: hasNofollow,
      sponsored: hasSponsored,
      ugc: hasUgc,
      isImageOnly: isImageOnly,
      issues: issues
    };

    if (isInternal) {
      results.internalLinks.push(linkData);
      if (resolvedUrl && !seenInternalUrls[resolvedUrl]) {
        seenInternalUrls[resolvedUrl] = true;
      }
    } else {
      // Extract domain for external links
      try {
        var extDomain = new URL(resolvedUrl).hostname;
        linkData.domain = extDomain;
        if (!seenExternalDomains[extDomain]) {
          seenExternalDomains[extDomain] = true;
        }
      } catch (e) {
        linkData.domain = "unknown";
      }
      results.externalLinks.push(linkData);
    }

    // Track anchor text distribution (for non-empty text)
    if (anchorText && anchorText.length > 0) {
      var normalizedText = anchorText.toLowerCase().substring(0, 80);
      if (!results.anchorTextDistribution[normalizedText]) {
        results.anchorTextDistribution[normalizedText] = 0;
      }
      results.anchorTextDistribution[normalizedText]++;
    }

    // Collect issues
    if (issues.length > 0) {
      results.linkIssues.push({
        href: href,
        anchorText: anchorText.substring(0, 80),
        issues: issues,
        isInternal: isInternal
      });
    }
  }

  // --- Summary ---
  results.summary.totalLinks = allAnchors.length;
  results.summary.internalCount = results.internalLinks.length;
  results.summary.externalCount = results.externalLinks.length;
  results.summary.issueCount = results.linkIssues.length;
  results.summary.uniqueInternalTargets = Object.keys(seenInternalUrls).length;
  results.summary.uniqueExternalDomains = Object.keys(seenExternalDomains).length;

  // Truncate large arrays for output manageability
  if (results.internalLinks.length > 200) {
    results.internalLinks = results.internalLinks.slice(0, 200);
    results.warnings = ["Internal links truncated to 200 (total: " + results.summary.internalCount + ")"];
  }

  return JSON.stringify(results, null, 2);
})();
