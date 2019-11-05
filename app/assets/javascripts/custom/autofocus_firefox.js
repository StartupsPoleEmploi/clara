clara.js_define("autofocus_firefox", {

  please_if: function () {
    return $("input.c-field").hasAttribute("autofocus");
  },

  please: function () {
    $("input.c-field").attr("autofocus", "autofocus").focus();
    console.log($(":focus"))
  }

});
