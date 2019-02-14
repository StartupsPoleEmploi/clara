clara.js_define("admin_simple_rule_form", {

  dress: function(){
    var that = this;
  
    var global_state = gon.global_state;

    global_state["selected_variable"] = $("select#rule_variable_id").find('option:selected').attr("data-name");
    global_state["selected_operator"] = $("select#rule_operator_kind").find('option:selected').attr("value");
    global_state["selected_value"] = $("#rule_value_eligible").val() || $("#rule_value_eligible_selectible").val();

    // REDUCER
    var reducer = function(state, action) { 

      console.log("action!! " + action.type + " " + action.value);

      // Deep copy of previous state to avoid side-effects
      var newState = _.cloneDeep(state);

      if (action.type === 'VARIABLE_CHANGED') {
        newState["selected_variable"] = action.value
        newState["selected_value"] = ""
        newState["selected_operator"] = ""
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
    // var selected_operator_watcher = watch('selected_operator')(function(newVal, oldVal, objectPath) {
    //   console.log('Operator : %s changed from %s to %s', objectPath, oldVal, newVal)
    // });
    // var selected_value_watcher = watch('selected_value')(function(newVal, oldVal, objectPath) {
    //   console.log('Value : %s changed from %s to %s', objectPath, oldVal, newVal)
    // });

    // main_store.subscribe(watch('selected_variable')(clara.admin_rules_var_changed.please));
    main_store.subscribe(clara.admin_rules_var_changed.please);
    // main_store.subscribe(selected_operator_watcher);
    // main_store.subscribe(selected_value_watcher);
    main_store.subscribe(clara.admin_rules_expl_changed.please);

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
