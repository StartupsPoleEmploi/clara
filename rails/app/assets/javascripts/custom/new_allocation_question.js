clara.js_define("new_allocation_question", {

    please: function() {
      $("input:radio:first").focus();
      if ($(".c-error-in-form").exists()) {
        $($(".c-error-in-form").detach()).appendTo(".c-fieldset");
        $(".c-error-in-form").css("margin-top", "13px")
      }
    },

});

