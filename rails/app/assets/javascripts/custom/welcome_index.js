clara.js_define("welcome_index", {

    please_if: function() {
      return $("body").hasClasses("welcome", "index");
    },

    please: function() {
   

      store.clearAll();
      console.log("Version : " + clara.version);

      $(document).scroll(function() {
        var scroll_position = $(document).scrollTop();
        if (scroll_position > 0) {
          $(".c-newhomehero-covid").addClass("is-scrolled");
          $(".c-newhomehero__header").addClass("is-scrolled");
        } else {
          $(".c-newhomehero-covid").removeClass("is-scrolled");
          $(".c-newhomehero__header").removeClass("is-scrolled");
        }
      });

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


    },

});

