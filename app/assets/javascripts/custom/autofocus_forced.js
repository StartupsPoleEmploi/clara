clara.js_define("autofocus_forced", {

  please_if: function () {
    return $('[autofocus]').length > 0
  },

  please: function () {
    $($('[autofocus]')[0]).focus();
  }

});
