clara.js_define("aides_get_state", {

  please_if: _.stubFalse,

  please: function(store_arg) {
    var key = clara.aides_state_key.please();
    var local_store = store_arg || _.get(window, "store");
    local_store.get(key);
  }

});
