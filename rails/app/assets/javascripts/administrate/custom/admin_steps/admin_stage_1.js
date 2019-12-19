clara.js_define("admin_stage_2", {

    please_if: function() {
      return $(".c-newaid--stage1").exists();
    },

    please: function() {
      clara.admin_stage_steps.please(1);

      // jQuery hacks
      $("#aid_contract_type_id option:first").attr("disabled", "disabled");
      $("#aid_contract_type_id option:first").html("Sélectionner une rubrique");

    }
    
});
