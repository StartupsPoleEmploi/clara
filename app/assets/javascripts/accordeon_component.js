_.set(window, 'clara.accordeon_component',

    function accordeon_component(discriminator, has_collapsed_lines_initially, localStorageService, urlExtractorService) {
      
      var storage = localStorageService ? localStorageService : localStorage;
      var urlExtractor = urlExtractorService ? urlExtractorService : _.getUrlParameter;

      var FOR_ID = urlExtractor('for_id');
      var STORAGE_KEY = "state_of_expander__" + discriminator + "__for-id__" + FOR_ID;

      // select by discriminator
      function $d(selector) {
        return $(discriminator + ' ' + selector);
      }

      function magic_subscription(the_store) {

        var expansionState = the_store.getState().expansions;
        var initial_show_mask = the_store.getState().show_mask;
        var opened_mask = the_store.getState().opened_mask;

        var expansions_exists = _.size(expansionState) > 0;
        var none_expanded = _.none(expansionState);
        var all_expanded = _.every(expansionState);
        var some_expanded = _.some(expansionState);
        var show_mask = initial_show_mask && expansions_exists;

        var possible_actions = [{
          jquery_id : '.c-expander--reduceable',
          condition : function() { return (opened_mask || !show_mask) && expansions_exists && some_expanded; }
        },
        {
          jquery_id : '.c-expander--unreduceable',
          condition : function() { return (opened_mask || !show_mask) && expansions_exists && none_expanded; }
        },
        {
          jquery_id : '.c-expander--expandable',
          condition : function() { return (opened_mask || !show_mask) && expansions_exists && !all_expanded; }
        },
        {
          jquery_id : '.c-expander--unexpandable',
          condition : function() { return (opened_mask || !show_mask) && expansions_exists && all_expanded; }
        },
        {
          jquery_id : '.c-expander-button--opened',
          condition : function() { return show_mask && opened_mask; }
        },
        {
          jquery_id : '.c-expander-button--closed',
          condition : function() { return show_mask && !opened_mask; }
        },
        {
          jquery_id : '.c-result-list__lines',
          condition : function() { return !show_mask || opened_mask; }
        }];

        _.each(possible_actions, function(possible_action) {
          possible_action.condition() ? $d(possible_action.jquery_id).removeClass('is-hidden') : $(discriminator + ' ' + possible_action.jquery_id).addClass('is-hidden');
        });

        _.each(expansionState, function(value, key) {
          if (value) {
            $('[data-id=' + key + ']').parent().find('.c-result-aid').removeClass('is-hidden');
            $('[data-id=' + key + ']').find('.c-result-line__action--expanded').removeClass('is-hidden');
            $('[data-id=' + key + ']').find('.c-result-line__action--reduced').addClass('is-hidden');
          } else {
            $('[data-id=' + key + ']').parent().find('.c-result-aid').addClass('is-hidden');
            $('[data-id=' + key + ']').find('.c-result-line__action--expanded').addClass('is-hidden');
            $('[data-id=' + key + ']').find('.c-result-line__action--reduced').removeClass('is-hidden');
          }
        });

      };

      // handlers are automagically removed by turbolinks
      // https://stackoverflow.com/a/30406119/2595513
      function register_callbacks() {
        $d('.c-result-line__content').click(function(e) {
          magic_store.dispatch({
            type: 'toggle_expansion_of',
            id: $(this).attr('data-id')
          });
        });
        $d('.c-expander--expandable').click(function(e) {
          magic_store.dispatch({ type: 'expand_all' });
        });
        $d('.c-expander--reduceable').click(function(e) {
          magic_store.dispatch({ type: 'reduce_all' });
        });
        $d('.c-expander-button').click(function(e) {
          magic_store.dispatch({ type: 'toggle_mask' });
        });        
      };

      function magic_reducer(state, action) {
        if (state === undefined) {
          return initial_state;
        }

        var newExpansionState = state.expansions;
        var newOpenedMaskState = state.opened_mask;
        var newValue=null;

        switch (action.type) {
          case 'toggle_expansion_of':
            var id_of_action = action.id;
            newValue = !state.expansions[id_of_action];
            newExpansionState = _.assign({}, state.expansions);
            newExpansionState[id_of_action] = newValue;
            break;
          case 'toggle_mask':
            newOpenedMaskState = !state.opened_mask;
            break;
          case 'expand_all':
            newExpansionState = _.mapValues(_.assign({}, state.expansions), function(e){return true;});
            break;
          case 'reduce_all':
            newExpansionState = _.mapValues(_.assign({}, state.expansions), function(e){return false;});
            break;
        }

        var newState = _.assign({}, state);
        newState.expansions = newExpansionState;
        newState.opened_mask = newOpenedMaskState;

        if (_.isFunction(_.get(storage, 'setItem')) && action.type !== "@@redux/INIT" && action.type !== "init") {
          storage.setItem(STORAGE_KEY, JSON.stringify(newState));
        }

        return newState;
      };

      var ids_of_eligies = $d('.c-result-line__content').map(function() {return $(this).attr('data-id');});

      var initial_state = {};

      if (_.isFunction(_.get(storage, 'getItem')) && storage.getItem(STORAGE_KEY)) {
        initial_state = JSON.parse(storage.getItem(STORAGE_KEY));
      } else {
        initial_state.expansions = {};
        initial_state.show_mask = has_collapsed_lines_initially;
        initial_state.opened_mask = !has_collapsed_lines_initially;
        _.each(ids_of_eligies, function(e, i) {initial_state.expansions[e] = false;});        
      }

      register_callbacks();
      var magic_store = Redux.createStore(magic_reducer, initial_state);
      magic_store.subscribe(_.partial(magic_subscription, magic_store));
      magic_store.dispatch({ type: 'init' });
    }

);
