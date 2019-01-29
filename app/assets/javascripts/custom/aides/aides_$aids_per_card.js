clara.js_define("aides_$aids_per_card", {

  please_if: _.stubFalse,

  please: function(eligy, contract_name) {
    return $('#' + eligy + 
        ' .c-resultcard[data-cslug="' + contract_name + '"]' +
        ' .c-resultaid');
  }

});
