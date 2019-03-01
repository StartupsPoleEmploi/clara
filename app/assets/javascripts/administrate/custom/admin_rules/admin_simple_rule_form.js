clara.js_define("admin_simple_rule_form", {

  dress: function(){
    var that = this;
  
    var global_state = gon.global_state;

    global_state["selected_variable"] = $("select#rule_variable_id").find('option:selected').attr("data-name");
    global_state["selected_operator"] = $("select#rule_operator_kind").find('option:selected').attr("value");
    global_state["selected_value"] = $("#rule_value_eligible").val() || $("#rule_value_eligible_selectible").val();

    // REDUCER
    var reducer = function(state, action) { 

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
    window.main_store = Redux.createStore(reducer, global_state);

    // SUBSCRIBER
    main_store.subscribe(clara.admin_rules_update_value.please);
    main_store.subscribe(clara.admin_rules_update_operator.please);
    main_store.subscribe(clara.admin_rules_update_explanation.please);

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

    // INIT HACK!!! make the store think that variable has change
    // clara.admin_rules_var_changed.please(global_state["selected_variable"], global_state["selected_variable"], "variables", _.cloneDeep(main_store.getState()), $('#rule_value_eligible').val())

    main_store.dispatch({type: 'INIT'});
  },




});
