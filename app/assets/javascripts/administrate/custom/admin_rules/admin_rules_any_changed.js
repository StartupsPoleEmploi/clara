
clara.js_define("admin_rules_any_changed", {

  please_if: _.stubFalse,

  please: function() {
    console.log("anything changed!")
    var s = main_store.getState()

  },




 });
