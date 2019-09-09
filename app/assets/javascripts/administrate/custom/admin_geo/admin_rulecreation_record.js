clara.js_define("admin_rulecreation_record", {

    please_if: function() {
      return $("#record_root_rule").exists();
    },

    please: function() {
      $("#record_root_rule").on("click", function(e) {

        $.ajax({
          url: $("#record_root_rule").data("url"),
          type: "POST",
          data: {
            trundle: store_trundle.getState(),
          },
          success: function(resp){ 
            
          }
        });

      })
    }
});

