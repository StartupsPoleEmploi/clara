load_js_for_page([], function(){
  if (typeof ga === "function") {
    ga("set", "location", location.pathname + location.search);
    return ga("send", "pageview");
  }
}, "global_ga_push");

$( document ).ready(function() {
    if (location.pathname === "/") {
      var es5number = 42;
      if (isES5Supported === false) es5number = 0;
      if (isES5Supported === true) es5number = 1;

      ga('send', 'event', 'material', 'flexbox', _DD);
      ga('send', 'event', 'material', 'es5', es5number);
      $( ".c-footer-motherhome" ).append( "<small>Nombres " + _DD + " " + es5number  +  "</small>" );
    }
});
