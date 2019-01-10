clara.js_define("admin_simple_rule_form", {
// _.set(window, "clara.admin_simple_rule_form", {

  dress: function(){
    var that = this;
    that._set_callbacks();
  },

  _set_name_as_error: function() {
    var that = this;
    that.find_input_with_text("Name").attr("class", "is-error");
  },

  _set_value_as_error: function() {
    var that = this;
    that.find_input_with_text("Value").attr("class", "is-error");
  },

  _input_of: function(prop_name) {
    var $elt =  $('[name]').filter(function(i,e){
      var result = false;
      try {
        var name_attr_val = $($('[name]')[i]).attr("name").split("rule[")[1].split("]")[0];
        result = prop_name.indexOf(name_attr_val) === 0;
      } catch(e) {
        result = false;
      }
      return result;
    });
    return $($elt[0]);
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
    window.first_state = first_state;
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
        that._whitelist_operator_type(first_state, all_choices, ["eq", "not_equal"]);
      } else if (kind === "integer") {
        that._whitelist_operator_type(first_state, all_choices, ["eq", "not_equal", "more_than", "less_than", "more_or_equal_than", "less_or_equal_than", "starts_with", "amongst", "not_amongst"]);
      } else if (kind === "boolean") {
        that._whitelist_operator_type(first_state, all_choices, ["eq", "not_equal"]);
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
    _.each(actual_choices, function(actual_choice){
      var current_value_is_origin = actual_choice.value === first_state.val;
      if (force_selection && current_value_is_origin) {
        $('#rule_operator_type').append('<option selected="selected" value="' + actual_choice.value + '">' + actual_choice.text + '</option>');
      } else {
        $('#rule_operator_type').append('<option value="' + actual_choice.value + '">' + actual_choice.text + '</option>');
      }
    });
  },

  _set_value_type: function($original_input) {
      var that = this;
      var kind = $("select#rule_variable_id").find('option:selected').attr("data-kind");
      var elements = $("select#rule_variable_id").find('option:selected').attr("data-elements");
      var original_name = $("#rule_value_eligible").attr("name");
      var original_value = $("#rule_value_eligible").val();

      that._value_type_reset();
      if (kind === "selectionnable") {
        var splitted_elts = _.split(elements, ",");
        var $new_select = that._populate_options("rule_value_eligible", splitted_elts, splitted_elts, original_name, original_value);
        $("#rule_value_eligible").replaceWith($new_select);
      } else if (kind === "integer") {
        $("#rule_value_eligible").replaceWith($original_input);
        $("#rule_value_eligible").attr("type", "number");
        if (_.includes($("#rule_operator_type").val(), "amongst")) {
          $("#rule_value_eligible").attr("type", "text");
        }
      } else if (kind === "boolean") {
        var $new_select = that._populate_options(
          "rule_value_eligible", 
          [ 
            true,
            false 
          ], 
          [
            I18n.t("boolean.true", {locale: $('body').data('locale')}), 
            I18n.t("boolean.false", {locale: $('body').data('locale')})
          ], 
          original_name, 
          original_value
        );
        $("#rule_value_eligible").replaceWith($new_select);
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
    console.log('original_value')
    console.log(original_value)
    var $result = $("<select id='" + select_id + "' name='" + original_name + "'></select>");
    for(var i = 0; i < options.length; i++) {
      var opt = options[i];
      var opt_en = options_en[i];
      $result.append("<option value=\"" + opt_en + "\">" + opt + "</option>");
    }
    $result.find('option[value="' + original_value + '"]').attr("selected", "selected");
    return $result;
  }

});
