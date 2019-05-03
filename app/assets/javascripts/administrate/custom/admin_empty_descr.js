clara.js_define("admin_flash", {

    please_if: function() {
      return $("dd.attribute-data").length > 0;
    },

    please: function() {
      $("dd.attribute-data").each(
        function(i,e){
          if (_.isEmpty($(e).text().trim())) {
            $(e).text("Non renseigné");
          }
        }
      );
    },

});

