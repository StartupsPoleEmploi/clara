clara.js_define_service("set_aides_state", {

  please: function(the_initial_state) {
    var that = this;
    var dup_state = JSON.parse(JSON.stringify(the_initial_state));
    var key = clara.please_get_state_key.main_function();
    if (_.isObject(dup_state) && !_.isEmpty(dup_state)) {
      var obj_to_store = clara.extract_aides_from_state.please(dup_state);
      dup_state["all_sorted_aids_slugs"] = obj_to_store
      store.set(key, dup_state);
    }
  }

});
