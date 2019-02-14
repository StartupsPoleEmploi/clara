
clara.js_define("admin_rules_update_operator", {

  please_if: _.stubFalse,

  please: function() {
    var s = main_store.getState();
    // 1 - Remove all options
    $("#rule_operator_kind").find("option").attr("disabled", "disabled")

    if (!_.isEmpty(s.selected_variable)) {
      var auth_expls = _.filter(s.explicitations, function(expl) {
        return s.selected_variable == expl.variable_name
      });
      var auth_ops = _.uniqBy(_.map(auth_expls, function(e){return e.operator_kind}));

      // 2 - Display only options that are tied to explanations, if apply
      _.each(auth_ops, function(auth_op){
        $("#rule_operator_kind").find('option[value="' + auth_op + '"]').removeAttr("disabled")
      });

    } else { // if no var, just display all ops
      $("#rule_operator_kind").find("option").removeAttr("disabled")
    }

    // 3 - Select the one of the model
    $("#rule_operator_kind").val(s["selected_operator"]);

  },


 });
