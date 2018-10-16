load_js_for_page([], function(){
  if (clara.ga_is_disabled) {
    $( "script[src*='analytics.com']" ).remove();    
    _.set(window, 'ga', function(){});
  } 
});
