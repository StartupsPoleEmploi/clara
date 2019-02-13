
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
      that._input_is_number()
    } else if (currentType === "selectionnable") {
      that._input_is_select()
      var innerHtml = that._populate_with(currentVar.elements.split(","))
      that._replace_input_select_content(innerHtml)
    }
  },

  _populate_with: function(values) {
    var res = "<option value></option>"
    _.each(values, function(value) {
      res += '<option value="' + value + '">' + value + '</option>'
    })
    return res;
  },

  _replace_input_select_content: function(with_html) {
    $('#rule_value_eligible_selectible').html(with_html)
  },

  _input_is_text: function() {
    $("#rule_value_eligible_selectible").css('display','none');
    $("#rule_value_eligible").css('display','block');
  },

  _input_is_number: function() {
    $("#rule_value_eligible_selectible").css('display','none');
    $("#rule_value_eligible").css('display','block');
    $("#rule_value_eligible").attr("type", "number");
  },

  _input_is_select: function() {
    $("#rule_value_eligible_selectible").css('display','block');
    $("#rule_value_eligible").css('display','none');
  },


 });
