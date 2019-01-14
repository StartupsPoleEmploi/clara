clara.js_define("admin_simple_rule_form", {

  dress: function(){
    var that = this;
    that._set_callbacks();
  },

  _set_callbacks: function(){
    var that = this;

    var $original_input = $("#rule_value_eligible").clone();
    that._set_value_type($original_input);
    $("#rule_variable_id").change(function(){
      that._set_value_type($original_input);
    });
    $("#rule_operator_type").change(function(){
      that._set_value_type($original_input);
    });

    var $selected = $('#rule_operator_type option[selected="selected"]');
    var first_state = {val:$selected.val(), for_var:$("#rule_variable_id option:selected").text()};
    var all_choices = $("#rule_operator_type option").map(function(i,e){return {value: $(e).val(), text:$(e).text().trim()};}).toArray();
    that._set_operator_type(all_choices, first_state);
    $("#rule_variable_id").change(function(){
      that._set_operator_type(all_choices, first_state);
    });
  },

  _set_operator_type: function(all_choices, first_state) {
      var that = this;
      var kind = $("select#rule_variable_id").find('option:selected').attr("data-kind");
      if (kind === "selectionnable") {
        var elts_size = $("select#rule_variable_id").find('option:selected').attr("data-elements").split(",").length;
        if (elts_size <= 2) {
          that._whitelist_operator_type(first_state, all_choices, ["eq"]);
        } else {
          that._whitelist_operator_type(first_state, all_choices, ["eq", "not_equal"]);
        }
      } else if (kind === "integer") {
        that._whitelist_operator_type(first_state, all_choices, ["eq", "not_equal", "more_than", "less_than", "more_or_equal_than", "less_or_equal_than", "starts_with"]);
      } else if (kind === "string") {
        that._whitelist_operator_type(first_state, all_choices, ["eq", "not_equal", "more_than", "less_than", "more_or_equal_than", "less_or_equal_than", "starts_with", "amongst", "not_amongst"]);
      }
  },

  _whitelist_operator_type: function(first_state, all_choices, user_choices) {
    $('#rule_operator_type').empty();
    var actual_choices = all_choices.filter(function(one_choice){
      return _.includes(user_choices, one_choice.value);
    });
    var current_variable = $('#rule_variable_id option:selected').text();
    var force_selection = current_variable === first_state.for_var;
    $('#rule_operator_type').append('<option value=""></option>');
    _.each(actual_choices, function(actual_choice){
      var current_value_is_origin = actual_choice.value === first_state.val;
      if (force_selection && current_value_is_origin) {
        $('#rule_operator_type').append('<option selected="selected" value="' + actual_choice.value + '">' + actual_choice.text + '</option>');
      } else {
        $('#rule_operator_type').append('<option value="' + actual_choice.value + '">' + actual_choice.text + '</option>');
      }
    });
    clara.zu_clean_select.main_function({for_select: $('#rule_operator_type')})
  },

  _set_value_type: function($original_input) {
      var that = this;
      var kind = $("select#rule_variable_id").find('option:selected').attr("data-kind");
      var elements = $("select#rule_variable_id").find('option:selected').attr("data-elements");
      var elements_translation = _.voidString($("select#rule_variable_id").find('option:selected').attr("data-elements-translation"));
      var original_name = $("#rule_value_eligible").attr("name");
      var original_value = $("#rule_value_eligible").val();

      that._value_type_reset();
      if (kind === "selectionnable") {
        var actual_values = _.split(elements, ",");
        var translated_values = elements_translation === "" ? actual_values : _.split(elements_translation, ",");
        var $new_select = that._populate_options("rule_value_eligible", actual_values, translated_values, original_name, original_value);
        $("#rule_value_eligible").replaceWith($new_select);
      } else if (kind === "integer") {
        $("#rule_value_eligible").replaceWith($original_input);
        $("#rule_value_eligible").attr("type", "number");
        if (_.includes($("#rule_operator_type").val(), "amongst")) {
          $("#rule_value_eligible").attr("type", "text");
        }
      } else if (kind === "string") {
        $("#rule_value_eligible").replaceWith($original_input);
        $("#rule_value_eligible").attr("type", "text");
        if (_.includes($("#rule_operator_type").val(), "amongst")) {
          $("#rule_value_eligible").attr("placeholder", "Example : value1;value2");
        }
      }
  },

  _value_type_reset: function() {
    $(".c-label").remove();
  },

  _populate_options: function(select_id, options_en, options, original_name, original_value) {
    var $result = $("<select id='" + select_id + "' name='" + original_name + "'></select>");
    $result.append('<option value=""></option>');
    _.each(options, function(opt, i){
      var opt_en = options_en[i];
      $result.append("<option value=\"" + opt_en + "\">" + opt + "</option>");
    });
    clara.zu_clean_select.main_function({for_select: $result});
    $result.find('option[value="' + original_value + '"]').attr("selected", "selected");
    return $result;
  }

});
