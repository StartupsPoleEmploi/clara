$(document).on('ready turbolinks:load', function () {
  if ($('body').hasClass('cookies', 'edit')) {

    console.log('cookies editing...')

    /**
    *         INITIAL STATE 
    **/
    var STATE_KEY = 'cookies_preference';

    var initial_state = {
      statistic: false,
      navigation: false
    };

    window.default_state = function() {
      var previous_state = {
        statistic: $('#input_stat').is(':checked'),
        navigation: $('#input_nav').is(':checked')
      };
      var has_state = _.isPlainObject(previous_state) && _.isNotEmpty(previous_state);
      return has_state ? previous_state : initial_state;
    };

    var disable_buttton = function (id) {
      $(id).attr("disabled", "disabled");
      $(id).addClass("is-disabled");
    }
    var enable_buttton = function (id) {
      $(id).removeAttr("disabled");
      $(id).removeClass("is-disabled");
    }

    /**
    *         MAIN REDUCER 
    **/
    window.main_reducer = function(state, action) {

      if (state === undefined) {
        return default_state();
      }

    };

    /**
    *         MAIN STORE 
    **/
    window.main_store = Redux.createStore(main_reducer, default_state());

    /**
    *         DISPATCHERS 
    **/
    $('.stuff').click(function(){
    });

    /**
    *         SUBSCRIBERS
    **/
    main_store.subscribe(function() {

      var state = main_store.getState();

      if (state.statistic === true) {
        disable_buttton("#authorize_statistic");
        enable_buttton("#forbid_statistic");
      } else {
        enable_buttton("#authorize_statistic");
        disable_buttton("#forbid_statistic");
      }
    }); 

    // fire initial state
    main_store.dispatch({type: 'INIT'})


  }
});
