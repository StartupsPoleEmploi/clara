load_js_for_page([], function(){
  if (typeof ga === "function") {
    ga("set", "location", location.pathname + location.search);
    return ga("send", "pageview");
  }
}, "ga_push");
