// load_js_for_page(["welcome", "index"], function() {
// });
/**
*
* Will load JavaScript file for page whose body has classes given in array_of_selectors.
*
* If first parameter is empty array, JavaScript will be loaded for the whole application.
*
* Usage : load_js_for_page(["welcome", "index"], function loaded_function() {});
*
* The JS will be loaded only, whether "ready" or "turbolinks:load" is called.
*
*/
function load_js_for_page(array_of_selectors, a_function) {
  $(document).on("ready turbolinks:load", 
    make_self_destructing_event_callback(1, a_function, array_of_selectors)
  );
}

function make_self_destructing_event_callback(maxExecutions, callback, selectors) {

  if (_.every(selectors, function(sel){ return $('body').hasClass(sel);})) {
    // console.log("try to trigger loading for " + selectors)
    var count = 0;
    return function(event) {
      // console.log(selectors)
      if (_.size(selectors) > 0) console.log("event is " + event.type + " with count " + count + " with selectors " + selectors);
      if (count++ >= maxExecutions){
        if (_.size(selectors) > 0) console.log("turned off event for " + event.type + " " + selectors);
        $(this).off(event)
        return;
      }
      //pass any normal arguments down to the wrapped callback
      return callback.apply(this, arguments);
    }

  }

}
