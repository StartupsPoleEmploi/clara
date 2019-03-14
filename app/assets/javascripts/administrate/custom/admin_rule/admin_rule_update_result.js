
clara.js_define("admin_rule_update_result", {

  please_if: _.stubFalse,

  please: function(store) {
    var s = store.getState();
    if (s.is_registerable) {
      $(".c-simulator-registration").html('<div class="simulation-save"><input type="text" class="simulation-save__name"> <button class="simulation-save__action" id="btn-save">💾</button></div>')
      if (s.current_simulation.result == "uncertain") {
        $(".c-simulator-result").html('<div class="eligibility-uncertain eligibility-sth"> &#9888; Le résultat est incertain</div>')
      } else if (s.current_simulation.result == "eligible") {
        $(".c-simulator-result").html('<div class="eligibility-ok eligibility-sth"> &#x2714; Le DE est éligible</div>')
      } else if (s.current_simulation.result == "ineligible") {
        $(".c-simulator-result").html('<div class="eligibility-nok eligibility-sth">&#x2716; Le DE est inéligible</div>')
      }
    } else {
      $(".c-simulator-result").html('<div class="eligibility-nothing"></div>')
      $(".c-simulator-registration").html('')
    }
  },


 });
