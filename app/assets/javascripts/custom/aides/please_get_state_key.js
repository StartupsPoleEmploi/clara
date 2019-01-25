clara.js_define("please_get_state_key", {

  trigger_function: _.stubFalse,

  main_function: function() {
    return 'state_of_' + $.urlParam('for_id');
  }

});
