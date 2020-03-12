clara.js_define("show_detail", {

    please_if: function() {
      return $(".c-body.detail.show").exists()
    },
    please: function() {

      $(".js-feedback-yes").on("click", function(e) {
        $("#hidden_decision_value").attr("value", "yes")
        $("#submit_feedback").click()
      })
      $("#post_feedback_form").on('ajax:success', function() {
        $(".c-feedback").html("Merci pour votre avis !")
      });    
    },

});

