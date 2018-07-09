$(document).on('turbolinks:load', function () {
  if ($('.c-result-default').length) {



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
    window.initial_state = {
      eligibles: {
        is_collapsed: false,
        aids_per_contract: _.map($('#o_eligibles .c-resultcard').map(function(){return $(this).data()["cslug"]}).get(), function(e){return {name:e, is_collapsed:false}})
      },
      ineligibles: {
        is_collapsed: false,
        aids_per_contract: _.map($('#o_ineligibles .c-resultcard').map(function(){return $(this).data()["cslug"]}).get(), function(e){return {name:e, is_collapsed:false}})
      },
      uncertains: {
        is_collapsed: false,
        aids_per_contract: _.map($('#o_uncertains .c-resultcard').map(function(){return $(this).data()["cslug"]}).get(), function(e){return {name:e, is_collapsed:false}})
      }
    };


    /**
    *
    *
    *
    *         MAIN REDUCER 
    *
    *
    *
    *
    **/
    function main_reducer(state, action) {
      if (state === undefined) {
        return initial_state;
      }
      var newState = _.assign({}, state);
      return newState;
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
    var main_store = Redux.createStore(main_reducer, initial_state);

    main_store.dispatch({ type: 'init' });

  }
});


