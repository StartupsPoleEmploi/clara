clara.js_define("aides_$filters_per_aid", {

  please_if: _.stubFalse,

  please: function(eligy, contract_name, aid_name) {
    return $(
      '#' + eligy + 
      ' .c-resultcard[data-cslug="' + contract_name + '"]' +
      ' .c-resultaid[data-aslug="' + aid_name + '"] .c-resultfilter');
  }

});
