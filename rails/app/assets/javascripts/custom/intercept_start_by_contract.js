clara.js_define("intercept_start_by_contract", {

    please_if: function() {
      return $(".c-detail-cta.js-contract").exists();
    },

    please: function() {
      // HACK : hard-coded mapping
      var FILTER_TABLE = {
        "appui-a-l-embauche": ["accompagne-recherche-emploi", "se-deplacer"],
        "aide-a-la-definition-du-projet-professionnel": ["trouver-change-de-metier"],
        "aide-a-la-mobilite": ["se-deplacer"],
        "dispositif-de-conversion-d-experience-en-titre": ["se-former-valoriser-ses-competences", "percevoir-une-remuneration-pendant-la-formation"],
        "aide-a-la-creation-ou-reprise-d-entreprise": ["creer-entreprise"],
        "emploi-international": ["travailler-a-l-international"],
        "contrat-specifique": ["s-informer-sur-contrats-specifiques"],
        "financement-aide-a-la-formation": ["se-former-valoriser-ses-competences", "percevoir-une-remuneration-pendant-la-formation", "se-deplacer"],
        "aide-regionale": ["pres_de_chez_vous"],
      }
      var current_contract = _.last(window.location.pathname.split("/"))
      var matching_filters = FILTER_TABLE[current_contract]
      $(".c-detail-cta.js-contract").click(function(e){
          e.preventDefault();
          var href = this.href;
          localStorage.setItem("choosen_filters", JSON.stringify(matching_filters));          
          location.href = href;
      });
    },

});

