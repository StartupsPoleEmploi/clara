clara.js_define("aides_iterate_contract_types", {

  please_if: _.stubFalse,

  please: function(callable_function, state) {
    if (!state) state = main_store.getState()
    _.each(clara.aides_constants["ELIGIES"], function(ely){
      _.each(main_store.getState()[ely + "_zone"][ely], function(contract){
          callable_function(ely, contract);
      })
    })
  }


});
