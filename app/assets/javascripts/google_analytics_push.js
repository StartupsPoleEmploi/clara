load_js_for_page([], function(){
  if (typeof ga === "function") {
    ga("set", "location", location.pathname + location.search);
    
    var es5supportNumber = 42;
    if (_.get(window, 'isES5Supported') === false) es5supportNumber = 0;
    if (_.get(window, 'isES5Supported') === true) es5supportNumber = 1;

    ga('send', 'event', 'material', 'flexbox', _.get(window, '_DD'));
    ga('send', 'event', 'material', 'es5', es5supportNumber);

    return ga("send", "pageview");
  }
}, "global_ga_push");
