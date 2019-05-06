clara.js_define("admin_rules", {

  please: function() {
    
    // console.log("hey " + $.urlParam("search").replace(/\+/g, ""))
    // console.log(_.isBlank($.urlParam("search").replace(/\+/g, "")))

    // there is a search
    if (_.isString($.urlParam("search"))) {
      var search_terms = $.urlParam("search").replace(/\+/g, "");
      // but search has no terms
      if (_.isEmpty(search_terms)) {

      } else { // search occured with some words
        
      }
    }
    
    var red_array = []
    var errored_simulations = $("[data-val]").filter(function( index ) {
      return $( this ).attr("data-val") === "errored_simulation";
    }).toArray();
    var missing_simulations = $("[data-val]").filter(function( index ) {
      return $( this ).attr("data-val") === "missing_simulation";
    }).toArray();
    var missing_eligibles = $("[data-val]").filter(function( index ) {
      return $( this ).attr("data-val") === "missing_eligible";
    }).toArray();
    var missing_ineligibles = $("[data-val]").filter(function( index ) {
      return $( this ).attr("data-val") === "missing_ineligible";
    }).toArray();



    var red_array = _.concat(errored_simulations, missing_simulations, missing_eligibles, missing_ineligibles);

    console.log(red_array);



    _.each(red_array, function(red){
      $(red).prepend("<span class='c-red-control'> • </span>");
    })

  }

});
