

clara.js_define("zu_clean_select", {

  please_if: _.stubFalse,

  please: function(arg_h) {
    var $select = arg_h.for_select
    if ($select.find("option").length === 2) {
      $select.find('option[value=""]').remove();
    }
  }


});
