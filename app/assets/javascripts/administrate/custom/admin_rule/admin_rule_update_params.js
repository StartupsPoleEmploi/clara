
clara.js_define("admin_rule_update_params", {

  please_if: _.stubFalse,

  please: function(state) {
    $( "input[name^='asker[']" ).val("")
    var params = state.current_simulation.params;
    _.each(params, function(v, k){
      $("#" + k).val(v);
    });
  },


 });
