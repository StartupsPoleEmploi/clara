clara.js_define("aides_default_state", {

  please_if: _.stubFalse,

  please: function(given_state) {
    var previous_state = clara.aides_get_state.please();
    var has_state = _.isPlainObject(previous_state) && _.isNotEmpty(previous_state);
    var result = given_state;
    if (has_state) {
      var current_data = clara.aides_extract_raw_data.please(given_state);
      var previous_data = clara.aides_extract_raw_data.please(previous_state);
      if (_.isEqual(current_data, previous_data)) {
        result = previous_state;
      }
    }
    return result;
  }

});
