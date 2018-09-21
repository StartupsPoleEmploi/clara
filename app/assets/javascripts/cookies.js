$(document).on('ready turbolinks:load', function () {
  if ($('body').hasClass('cookies', 'edit')) {

    console.log('cookies editing...')

    /**
    *
    *
    *
    *         INITIAL STATE 
    *
    *
    *
    *
    **/
    var STATE_KEY = 'cookies_preference';
    var initial_state = {};
    var default_state = function() {
      var previous_state = store.get(STATE_KEY);
      var has_state = _.isPlainObject(previous_state) && _.isNotEmpty(previous_state);
      return has_state ? previous_state : initial_state;
    }




    /**
    *
    *
    *
    *         MAIN STORE 
    *
    *
    *
    *
    **/
    window.main_store = Redux.createStore(main_reducer, default_state());

    /**
    *
    *
    *
    *         DISPATCHERS 
    *
    *
    *
    *
    **/
    $('.stuff').click(function(){
    });

    /**
    *
    *
    *
    *         SUBSCRIBERS
    *
    *
    *
    *
    **/
    main_store.subscribe(function() {

      var state = main_store.getState();
    });

    // fire initial state
    main_store.dispatch({type: 'INIT'})


  }
});
