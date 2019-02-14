
clara.js_define("admin_rules_update_value", {

  please_if: _.stubFalse,

  please: function() {
    var that = clara.admin_rules_update_value;
    var s = main_store.getState();
    var currentVar = _.find(s.variables, function(e){return e.name == s["selected_variable"]})
    if (currentVar) {
      var currentType = currentVar.variable_kind
      console.log(currentType)
      if (currentType === "integer") {
        that._input_is_number(s.selected_value)
      } else if (currentType === "string") {
        that._input_is_text(s.selected_value)
      } else if (currentType === "selectionnable") {
        that._input_is_select()
        var innerHtml = that._populate_with(currentVar.elements.split(","))
        that._replace_input_select_content(innerHtml, s.selected_value)
      }      
    }
  },

  _populate_with: function(values) {
    var res = "<option value></option>"
    _.each(values, function(value) {
      res += '<option value="' + value + '">' + value + '</option>'
    })
    return res;
  },

  _replace_input_select_content: function(with_html, initial_value) {
    $('#rule_value_eligible_selectible').html(with_html)
    $("#rule_value_eligible_selectible").val(initial_value)
  },

  _input_is_text: function(initial_value) {
    that._input_is_number()
    $("#rule_value_eligible").attr("type", "text");
    $("#rule_value_eligible").val(initial_value);
  },

  _input_is_number: function(initial_value) {
    $("#rule_value_eligible_selectible").css('display','none');
    $("#rule_value_eligible_selectible").removeAttr("name", "rule[value_eligible]");
    $("#rule_value_eligible").css('display','block');
    $("#rule_value_eligible").attr("name", "rule[value_eligible]");
    $("#rule_value_eligible").attr("type", "number");
    $("#rule_value_eligible").val(initial_value);
  },

  _input_is_select: function() {
    $("#rule_value_eligible_selectible").css('display','block');
    $("#rule_value_eligible_selectible").attr("name", "rule[value_eligible]");
    $("#rule_value_eligible").css('display','none');
    $("#rule_value_eligible").removeAttr("name", "rule[value_eligible]");
  },


 });
