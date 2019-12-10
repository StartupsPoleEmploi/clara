clara.js_define("admin_edit_filter", {

  please_if: function() {
    return $(".js-filter-edition").exists();
  },

  
  please: /* istanbul ignore next */ function () {
    $(".c-filter-record.is-top").on("click", function() {
      $(".c-filter-record.is-bottom").click();
    });
  }

});
