

clara.js_define("zs_admin_rule_form", {

  please_if: function() {
    return $('select[id$="_variable_id"]').exists() && !$(".c-rulecreation").exists();
  },


  please: function() {
    clara.admin_simple_rule_form.dress();
    store_rule.dispatch({type: 'INIT'});
  }

});
