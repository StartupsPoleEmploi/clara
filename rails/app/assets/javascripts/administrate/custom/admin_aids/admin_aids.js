clara.js_define("admin_aids", {

    please_if: function() {
      return $("body").attr("data-path") === "admin_aids_path";
    },

    please: function() {

      localStorage.clear();

      if ( $(".c-topbar__connect").attr("data-role") !== "superadmin" ) {
        $(".cell-data--belongs-to a").replaceTag('<div>', false)
      }

    }

});
