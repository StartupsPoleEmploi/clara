clara.js_define("intercept_start_by_contract", {

    please_if: function() {
      return $(".c-detail-cta.js-contract").exists();
    },

    please: function() {
      var FILTER_TABLE = {
        "aide-a-la-mobilite": "se-deplacer",
        "aide-a-la-creation-ou-reprise-d-entreprise": "creer-entreprise",
        "contrat-specifique": "s-informer-sur-contrats-specifiques",
        "aide-regionale": "pres_de_chez_vous",
        "emploi-international": "travailler-a-l-international",
        "aide-a-la-definition-du-projet-professionnel": "trouver-change-de-metier",

      }
      var current_contract = _.last(window.location.pathname.split("/"))
      var matching_filter = FILTER_TABLE[current_contract]
      $(".c-detail-cta.js-contract").click(function(e){
          e.preventDefault();
          var href = this.href;
          localStorage.setItem("choosen_filters", JSON.stringify([matching_filter]));          
          location.href = href;
      });
    },

});

