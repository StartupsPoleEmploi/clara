clara.js_define("show_detail", {

    please_if: function() {
      return $(".c-body.detail.show").exists()
    },
    please: function() {

      $(".js-feedback-no").on("click", function(e) {
        $(".js-hideable").hide()
      })
      $(".js-feedback-yes").on("click", function(e) {
        $("#hidden_decision_value").attr("value", "oui")
        $("#submit_feedback").click()
      })
      $("#post_feedback_form").on('ajax:success', function() {
        $(".c-feedback").html("<div class='js-thankyou'>Merci pour votre avis !</div>")
      });    
    },

});

