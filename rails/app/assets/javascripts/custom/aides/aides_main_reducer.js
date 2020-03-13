clara.js_define("aides_main_reducer", {

  please_if: _.stubFalse,

  please: function(state, action) {
    
    if (state === undefined) {
      return clara.aides_default_state.please();
    }

    // Works better than _.assign or Object.assign
    var newState = JSON.parse(JSON.stringify(state));
    
    if (action.type === 'INIT') {
      if (newState.width > clara.aides_constants["MOBILE_MAX_WIDTH"]) {
        newState.filters_zone.is_collapsed = false;
      }
      clara.aides_iterate_through_aids.please(clara.aides_update_filtering.please, newState);
    }
    else if (action.type === 'RESIZE_WINDOW') {
      newState.width = action.width;
    }
    else if (action.type === 'TOGGLE_INELIGIES_ZONE') {
      newState.ineligibles_zone.is_collapsed = !newState.ineligibles_zone.is_collapsed;
    }
    else if (action.type === 'TOGGLE_FILTER') {

      // track filter with GA
      if (action["value"] === true) clara.aides_track_filter.please(action["name"])

      var filter_changed = _.find(newState.filters_zone.filters, function(filter){return filter.name === action.name});
      filter_changed.is_checked = action.value;
      clara.aides_iterate_through_aids.please(clara.aides_update_filtering.please, newState);
    }
    else if (action.type === 'TOGGLE_FILTERS_ZONE') {
      newState.filters_zone.is_collapsed = !newState.filters_zone.is_collapsed;
    }
    else if (action.type === 'TOGGLE_RECAP_ZONE') {
      newState.recap_zone.is_collapsed = !newState.recap_zone.is_collapsed;
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
    
    clara.aides_set_state.please(newState);


    return newState;
  
  }


});
