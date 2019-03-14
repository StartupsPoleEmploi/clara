

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
      } else if (action.type === 'REPLAY') {
        console.log("REPLAY")
        console.log(action)
        newState.current_simulation.params = action.value;
      }
      console.log(newState)
      return newState;
    };

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // SUBSCRIBER
    // main_store.subscribe(clara.admin_rules_update_value.please);
    // main_store.subscribe(clara.admin_rules_update_operator.please);
    main_store.subscribe(function(){clara.admin_rule_update_result.please(main_store.getState())});
    main_store.subscribe(function(){clara.admin_rule_update_params.please(main_store.getState())});

    // DISPATCHERS
    var $replay = $(".simulator-table-row .simulation-table-replay");
    var $simulate = $("#btn_simulate");
    var $remove = $(".simulation-table-delete");

    $simulate.on('click', function(){clara.admin_rule_ajax_resolve.please(main_store)});
    $replay.on('click', function(e){clara.admin_rule_replay.please(e, main_store)})
    $remove.on('click', function(e){clara.admin_rule_remove.please(e, main_store)})
  }

});
