

clara.js_define("admin_rule", {

  please: function() {
    console.log("ok triggereed");

    var global_state = {
      current_simulation: {
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
    // main_store.subscribe(clara.admin_rules_update_explanation.please);

    // DISPATCHERS
    $('#btn_simulate').on('click', function() {
      var that = this;
      var mydata = {
        asker: {
          v_age: 55,
        },
        authenticity_token: window._token
      };
      $.ajax({
        url: $(that).attr("data-url"),
        type:'GET',
        dataType:'json',
        data: mydata,
        success: function (res) {
          console.log(res)
          action_value = {
            result: res,
            params: mydata.asker
          };
          main_store.dispatch({type: 'SIMULATION_SUBMITTED', value:action_value });

        }
      });

    });

  }

});
