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

// DEBUG purpose : in the chrome console, >$ $(document).trigger( "ready")
// $(document).on("ready", function(){console.log("I'm ready");});

function load_js_for_page(array_of_selectors, a_function) {
  $(document).on("ready turbolinks:load", max_one_call(a_function, array_of_selectors));
}

var max_one_call = makeSelfDestructingEventCallback(1);

function makeSelfDestructingEventCallback(maxExecutions) {
  return function(callback, selectors) {
    var count = 0;
    return function(event) {
      if ($( 'body' ).hasClass(_.join(selectors, ' '))) {
        if (count++ >= maxExecutions){
          console.log ('turning off')
          $(this).off(event)
          return;
        }
        console.log ('execute')
        //pass any normal arguments down to the wrapped callback
        return callback.apply(this, arguments);
      } else {
        count = 0;
      }
    }
  }
  
}
