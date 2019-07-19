clara.js_define("admin_simple_rule_form", {

  dress: function(){
    var that = this;
  
    var global_state = gon.global_state;

    global_state["selected_variable"] = $("select#rule_variable_id").find('option:selected').attr("data-name");
    global_state["selected_operator"] = $("select#rule_operator_kind").find('option:selected').attr("value");
    global_state["selected_value"] = $("#rule_value_eligible").val() || $("#rule_value_eligible_selectible").val();

    // REDUCER
    var reducer = function(state, action) { 
      console.log('reducin....')
      console.log(action)
      console.log('')


      // Deep copy of previous state to avoid side-effects
      var newState = _.cloneDeep(state);

      if (action.type === 'VARIABLE_CHANGED') {
        newState["selected_variable"] = action.value
        newState["selected_value"] = ""
        newState["selected_operator"] = clara.admin_rules_concerned_operator.please(newState, action.value)
      } else if (action.type === 'OPERATOR_CHANGED') {
        newState["selected_operator"] = action.value
      } else if (action.type === 'VALUE_CHANGED') {
        newState["selected_value"] = action.value
      }

      return newState;
    };

    // STORE
    window.store_rule = Redux.createStore(reducer, global_state);

    // SUBSCRIBER
    store_rule.subscribe(function(){clara.admin_rules_update_value.please(_.cloneDeep(store_rule.getState()))});
    store_rule.subscribe(function(){clara.admin_rules_update_operator.please(_.cloneDeep(store_rule.getState()))});
    store_rule.subscribe(function(){clara.admin_rules_update_explanation.please(_.cloneDeep(store_rule.getState()))});

    // DISPATCHERS
    $('#rule_variable_id').on('input', function() {
      var value = $(this).find("option:selected").attr("data-name");
      store_rule.dispatch({type: 'VARIABLE_CHANGED', value: value});
    });

    $('#rule_operator_kind').on('input', function() {
      var value = $(this).find("option:selected").attr("value");
      store_rule.dispatch({type: 'OPERATOR_CHANGED', value: value});
    });

    $('#rule_value_eligible').on('input', function() {
      var value = $(this).val();
      store_rule.dispatch({type: 'VALUE_CHANGED', value: value});
    });

    $('#rule_value_eligible_selectible').on('input', function() {
      var value = $(this).find("option:selected").attr("value");
      store_rule.dispatch({type: 'VALUE_CHANGED', value: value});
    });


  },




});
