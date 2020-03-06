clara.js_define("aides_initial_state", {

  please_if: _.stubFalse,

  please: function(eligy) {
    var that = clara.aides_initial_state;
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
        filters: _.map(clara.aides_collect_filters_name.please(), function(e){return {name: e, is_checked: that._is_checked(e), updated_at : 0}})
      },
      recap_zone: {
        is_collapsed: true
      }
    }
  },

  _is_checked: function(filter_slug) {
    var result = false;
    var choosen_filters = [];
    if (window.localStorage) {
      choosen_filters = JSON.parse(localStorage.getItem("choosen_filters"));
      result = _.includes(choosen_filters, filter_slug)
    }
    return result;
  }

});
