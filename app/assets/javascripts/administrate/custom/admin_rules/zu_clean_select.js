

clara.js_define("zu_clean_select", {

  trigger_function: _.stubFalse,

  main_function: function(arg_h) {
    var $select = arg_h.for_select
    if ($select.find("option").length === 2) {
      $select.find('option[value=""]').remove();
    }
  }


});
