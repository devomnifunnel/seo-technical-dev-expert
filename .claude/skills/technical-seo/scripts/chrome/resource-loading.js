/**
 * Resource Loading Analyzer
 * Analyzes resource loading order, priorities, render-blocking resources,
 * resource hints, page weight, and third-party inventory.
 * ES5 compatible - runs via mcp__claude-in-chrome__javascript_tool
 */
(function() {
  "use strict";

  var results = {
    url: window.location.href,
    timestamp: new Date().toISOString(),
    resourceInventory: { scripts: [], stylesheets: [], images: [], fonts: [], other: [] },
    renderBlocking: [],
    resourceHints: { preconnect: [], prefetch: [], preload: [], dnsPrefetch: [] },
    pageWeight: { total: 0, scripts: 0, stylesheets: 0, images: 0, fonts: 0, other: 0 },
    thirdParty: {},
    unusedPreloads: [],
    warnings: [],
    summary: {}
  };

  var currentHost = window.location.hostname;

  // Helper: check if URL is third-party
  function isThirdParty(url) {
    try {
      var host = new URL(url).hostname;
      // Same domain or subdomain
      if (host === currentHost) return false;
      var baseDomain = currentHost.split(".").slice(-2).join(".");
      var resourceDomain = host.split(".").slice(-2).join(".");
      return baseDomain !== resourceDomain;
    } catch (e) {
      return false;
    }
  }

  // Helper: classify resource type from initiatorType or URL
  function classifyResource(entry) {
    var type = entry.initiatorType;
    if (type === "script") return "scripts";
    if (type === "link" || type === "css") return "stylesheets";
    if (type === "img" || type === "image") return "images";
    var name = entry.name.toLowerCase();
    if (name.indexOf(".js") !== -1) return "scripts";
    if (name.indexOf(".css") !== -1) return "stylesheets";
    if (name.match(/\.(woff2?|ttf|otf|eot)(\?|$)/)) return "fonts";
    if (name.match(/\.(jpg|jpeg|png|gif|webp|avif|svg|ico)(\?|$)/)) return "images";
    if (type === "font" || name.indexOf("font") !== -1) return "fonts";
    return "other";
  }

  // Helper: format bytes
  function formatBytes(bytes) {
    if (bytes < 1024) return bytes + " B";
    if (bytes < 1048576) return Math.round(bytes / 1024) + " KB";
    return (bytes / 1048576).toFixed(2) + " MB";
  }

  // --- Process all resource timing entries ---
  var resources = performance.getEntriesByType("resource");

  for (var i = 0; i < resources.length; i++) {
    var res = resources[i];
    var category = classifyResource(res);
    var transferSize = res.transferSize || 0;
    var isTP = isThirdParty(res.name);

    var entry = {
      url: res.name.substring(0, 150),
      type: res.initiatorType,
      transferSize: transferSize,
      transferSizeFormatted: formatBytes(transferSize),
      duration: Math.round(res.duration),
      startTime: Math.round(res.startTime),
      isThirdParty: isTP
    };

    results.resourceInventory[category].push(entry);
    results.pageWeight[category] += transferSize;
    results.pageWeight.total += transferSize;

    // Track third-party resources by domain
    if (isTP) {
      try {
        var domain = new URL(res.name).hostname;
        if (!results.thirdParty[domain]) {
          results.thirdParty[domain] = { count: 0, totalSize: 0, types: [] };
        }
        results.thirdParty[domain].count++;
        results.thirdParty[domain].totalSize += transferSize;
        if (results.thirdParty[domain].types.indexOf(category) === -1) {
          results.thirdParty[domain].types.push(category);
        }
      } catch (e) {
        // Skip malformed URLs
      }
    }
  }

  // --- Identify render-blocking resources ---
  // Scripts in head without defer or async
  var headScripts = document.querySelectorAll("head script[src]");
  for (var hs = 0; hs < headScripts.length; hs++) {
    var script = headScripts[hs];
    var hasDefer = script.hasAttribute("defer");
    var hasAsync = script.hasAttribute("async");
    var scriptType = script.getAttribute("type") || "";

    // Module scripts are deferred by default
    if (!hasDefer && !hasAsync && scriptType !== "module") {
      results.renderBlocking.push({
        type: "script",
        url: (script.getAttribute("src") || "").substring(0, 150),
        suggestion: "Add defer or async attribute"
      });
    }
  }

  // Stylesheets without media query limiting
  var styleLinks = document.querySelectorAll('link[rel="stylesheet"]');
  for (var sl = 0; sl < styleLinks.length; sl++) {
    var link = styleLinks[sl];
    var media = link.getAttribute("media");
    // Stylesheets with media="all" or no media are render-blocking
    if (!media || media === "all" || media === "screen") {
      results.renderBlocking.push({
        type: "stylesheet",
        url: (link.getAttribute("href") || "").substring(0, 150),
        media: media || "none (default: all)",
        suggestion: "Consider critical CSS inlining or media query scoping"
      });
    }
  }

  // --- Resource hints ---
  var hintTypes = [
    { rel: "preconnect", key: "preconnect" },
    { rel: "prefetch", key: "prefetch" },
    { rel: "preload", key: "preload" },
    { rel: "dns-prefetch", key: "dnsPrefetch" }
  ];

  for (var h = 0; h < hintTypes.length; h++) {
    var hintLinks = document.querySelectorAll('link[rel="' + hintTypes[h].rel + '"]');
    for (var hl = 0; hl < hintLinks.length; hl++) {
      var hintLink = hintLinks[hl];
      results.resourceHints[hintTypes[h].key].push({
        href: (hintLink.getAttribute("href") || "").substring(0, 150),
        as: hintLink.getAttribute("as") || null,
        crossorigin: hintLink.hasAttribute("crossorigin")
      });
    }
  }

  // --- Check for unused preloads ---
  var preloads = document.querySelectorAll('link[rel="preload"]');
  for (var p = 0; p < preloads.length; p++) {
    var preloadHref = preloads[p].getAttribute("href") || "";
    var wasUsed = false;
    for (var ri = 0; ri < resources.length; ri++) {
      if (resources[ri].name.indexOf(preloadHref) !== -1) {
        wasUsed = true;
        break;
      }
    }
    if (!wasUsed && preloadHref) {
      results.unusedPreloads.push({
        href: preloadHref.substring(0, 150),
        as: preloads[p].getAttribute("as") || null
      });
    }
  }

  // --- Format page weight ---
  var weightFormatted = {};
  var categories = ["total", "scripts", "stylesheets", "images", "fonts", "other"];
  for (var w = 0; w < categories.length; w++) {
    weightFormatted[categories[w]] = formatBytes(results.pageWeight[categories[w]]);
  }

  // --- Warnings ---
  if (results.renderBlocking.length > 0) {
    results.warnings.push(results.renderBlocking.length + " render-blocking resources detected.");
  }
  if (results.unusedPreloads.length > 0) {
    results.warnings.push(results.unusedPreloads.length + " unused preload(s) detected. These waste bandwidth.");
  }
  if (results.pageWeight.total > 3145728) {
    results.warnings.push("Total page weight exceeds 3 MB (" + formatBytes(results.pageWeight.total) + ").");
  }
  var tpDomains = Object.keys(results.thirdParty);
  if (tpDomains.length > 10) {
    results.warnings.push("High number of third-party domains (" + tpDomains.length + "). Consider reducing for performance.");
  }
  if (results.resourceHints.preconnect.length === 0 && tpDomains.length > 0) {
    results.warnings.push("No preconnect hints found despite third-party resources. Consider preconnecting critical origins.");
  }

  // --- Summary ---
  results.summary = {
    totalResources: resources.length,
    resourcesByType: {
      scripts: results.resourceInventory.scripts.length,
      stylesheets: results.resourceInventory.stylesheets.length,
      images: results.resourceInventory.images.length,
      fonts: results.resourceInventory.fonts.length,
      other: results.resourceInventory.other.length
    },
    pageWeight: weightFormatted,
    renderBlockingCount: results.renderBlocking.length,
    thirdPartyDomains: tpDomains.length,
    resourceHintCount: results.resourceHints.preconnect.length + results.resourceHints.prefetch.length + results.resourceHints.preload.length + results.resourceHints.dnsPrefetch.length,
    warningCount: results.warnings.length
  };

  return JSON.stringify(results, null, 2);
})();
