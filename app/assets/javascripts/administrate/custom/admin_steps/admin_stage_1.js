clara.js_define("admin_stage_2", {

    please_if: function() {
      return $(".c-newaid--stage1").exists();
    },

    please: function() {
      clara.admin_stage_steps.please(1);
    }
    
});
