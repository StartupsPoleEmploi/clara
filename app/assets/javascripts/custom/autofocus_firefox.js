clara.js_define("autofocus_firefox", {

  please_if: function () {
    console.log("hey")
    // return $("input").hasAttribute("autofocus");
    return true;
  },

  please: function () {
    console.log("triggered")
    $("input").focus();
    // $("input.c-field").attr("autofocus", "autofocus").focus();
    // console.log($(":focus"))
  }

});
