clara.js_define("admin_stage_5", {

    please_if: function() {
      return $(".c-newaid--stage5").exists();
    },

    please: function() {
      clara.admin_stage_steps.please(5);
    }
    
});
