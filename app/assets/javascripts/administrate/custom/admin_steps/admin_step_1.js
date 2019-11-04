clara.js_define("admin_step_1", {

    please_if: function() {
      return $("#submit-current-step").exists();
    },

    please: function() {
      $("button.c-newaid-actionrecord").click(function() {
        $("#submit-current-step").click();
      });
    }

});

