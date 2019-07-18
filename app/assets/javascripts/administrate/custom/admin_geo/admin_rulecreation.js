clara.js_define("admin_rulecreation", {

    please_if: function() {
      return $(".c-rulecreation").exists();
    },

    please: function() {

        clara.admin_simple_rule_form.dress();
        clara.admin_sortable.please();

    
    }

});

