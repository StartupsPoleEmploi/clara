
clara.js_define("admin_rules_update_operator", {

  please_if: _.stubFalse,

  please: function() {
    var s = main_store.getState();
    $("#rule_operator_kind").val(s["selected_operator"]);
  },


 });
