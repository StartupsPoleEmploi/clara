clara.js_define("admin_rulecreation_record", {

    please_if: function() {
      return $("#record_root_rule").exists();
    },

    please: function() {
      var SEL = " .selectize-input [data-value]";
      var datavalf = function(selector) {
        return $(selector + SEL).toArray().map(function(e){ return $(e).attr("data-value") })
      }
      var htmlf = function(selector) {
        return $(selector + SEL).toArray().map(function(e){ return $(e).html() })
      }
      var objf = function(selector) {
        return $(selector + SEL).toArray().map(function(e){ var res = {}; res[$(e).attr("data-value")] = $(e).html();return res; })
      }
      $("#record_root_rule").on("click", function(e) {

        $.ajax({
          url: $("#record_root_rule").data("url"),
          type: "POST",
          data: {
            aid: $.urlParam("aid") || $.urlParam("slug"),
            trundle: JSON.stringify(store_trundle.getState()),
            modify: $.urlParam("modify"),
            geo: JSON.stringify({
              selection: $('.c-geowhere input[type=radio]:checked').attr("id"),
              town: objf(".c-geoselect--town"),
              department: objf(".c-geoselect--department"),
              region: objf(".c-geoselect--region"),
            })
          },
          success: function(resp){ 

          },
          error: function(e){ 
            $(".flash-error").remove()
            $("<h2 class='flash-error'>" + e.responseText + "</h2>").insertAfter(".c-errorafter");
            window.scrollTo(0, 0); 
          },
        });

      })
    }
});


