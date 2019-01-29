clara.js_define("aides_initial_eligy", {

  please_if: _.stubFalse,

  please: function(eligy) {
    return _.map(
      clara.aides_$card.please(eligy).datamap("cslug"), 
      function(contract_name){
        return {
          name: contract_name, 
          is_collapsed: true,
          aids: _.map(
            clara.aides_$aids_per_card.please(eligy, contract_name).datamap("aslug"),
            function(aid_name) {
              return {
                name: aid_name,
                is_collapsed: false,
                filters: _.map(
                  clara.aides_$filters_per_aid.please(eligy, contract_name, aid_name).datamap("name"),
                  function(filter_name) {
                    return {
                      name: filter_name,
                      is_collapsed: false,
                    }
                  }
                )
              }
            }
          )
        }
      }
    );
  }


});
