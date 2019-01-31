clara.js_define("aides_iterate_through_aids", {

  please_if: _.stubFalse,

  please: function(callable_function, state) {
    if (!state) state = main_store.getState();
    _.each(clara.aides_constants["ELIGIES"], function(ely){
      _.each(state[ely + "_zone"][ely], function(contract){
        _.each(contract.aids, function(aid){
          callable_function(ely, contract, aid);
        })
      })
    })
  }


});
