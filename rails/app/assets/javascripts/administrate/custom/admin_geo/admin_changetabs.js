clara.js_define("admin_changetabs", {

    please_if: function() {
      return $("body").attr("data-path") === "new_admin_aid_path";
    },

    please: function() {
      $("#label_tab_1").html("Étape 1")
      $("#label_tab_2").html("Étape 2")
      $("#label_tab_3").html("Étape 3")
      $("#label_tab_4").html("Étape 4")
    },

});


