
clara.js_define("admin_rule_input_changed", {

  please_if: _.stubFalse,

  please: function(evt, store) {
    var res = {
      name: $(evt.currentTarget).attr("id"),
      value: $(evt.currentTarget).val()
    }
    store.dispatch({type: 'INPUT_CHANGED', value: res });
  },


});
