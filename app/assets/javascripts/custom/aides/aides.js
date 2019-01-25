clara.js_define("aides", {

  main_function: function() {

    var MOBILE_MAX_WIDTH = 739;
    var grey_caret_open = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 -1 16 16"><path fill-rule="evenodd" d="M13,5 L13,13 L11,13 L11,5 L3,5 L3,3 L13,3 L13,5 Z" transform="rotate(135 8 8)"/></svg>'
    var grey_caret_close = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 -6 16 16"><path fill-rule="evenodd" d="M13,5 L13,13 L11,13 L11,5 L3,5 L3,3 L13,3 L13,5 Z" transform="rotate(-45 8 8)"/></svg>'

    function track_filter(filter_name) {
      if (typeof ga === "function") {
        ga('send', 'event', 'results', 'filter', filter_name);
      }      
    }

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

    var eligies = ['eligibles', 'uncertains', 'ineligibles'];
    
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
    }

    var initial_state = {
      width: $( window ).width(),
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
        is_collapsed: true,
        filters: _.map(collect_filters_name(), function(e){return {name: e, is_checked: false, updated_at : 0}})
      },
      recap_zone: {
        is_collapsed: true
      }
    };

    // var clara.please_get_aides_default_state = function() {
    //   var previous_state = store.get(clara.please_get_state_key.main_function());
    //   var has_state = _.isPlainObject(previous_state) && _.isNotEmpty(previous_state);
    //   return has_state ? previous_state : initial_state;
    // }

    var iterate_through_aids = function(callable_function, state) {
      if (!state) state = main_store.getState()
      _.each(eligies, function(ely){
        _.each(state[ely + "_zone"][ely], function(contract){
          _.each(contract.aids, function(aid){
            callable_function(ely, contract, aid);
          })
        })
      })
    };

    var iterate_contract_types = function(callable_function, state) {
      if (!state) state = main_store.getState()
      _.each(eligies, function(ely){
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
    var main_reducer = function(state, action) {
      
      if (state === undefined) {
        return clara.please_get_aides_default_state.main_function(initial_state);
      }

      // Works better than _.assign or Object.assign
      var newState = JSON.parse(JSON.stringify(state));
      
      if (action.type === 'INIT') {
        if (newState.width > MOBILE_MAX_WIDTH) {
          newState.filters_zone.is_collapsed = false;
        }
      }
      else if (action.type === 'RESIZE_WINDOW') {
        newState.width = action.width;
      }
      else if (action.type === 'TOGGLE_INELIGIES_ZONE') {
        newState.ineligibles_zone.is_collapsed = !newState.ineligibles_zone.is_collapsed;
      }
      else if (action.type === 'TOGGLE_FILTER') {

        // track filter with GA
        if (action["value"] === true) track_filter(action["name"])

        var filter_changed = _.find(newState.filters_zone.filters, function(filter){return filter.name === action.name});
        filter_changed.is_checked = action.value;
        if (filter_changed.is_checked) filter_changed.updated_at = (new Date()).getTime();
        iterate_through_aids(function(ely, contract, aid){
          var aid_filters_name = _.map(aid.filters, function(e) {return e.name});
          var existing_filters_name = _.map(_.filter(newState.filters_zone.filters, function(f){return f.is_checked}), function(e) {return e.name});
          var has_intersection = _.isNotEmpty(_.intersection(aid_filters_name, existing_filters_name));
          var no_filter = _.isEmpty(_.filter(newState.filters_zone.filters, function(e){return e.is_checked === true}))

          // aid state
          if (no_filter) {
            aid.is_collapsed = false;
          } else if (has_intersection) {
            aid.is_collapsed = false;
          } else {
            aid.is_collapsed = true;
          }
          
          // contract state
          if (!no_filter) contract.is_collapsed = false;          
            
        }, newState);
      }
      else if (action.type === 'TOGGLE_FILTERS_ZONE') {
        newState.filters_zone.is_collapsed = !newState.filters_zone.is_collapsed;
        if (newState.filters_zone.is_collapsed === false) {
          newState.recap_zone.is_collapsed = true;
        }
      }
      else if (action.type === 'TOGGLE_RECAP_ZONE') {
        newState.recap_zone.is_collapsed = !newState.recap_zone.is_collapsed;
        if (newState.recap_zone.is_collapsed === false) {
          newState.filters_zone.is_collapsed = true;
        }
      }
      else if (action.type === 'OPEN_CONTRACT') {
        var ely = action.eligy_name; // either eligibles, ineligibles, or uncertains
        // allow no-filter
        var found = _.find(newState[ely + "_zone"][ely], function(e) {return e.name === action.contract_name});
        found.is_collapsed = false;
      }
      else if (action.type === 'CLOSE_CONTRACT') {
        var ely = action.eligy_name; // either eligibles, ineligibles, or uncertains
        // allow no-filter
        var found = _.find(newState[ely + "_zone"][ely], function(e) {return e.name === action.contract_name});
        found.is_collapsed = true;
      }
      else if (action.type === 'FOLD_ELIGY') {
        var ely = action.eligy_name; // either eligibles, ineligibles, or uncertains
        contracts = newState[ely + "_zone"][ely]
        _.each(contracts, function(contract){
          contract.is_collapsed = false;
        })
      }
      else if (action.type === 'UNFOLD_ELIGY') {
        var ely = action.eligy_name; // either eligibles, ineligibles, or uncertains
        contracts = newState[ely + "_zone"][ely]
        _.each(contracts, function(contract){
          contract.is_collapsed = true;
        });
      }
      
      store.set(clara.please_get_state_key.main_function(), newState);

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
    window.main_store = Redux.createStore(main_reducer, clara.please_get_aides_default_state.main_function(initial_state));


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
    $('.c-filtertag__close').click(function(){
      var filter_name = $(this).closest('.c-filterstag__item').attr('data-name');
      main_store.dispatch({type: 'TOGGLE_FILTER', name: filter_name, value: false});
    });

    $( window ).resize(function() {
        main_store.dispatch({type: 'RESIZE_WINDOW', width: $( window ).width()});
    });

    $('.js-toggle-ineligies').on('click', function(){
      main_store.dispatch({type: 'TOGGLE_INELIGIES_ZONE'});
    });
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

    _.each(eligies, function(eligy_name) {
      _.each($card(eligy_name).datamap("cslug"), function(contract_name){
        $('#' + eligy_name + ' .c-resultcard[data-cslug="' + contract_name + '"]' + ' .js-open').click(function(){
          main_store.dispatch({type: 'OPEN_CONTRACT', eligy_name: eligy_name, contract_name: contract_name});
        });
        $('#' + eligy_name + ' .c-resultcard[data-cslug="' + contract_name + '"]' + ' .js-close').click(function(){
          main_store.dispatch({type: 'CLOSE_CONTRACT', eligy_name: eligy_name, contract_name: contract_name});
        });
      });
    });

    _.each(eligies, function(eligy_name) {
      $('#' + eligy_name + ' .js-fold').click(function(){
        main_store.dispatch({type: 'FOLD_ELIGY', eligy_name: eligy_name});
      });
      $('#' + eligy_name + ' .js-unfold').click(function(){
        main_store.dispatch({type: 'UNFOLD_ELIGY', eligy_name: eligy_name});
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

      // filters_zone : caret
      state.filters_zone.is_collapsed ? $('.js-filters-zone .c-mask-filter__caret').html(grey_caret_open) : $('.js-filters-zone .c-mask-filter__caret').html(grey_caret_close);

      // recap_zone  : caret
      state.recap_zone.is_collapsed ? $('.js-recap-zone .c-mask-filter__caret').html(grey_caret_open) : $('.js-recap-zone .c-mask-filter__caret').html(grey_caret_close);

      // filters_zone : repaint
      _.each(state.filters_zone.filters, function(f){
         $('.c-resultfiltering[data-name="' + f.name + '"] input[type="checkbox"]').prop('checked', f.is_checked);
      });

      // filters_zone : text
      state.filters_zone.is_collapsed ? $('.js-filters-zone .c-mask-filter__text').text('Ouvrir les filtres') : $('.js-filters-zone .c-mask-filter__text').text('Masquer les filtres');

      // Collapse ineligibles
      state.ineligibles_zone.is_collapsed ? $('.js-ineligibles-zone').addClass('u-hidden-visually') : $('.js-ineligibles-zone').removeClass('u-hidden-visually');

      // Collapse ineligibles : text
      state.ineligibles_zone.is_collapsed ? $('.js-toggle-ineligies').text('Voir') : $('.js-toggle-ineligies').text('Cacher');

      // Collapse filters_zone
      state.filters_zone.is_collapsed ? $('.c-resultfilterings').addClass('u-hidden-visually') : $('.c-resultfilterings').removeClass('u-hidden-visually');

      // Collapse filters_zone : CSS. 
      var is_discrete = (state.filters_zone.is_collapsed && state.width > MOBILE_MAX_WIDTH); 
      is_discrete ? $('.js-filters-zone').addClass('is-discrete') : $('.js-filters-zone').removeClass('is-discrete');

      // Collapse recap_zone 
      state.recap_zone.is_collapsed ? $('.c-situation__content').addClass('u-hidden-visually') : $('.c-situation__content').removeClass('u-hidden-visually');

      // Collapse recap_zone : CSS. 
      state.recap_zone.is_collapsed ? $('.js-recap-zone').addClass('is-discrete') : $('.js-recap-zone').removeClass('is-discrete');

      // Show bigtags or not
      _.each(state.filters_zone.filters, function(filter){
        var $el = $('.c-filterstag__item[data-name="' + filter.name +'"]');
        filter.is_checked ? $el.removeClass('u-hidden') : $el.addClass('u-hidden');
      });

      iterate_contract_types(function(ely, contract){
        // Collapse contract or not
        var $el = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"]');
        var $aids = $el.find('.c-resultaids');
        contract.is_collapsed ? $aids.addClass('u-hidden-visually') : $aids.removeClass('u-hidden-visually');

        // Display number of shown aids
        var $number = $el.find('.c-resultcontract-title__number');
        var new_number = _.count(contract.aids, function(aid){return !aid.is_collapsed;})
        $number.text(new_number);

        // Display single or plural for contract
        var csingle = $el.find('.c-resultcontract-title__text').attr('data-csingle')
        var cplural = $el.find('.c-resultcontract-title__text').attr('data-cplural')
        var new_text = csingle;
        if (new_number > 1 && _.isNotEmpty(cplural)) new_text = cplural;
        $el.find('.c-resultcontract-title__text').text(new_text)

        // Remove contracts without aid
        new_number === 0 ? $el.addClass('u-hidden-visually') : $el.removeClass('u-hidden-visually')

        // Show open or not
        var $open = $el.find('.js-open');
        contract.is_collapsed ? $open.removeClass('u-hidden-visually') : $open.addClass('u-hidden-visually');

        // Show close or not
        var $close = $el.find('.js-close');
        contract.is_collapsed ? $close.addClass('u-hidden-visually') : $close.removeClass('u-hidden-visually');
      });

      iterate_through_aids(function(ely, contract, aid){
        // Show aid or not
        var $aid = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaid[data-aslug="' + aid.name + '"]');
        aid.is_collapsed ? $aid.addClass('u-hidden-visually') : $aid.removeClass('u-hidden-visually');

        // Show smalltags or not
        var $smalltag = $('#' + ely + ' .c-resultcard[data-cslug="' + contract.name + '"] .c-resultaid[data-aslug="' + aid.name + '"] .c-resultfilters');
        var active_filters = _.filter(main_store.getState().filters_zone.filters, function(e){return e.is_checked === true})
        _.isEmpty(active_filters) ? $smalltag.addClass('u-hidden-visually') : $smalltag.removeClass('u-hidden-visually')


      });


      _.each(eligies, function(ely){
        var $el = $('#' + ely);
        var contracts = state[ely + "_zone"][ely];

        // Hide the whole ely or not
        var number_of_aid_per_eligy = _.sumBy(contracts, function(contract){
          return _.count(contract.aids, function(aid){return !aid.is_collapsed;})
        })
        number_of_aid_per_eligy === 0 ? $el.addClass('u-hidden-visually') : $el.removeClass('u-hidden-visually');

        // fold all contracts
        var $fold = $el.find('.js-fold');
        var no_contracts_are_collapsed = _.none(contracts, function(e){return e.is_collapsed;});
        no_contracts_are_collapsed ? $fold.addClass('u-hidden-visually') : $fold.removeClass('u-hidden-visually');

        // unfold all contracts
        var $unfold = $el.find('.js-unfold');
        var some_contracts_are_uncollapsed = _.some(contracts, function(e){return !e.is_collapsed;});
        some_contracts_are_uncollapsed ? $unfold.removeClass('u-hidden-visually') : $unfold.addClass('u-hidden-visually');
      });

      // Nothing interesting was found for the user
      var nb_of_eligibles = _.sumBy(state.eligibles_zone.eligibles, function(contract){return _.count(contract.aids, function(aid){return !aid.is_collapsed;})})  
      var nb_of_uncertains = _.sumBy(state.uncertains_zone.uncertains, function(contract){return _.count(contract.aids, function(aid){return !aid.is_collapsed;})})  
      nb_of_eligibles + nb_of_uncertains === 0  ? $('#nothing').removeClass('u-hidden') : $('#nothing').addClass('u-hidden');

      
    });

    // fire initial state
    main_store.dispatch({type: 'INIT'})


  }

});
