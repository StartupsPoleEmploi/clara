clara.js_define_service("set_aides_state", {

  please: function(the_initial_state) {
    var that = this;
    var dup_state = JSON.parse(JSON.stringify(the_initial_state));
    var key = clara.please_get_state_key.main_function();
    if (_.isObject(dup_state) && !_.isEmpty(dup_state)) {
      var obj_to_store = that._extract_from_state(dup_state);
      dup_state["all_sorted_aids_slugs"] = obj_to_store
      store.set(key, dup_state);
    }
  },

  _extract_from_state: function(the_initial_state) {
    var that = this;
    console.log("the_initial_state")
    console.log(the_initial_state)
    aids_eligibles = 
      _.defaultTo(
        that._extract_ely(the_initial_state, "eligibles_zone.eligibles"),
        []
      );
    aids_ineligibles = 
      _.defaultTo(
        that._extract_ely(the_initial_state, "ineligibles_zone.ineligibles"),
        []
      );
    aids_uncertains = 
      _.defaultTo(
        that._extract_ely(the_initial_state, "uncertains_zone.uncertains"),
        []
      );

    var concatenated = _.concat(aids_eligibles, aids_uncertains, aids_ineligibles)
    var concatenated_sorted = _.sortBy(concatenated)
    return concatenated_sorted;
  },

  _extract_ely: function(an_initial_state, a_status) {
    return _.chain(an_initial_state)
              .get(a_status)
              .map(function(e){return e["aids"]})
              .flatten()
              .map(function(e){return e["name"]})
              .value();
  }

});
