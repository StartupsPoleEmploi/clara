$(document).on('turbolinks:load', function () {
  if ($('body').hasClass('cookies', 'edit')) {


    /**
    *         INITIAL STATE 
    **/
    var STATE_KEY = 'cookies_preference';

    var initial_state = {
      disable_statistic: false,
      disable_navigation: false
    };

    var default_state = function() {
      var previous_state = {
        disable_statistic: $('#input_stat').is(':checked'),
        disable_navigation: $('#input_nav').is(':checked')
      };
      var has_state = _.isPlainObject(previous_state) && _.isNotEmpty(previous_state);
      return has_state ? previous_state : initial_state;
    };

    var disable_buttton = function (id) {
      $(id).addClass("is-disabled");
    }
    var enable_buttton = function (id) {
      $(id).removeClass("is-disabled");
    }

    /**
    *         MAIN REDUCER 
    **/
    var main_reducer = function(state, action) {

      console.log('-----BOOM-------')
      console.log(action);
      console.log(state);

      if (state === undefined) {
        return default_state();
      }

      // Works better than _.assign or Object.assign
      var newState = JSON.parse(JSON.stringify(state));

      if (action.type === 'AUTHORIZE_STATISTIC') {
        newState.disable_statistic = false;
      }
      if (action.type === 'FORBID_STATISTIC') {
        newState.disable_statistic = true;
      }
      if (action.type === 'AUTHORIZE_NAVIGATION') {
        newState.disable_navigation = false;
      }
      if (action.type === 'FORBID_NAVIGATION') {
        newState.disable_navigation = true;
      }
      if (action.type === 'AUTHORIZE_ALL') {
        newState.disable_statistic = false;
        newState.disable_navigation = false;
      }
      if (action.type === 'FORBID_ALL') {
        newState.disable_statistic = true;
        newState.disable_navigation = true;
      }

      console.log(newState);
      return newState;
    };

    /**
    *         MAIN STORE 
    **/
    var main_store = Redux.createStore(main_reducer, default_state());

    /**
    *         DISPATCHERS 
    **/
    $('#authorize_statistic').click(function(){
      var that = this;
      main_store.dispatch({type: 'AUTHORIZE_STATISTIC'});
    });
    $('#forbid_statistic').click(function(){
      var that = this;
      main_store.dispatch({type: 'FORBID_STATISTIC'});
    });

    $('#authorize_navigation').click(function(){
      var that = this;
      main_store.dispatch({type: 'AUTHORIZE_NAVIGATION'});
    });
    $('#forbid_navigation').click(function(){
      var that = this;
      main_store.dispatch({type: 'FORBID_NAVIGATION'});
    });

    $('#authorize_all').click(function(){
      var that = this;
      main_store.dispatch({type: 'AUTHORIZE_ALL'});
    });
    $('#forbid_all').click(function(){
      var that = this;
      main_store.dispatch({type: 'FORBID_ALL'});
    });

    /**
    *         SUBSCRIBERS
    **/
    main_store.subscribe(function() {

      var state = main_store.getState();

      // state of simple buttons
      if (state.disable_statistic === true) {
        disable_buttton("#authorize_statistic");
        enable_buttton("#forbid_statistic");
      } else {
        enable_buttton("#authorize_statistic");
        disable_buttton("#forbid_statistic");
      }

      if (state.disable_navigation === true) {
        disable_buttton("#authorize_navigation");
        enable_buttton("#forbid_navigation");
      } else {
        enable_buttton("#authorize_navigation");
        disable_buttton("#forbid_navigation");
      }

      // state aggregated buttons
      if (_.every(state)) {
        enable_buttton("#forbid_all");
        disable_buttton("#authorize_all");        
      } 
      else if (_.none(state)) {
        disable_buttton("#forbid_all");
        enable_buttton("#authorize_all");        
      } 
      else { // some
        disable_buttton("#authorize_all");
        disable_buttton("#forbid_all");        
      } 

      // state of form
      $("#input_nav").prop( "checked", state.disable_navigation );
      $("#input_stat").prop( "checked", state.disable_statistic );
    }); 

    // fire initial state
    main_store.dispatch({type: 'INIT'})


  }
});
