
clara.js_define("admin_rule_replay", {

  please_if: _.stubFalse,

  please: function(evt, store) {
    var params = $(evt.currentTarget).closest(".simulator-table-row").attr("data-h");
    store.dispatch({type: 'REPLAY', value: JSON.parse(params) });
  },


});
