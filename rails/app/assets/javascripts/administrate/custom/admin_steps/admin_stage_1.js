clara.js_define("admin_stage_1", {

    please_if: function() {
      return $(".c-newaid--stage1").exists();
    },

    please: function() {
      clara.admin_stage_steps.please(1);

      // jQuery hacks
      $("#aid_contract_type_id option:first").attr("disabled", "disabled");
      $("#aid_contract_type_id option:first").html("Sélectionner une rubrique");

      function sth_changed() {
        $("button.c-newaid-actionrecord").removeAttr("disabled");
      }

      function listen_to(sel) {
        $(sel).on("input change keyup paste", sth_changed)
      }

      listen_to("#aid_name");
      listen_to("#aid_contract_type_id");
      listen_to("#aid_ordre_affichage");
      listen_to("#aid_source");

    }
    
});
