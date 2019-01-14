

clara.js_define("zu_clean_select", {

  trigger_function: _.stubFalse,

  main_function: function(arg_h) {
    var that = this;
    that._remove_empty_option_if_only_one_choice(arg_h);
    that._sort_options_alphabetically(arg_h);
  },

  _remove_empty_option_if_only_one_choice: function(arg_h) {
    $select = arg_h.for_select
    if ($select.find("option").length === 2) {
      $select.find('option[value=""]').remove();
    }
  },

  _sort_options_alphabetically: function(arg_h) {
    $select = arg_h.for_select

    var my_options = $select.find("option");
    var selected = $select.val();

    my_options.sort(function(a,b) {
        if (a.text > b.text) return 1;
        if (a.text < b.text) return -1;
        return 0
    });

    $select.empty().append( my_options );
    $select.val(selected);
  }

});
