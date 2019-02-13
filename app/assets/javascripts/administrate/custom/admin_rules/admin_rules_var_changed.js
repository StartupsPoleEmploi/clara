
clara.js_define("admin_rules_var_changed", {

  please_if: _.stubFalse,

  please: function(newVal, oldVal, objectPath, stateCopy) {
    console.log('Variable : %s changed from %s to %s', objectPath, oldVal, newVal)
    var s = stateCopy
    var currentVar = _.find(s.variables, function(e){return e.name == newVal})
    console.log(currentVar)
    var currentType = currentVar.variable_kind
  }


});
