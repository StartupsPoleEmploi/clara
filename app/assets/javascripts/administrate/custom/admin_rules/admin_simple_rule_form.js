clara.js_define("admin_simple_rule_form", {

  dress: function(){
    var that = this;
  
    var global_state = gon.global_state;

    global_state["selected_variable"] = $("select#rule_variable_id").find('option:selected').attr("data-name");
    global_state["selected_operator"] = $("select#rule_operator_kind").find('option:selected').attr("value");
    global_state["selected_value"] = $("#rule_value_eligible").val();

    // REDUCER
    var reducer = function(state, action) { 

      console.log("action!! " + action.type + " " + action.value);

      // Deep copy of previous state to avoid side-effects
      var newState = _.cloneDeep(state);

      if (action.type === 'VARIABLE_CHANGED') {
        newState["selected_variable"] = action.value
      } else if (action.type === 'OPERATOR_CHANGED') {
        newState["selected_operator"] = action.value
      } else if (action.type === 'VALUE_CHANGED') {
        newState["selected_value"] = action.value
      }

      return newState;
    };

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // SUBSCRIBER
    var watch = _.partial(Redux.watch, main_store.getState, _);
    var selected_operator_watcher = Redux.watch(main_store.getState, 'selected_operator')(function(newVal, oldVal, objectPath) {
      console.log('Operator : %s changed from %s to %s', objectPath, oldVal, newVal)
    });
    var selected_value_watcher = Redux.watch(main_store.getState, 'selected_value')(function(newVal, oldVal, objectPath) {
      console.log('Value : %s changed from %s to %s', objectPath, oldVal, newVal)
    });

    main_store.subscribe(watch('selected_variable')(clara.admin_rules_var_changed.please));
    main_store.subscribe(selected_operator_watcher);
    main_store.subscribe(selected_value_watcher);

    // DISPATCHERS
    $('#rule_variable_id').on('input', function() {
      var value = $(this).find("option:selected").attr("data-name");
      main_store.dispatch({type: 'VARIABLE_CHANGED', value: value});
    });

    $('#rule_operator_kind').on('input', function() {
      var value = $(this).find("option:selected").attr("value");
      main_store.dispatch({type: 'OPERATOR_CHANGED', value: value});
    });

    $('#rule_value_eligible').on('input', function() {
      var value = $(this).val();
      main_store.dispatch({type: 'VALUE_CHANGED', value: value});
    });

    $('#rule_value_eligible_selectible').on('input', function() {
      var value = $(this).find("option:selected").attr("value");
      main_store.dispatch({type: 'VALUE_CHANGED', value: value});
    });

  },


  _set_value_type: function($original_input) {
      var that = this;
      var kind = $("select#rule_variable_id").find('option:selected').attr("data-kind");
      var elements = $("select#rule_variable_id").find('option:selected').attr("data-elements");
      var elements_translation = _.voidString($("select#rule_variable_id").find('option:selected').attr("data-elements-translation"));
      var original_name = $("#rule_value_eligible").attr("name");
      var original_value = $("#rule_value_eligible").val();

      if (kind === "selectionnable") {
        var actual_values = _.split(elements, ",");
        var translated_values = elements_translation === "" ? actual_values : _.split(elements_translation, ",");
        var $new_select = that._populate_options("rule_value_eligible", actual_values, translated_values, original_name, original_value);
        $("#rule_value_eligible").replaceWith($new_select);
      } else if (kind === "integer") {
        $("#rule_value_eligible").replaceWith($original_input);
        $("#rule_value_eligible").attr("type", "number");
        if (_.includes($("#rule_operator_kind").val(), "amongst")) {
          $("#rule_value_eligible").attr("type", "text");
        }
      } else if (kind === "string") {
        $("#rule_value_eligible").replaceWith($original_input);
        $("#rule_value_eligible").attr("type", "text");
        if (_.includes($("#rule_operator_kind").val(), "amongst")) {
          $("#rule_value_eligible").attr("placeholder", "Example : value1;value2");
        }
      }
  },

  _populate_options: function(select_id, options_en, options, original_name, original_value) {
    var $result = $("<select id='" + select_id + "' name='" + original_name + "'></select>");
    $result.append('<option value=""></option>');
    _.each(options, function(opt, i){
      var opt_en = options_en[i];
      $result.append("<option value=\"" + opt_en + "\">" + opt + "</option>");
    });
    clara.zu_clean_select.please({for_select: $result});
    $result.find('option[value="' + original_value + '"]').attr("selected", "selected");
    return $result;
  }

});
