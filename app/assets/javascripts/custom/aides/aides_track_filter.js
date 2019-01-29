clara.js_define("aides_track_filter", {

  please_if: _.stubFalse,

  please: function(filter_name, ga_arg) {
    var local_ga = _.get(window, "ga");
    if (typeof local_ga === "function") {
      local_ga('send', 'event', 'results', 'filter', filter_name);
    }      
  }

});
