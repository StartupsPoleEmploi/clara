clara.js_define("admin_edit_convention", {

    please_if: function() {
      return $(".js-form-convention").exists();
    },

    please: function() {
      
      //Clean CKEDitor
      setTimeout(function() {
        clara.admin_edit_rule_clean_ckeditor.please();
      },1000);      

      // disable name change
      $("#convention_name").attr("disabled", "disabled");

    },

});

