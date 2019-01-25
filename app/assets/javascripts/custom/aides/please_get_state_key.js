clara.js_define("aides.please_get_state_key", {

  trigger_function: function(){return false;},

  main_function: function() {
    return 'state_of_' + $.urlParam('for_id');
  }

});
