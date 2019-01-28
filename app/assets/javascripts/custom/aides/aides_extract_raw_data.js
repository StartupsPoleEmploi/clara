clara.js_define("aides_extract_raw_data", {

  please_if: _.stubFalse,

  please: function(given_state) {

    var that = this;
    aids_eligibles = 
      _.defaultTo(
        that._extract_ely(given_state, "eligibles_zone.eligibles"),
        []
      );
    aids_ineligibles = 
      _.defaultTo(
        that._extract_ely(given_state, "ineligibles_zone.ineligibles"),
        []
      );
    aids_uncertains = 
      _.defaultTo(
        that._extract_ely(given_state, "uncertains_zone.uncertains"),
        []
      );

    var concatenated = _.concat(aids_eligibles, aids_uncertains, aids_ineligibles)
    var concatenated_sorted = _.sortBy(concatenated)
    console.log(concatenated_sorted)
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
