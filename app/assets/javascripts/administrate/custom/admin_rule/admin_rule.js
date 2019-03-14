

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
        newState["blabla"] = ""
      } else if (action.type === 'ANYTHING ELSE') {
      }

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

      $.ajax({
        url: that.url,
        type:'GET',
        dataType:'json',
        data: mydata,
        success: function (res) {
          that.$root.simulation_result.val = res;
          that.$root.is_registerable = true;
        }
      });

      // main_store.dispatch({type: 'VARIABLE_CHANGED', value: value});
    });

  }

});
