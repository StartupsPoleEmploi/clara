/**
*
* Avoid to force the load_js_for_page file to be included.
* Useful for tests.
*
*/

function load_js(selectors, a_function, optional_id) {
  return _.defaultTo(_.get(window, 'load_js_for_page'), function(){})(selectors, a_function, optional_id);
};

