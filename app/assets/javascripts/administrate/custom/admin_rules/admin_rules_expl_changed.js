
clara.js_define("admin_rules_expl_changed", {

  please_if: _.stubFalse,

  please: function() {
    console.log("anything changed!")
    var s = main_store.getState()
    var all_selected = 
      _.every(
        [s.selected_operator, s.selected_variable, s.selected_value],
        function(e){return !_.isEmpty(_.trim(e))}
      );
    if (all_selected) {
      console.log("all_selected")
    }
  },




 });
