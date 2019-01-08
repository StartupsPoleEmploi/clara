
clara.js_define("zu_admin", {

  // Never trigger, because it is a utility function
  trigger_function: _.stubFalse,

  detect_simple_rule: function() {
    var selector = '#rule_operator_type option[selected="selected"]'
    var has_already_operator = $(selector).present();
    var has_simple_urlparam = $.urlParam("rule_kind") === "simple";
    var is_an_admin_rule = _.startsWith($.currentRelativePath(), "/admin/rules")
    return is_an_admin_rule && (has_already_operator || has_simple_urlparam);
  },
  detect_composite_rule: function() {
    var selector = '#rule_composition_type option[selected="selected"]'
    var has_already_composition = $(selector).present();
    var has_composite_urlparam = $.urlParam("rule_kind") === "composite"
    var is_an_admin_rule = _.startsWith($.currentRelativePath(), "/admin/rules")
    return is_an_admin_rule && (has_already_composition || has_composite_urlparam);
  },
  remove_line_with_label: function(content_str){
    var that = this;
    var $composition_type_line = that.find_labeled_line(content_str)
    if ($composition_type_line.length !== 1) throw {message: "There must be exactly one '" + content_str + "' field"}
    $composition_type_line.remove();
  },
  find_labeled_line: function(id_label) {
    var $res = $();
    var $found_label = $('.field-unit .field-unit__label label').filter(function(i,e){return _($(e).attr("id")).voidString().value() === id_label});
    if ($found_label.length) {
      $res = $found_label.parent().parent();
    }
    return $res;
  },
  find_option_with_text: function(option_txt) {
    return $($('option').filter(function(i,e){return $(e).text().trim().toLowerCase().indexOf(option_txt.toLowerCase()) === 0;})[0]);
  },
  find_label: function(label_str) {
    return this.find_labeled_line(label_str).find("label");
  },
  find_input_with_text: function(label_str) {
    var that = this;
    var lines = this.find_labeled_line(label_str).parent().find(".field-unit__field").children();
    var $correct_lines = $(lines).filter(function(i,e){ return !!$(e).attr("name")});
    return $($correct_lines[0]);
  },

});
