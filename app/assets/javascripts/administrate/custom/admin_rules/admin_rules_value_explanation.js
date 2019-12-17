
clara.js_define("admin_rules_value_explanation", {

  please_if: _.stubFalse,

  please: function(state) {

    if (state.selected_variable === "v_allocation_value_min") {
      $("#label_value_eligible").html("Valeur (par jour)")
    } else {
      $("#label_value_eligible").html("Valeur")
    }

  },



});
