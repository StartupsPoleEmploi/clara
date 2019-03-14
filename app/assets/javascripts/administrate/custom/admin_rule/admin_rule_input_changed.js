
clara.js_define("admin_rule_input_changed", {

  please_if: _.stubFalse,

  please: function(evt, store) {
    store.dispatch({type: 'INPUT_CHANGED' });
  },


});
