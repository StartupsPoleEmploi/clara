clara.js_define("admin_edit_recall", {

  please_if: function () {
    return $("form#new_recall").exists()
  },

  please: function () {
    $("#recall_email").val($(".c-topbar__connect strong").html())
    $("#recall_email").attr("readonly", true)
    $("#recall_email").css("background-color", "#f8f8f8")
    $("#recall_email").css("color", "grey")
  }


});
