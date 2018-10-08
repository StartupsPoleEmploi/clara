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
  $(document).on("ready turbolinks:load", (function(){
    var that = this;
    var count = 0;
    if ($( 'body' ).hasClass(_.join(array_of_selectors, ' '))) {
      if (count++ >= 1){
        $(that).off(event);
        return;
      }
      console.log('calling a_function')
      return a_function();
    }
  })()
  );
}

function make_self_destructing_event_callback(maxExecutions, callback, selectors) {

  var debug = (_.size(selectors) > 0);
  // if (debug) console.log("enter the arena")
  // if (_.every(selectors, function(sel){ return $('body').hasClass(sel);})) {
    // if (debug) console.log($('body').attr("class").split(' '));
    var count = 0;
    return function(event) {
      // console.log(selectors)
      // if (debug) console.log("within closure " + $('body').attr("class").split(' '))
      var current_selectors = $('body').attr("class").split(' ');
      var is_page_corresponding_to_selectors = _.isEmpty(_.difference(selectors, current_selectors))
      // if (debug) console.log("is_page_corresponding_to_selectors " + is_page_corresponding_to_selectors)
      // if (debug) console.log("event is " + event.type + " with count " + count + " with selectors " + selectors);
      if (!is_page_corresponding_to_selectors) {
        if (debug) console.log("resetted event for " + event.type + " " + selectors + " for " + $('body').attr("class").split(' '));
        count = 0;
      }
      else if (count++ >= maxExecutions){
        if (debug) console.log("turned off event for " + event.type + " " + selectors + " for " + $('body').attr("class").split(' '));
        $(this).off(event)
        return;
      }


      //pass any normal arguments down to the wrapped callback
      return callback.apply(this, arguments);
    }

  // }

}
