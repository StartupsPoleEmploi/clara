
clara.js_define("admin_rules_expl_changed", {

  please_if: _.stubFalse,

  please: function() {
    var that = clara.admin_rules_expl_changed;
    var s = main_store.getState()
    var is_not_empty = function(e){return !_.isEmpty(_.trim(e))}

    var all_selected = 
      _.every([s.selected_operator, s.selected_variable, s.selected_value], is_not_empty);
    var only_var_and_op_selected = 
      _.every([s.selected_operator, s.selected_variable], is_not_empty);
    var only_var_selected = 
      _.every([s.selected_variable], is_not_empty);

    if (all_selected) {
      var found_value = that._look_for_explicitation(s);
      if (found_value) {
        var text_to_display = found_value.template.replace("XX", s.selected_value)
        $(".expl-text").html(text_to_display)
      }
    } else if (only_var_and_op_selected) {
        $(".expl-text").html("(Veuillez renseigner une valeur, l'explication apparaîtra ici)");
    }
  },

  _look_for_explicitation: function(s) {
    return _.find(s.explicitations, function(expl) {
      var res = false;
      if (expl.variable_name === s.selected_variable) {
        if (expl.operator_kind === s.selected_operator) {
          if (expl.value_eligible === null) {
            res = true;
          } else if (expl.value_eligible === s.selected_value) {
            res = true;
          }
        }  
      }  
      return res;
    });
  }


});
