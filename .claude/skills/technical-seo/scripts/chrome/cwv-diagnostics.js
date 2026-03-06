/**
 * Core Web Vitals Diagnostics Script
 * Real-time measurement of LCP, CLS, TTFB, TBT, and long tasks.
 * Uses PerformanceObserver and Performance APIs.
 * ES5 compatible - runs via mcp__claude-in-chrome__javascript_tool
 */
(function() {
  "use strict";

  var results = {
    url: window.location.href,
    timestamp: new Date().toISOString(),
    lcp: { value: null, element: null, rating: null },
    cls: { value: 0, shifts: [], rating: null },
    ttfb: { value: null, rating: null },
    tbt: { value: 0, longTaskCount: 0, longestTask: 0 },
    resourceTiming: [],
    navigationTiming: {},
    warnings: [],
    summary: {}
  };

  // Rating thresholds per Google Web Vitals
  function rateLCP(ms) {
    if (ms <= 2500) return "Good";
    if (ms <= 4000) return "Needs Improvement";
    return "Poor";
  }
  function rateCLS(score) {
    if (score <= 0.1) return "Good";
    if (score <= 0.25) return "Needs Improvement";
    return "Poor";
  }
  function rateTTFB(ms) {
    if (ms <= 800) return "Good";
    if (ms <= 1800) return "Needs Improvement";
    return "Poor";
  }

  // --- TTFB from Navigation Timing ---
  try {
    var navEntries = performance.getEntriesByType("navigation");
    if (navEntries && navEntries.length > 0) {
      var nav = navEntries[0];
      results.ttfb.value = Math.round(nav.responseStart - nav.requestStart);
      results.ttfb.rating = rateTTFB(results.ttfb.value);

      results.navigationTiming = {
        dns: Math.round(nav.domainLookupEnd - nav.domainLookupStart),
        tcp: Math.round(nav.connectEnd - nav.connectStart),
        ssl: nav.secureConnectionStart > 0 ? Math.round(nav.connectEnd - nav.secureConnectionStart) : 0,
        ttfb: results.ttfb.value,
        download: Math.round(nav.responseEnd - nav.responseStart),
        domInteractive: Math.round(nav.domInteractive),
        domComplete: Math.round(nav.domComplete),
        loadEvent: Math.round(nav.loadEventEnd - nav.loadEventStart),
        totalTime: Math.round(nav.loadEventEnd - nav.startTime)
      };
    } else if (performance.timing) {
      // Fallback to deprecated performance.timing
      var timing = performance.timing;
      results.ttfb.value = timing.responseStart - timing.requestStart;
      results.ttfb.rating = rateTTFB(results.ttfb.value);
      results.navigationTiming = {
        dns: timing.domainLookupEnd - timing.domainLookupStart,
        tcp: timing.connectEnd - timing.connectStart,
        ttfb: results.ttfb.value,
        domInteractive: timing.domInteractive - timing.navigationStart,
        domComplete: timing.domComplete - timing.navigationStart
      };
    }
  } catch (e) {
    results.warnings.push("Navigation Timing API error: " + e.message);
  }

  // --- LCP from existing PerformanceObserver entries ---
  try {
    var lcpEntries = performance.getEntriesByType("largest-contentful-paint");
    if (lcpEntries && lcpEntries.length > 0) {
      var lastLCP = lcpEntries[lcpEntries.length - 1];
      results.lcp.value = Math.round(lastLCP.startTime);
      results.lcp.rating = rateLCP(results.lcp.value);
      if (lastLCP.element) {
        results.lcp.element = {
          tag: lastLCP.element.tagName.toLowerCase(),
          id: lastLCP.element.id || null,
          className: (lastLCP.element.className || "").toString().substring(0, 80),
          src: lastLCP.element.src || lastLCP.element.currentSrc || null,
          size: lastLCP.size || null
        };
      }
      results.lcp.url = lastLCP.url || null;
    } else {
      results.lcp.value = null;
      results.warnings.push("No LCP entries available. Page may still be loading or observer not active.");
    }
  } catch (e) {
    results.warnings.push("LCP measurement error: " + e.message);
  }

  // --- CLS from layout shift entries ---
  try {
    var layoutShifts = performance.getEntriesByType("layout-shift");
    var clsValue = 0;
    var sessionValue = 0;
    var sessionEntries = [];
    var lastEntryTime = 0;

    for (var s = 0; s < layoutShifts.length; s++) {
      var shift = layoutShifts[s];
      if (!shift.hadRecentInput) {
        // Session window: gap < 1s, window < 5s
        if (shift.startTime - lastEntryTime > 1000 || (sessionEntries.length > 0 && shift.startTime - sessionEntries[0].startTime > 5000)) {
          if (sessionValue > clsValue) {
            clsValue = sessionValue;
          }
          sessionValue = 0;
          sessionEntries = [];
        }
        sessionValue += shift.value;
        sessionEntries.push(shift);
        lastEntryTime = shift.startTime;

        // Record individual shifts
        var shiftDetail = {
          value: Math.round(shift.value * 10000) / 10000,
          time: Math.round(shift.startTime),
          sources: []
        };
        if (shift.sources) {
          for (var src = 0; src < shift.sources.length && src < 3; src++) {
            var srcNode = shift.sources[src].node;
            shiftDetail.sources.push({
              tag: srcNode ? srcNode.tagName.toLowerCase() : "unknown",
              id: srcNode && srcNode.id ? srcNode.id : null,
              className: srcNode ? (srcNode.className || "").toString().substring(0, 60) : null
            });
          }
        }
        results.cls.shifts.push(shiftDetail);
      }
    }
    // Final session check
    if (sessionValue > clsValue) {
      clsValue = sessionValue;
    }
    results.cls.value = Math.round(clsValue * 10000) / 10000;
    results.cls.rating = rateCLS(results.cls.value);
  } catch (e) {
    results.warnings.push("CLS measurement error: " + e.message);
  }

  // --- Long Tasks and TBT ---
  try {
    var longTasks = performance.getEntriesByType("longtask");
    results.tbt.longTaskCount = longTasks.length;
    for (var lt = 0; lt < longTasks.length; lt++) {
      var taskDuration = longTasks[lt].duration;
      var blockingTime = taskDuration - 50; // TBT = time beyond 50ms
      if (blockingTime > 0) {
        results.tbt.value += Math.round(blockingTime);
      }
      if (taskDuration > results.tbt.longestTask) {
        results.tbt.longestTask = Math.round(taskDuration);
      }
    }
    results.tbt.value = Math.round(results.tbt.value);
  } catch (e) {
    results.warnings.push("Long task measurement error: " + e.message);
  }

  // --- Top 10 largest resources by duration ---
  try {
    var resources = performance.getEntriesByType("resource");
    var sorted = resources.slice().sort(function(a, b) { return b.duration - a.duration; });
    var top10 = sorted.slice(0, 10);
    for (var r = 0; r < top10.length; r++) {
      var res = top10[r];
      results.resourceTiming.push({
        name: res.name.substring(0, 120),
        type: res.initiatorType,
        duration: Math.round(res.duration),
        transferSize: res.transferSize || 0,
        startTime: Math.round(res.startTime)
      });
    }
  } catch (e) {
    results.warnings.push("Resource timing error: " + e.message);
  }

  // --- Summary ---
  results.summary = {
    lcpMs: results.lcp.value,
    lcpRating: results.lcp.rating,
    clsScore: results.cls.value,
    clsRating: results.cls.rating,
    ttfbMs: results.ttfb.value,
    ttfbRating: results.ttfb.rating,
    tbtMs: results.tbt.value,
    longTaskCount: results.tbt.longTaskCount,
    overallHealth: "Unknown"
  };

  // Determine overall health
  var ratings = [results.lcp.rating, results.cls.rating, results.ttfb.rating];
  var hasPoor = false;
  var hasNI = false;
  for (var h = 0; h < ratings.length; h++) {
    if (ratings[h] === "Poor") hasPoor = true;
    if (ratings[h] === "Needs Improvement") hasNI = true;
  }
  if (hasPoor) {
    results.summary.overallHealth = "Poor";
  } else if (hasNI) {
    results.summary.overallHealth = "Needs Improvement";
  } else if (results.lcp.value !== null) {
    results.summary.overallHealth = "Good";
  }

  return JSON.stringify(results, null, 2);
})();
