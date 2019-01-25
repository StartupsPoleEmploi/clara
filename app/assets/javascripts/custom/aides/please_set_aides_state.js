clara.js_define("please_set_aides_state", {

  trigger_function: _.stubFalse,

  main_function: function(the_initial_state) {
    var that = this;
    var key = clara.please_get_state_key.main_function();
    if (_.isObject(the_initial_state) && !_.isEmpty(the_initial_state)) {
      var obj_to_store = that._extract_from_state(the_initial_state);
      store.set(key, obj_to_store);
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
