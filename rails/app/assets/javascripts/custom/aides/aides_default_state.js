clara.js_define("aides_default_state", {

  please_if: _.stubFalse,

  please: function() {
    var that = clara.aides_default_state;
    var current_state = clara.aides_initial_state.please();
    var previous_state = clara.aides_get_state.please();
    var has_state = _.isPlainObject(previous_state) && _.isNotEmpty(previous_state);
    var result = current_state;
    if (has_state) {
      var current_data = clara.aides_extract_raw_data.please(current_state);
      var previous_data = clara.aides_extract_raw_data.please(previous_state);
      if (_.isEqual(current_data, previous_data)) {
        result = previous_state;
      }
    }
    result = that._merge_with_filters_state(result);
    return result;
  },

  _merge_with_filters_state: function(state) {
    var localState = _.cloneDeep(state);
    var filters = _.get(localState, "filters_zone.filters");
    var choosen_filters = []
    if (window.localStorage) {
      choosen_filters = JSON.parse(localStorage.getItem("choosen_filters"));
    }
    _.each(filters, function(filter) {
      filter.is_checked = _.includes(choosen_filters, filter.name)
    })
    return localState;
  }

});
