clara.js_define("admin_rules", {

  please: function() {
    
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



    // put some red circles
    var red_array = _.concat(errored_simulations, missing_simulations, missing_eligibles, missing_ineligibles);
    _.each(red_array, function(red){
      $(red).prepend("<span class='c-red-control'> • </span>");
    })

    // left-align red circle explanation
    var targeted_left_position = $($("span[data-key^='rule.simulated']")[0]).position().left;
    var get_actual_left_position = function() {
      return $(".c-red-control").position().left;
    }
    var offset = 0;
    while (offset < 300 && get_actual_left_position() < targeted_left_position) {
      offset += 1;
      $(".c-rules-warning").css("margin-left", offset + "px");
    }

    // launch modal when clicking on aides
    $("[data-names]").click(function(event){
      var $title = $(".c-aidview-title strong");
      var link = event.target
      var names_str = $(this).attr("data-names");
      var no_name = _.isBlank(names_str);
      var names_ary = names_str.split(",")
      var number_of_aids = _.count(names_ary, _.isNotEmpty);
      var html_str = "";
      if (number_of_aids === 0) {
        $title.html("Aucune aide concernée")
      } else if (number_of_aids === 1) {
        $title.html("Aide concernée")
        html_str = "<div class='small-bottom-margin'>" + names_ary[0] + "</div>";
      } else {
        $title.html("Aides concernées")
        html_str = _.map(names_ary, function(name){return "<div class='small-bottom-margin'>" + name + "</div>"}).join("")
      }
      $(".c-aidview-line").html(html_str)        
      $("button.c-aidview").click();

      // setup backfocus
      var id = (new Date()).getTime();
      $("#label_modal_1").attr("id", "label_modal_1_" + id);
      $(link).attr("id", "label_modal_1");
      $("#js-modal-close").attr("data-focus-back", "label_modal_1");

    });

  }

});
