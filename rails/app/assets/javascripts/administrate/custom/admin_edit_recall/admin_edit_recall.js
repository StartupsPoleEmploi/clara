clara.js_define("admin_edit_recall", {

  please_if: function () {
    return $("body[data-path='edit_admin_recall_path']").exists();
  },

  please: function () {
    $("#recall_email").attr("readonly", true)
    $("#recall_email").css("background-color", "#f8f8f8")
    $("#recall_email").css("color", "grey")
  }


});
