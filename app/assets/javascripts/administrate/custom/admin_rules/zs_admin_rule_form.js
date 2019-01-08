

clara.js_define("zs_admin_rule_form", {

  trigger_function: function() {
    return $('form[id*="_rule"]').length > 0;
  },


  main_function: function() {
    var kind = $('form[id*="_rule"]').attr("data-kind");
    if (kind === "simple") {
      clara.admin_simple_rule_form.dress();
    }
  }

});
