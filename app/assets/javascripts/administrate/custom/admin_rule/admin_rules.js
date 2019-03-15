clara.js_define("admin_rules", {

  please: function() {
    
    console.log("hey " + (new Date()).toString())
    
    var red_array = []
    var missing_simulations = $("[data-val]").filter(function( index ) {
      return $( this ).attr("data-val") === "missing_simulation";
    }).toArray();
    var missing_eligibles = $("[data-val]").filter(function( index ) {
      return $( this ).attr("data-val") === "missing_eligible";
    }).toArray();
    var missing_ineligibles = $("[data-val]").filter(function( index ) {
      return $( this ).attr("data-val") === "missing_ineligible";
    }).toArray();



    var red_array = _.concat(missing_simulations, missing_eligibles, missing_ineligibles);

    _.each(red_array, function(red){
      $(red).closest(".js-table-row").addClass("is-red");
    })

  }

});
