clara.js_define("welcome_index", {

  please_if: function() {
    return $("body").hasClasses("welcome", "index");
  },

  please: function() {

    store.clearAll();
    console.log("Version : " + clara.version);

    $(document).scroll(function() {
      var scroll_position = $(document).scrollTop();
      if (scroll_position > 800 && !$(".c-home-catalog-first").exists()) {
        $("h2.c-home-catalog-title").after(clara.welcome_index_constants.strSecond());
        $("h2.c-home-catalog-title").after(clara.welcome_index_constants.strFirst());
        $("a.c-am-i-eligible").off();
        intercept_link_and_set_filters();
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

    var intercept_link_and_set_filters = function() {

      $("a.c-am-i-eligible").click(function(e) {
        e.preventDefault();
        var href = this.href;
        var choosen_filter = $(this).data('filter');
        localStorage.setItem("choosen_filters", JSON.stringify([choosen_filter]));          
        location.href = href;
      });

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
      $(".c-home-catalog-lastlayout").after(clara.welcome_index_constants.strUltimate());
      $(".c-home-catalog-lastlayout").after(clara.welcome_index_constants.strPenultimate());

      $("a.c-am-i-eligible").off();
      intercept_link_and_set_filters();
    });
  }
});

