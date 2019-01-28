clara.js_define("aides_default_state", {

  please_if: _.stubFalse,

  please: function(the_initial_state) {
    var previous_state = clara.aides_get_state.please();
    var has_state = _.isPlainObject(previous_state) && _.isNotEmpty(previous_state);
    return has_state ? previous_state : the_initial_state;
  }

});
