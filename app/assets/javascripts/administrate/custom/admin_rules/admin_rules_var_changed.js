
clara.js_define("admin_rules_var_changed", {

  please_if: _.stubFalse,

  please: function(newVal, oldVal, objectPath, stateCopy, initial_value) {
    console.log("hey i changed!")
    console.log('Variable : %s changed from %s to %s', objectPath, oldVal, newVal)
    var s = stateCopy
    var currentVar = _.find(s.variables, function(e){return e.name == newVal})
    if (currentVar) {
      var currentType = currentVar.variable_kind
      console.log(currentType)
      if (currentType === "integer") {
        clara.admin_rules_var_val._input_is_number()
      } else if (currentType === "string") {
        clara.admin_rules_var_val._input_is_text()
      } else if (currentType === "selectionnable") {
        clara.admin_rules_var_val._input_is_select()
        var innerHtml = clara.admin_rules_var_val._populate_with(currentVar.elements.split(","), initial_value)
        clara.admin_rules_var_val._replace_input_select_content(innerHtml)
      }      
    }
  },




 });
