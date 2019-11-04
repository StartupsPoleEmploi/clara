clara.js_define("admin_step_1", {

    please_if: function() {
      return $("#submit-step-1").exists();
    },

    please: function() {
      $("button.c-newaid-actionrecord").click(function() {
        $("#submit-step-1").click();
      });
    }

});

