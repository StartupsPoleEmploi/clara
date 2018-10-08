// load_js_for_page(["welcome", "index"], function() {
// });
function load_js_for_page(array_of_selectors, a_function) {
  $(document).on("ready turbolinks:load", 
    make_self_destructing_event_callback(1, a_function, array_of_selectors)
  );
}

function make_self_destructing_event_callback(maxExecutions, callback, selectors) {

  if (selectors.every(function(sel){ return $('body').hasClass(sel);})) {

    var count = 0;
    
    return function(event) {
      if (count++ >= maxExecutions){
        $(this).off(event)
        return;
      }
      //pass any normal arguments down to the wrapped callback
      return callback.apply(this, arguments);
    }

  }

}
