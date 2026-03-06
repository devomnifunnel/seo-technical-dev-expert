/**
 * JavaScript Rendering Check Script
 * Compares pre-render vs post-render content for SPA SEO analysis.
 * Detects frameworks, checks noscript content, identifies JS-dependent content.
 * ES5 compatible - runs via mcp__claude-in-chrome__javascript_tool
 */
(function() {
  "use strict";

  var results = {
    url: window.location.href,
    timestamp: new Date().toISOString(),
    framework: { detected: [], signals: [] },
    renderedState: {
      title: null,
      metaDescription: null,
      canonical: null,
      h1: null,
      h1Count: 0,
      linkCount: 0,
      contentWordCount: 0
    },
    noscriptContent: [],
    jsDependencyIssues: [],
    spaSignals: [],
    warnings: []
  };

  // --- Framework Detection ---
  var frameworkChecks = [
    { name: "React", tests: [
      function() { return !!window.React; },
      function() { return !!document.querySelector("[data-reactroot], [data-reactid]"); },
      function() { return !!window.__REACT_DEVTOOLS_GLOBAL_HOOK__; }
    ]},
    { name: "Angular", tests: [
      function() { return !!window.angular; },
      function() { return !!document.querySelector("[ng-app], [data-ng-app], [ng-controller]"); },
      function() { return !!document.querySelector("app-root, [_nghost], [_ngcontent]"); },
      function() { return !!window.getAllAngularRootElements; }
    ]},
    { name: "Vue", tests: [
      function() { return !!window.Vue || !!window.__VUE__; },
      function() { return !!document.querySelector("[data-v-], [v-cloak]"); },
      function() { return !!window.__VUE_DEVTOOLS_GLOBAL_HOOK__; }
    ]},
    { name: "Next.js", tests: [
      function() { return !!window.__NEXT_DATA__; },
      function() { return !!document.querySelector("#__next"); }
    ]},
    { name: "Nuxt.js", tests: [
      function() { return !!window.__NUXT__; },
      function() { return !!document.querySelector("#__nuxt, #__layout"); }
    ]},
    { name: "Gatsby", tests: [
      function() { return !!document.querySelector("#___gatsby"); },
      function() { return !!window.___loader; }
    ]},
    { name: "Backbone", tests: [
      function() { return !!window.Backbone; }
    ]},
    { name: "Ember", tests: [
      function() { return !!window.Ember || !!window.Em; },
      function() { return !!document.querySelector("[id^='ember']"); }
    ]},
    { name: "Svelte", tests: [
      function() { return !!document.querySelector("[class*='svelte-']"); }
    ]},
    { name: "jQuery", tests: [
      function() { return !!window.jQuery || !!window.$; }
    ]}
  ];

  for (var f = 0; f < frameworkChecks.length; f++) {
    var fw = frameworkChecks[f];
    for (var t = 0; t < fw.tests.length; t++) {
      try {
        if (fw.tests[t]()) {
          if (results.framework.detected.indexOf(fw.name) === -1) {
            results.framework.detected.push(fw.name);
          }
          break;
        }
      } catch (e) {
        // Ignore detection errors
      }
    }
  }

  // --- Capture current rendered state ---
  var titleEl = document.querySelector("title");
  results.renderedState.title = titleEl ? titleEl.textContent.trim() : null;

  var descEl = document.querySelector('meta[name="description"]');
  results.renderedState.metaDescription = descEl ? descEl.getAttribute("content") : null;

  var canonEl = document.querySelector('link[rel="canonical"]');
  results.renderedState.canonical = canonEl ? canonEl.getAttribute("href") : null;

  var h1Els = document.querySelectorAll("h1");
  results.renderedState.h1Count = h1Els.length;
  results.renderedState.h1 = h1Els.length > 0 ? h1Els[0].textContent.trim().substring(0, 200) : null;

  results.renderedState.linkCount = document.querySelectorAll("a[href]").length;

  var mainContent = document.querySelector("main, article, [role='main'], #content, .content");
  var contentRoot = mainContent || document.body;
  var text = contentRoot.innerText || "";
  results.renderedState.contentWordCount = text.trim().split(/\s+/).filter(function(w) { return w.length > 0; }).length;

  // --- Analyze initial HTML source for JS dependency ---
  var htmlSource = document.documentElement.innerHTML;

  // Check if key SEO elements are present in the source HTML
  var sourceChecks = [
    { name: "title", present: /<title[^>]*>[^<]+<\/title>/i.test(htmlSource), critical: true },
    { name: "meta description", present: /<meta[^>]*name=["']description["'][^>]*content=["'][^"']+["'][^>]*>/i.test(htmlSource), critical: true },
    { name: "h1", present: /<h1[^>]*>[^<]*\S[^<]*<\/h1>/i.test(htmlSource), critical: true },
    { name: "canonical", present: /<link[^>]*rel=["']canonical["'][^>]*>/i.test(htmlSource), critical: true }
  ];

  for (var sc = 0; sc < sourceChecks.length; sc++) {
    var check = sourceChecks[sc];
    if (!check.present && results.renderedState[check.name === "meta description" ? "metaDescription" : check.name]) {
      results.jsDependencyIssues.push({
        element: check.name,
        issue: "Present in rendered DOM but may be JavaScript-generated",
        severity: check.critical ? "high" : "medium"
      });
    }
  }

  // --- SPA signals ---
  if (document.querySelector("#app, #root, #__next, #__nuxt, #___gatsby, app-root")) {
    results.spaSignals.push("Single root mount point detected (SPA pattern).");
  }

  var bodyScripts = document.querySelectorAll("body > script[src]");
  if (bodyScripts.length > 3) {
    results.spaSignals.push("Multiple script bundles loaded in body (" + bodyScripts.length + ").");
  }

  // Check for dynamic content loading indicators
  if (document.querySelector("[data-loading], .loading, .spinner, [v-cloak]")) {
    results.spaSignals.push("Client-side loading indicators found in DOM.");
  }

  // --- Noscript content ---
  var noscripts = document.querySelectorAll("noscript");
  for (var n = 0; n < noscripts.length; n++) {
    var nsContent = noscripts[n].textContent.trim();
    if (nsContent.length > 0) {
      results.noscriptContent.push(nsContent.substring(0, 300));
    }
  }

  if (noscripts.length === 0 && results.framework.detected.length > 0) {
    results.warnings.push("No <noscript> fallback found despite JavaScript framework detected.");
  }

  // --- Warnings ---
  if (results.jsDependencyIssues.length > 0) {
    results.warnings.push(results.jsDependencyIssues.length + " SEO-critical elements may depend on JavaScript rendering.");
  }

  if (results.framework.detected.length > 0 && results.renderedState.contentWordCount < 100) {
    results.warnings.push("Low word count with JS framework detected. Content may not be server-side rendered.");
  }

  return JSON.stringify(results, null, 2);
})();
