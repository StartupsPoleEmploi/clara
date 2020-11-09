clara.load_js(function only_if(){return true}, function() {

  if (typeof ga === "function") {
    ga("set", "location", location.pathname + location.search);
    return ga("send", "pageview");
  }

  if (window.dataLayer) {
    window.dataLayer.push({'is-connected': 0})
  }

}, "global_ga_push");
