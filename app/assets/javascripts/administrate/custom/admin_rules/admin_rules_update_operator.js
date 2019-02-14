
clara.js_define("admin_rules_update_operator", {

  please_if: _.stubFalse,

  please: function() {
    var s = main_store.getState();
    // 1 - Display only what is properly translated
    $("#rule_operator_kind").find("option").attr("disabled", "disabled")

    if (!_.isEmpty(s.selected_variable)) {
      var auth_expls = _.filter(s.explicitations, function(expl) {
        return s.selected_variable == expl.variable_name
      });
      console.log("auth_expls")
      console.log(auth_expls)
      var auth_ops = _.uniqBy(_.map(auth_expls, function(e){return e.operator_kind}));
      console.log("auth_ops")
      console.log(auth_ops)

      _.each(auth_ops, function(auth_op){
        $("#rule_operator_kind").find('option[value="' + auth_op + '"]').removeAttr("disabled")
      });

    }
    // _.each(s.operator_kinds, function(op){
    //   if ()
    // });
    // 2 - Select the one of the model
    $("#rule_operator_kind").val(s["selected_operator"]);

  },


 });
