

clara.js_define("admin_rule", {

  please: function() {
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
        newState.current_simulation.params = action.value;
        newState.current_simulation.result = "";
        newState.is_registerable = false;
      } else if (action.type === 'INPUT_CHANGED') {
        newState.is_registerable = false;
        newState.current_simulation.params[action.value.name] = action.value.value;
      }
      return newState;
    };

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // SUBSCRIBER
    main_store.subscribe(function(){clara.admin_rule_update_result.please(main_store.getState())});
    main_store.subscribe(function(){clara.admin_rule_update_params.please(main_store.getState())});

    // DISPATCHERS
    var $replay = $(".simulator-table-row .simulation-table-replay");
    var $simulate = $("#btn_simulate");
    var $remove = $(".simulation-table-delete");
    var $save = $("#btn-save");
    var $inputs = $( "input[name^='asker']" );
    $simulate.on('click', function(){clara.admin_rule_ajax_resolve.please(main_store)});
    $replay.on('click', function(e){clara.admin_rule_replay.please(e, main_store)})
    $remove.on('click', function(e){clara.admin_rule_remove.please(e, main_store)})
    $save.on('click', function(e){clara.admin_rule_save.please(e, main_store)})
    $inputs.on('keypress', function(e){clara.admin_rule_input_changed.please(e, main_store)})

    main_store.dispatch({type: 'INIT' })
  }

});
