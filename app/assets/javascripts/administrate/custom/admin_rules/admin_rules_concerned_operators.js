
clara.js_define("admin_rules_concerned_operator", {

  please_if: _.stubFalse,

  please: function(state, given_variable) {
    var result = "";
    // console.log("admin_rules_concerned_operator")
    // console.log(state, given_variable);
    var auth_expls = _.filter(state.explicitations, function(expl) {
      return given_variable == expl.variable_name
    });
    var auth_ops = _.uniqBy(_.map(auth_expls, function(e){return e.operator_kind}));
    console.log(auth_ops)
    if (auth_ops.length === 1) {
      result= auth_ops[0]
    }
    return result;
  },


 });
