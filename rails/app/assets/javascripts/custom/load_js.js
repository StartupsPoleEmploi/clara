/**
*
* Avoid to force the main function (actual_f) to be triggered  
* if the file load_js_per_page is not included.
* 
* Very useful for testing.
*
*/

_.set(window, "clara.load_js", function (cond_f, actual_f, optional_id) {
  return _.defaultTo(_.get(window, 'clara.load_js_per_page'), function(){})(cond_f, actual_f, optional_id);
});


