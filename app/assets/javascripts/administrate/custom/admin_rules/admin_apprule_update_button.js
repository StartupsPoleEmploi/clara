
clara.js_define("admin_apprule_update_button", {

  please_if: _.stubFalse,

  please: function(state) {
    console.log('fire')
    var that = clara.admin_rules_update_explanation;
    var s = state
    var is_not_empty = function(e){return !_.isEmpty(_.trim(e))}

    var all_selected = 
      _.every([s.selected_operator, s.selected_variable, s.selected_value], is_not_empty);

    if (all_selected) {
      $(".c-apprule-button.is-validation").show(200)
    } else {
      $(".c-apprule-button.is-validation").hide(200)
    }
  },



});
