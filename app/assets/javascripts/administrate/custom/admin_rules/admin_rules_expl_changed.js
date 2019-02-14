
clara.js_define("admin_rules_expl_changed", {

  please_if: _.stubFalse,

  please: function() {
    console.log("anything changed!")
    var s = main_store.getState()
    var all_selected = 
      _.every(
        [s.selected_operator, 
        s.selected_variable, 
        s.selected_value],
        function(e){return !_.isEmpty(_.trim(e))}
      );
    if (all_selected) {
      console.log("all_selected")
      var found_value =
        _.find(s.explicitations, function(expl) {
          var res = false;
          console.log(expl)
          console.log(s.selected_variable)
          console.log(s.selected_operator)
          console.log(s.selected_value)
          if (expl.variable_name === s.selected_variable) {
            console.log("1st")
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
      console.log("found_value is ")
      console.log(found_value)
      if (found_value) {
        $(".expl-text").html(found_value.template)
      }
    }
  },




 });
