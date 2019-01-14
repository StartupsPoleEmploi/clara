

clara.js_define("zu_clean_select", {

  trigger_function: _.stubFalse,

  main_function: function(arg_h) {
    var that = this;
    that._remove_empty_option_if_only_one_choice(arg_h);
    that._sort_options_alphabetically();
  },

  _remove_empty_option_if_only_one_choice: function(arg_h) {
    $select = arg_h.for_select
    if ($select.find("option").length === 2) {
      $select.find('option[value=""]').remove();
    }
  },

  _sort_options_alphabetically: function() {

  }

});
