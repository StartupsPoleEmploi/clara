clara.js_define("admin_modify_ct", {

    please_if: function() {
      return $("form#new_contract_type").length > 0;
    },

    please: function() {
      $("#contract_type_icon").parent().parent().addClass("hidden");
    }

});

