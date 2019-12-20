clara.js_define("admin_show_aid", {

  please_if: function () {
    return $("body").attr("data-path") === "admin_aid_path";
  },

  please: function () {
    if ($("#contract_type").attr("data-role") !== "superadmin") {
      $("#contract_type").next().children().replaceTag('<div>', false)
    }
    var $source = $($("#source").next().children())
    if (urlize) {
      $source.html(urlize($source.html(), {target: "blank"}))
    }
  }

});
