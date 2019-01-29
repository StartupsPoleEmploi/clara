clara.js_define("aides_get_state", {

  please_if: _.stubFalse,

  please: function() {
    var key = clara.aides_state_key.please();
    var local_store = _.get(window, "store");
    return local_store.get(key);
  }

});
