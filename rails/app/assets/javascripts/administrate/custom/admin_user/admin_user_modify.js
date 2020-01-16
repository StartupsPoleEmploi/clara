clara.js_define("admin_user_modify", {

    please_if: function() {
      return $("#user_role option").exists();
    },

    // See https://stackoverflow.com/a/26009641/2595513
    please: function() {
      $("#user_role option").filter(function() {
          return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
      }).remove();
    },

});


