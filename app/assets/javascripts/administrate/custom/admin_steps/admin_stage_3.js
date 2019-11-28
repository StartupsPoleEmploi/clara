clara.js_define("admin_stage_3", {

    please_if: function() {
      return $(".c-newaid--stage3").exists();
    },

    please: function() {

      clara.admin_stage_steps.please(3);

      var txt_update = function() {
        var slug = $.urlParam("slug")
        var $txt = $(".c-resultaid__smalltxt--" + slug)
        var new_textarea_value = $("#aid_short_description").val();
        $txt.text(new_textarea_value)
      }

      $("#aid_short_description").on("change keyup paste", txt_update);
      
      txt_update();
    }

});
