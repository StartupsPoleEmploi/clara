clara.js_define("admin_edit_aid_reducer", {

  please_if: _.stubFalse,

  please: function(state, action) {

    // Deep copy of previous state to avoid side-effects
    var newState = _.cloneDeep(state);

    if (action.type === 'INIT') {
      // do nothing
    } else if (action.type === 'ADDITIONNAL_CONDITIONS_CHANGED') {
      newState.additionnal_conditions = action.value
    } else if (action.type === 'HOW_AND_WHEN_CHANGED') {
      newState.how_and_when = action.value
    } else if (action.type === 'HOW_MUCH_CHANGED') {
      newState.how_much = action.value
    } else if (action.type === 'LIMITATIONS_CHANGED') {
      newState.limitations = action.value
    } else if (action.type === 'WHAT_CHANGED') {
      newState.what = action.value
    } else if (action.type === 'TITLE_CHANGED') {
      newState.title = action.value
    } else if (action.type === 'CONTRACT_CHANGED') {
      newState.contract = action.value
    }
    return newState;
  }


});
