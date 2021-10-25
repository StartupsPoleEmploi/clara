clara.js_define("admin_show_aid", {

  please_if: function () {
    return $("body").attr("data-path") === "admin_aid_path";
  },

  please: function () {
    if ($("#contract_type").attr("data-role") !== "superadmin") {
      $.renameElement( $("#contract_type").next().children(), 'div', false )
    }
    var $source = $($("#source").next().children())
    if (window.urlize) {
      $source.html(urlize($source.html(), {target: "blank"}))
    }
  }

});
