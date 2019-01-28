

clara.js_define("zs_admin_rule_form", {

  please_if: function() {
    return $('form[id*="_rule"]').length > 0;
  },


  please: function() {
    var kind = $('form[id*="_rule"]').attr("data-kind");
    if (kind === "simple") {
      clara.admin_simple_rule_form.dress();
    }
  }

});
