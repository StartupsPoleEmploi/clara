clara.js_define("admin_aids", {

    please_if: function() {
      return $("body").attr("data-path") === "admin_aids_path";
    },

    please: function() {
      localStorage.clear();
    }

});
