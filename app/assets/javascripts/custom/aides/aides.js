clara.js_define("aides", {

  please: function() {


    window.main_store = 
      Redux.createStore(
        clara.aides_main_reducer.please, 
        clara.aides_default_state.please()
      );


    main_store.subscribe(clara.aides_main_subscriber.please);

    // fire initial state
    main_store.dispatch({type: 'INIT'});

    clara.aides_main_dispatcher.please();


  }

});
