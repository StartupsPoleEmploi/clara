

clara.js_define("admin_rule", {

  please: function() {
    console.log("ok triggereed");

    var global_state = {
      is_registerable: false,
      current_simulation: {
        name: "",
        params: {},
        result: "",
      },
    };
    
    // REDUCER
    var reducer = function(state, action) { 

      // Deep copy of previous state to avoid side-effects
      var newState = _.cloneDeep(state);

      if (action.type === 'SIMULATION_SUBMITTED') {
        newState.current_simulation.result = action.value.result;
        newState.current_simulation.params = action.value.params;
        newState.is_registerable = true;
      } else if (action.type === 'ANYTHING ELSE') {
      }
      console.log(newState)
      return newState;
    };

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // SUBSCRIBER
    // main_store.subscribe(clara.admin_rules_update_value.please);
    // main_store.subscribe(clara.admin_rules_update_operator.please);
    main_store.subscribe(clara.admin_rule_update_result.please);

    // DISPATCHERS
    $('#btn_simulate').on('click', clara.admin_rule_ajax_resolve.please);

  }

});
