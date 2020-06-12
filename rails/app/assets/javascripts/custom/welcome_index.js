clara.js_define("welcome_index", {

    please_if: function() {
      return $("body").hasClasses("welcome", "index");
    },

    please: function() {

      store.clearAll();
      console.log("Version : " + clara.version);

      // $(document).scroll(function() {
      //   var scroll_position = $(document).scrollTop();
      //   if (scroll_position > 0) {
      //     $(".c-newhomehero-covid").addClass("is-scrolled");
      //     $(".c-newhomehero__header").addClass("is-scrolled");
      //   } else {
      //     $(".c-newhomehero-covid").removeClass("is-scrolled");
      //     $(".c-newhomehero__header").removeClass("is-scrolled");
      //   }
      // });

      function setFocusIframe() {
        var iframe = $("#video-clara")[0];
        iframe.contentWindow.focus();
      }

      $(".c-seevideo").click(function(){
        var html = '<iframe id="video-clara" width="720" height="405" src="https://www.youtube.com/embed/8IDnLjfAt5U?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>';
        $(".c-video-container").html(html);
        setTimeout(setFocusIframe, 500);
      });

      var intercept_link_and_call_ga = function(event_name, e, url) {
        var local_ga = _.get(window, "ga");
        e.preventDefault();
        var href = url;
        if (typeof local_ga === "function") {
          local_ga('send', 'event', 'home', 'chip', event_name);
        }
        location.href = href;
      }

      var intercept_link_and_set_filters = function() {

        $("a.c-am-i-eligible").click(function(e) {
          e.preventDefault();
          var href = this.href;
          var choosen_filter = $(this).data('filter');
          console.log($(this).data('filter'));
          localStorage.setItem("choosen_filters", JSON.stringify([choosen_filter]));          
          location.href = href;
        });

      }

      intercept_link_and_set_filters();

      $("a.c-chip-creation").click(function(e){
        intercept_link_and_call_ga('creation', e, this.href);
      });
      $("a.c-chip-mobilite").click(function(e){
        intercept_link_and_call_ga('mobilite', e, this.href);
      });
      $("a.c-chip-formation").click(function(e){
        intercept_link_and_call_ga('formation', e, this.href);
      });
      $("a.c-chip-projetpro").click(function(e){
        intercept_link_and_call_ga('projetpro', e, this.href);
      });

      $("button.c-home-catalog-seemore").click(function(e){
        $(".c-home-catalog-seemore-container").remove();
        $(".c-home-catalog-lastlayout").after(strUltimate);
        $(".c-home-catalog-lastlayout").after(strPenultimate);
        $("a.c-am-i-eligible").off();
        intercept_link_and_set_filters();
      });




      var strPenultimate="";
      strPenultimate += "<div class='o-layout c-home-catalog-penultimate'>";
      strPenultimate += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      strPenultimate += "<div class='c-home-catalog-card'>";
      strPenultimate += "<div class='o-media'>";
      strPenultimate += "<div class='o-media__img c-home-catalog-cardimg'>";
      strPenultimate += "<img alt='Percevoir une rémunération pendant la formation' src='";
      strPenultimate += $(".c-home-catalog-penultimate").data("src1");
      strPenultimate += "'>";
      strPenultimate += "</div>";
      strPenultimate += "<div class='o-media__body c-home-catalog-cardbody'>";
      strPenultimate += "<div class='c-home-catalog-cardtxt1'>";
      strPenultimate += "<span>";
      strPenultimate += "Percevoir une rémunération pendant la formation";
      strPenultimate += "</span>";
      strPenultimate += "</div>";
      strPenultimate += "<div class='c-home-catalog-cardtxt2'>";
      strPenultimate += "<a class='c-am-i-eligible' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";
      strPenultimate += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      strPenultimate += "<div class='c-home-catalog-card'>";
      strPenultimate += "<div class='o-media'>";
      strPenultimate += "<div class='o-media__img c-home-catalog-cardimg'>";
      strPenultimate += "<img alt='garde enfants' src='";
      strPenultimate += $(".c-home-catalog-penultimate").data("src2");
      strPenultimate += "'>";
      strPenultimate += "</div>";
      strPenultimate += "<div class='o-media__body c-home-catalog-cardbody'>";
      strPenultimate += "<div class='c-home-catalog-cardtxt1'>";
      strPenultimate += "<span>";
      strPenultimate += "Bénéficier d'une";
      strPenultimate += "</span>";
      strPenultimate += "<span>";
      strPenultimate += "aide à la";
      strPenultimate += "</span>";
      strPenultimate += "<span>";
      strPenultimate += "garde d'enfants";
      strPenultimate += "</span>";
      strPenultimate += "</div>";
      strPenultimate += "<div class='c-home-catalog-cardtxt2'>";
      strPenultimate += "<a class='c-am-i-eligible' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";
      strPenultimate += "</div>";

      var strUltimate="";
      strUltimate += "<div class='o-layout c-home-catalog-ultimate'>";
      strUltimate += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      strUltimate += "<div class='c-home-catalog-card'>";
      strUltimate += "<div class='o-media'>";
      strUltimate += "<div class='o-media__img c-home-catalog-cardimg'>";
      strUltimate += "<img alt='Contrats spécifiques' src='";
      strUltimate += $(".c-home-catalog-ultimate").data("src1");
      strUltimate += "'>";
      strUltimate += "</div>";
      strUltimate += "<div class='o-media__body c-home-catalog-cardbody'>";
      strUltimate += "<div class='c-home-catalog-cardtxt1'>";
      strUltimate += "<span>";
      strUltimate += "Connaître les contrats pour les publics spécifiques";
      strUltimate += "</span>";
      strUltimate += "</div>";
      strUltimate += "<div class='c-home-catalog-cardtxt2'>";
      strUltimate += "<a class='c-am-i-eligible' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      strUltimate += "</div>";
      strUltimate += "</div>";
      strUltimate += "</div>";
      strUltimate += "</div>";
      strUltimate += "</div>";
      strUltimate += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      strUltimate += "<div class='c-home-catalog-card'>";
      strUltimate += "<div class='o-media'>";
      strUltimate += "<div class='o-media__img c-home-catalog-cardimg'>";
      strUltimate += "<img alt='dans ma région' src='";
      strUltimate += $(".c-home-catalog-ultimate").data("src2");
      strUltimate += "'>";
      strUltimate += "</div>";
      strUltimate += "<div class='o-media__body c-home-catalog-cardbody'>";
      strUltimate += "<div class='c-home-catalog-cardtxt1'>";
      strUltimate += "<span>";
      strUltimate += "Les aides";
      strUltimate += "</span>";
      strUltimate += "<span>";
      strUltimate += "dans ma région";
      strUltimate += "</span>";
      strUltimate += "</div>";
      strUltimate += "<div class='c-home-catalog-cardtxt2'>";
      strUltimate += "<a class='c-am-i-eligible' href='/inscription_questions/new'>Suis-je éligible ?</a>";
      strUltimate += "</div>";
      strUltimate += "</div>";
      strUltimate += "</div>";
      strUltimate += "</div>";
      strUltimate += "</div>";
      strUltimate += "</div>";

    },

});

