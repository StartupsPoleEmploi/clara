clara.js_define("zs_admin_rule_form", {

  please_if: function() {
    return $('select[id$="_variable_id"]').exists() && !$(".c-rulecreation").exists() && !$('body[data-path="new_admin_explicitation_path"]').exists() && !$('body[data-path="edit_admin_explicitation_path"]').exists();
  },


  please: function() {
    clara.admin_simple_rule_form.dress();
    store_rule.dispatch({type: 'INIT'});
  }

});
