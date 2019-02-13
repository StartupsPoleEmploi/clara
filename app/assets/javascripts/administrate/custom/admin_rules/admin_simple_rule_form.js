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
      // console.log(action);

      // Deep copy of previous state to avoid side-effects
      var newState = _.cloneDeep(state);

      if (action.type === '') {
      }

      return newState;
    };

    // STORE
    window.main_store = Redux.createStore(reducer, global_state);

    // SUBSCRIBER
    var selected_variable_watcher = Redux.watch(main_store.getState, 'selected_variable')(function(newVal, oldVal, objectPath) {
      console.log('Variable : %s changed from %s to %s', objectPath, oldVal, newVal)
    });
    var selected_operator_watcher = Redux.watch(main_store.getState, 'selected_operator')(function(newVal, oldVal, objectPath) {
      console.log('Operator : %s changed from %s to %s', objectPath, oldVal, newVal)
    });
    var selected_value_watcher = Redux.watch(main_store.getState, 'selected_value')(function(newVal, oldVal, objectPath) {
      console.log('Value : %s changed from %s to %s', objectPath, oldVal, newVal)
    });

    main_store.subscribe(selected_variable_watcher);
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
      var value = null;
      if ($(this).find("option:selected").length) {
        value = $(this).find("option:selected").attr("value")
      } else {
        value = $(this).val()
      }
      main_store.dispatch({type: 'VALUE_CHANGED', value: value});
    });

  },




});
