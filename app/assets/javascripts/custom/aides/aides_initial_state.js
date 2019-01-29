clara.js_define("aides_initial_state", {

  please_if: _.stubFalse,

  please: function(eligy) {
    return {
      width: $( window ).width(),
      eligibles_zone: {
        eligibles: clara.aides_initial_eligy.please('eligibles')
      },
      uncertains_zone: {
        uncertains: clara.aides_initial_eligy.please('uncertains')
      },
      ineligibles_zone: {
        is_collapsed: true,
        ineligibles: clara.aides_initial_eligy.please('ineligibles')
      },
      filters_zone: {
        is_collapsed: true,
        filters: _.map(clara.aides_collect_filters_name.please(), function(e){return {name: e, is_checked: false, updated_at : 0}})
      },
      recap_zone: {
        is_collapsed: true
      }
    }
  }

});
