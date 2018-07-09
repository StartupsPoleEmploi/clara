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
    window.collect_aids_per_contract = function(eligy){
      return $('#' + eligy + ' .c-resultcard').map(function(){return $(this).data()["cslug"]}).get();
    }
    window.collect_aids = function(eligy, contract_name){
      return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaid').map(function(){return $(this).data()["aslug"]}).get();
    }
    window.collect_filters = function(eligy, contract_name, aid_name){
      return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaid[data-aslug="'+aid_name+'"] .c-resultfilter').map(function(){return $(this).data()["name"]}).get();
    }

    window.initial_eligibles_aids_per_contract = _.map(
      collect_aids_per_contract('o_eligibles'), 
      function(contract_name){
        return {
          name: contract_name, 
          is_collapsed: false,
          aids: _.map(
            collect_aids('o_eligibles', contract_name), 
            function(aid_name) {
              return {
                name: aid_name,
                is_collapsed: false,
                filters: _.map(
                  collect_filters('o_eligibles', contract_name, aid_name),
                  function(filter_name) {
                    return {
                      name: filter_name,
                      is_collapsed: false,
                    }
                  }
                )
              }
            }
          )

        }
      }
    );
    window.initial_state = {
      eligibles_zone: {
        is_collapsed: false,
        aids_per_contract: initial_eligibles_aids_per_contract
      },
      ineligibles_zone: {
        is_collapsed: false,
        aids_per_contract: _.map($('#o_ineligibles .c-resultcard').map(function(){return $(this).data()["cslug"]}).get(), function(e){return {name:e, is_collapsed:false}})
      },
      uncertains_zone: {
        is_collapsed: false,
        aids_per_contract: _.map($('#o_uncertains .c-resultcard').map(function(){return $(this).data()["cslug"]}).get(), function(e){return {name:e, is_collapsed:false}})
      },
      filters_zone: {
        is_collapsed: false,
        filters: _.map($('#o_all_filters .c-resultfiltering').map(function(){return $(this).data()["name"]}).get(), function(e){return {name: e, is_checked: false}})
      },
      recap_zone: {
        is_collapsed: false
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


