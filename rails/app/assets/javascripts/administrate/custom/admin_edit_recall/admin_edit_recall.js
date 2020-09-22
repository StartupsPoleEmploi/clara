clara.js_define("admin_edit_recall", {

  please_if: function () {
    return $("input#recall_email").exists();
  },

  please: function () {
    $("#recall_email").attr("readonly", true)
    $("#recall_email").css("background-color", "#f8f8f8")
    $("#recall_email").css("color", "grey")
    $("#recall_hourmin").attr('value', '07:30')
    $("#recall_hourmin").attr('autofill', 'disabled')
  }


});
