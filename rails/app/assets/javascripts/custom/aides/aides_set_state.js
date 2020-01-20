clara.js_define("aides_set_state", {

  please_if: _.stubFalse,

  please: function(state_to_set, store_arg) {
    var that = this;
    var key = clara.aides_state_key.please();
    var local_store = store_arg || _.get(window, "store");
    local_store.set(key, state_to_set);
  }


});
