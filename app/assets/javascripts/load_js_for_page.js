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

function load_js_for_page(selectors, a_function) {
  $(document).on("ready turbolinks:load", function() {
    if (_.isEmpty(selectors) || _.every(selectors, function(sel){return $('body').hasClass(sel)})) {
      a_function();
    }
  });
}

