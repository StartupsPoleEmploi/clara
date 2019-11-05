clara.js_define("autofocus_firefox", {

  please_if: function () {
    return $('[autofocus]').length > 0
  },

  please: function () {
    $($('[autofocus]')[0]).focus();
  }

});
