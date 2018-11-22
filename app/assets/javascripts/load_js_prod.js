/**
*
* Avoid to force the load_js_per_page file to be included.
* 
* Useful for tests.
*
*/

function load_js_prod(cond_f, actual_f, optional_id) {
  return _.defaultTo(_.get(window, 'clara.load_js_per_page'), function(){})(cond_f, actual_f, optional_id);
};

