
clara.js_define("admin_rules_var_changed", {

  please_if: _.stubFalse,

  please: function(newVal, oldVal, objectPath, stateCopy) {
    var that = clara.admin_rules_var_changed;
    console.log('Variable : %s changed from %s to %s', objectPath, oldVal, newVal)
    var s = stateCopy
    var currentVar = _.find(s.variables, function(e){return e.name == newVal})
    console.log(currentVar)
    var currentType = currentVar.variable_kind
    if (currentType === "integer") {
      that._enable_input_text()
      that._disable_input_select()
      $("#rule_value_eligible").attr("type", "number");
    } else if (currentType === "selectionnable") {
      console.log(that)
      that._disable_input_text()
      that._enable_input_select()
    }
  },

  _enable_input_select: function() {
    $("#rule_value_eligible_selectible").css('display','block');
  },

  _disable_input_select: function() {
    $("#rule_value_eligible_selectible").css('display','none');
  },

  _enable_input_text: function() {
    $("#rule_value_eligible").css('display','block');
  },
  
  _disable_input_text: function() {
    $("#rule_value_eligible").css('display','none');
  },

 });
