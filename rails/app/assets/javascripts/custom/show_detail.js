clara.js_define("show_detail", {

    please_if: function() {
      return $(".c-body.detail.show").exists()
    },
    please: function() {
      $(".js-hideable").on("click", function(e) {
        $(".js-hideable").hide();
      });
      $("#post_feedback_form").on('ajax:success', function() {
        $(".js-expandmore-yes").click();
        $(this).hide()
      });    
    },

});

