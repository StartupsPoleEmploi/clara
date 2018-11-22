/**
*
* Avoid to force the load_js_per_page file to be included.
* 
* Useful for tests.
*
*/

_.set(window, "clara.load_js", function (cond_f, actual_f, optional_id) {
  return _.defaultTo(_.get(window, 'clara.load_js_per_page'), function(){})(cond_f, actual_f, optional_id);
});


