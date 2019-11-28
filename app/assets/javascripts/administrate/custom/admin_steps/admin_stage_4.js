clara.js_define("admin_stage_4", {

    please_if: function() {
      return $(".c-newaid--stage4").exists();
    },

    please: function() {
      clara.admin_stage_steps.please(4);
    }
    
});
