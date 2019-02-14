
clara.js_define("admin_rules_var_changed", {

  please_if: _.stubFalse,

  please: function() {
    var that = clara.admin_rules_var_changed;
    that._update_value();
    that._update_operator();
  },

  _update_value: function() {
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
        clara.admin_rules_var_val._input_is_select(s.selected_value)
        var innerHtml = clara.admin_rules_var_val._populate_with(currentVar.elements.split(","))
        clara.admin_rules_var_val._replace_input_select_content(innerHtml)
      }      
    }
  },

  _update_operator: function() {
    var s = main_store.getState();
    $("#rule_operator_kind").val(s["selected_operator"]);
  },


 });
