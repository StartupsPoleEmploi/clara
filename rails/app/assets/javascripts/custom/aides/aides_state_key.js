clara.js_define("aides_state_key", {

  please_if: _.stubFalse,

  please: function() {
    return 'state_of_' + $.urlParam('for_id');
  }

});
