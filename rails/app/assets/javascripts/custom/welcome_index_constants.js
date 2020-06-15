clara.js_define("welcome_index_constants", {

    please_if: _.stubFalse,

    strFirst: function() {
      var res="";
      res += "<div class='o-layout c-home-catalog-first'>";
      res += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      res += "<div class='c-home-catalog-card'>";
      res += "<div class='o-media'>";
      res += "<div class='o-media__img c-home-catalog-cardimg'>";
      res += "<img alt='Se former' src='";
      res += $(".c-home-catalog-firstline").data("src1");
      res += "'>";
      res += "</div>";
      res += "<div class='o-media__body c-home-catalog-cardbody'>";
      res += "<div class='c-home-catalog-cardtxt1'>";
      res += "<span>";
      res += "Se former, obtenir";
      res += "</span>";
      res += "<span>";
      res += "ou valider un diplôme";
      res += "</span>";
      res += "</div>";
      res += "<div class='c-home-catalog-cardtxt2'>";
      res += "<a class='c-am-i-eligible' data-filter='se-former-valoriser-ses-competences' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      res += "<div class='c-home-catalog-card'>";
      res += "<div class='o-media'>";
      res += "<div class='o-media__img c-home-catalog-cardimg'>";
      res += "<img alt='être accompagné dans sa recherche' src='";
      res += $(".c-home-catalog-firstline").data("src2");
      res += "'>";
      res += "</div>";
      res += "<div class='o-media__body c-home-catalog-cardbody'>";
      res += "<div class='c-home-catalog-cardtxt1'>";
      res += "<span>";
      res += "Être accompagné";
      res += "</span>";
      res += "<span>";
      res += "dans sa recherche";
      res += "</span>";
      res += "</div>";
      res += "<div class='c-home-catalog-cardtxt2'>";
      res += "<a class='c-am-i-eligible' data-filter='accompagne-recherche-emploi' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      return res;
    },

    strUltimate: function() {
      var res="";
      res += "<div class='o-layout c-home-catalog-ultimate'>";
      res += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      res += "<div class='c-home-catalog-card'>";
      res += "<div class='o-media'>";
      res += "<div class='o-media__img c-home-catalog-cardimg'>";
      res += "<img alt='Contrats spécifiques' src='";
      res += $(".c-home-catalog-ultimate").data("src1");
      res += "'>";
      res += "</div>";
      res += "<div class='o-media__body c-home-catalog-cardbody'>";
      res += "<div class='c-home-catalog-cardtxt1'>";
      res += "<span>";
      res += "Connaître les contrats pour les publics spécifiques";
      res += "</span>";
      res += "</div>";
      res += "<div class='c-home-catalog-cardtxt2'>";
      res += "<a class='c-am-i-eligible' data-filter='s-informer-sur-contrats-specifiques' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      res += "<div class='c-home-catalog-card'>";
      res += "<div class='o-media'>";
      res += "<div class='o-media__img c-home-catalog-cardimg'>";
      res += "<img alt='dans ma région' src='";
      res += $(".c-home-catalog-ultimate").data("src2");
      res += "'>";
      res += "</div>";
      res += "<div class='o-media__body c-home-catalog-cardbody'>";
      res += "<div class='c-home-catalog-cardtxt1'>";
      res += "<span>";
      res += "Les aides";
      res += "</span>";
      res += "<span>";
      res += "dans ma région";
      res += "</span>";
      res += "</div>";
      res += "<div class='c-home-catalog-cardtxt2'>";
      res += "<a class='c-am-i-eligible' data-filter='pres_de_chez_vous' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      return res;
    },

    strPenultimate: function() {

      var res="";
      res += "<div class='o-layout c-home-catalog-penultimate'>";
      res += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      res += "<div class='c-home-catalog-card'>";
      res += "<div class='o-media'>";
      res += "<div class='o-media__img c-home-catalog-cardimg'>";
      res += "<img alt='Percevoir une rémunération pendant la formation' src='";
      res += $(".c-home-catalog-penultimate").data("src1");
      res += "'>";
      res += "</div>";
      res += "<div class='o-media__body c-home-catalog-cardbody'>";
      res += "<div class='c-home-catalog-cardtxt1'>";
      res += "<span>";
      res += "Percevoir une rémunération pendant la formation";
      res += "</span>";
      res += "</div>";
      res += "<div class='c-home-catalog-cardtxt2'>";
      res += "<a class='c-am-i-eligible' data-filter='percevoir-une-remuneration-pendant-la-formation' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      res += "<div class='c-home-catalog-card'>";
      res += "<div class='o-media'>";
      res += "<div class='o-media__img c-home-catalog-cardimg'>";
      res += "<img alt='garde enfants' src='";
      res += $(".c-home-catalog-penultimate").data("src2");
      res += "'>";
      res += "</div>";
      res += "<div class='o-media__body c-home-catalog-cardbody'>";
      res += "<div class='c-home-catalog-cardtxt1'>";
      res += "<span>";
      res += "Bénéficier d'une";
      res += "</span>";
      res += "<span>";
      res += "aide à la";
      res += "</span>";
      res += "<span>";
      res += "garde d'enfants";
      res += "</span>";
      res += "</div>";
      res += "<div class='c-home-catalog-cardtxt2'>";
      res += "<a class='c-am-i-eligible' data-filter='garder-enfant' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      res += "</div>";
      return res;
    },


});

