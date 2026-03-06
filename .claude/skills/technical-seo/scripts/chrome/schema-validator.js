/**
 * Schema Validator Script
 * Extracts and validates all JSON-LD structured data on the current page.
 * Checks required properties per schema type and common errors.
 * ES5 compatible - runs via mcp__claude-in-chrome__javascript_tool
 */
(function() {
  "use strict";

  var results = {
    url: window.location.href,
    timestamp: new Date().toISOString(),
    schemasFound: 0,
    schemas: [],
    validationErrors: [],
    warnings: [],
    recommendations: []
  };

  // Required properties by schema type
  var requiredProps = {
    "Product": ["name", "image", "description"],
    "Organization": ["name", "url"],
    "LocalBusiness": ["name", "address", "telephone"],
    "Article": ["headline", "author", "datePublished", "image"],
    "NewsArticle": ["headline", "author", "datePublished", "image"],
    "BlogPosting": ["headline", "author", "datePublished"],
    "FAQPage": ["mainEntity"],
    "BreadcrumbList": ["itemListElement"],
    "WebSite": ["name", "url"],
    "WebPage": ["name"],
    "Person": ["name"],
    "Event": ["name", "startDate", "location"],
    "Recipe": ["name", "image", "author"],
    "Review": ["itemReviewed", "author"],
    "VideoObject": ["name", "description", "thumbnailUrl", "uploadDate"],
    "HowTo": ["name", "step"],
    "SoftwareApplication": ["name", "operatingSystem"]
  };

  // Recommended properties by schema type (for warnings, not errors)
  var recommendedProps = {
    "Product": ["offers", "aggregateRating", "brand", "sku"],
    "Article": ["publisher", "dateModified", "mainEntityOfPage"],
    "LocalBusiness": ["openingHours", "geo", "image"],
    "Organization": ["logo", "sameAs", "contactPoint"]
  };

  // Find all JSON-LD script blocks
  var scripts = document.querySelectorAll('script[type="application/ld+json"]');
  results.schemasFound = scripts.length;

  if (scripts.length === 0) {
    results.warnings.push("No JSON-LD structured data found on this page.");
    results.recommendations.push("Add JSON-LD structured data relevant to your page content.");
    return JSON.stringify(results, null, 2);
  }

  for (var i = 0; i < scripts.length; i++) {
    var rawText = scripts[i].textContent.trim();
    var schemaEntry = { index: i, raw: rawText, parsed: null, type: null, errors: [], warnings: [] };

    // Attempt to parse JSON
    try {
      schemaEntry.parsed = JSON.parse(rawText);
    } catch (e) {
      schemaEntry.errors.push("JSON parse error: " + e.message);
      results.validationErrors.push("Schema #" + i + ": Invalid JSON - " + e.message);
      results.schemas.push(schemaEntry);
      continue;
    }

    var data = schemaEntry.parsed;

    // Handle @graph arrays by flattening for validation
    var itemsToValidate = [];
    if (data["@graph"] && Array.isArray(data["@graph"])) {
      for (var g = 0; g < data["@graph"].length; g++) {
        itemsToValidate.push(data["@graph"][g]);
      }
    } else {
      itemsToValidate.push(data);
    }

    // Check @context on the root object
    if (!data["@context"]) {
      schemaEntry.errors.push("Missing @context. Should be 'https://schema.org'.");
    } else if (String(data["@context"]).indexOf("schema.org") === -1) {
      schemaEntry.warnings.push("@context does not reference schema.org: " + data["@context"]);
    }

    // Validate each item
    for (var v = 0; v < itemsToValidate.length; v++) {
      var item = itemsToValidate[v];
      var itemType = item["@type"];

      if (!itemType) {
        schemaEntry.errors.push("Item missing @type property.");
        continue;
      }

      schemaEntry.type = schemaEntry.type ? schemaEntry.type + ", " + itemType : itemType;

      // Check required properties
      var reqs = requiredProps[itemType];
      if (reqs) {
        for (var r = 0; r < reqs.length; r++) {
          var prop = reqs[r];
          if (item[prop] === undefined || item[prop] === null || item[prop] === "") {
            schemaEntry.errors.push(itemType + ": Missing required property '" + prop + "'.");
          }
        }
      }

      // Check recommended properties
      var recs = recommendedProps[itemType];
      if (recs) {
        for (var rc = 0; rc < recs.length; rc++) {
          if (item[recs[rc]] === undefined) {
            schemaEntry.warnings.push(itemType + ": Missing recommended property '" + recs[rc] + "'.");
          }
        }
      }
    }

    // Strip raw text if very large to keep output manageable
    if (schemaEntry.raw.length > 2000) {
      schemaEntry.raw = schemaEntry.raw.substring(0, 2000) + "... [truncated]";
    }

    results.schemas.push(schemaEntry);
    // Aggregate errors
    for (var e = 0; e < schemaEntry.errors.length; e++) {
      results.validationErrors.push("Schema #" + i + " (" + (schemaEntry.type || "unknown") + "): " + schemaEntry.errors[e]);
    }
    for (var w = 0; w < schemaEntry.warnings.length; w++) {
      results.warnings.push("Schema #" + i + " (" + (schemaEntry.type || "unknown") + "): " + schemaEntry.warnings[w]);
    }
  }

  // Recommendations
  if (results.validationErrors.length > 0) {
    results.recommendations.push("Fix all validation errors before submitting to Google Rich Results Test.");
  }
  if (results.schemasFound > 5) {
    results.recommendations.push("Large number of JSON-LD blocks detected (" + results.schemasFound + "). Consider consolidating with @graph.");
  }

  return JSON.stringify(results, null, 2);
})();
