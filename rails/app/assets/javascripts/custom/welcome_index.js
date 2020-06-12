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
        $(".c-home-catalog-lastlayout").after(strPenultimate);
          
      });



      var strPenultimate="";
      strPenultimate += "<div class='o-layout'>";
      strPenultimate += "<div class='o-layout__item u-1/1 u-1/2@wide'>";
      strPenultimate += "<div class='c-home-catalog-card'>";
      strPenultimate += "<div class='o-media'>";
      strPenultimate += "<div class='o-media__img c-home-catalog-cardimg'>";
      strPenultimate += "<img alt='mobilité' src='";
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
      strPenultimate += "<img alt='international' src='/assets/image_travailler_international-1de8cb26246da3b9e23a78d625ba3e549fbc2ffe823fe5e4a7c9f1b13fa0c600.jpg'>";
      strPenultimate += "</div>";
      strPenultimate += "<div class='o-media__body c-home-catalog-cardbody'>";
      strPenultimate += "<div class='c-home-catalog-cardtxt1'>";
      strPenultimate += "<span>";
      strPenultimate += "Se former,";
      strPenultimate += "</span>";
      strPenultimate += "<span>";
      strPenultimate += "ou travailler à";
      strPenultimate += "</span>";
      strPenultimate += "<span>";
      strPenultimate += "l'international";
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


    },

});

