
clara.js_define("admin_rules_var_val", {

  please_if: _.stubFalse,

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
    clara.admin_rules_var_val._input_is_number()
    $("#rule_value_eligible").attr("type", "text");
    $("#rule_value_eligible").val("");
  },

  _input_is_number: function() {
    $("#rule_value_eligible_selectible").css('display','none');
    $("#rule_value_eligible_selectible").removeAttr("name", "rule[value_eligible]");
    $("#rule_value_eligible").css('display','block');
    $("#rule_value_eligible").attr("name", "rule[value_eligible]");
    $("#rule_value_eligible").attr("type", "number");
    $("#rule_value_eligible").val("");
  },

  _input_is_select: function(innerHTML) {
    $("#rule_value_eligible_selectible").css('display','block');
    $("#rule_value_eligible_selectible").attr("name", "rule[value_eligible]");
    $("#rule_value_eligible").css('display','none');
    $("#rule_value_eligible").removeAttr("name", "rule[value_eligible]");
  },


 });
