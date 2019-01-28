clara.js_define("aides_set_state", {

  please: function(the_initial_state) {
    var that = this;
    var dup_state = JSON.parse(JSON.stringify(the_initial_state));
    var key = clara.aides_state_key.please();
    if (_.isObject(dup_state) && !_.isEmpty(dup_state)) {
      var obj_to_store = clara.aides_extract_raw_data.please(dup_state);
      dup_state["all_sorted_aids_slugs"] = obj_to_store
      store.set(key, dup_state);
    }
  }

});
