clara.js_define("admin_stage_3", {

    please_if: function() {
      return $(".c-newaid--stage3").exists();
    },

    please: function() {
      var slug = $.urlParam("slug")
      var $txt = $(".c-resultaid__smalltxt--" + slug)
      $("#aid_short_description").on("change keyup paste", function(e) {
        var new_textarea_value = $(this).val();
        $txt.text(new_textarea_value)
      });
    }

});
