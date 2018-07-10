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
    var collect_eligies = function(){
      return ['eligibles', 'uncertains', 'ineligibles'];
    }
    var collect_aids_per_contract = function(eligy){
      return $('#' + eligy + ' .c-resultcard').map(function(){return $(this).data()["cslug"]}).get();
    }
    var collect_aids = function(eligy, contract_name){
      return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaid').map(function(){return $(this).data()["aslug"]}).get();
    }
    var collect_filters = function(eligy, contract_name, aid_name){
      return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaid[data-aslug="'+aid_name+'"] .c-resultfilter').map(function(){return $(this).data()["name"]}).get();
    }
    var collect_filters_name = function() {
      return $('#o_all_filters .c-resultfiltering').map(function(){return $(this).data()["name"]}).get();
    }

    var initial_eligy = function(eligy) {
      return _.map(
        collect_aids_per_contract(eligy), 
        function(contract_name){
          return {
            name: contract_name, 
            is_collapsed: true,
            aids: _.map(
              collect_aids(eligy, contract_name), 
              function(aid_name) {
                return {
                  name: aid_name,
                  is_collapsed: false,
                  filters: _.map(
                    collect_filters(eligy, contract_name, aid_name),
                    function(filter_name) {
                      return {
                        name: filter_name,
                        is_shown: false,
                      }
                    }
                  )
                }
              }
            )
          }
        }
      );
    }

    window.initial_state = {
      eligibles_zone: {
        eligibles: initial_eligy('eligibles')
      },
      uncertains_zone: {
        uncertains: initial_eligy('uncertains')
      },
      ineligibles_zone: {
        is_collapsed: true,
        ineligibles: initial_eligy('ineligibles')
      },
      filters_zone: {
        is_collapsed: false,
        filters: _.map(collect_filters_name(), function(e){return {name: e, is_checked: false, updated_at : 0}})
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
      
      var has_contract_name = function(e) {return e.name === action.contract_name};

      if (state === undefined) {
        return initial_state;
      }

      // Works better than _.assign or Object.assign
      var newState = JSON.parse(JSON.stringify(state));

      if (action.type === 'INIT' || action.type === '@@redux/INIT') {
        return initial_state;
      }
      else if (action.type === 'TOGGLE_FILTER') {
        var filter_changed = _.find(newState.filters_zone.filters, function(filter){return filter.name === action.name});
        filter_changed.is_checked = action.value;
        if (filter_changed.is_checked) filter_changed.updated_at = (new Date()).getTime();
      }
      else if (action.type === 'TOGGLE_FILTERS_ZONE') {
        newState.filters_zone.is_collapsed = !newState.filters_zone.is_collapsed;
      }
      else if (action.type === 'TOGGLE_RECAP_ZONE') {
        newState.recap_zone.is_collapsed = !newState.recap_zone.is_collapsed;
      }
      else if (action.type === 'OPEN_CONTRACT') {
        var ely = action.eligy_name; // either eligibles, ineligibles, or uncertains
        _.find(newState[ely + "_zone"][ely], has_contract_name).is_collapsed = false;
      }
      else if (action.type === 'CLOSE_CONTRACT') {
        var ely = action.eligy_name; // either eligibles, ineligibles, or uncertains
        _.find(newState[ely + "_zone"][ely], has_contract_name).is_collapsed = true;
      }


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
    window.main_store = Redux.createStore(main_reducer, initial_state);


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
    $('.js-filters-zone').on('click', function(){ 
      main_store.dispatch({type: 'TOGGLE_FILTERS_ZONE'});
    });
    $('.js-recap-zone').on('click', function(){ 
      main_store.dispatch({type: 'TOGGLE_RECAP_ZONE'});
    });

    _.each(collect_filters_name(), function(filter_name){ 
      $('.c-resultfiltering[data-name="' + filter_name + '"] input[type="checkbox"]').click(function(){
        var that = this; 
        main_store.dispatch({type: 'TOGGLE_FILTER', name: filter_name, value: $(that).prop("checked")}) 
      });
    });

    _.each(collect_eligies(), function(eligy_name) {
      _.each(collect_aids_per_contract(eligy_name), function(contract_name){
        $('#' + eligy_name + ' .c-resultcard[data-cslug="' + contract_name + '"]' + ' .js-open').click(function(){
          main_store.dispatch({type: 'OPEN_CONTRACT', eligy_name: eligy_name, contract_name: contract_name});
        });
        $('#' + eligy_name + ' .c-resultcard[data-cslug="' + contract_name + '"]' + ' .js-close').click(function(){
          main_store.dispatch({type: 'CLOSE_CONTRACT', eligy_name: eligy_name, contract_name: contract_name});
        });
      });
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

      state.filters_zone.is_collapsed ? $('.c-resultfilterings').addClass('u-hidden-visually') : $('.c-resultfilterings').removeClass('u-hidden-visually');

      state.recap_zone.is_collapsed ? $('.c-situation__content').addClass('u-hidden-visually') : $('.c-situation__content').removeClass('u-hidden-visually');

      _.each(state.filters_zone.filters, function(filter){
        var $el = $('.c-filterstag__item[data-name="' + filter.name +'"]');
        filter.is_checked ? $el.removeClass('u-hidden') : $el.addClass('u-hidden');
      });

      // Collapse contract or not
      _.each(collect_eligies(), function(ely){
        _.each(state[ely + "_zone"][ely], function(contract){
          var $el = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaids');
          contract.is_collapsed ? $el.addClass('u-hidden-visually') : $el.removeClass('u-hidden-visually');
        });
      });

      // Show aid or not
      _.each(collect_eligies(), function(ely){
        _.each(state[ely + "_zone"][ely], function(contract){
          _.each(contract.aids, function(aid){
            var $el = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaid[data-aslug="' + aid.name + '"]');
            aid.is_collapsed ? $el.addClass('u-hidden-visually') : $el.removeClass('u-hidden-visually');
          });
        });
      });

    });

    // fire initial state
    main_store.dispatch({type: 'INIT'})
  }
});


