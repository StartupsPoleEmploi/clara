clara.js_define("please_get_aides_default_state", {

  trigger_function: _.stubFalse,

  main_function: function(the_initial_state) {
    var previous_state = store.get(clara.please_get_state_key.main_function());
    var has_state = _.isPlainObject(previous_state) && _.isNotEmpty(previous_state);
    return has_state ? previous_state : the_initial_state;
  }

});
