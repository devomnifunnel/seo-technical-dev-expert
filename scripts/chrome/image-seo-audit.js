/**
 * Image SEO Audit Script
 * Audits all images on the page for SEO optimization.
 * Checks alt text, dimensions, lazy loading, formats, and CSS backgrounds.
 * ES5 compatible - runs via mcp__claude-in-chrome__javascript_tool
 */
(function() {
  "use strict";

  var results = {
    url: window.location.href,
    timestamp: new Date().toISOString(),
    images: [],
    cssBackgroundImages: [],
    formatDistribution: {},
    warnings: [],
    summary: {
      totalImages: 0,
      missingAlt: 0,
      emptyAlt: 0,
      missingDimensions: 0,
      lazyLoadedCount: 0,
      withSrcset: 0,
      cssBackgroundCount: 0,
      nextGenFormatCount: 0
    }
  };

  // Helper: extract file extension / format from URL
  function getImageFormat(src) {
    if (!src) return "unknown";
    var cleanUrl = src.split("?")[0].split("#")[0].toLowerCase();
    if (cleanUrl.indexOf(".webp") !== -1) return "webp";
    if (cleanUrl.indexOf(".avif") !== -1) return "avif";
    if (cleanUrl.indexOf(".svg") !== -1) return "svg";
    if (cleanUrl.indexOf(".png") !== -1) return "png";
    if (cleanUrl.indexOf(".jpg") !== -1 || cleanUrl.indexOf(".jpeg") !== -1) return "jpeg";
    if (cleanUrl.indexOf(".gif") !== -1) return "gif";
    if (cleanUrl.indexOf(".bmp") !== -1) return "bmp";
    if (cleanUrl.indexOf(".ico") !== -1) return "ico";
    if (cleanUrl.indexOf("data:image/webp") !== -1) return "webp";
    if (cleanUrl.indexOf("data:image/svg") !== -1) return "svg";
    if (cleanUrl.indexOf("data:image/png") !== -1) return "png";
    if (cleanUrl.indexOf("data:image/jpeg") !== -1) return "jpeg";
    return "unknown";
  }

  // Helper: estimate file size from dimensions (rough heuristic)
  function estimateSize(width, height, format) {
    if (!width || !height) return null;
    var pixels = width * height;
    var bytesPerPixel = { jpeg: 0.5, png: 1.0, gif: 0.3, webp: 0.3, avif: 0.2, svg: 0, unknown: 0.5 };
    var bpp = bytesPerPixel[format] || 0.5;
    var bytes = Math.round(pixels * bpp);
    return {
      estimatedKB: Math.round(bytes / 1024),
      note: "Rough estimate based on dimensions"
    };
  }

  // --- Audit all <img> elements ---
  var imgs = document.querySelectorAll("img");
  results.summary.totalImages = imgs.length;

  for (var i = 0; i < imgs.length; i++) {
    var img = imgs[i];
    var src = img.getAttribute("src") || img.getAttribute("data-src") || "";
    var alt = img.getAttribute("alt");
    var hasAlt = alt !== null;
    var isEmptyAlt = hasAlt && alt.trim() === "";
    var widthAttr = img.getAttribute("width");
    var heightAttr = img.getAttribute("height");
    var loading = img.getAttribute("loading");
    var srcset = img.getAttribute("srcset");
    var sizes = img.getAttribute("sizes");
    var format = getImageFormat(src);

    // Track format distribution
    if (!results.formatDistribution[format]) {
      results.formatDistribution[format] = 0;
    }
    results.formatDistribution[format]++;

    // Rendered and natural dimensions
    var naturalW = img.naturalWidth || 0;
    var naturalH = img.naturalHeight || 0;

    var imageEntry = {
      src: src.substring(0, 200),
      alt: hasAlt ? alt.substring(0, 150) : null,
      hasAlt: hasAlt,
      isEmptyAlt: isEmptyAlt,
      format: format,
      width: widthAttr,
      height: heightAttr,
      naturalWidth: naturalW,
      naturalHeight: naturalH,
      loading: loading,
      hasSrcset: !!srcset,
      hasSizes: !!sizes,
      estimatedSize: estimateSize(naturalW, naturalH, format),
      issues: []
    };

    // Issue detection
    if (!hasAlt) {
      imageEntry.issues.push("Missing alt attribute");
      results.summary.missingAlt++;
    } else if (isEmptyAlt) {
      results.summary.emptyAlt++;
    }

    if (!widthAttr || !heightAttr) {
      imageEntry.issues.push("Missing width/height attributes (CLS risk)");
      results.summary.missingDimensions++;
    }

    if (loading === "lazy") {
      results.summary.lazyLoadedCount++;
    }

    if (srcset) {
      results.summary.withSrcset++;
    }

    if (format === "webp" || format === "avif") {
      results.summary.nextGenFormatCount++;
    }

    if (hasAlt && alt.length > 125) {
      imageEntry.issues.push("Alt text is very long (" + alt.length + " chars). Consider shortening.");
    }

    // Check for keyword-stuffed alt text (heuristic: all caps or repeating patterns)
    if (hasAlt && alt.length > 20 && alt === alt.toUpperCase() && alt.indexOf(" ") !== -1) {
      imageEntry.issues.push("Alt text appears to be ALL CAPS (possible keyword stuffing).");
    }

    results.images.push(imageEntry);
  }

  // --- Check CSS background images ---
  var allElements = document.querySelectorAll("div, section, header, footer, span, a, figure");
  for (var c = 0; c < allElements.length && c < 500; c++) {
    var style = window.getComputedStyle(allElements[c]);
    var bgImage = style.backgroundImage;
    if (bgImage && bgImage !== "none" && bgImage.indexOf("url(") !== -1) {
      var urlMatch = bgImage.match(/url\(["']?([^"')]+)["']?\)/);
      var bgUrl = urlMatch ? urlMatch[1] : bgImage;
      results.cssBackgroundImages.push({
        element: allElements[c].tagName.toLowerCase(),
        className: (allElements[c].className || "").toString().substring(0, 80),
        backgroundUrl: bgUrl.substring(0, 200)
      });
      results.summary.cssBackgroundCount++;
    }
  }

  // --- Warnings ---
  if (results.summary.missingAlt > 0) {
    results.warnings.push(results.summary.missingAlt + " images are missing alt attributes.");
  }
  if (results.summary.missingDimensions > 0) {
    results.warnings.push(results.summary.missingDimensions + " images lack explicit width/height (CLS risk).");
  }
  if (results.summary.nextGenFormatCount === 0 && results.summary.totalImages > 0) {
    results.warnings.push("No next-gen image formats (WebP/AVIF) detected. Consider converting for performance.");
  }
  if (results.summary.cssBackgroundCount > 0) {
    results.warnings.push(results.summary.cssBackgroundCount + " CSS background images detected. These are not crawlable by search engines.");
  }
  if (results.summary.lazyLoadedCount === 0 && results.summary.totalImages > 3) {
    results.warnings.push("No lazy loading detected. Consider adding loading='lazy' to below-the-fold images.");
  }

  return JSON.stringify(results, null, 2);
})();
