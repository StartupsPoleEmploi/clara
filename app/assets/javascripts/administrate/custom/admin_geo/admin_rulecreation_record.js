clara.js_define("admin_rulecreation_record", {

    please_if: function() {
      return $("#record_root_rule").exists();
    },

    please: function() {
      var SEL = " .selectize-input [data-value]"
      $("#record_root_rule").on("click", function(e) {

        $.ajax({
          url: $("#record_root_rule").data("url"),
          type: "POST",
          data: {
            aid: $.urlParam("aid"),
            trundle: JSON.stringify(store_trundle.getState()),
            geo_selection: $('.c-geowhere input[type=radio]:checked').attr("id"),
            geo_town: $(".c-geoselect--town" + SEL).toArray().map(function(e){ return $(e).attr("data-value") }),
            geo_dep: $(".c-geoselect--department" + SEL).toArray().map(function(e){ return $(e).attr("data-value") }),
            geo_region: $(".c-geoselect--region" + SEL).toArray().map(function(e){ return $(e).attr("data-value") })
          },
          success: function(resp){ 

          }
        });

      })
    }
});


