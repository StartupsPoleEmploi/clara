
clara.js_define("admin_rules_var_changed", {

  please_if: _.stubFalse,

  please: function() {
    console.log("hey i changed!")
    // console.log('Variable : %s changed from %s to %s', objectPath, oldVal, newVal)
    var s = main_store.getState();
    var currentVar = _.find(s.variables, function(e){return e.name == s["selected_variable"]})
    if (currentVar) {
      var currentType = currentVar.variable_kind
      console.log(currentType)
      if (currentType === "integer") {
        clara.admin_rules_var_val._input_is_number()
      } else if (currentType === "string") {
        clara.admin_rules_var_val._input_is_text()
      } else if (currentType === "selectionnable") {
        clara.admin_rules_var_val._input_is_select()
        var innerHtml = clara.admin_rules_var_val._populate_with(currentVar.elements.split(","))
        clara.admin_rules_var_val._replace_input_select_content(innerHtml)
      }      
    }
  },




 });
