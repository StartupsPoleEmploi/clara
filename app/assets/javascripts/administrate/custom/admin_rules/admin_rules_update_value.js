
clara.js_define("admin_rules_update_value", {

  please_if: _.stubFalse,

  please: function() {
    var s = main_store.getState();
    var currentVar = _.find(s.variables, function(e){return e.name == s["selected_variable"]})
    if (currentVar) {
      var currentType = currentVar.variable_kind
      console.log(currentType)
      if (currentType === "integer") {
        clara.admin_rules_var_val._input_is_number(s.selected_value)
      } else if (currentType === "string") {
        clara.admin_rules_var_val._input_is_text(s.selected_value)
      } else if (currentType === "selectionnable") {
        clara.admin_rules_var_val._input_is_select()
        var innerHtml = clara.admin_rules_var_val._populate_with(currentVar.elements.split(","))
        clara.admin_rules_var_val._replace_input_select_content(innerHtml, s.selected_value)
      }      
    }
  },


 });
