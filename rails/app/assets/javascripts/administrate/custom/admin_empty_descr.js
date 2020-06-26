clara.js_define("admin_empty_descr", {

    please_if: function() {
      return $("dd.attribute-data").length > 0;
    },

    please: function() {
      $("dd.attribute-data").each(
        function(i,e){
          if (_.isEmpty($(e).text().trim()) && !$(e).hasClass("attribute-data--paperclip")) {
            $(e).text("Non renseigné");
          }
        }
      );
    },

});

