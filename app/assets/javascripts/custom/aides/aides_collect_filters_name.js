clara.js_define("aides_collect_filters_name", {

  please_if: _.stubFalse,

  please: function() {
    return clara.aides_$actual_filters.please().map(function(){return $(this).data()["name"]}).get();
  }

});
