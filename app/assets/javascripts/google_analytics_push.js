load_js_for_page([], function(){
  if (typeof ga === "function") {
    ga("set", "location", location.pathname + location.search);
    
    // ga('send', 'event', 'results', 'print', document.location.pathname);

    return ga("send", "pageview");
  }
}, "global_ga_push");
