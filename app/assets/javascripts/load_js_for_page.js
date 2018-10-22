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
* The JS will be loaded only once, whether "ready" or "turbolinks:load" is called.
*
*/

function load_js_for_page(selectors, a_function, optional_id) {
  if (!$.isArray(selectors) || !$.isFunction(a_function)) return;

  var should_apply_on_all_pages = _.isEmpty(selectors);
  var should_apply_on_selected_page = 
    !_.isEmpty(selectors) && 
      _.every(selectors, function(selector){return $('body').hasClass(selector)});

  if (should_apply_on_all_pages || should_apply_on_selected_page) {
    $(document).on("ready", a_function);
  }

};

