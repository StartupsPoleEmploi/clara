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

    var $card = function(eligy) {return $('#' + eligy + ' .c-resultcard')};
    var $aids_per_card = function(eligy, contract_name) {return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaid')};
    var $aids_container_per_card = function(eligy, contract_name) {return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaids')};
    var $filters_per_aid = function(eligy, contract_name, aid_name) {return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaid[data-aslug="'+aid_name+'"] .c-resultfilter')};
    var $actual_filters = function() {return $('#o_all_filters .c-resultfiltering')};

    var collect_eligies = function(){
      return ['eligibles', 'uncertains', 'ineligibles'];
    }
    var collect_aids_per_contract = function(eligy){
      return $card(eligy).map(function(){return $(this).data()["cslug"]}).get();
    }
    var collect_filters_name = function() {
      return $actual_filters().map(function(){return $(this).data()["name"]}).get();
    }

    var initial_eligy = function(eligy) {
      return _.map(
        $card(eligy).datamap("cslug"), 
        function(contract_name){
          return {
            name: contract_name, 
            is_collapsed: true,
            aids: _.map(
              $aids_per_card(eligy, contract_name).datamap("aslug"), 
              function(aid_name) {
                return {
                  name: aid_name,
                  is_collapsed: false,
                  filters: _.map(
                    $filters_per_aid(eligy, contract_name, aid_name).datamap("name"),
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


    var iterate_through_aids = function(callable_function) {
      _.each(collect_eligies(), function(ely){
        _.each(main_store.getState()[ely + "_zone"][ely], function(contract){
          _.each(contract.aids, function(aid){
            callable_function(ely, contract, aid);
          })
        })
      })
    };

    var iterate_contract_types = function(callable_function) {
      _.each(collect_eligies(), function(ely){
        _.each(main_store.getState()[ely + "_zone"][ely], function(contract){
            callable_function(ely, contract);
        })
      })
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
    window.main_reducer = function(state, action) {
      
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
      _.each($card(eligy_name).datamap("cslug"), function(contract_name){
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
      iterate_contract_types(function(ely, contract){
        var $el = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaids');
        contract.is_collapsed ? $el.addClass('u-hidden-visually') : $el.removeClass('u-hidden-visually');
      });

      // Show aid or not
      iterate_through_aids(function(ely, contract, aid){
        var $el = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaid[data-aslug="' + aid.name + '"]');
        var active_filters = _.filter(main_store.getState().filters_zone.filters, function(e){return e.is_checked === true})
        var active_filters_name = _.map(active_filters, function(f){return f.name});
        var aid_filters_name = _.map(aid.filters, function(f){return f.name});
        var has_filter = _.isNotEmpty(active_filters_name);
        var has_intersection = _.isNotEmpty(_.intersection(active_filters_name, aid_filters_name));
        if (!has_filter) {
          $el.removeClass('u-hidden-visually')
        } else if (has_intersection) {
          $el.removeClass('u-hidden-visually')
        } else {
          $el.addClass('u-hidden-visually')
        }
      });

      // Show smalltags or not
      iterate_through_aids(function(ely, contract, aid){
        var $el = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaid[data-aslug="' + aid.name + '"] .c-resultfilters');
        var active_filters = _.filter(main_store.getState().filters_zone.filters, function(e){return e.is_checked === true})
        _.isEmpty(active_filters) ? $el.addClass('u-hidden-visually') : $el.removeClass('u-hidden-visually')
      });

    });

    // fire initial state
    main_store.dispatch({type: 'INIT'})
  }
});


