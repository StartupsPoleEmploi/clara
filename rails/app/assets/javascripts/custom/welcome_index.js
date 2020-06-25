clara.js_define("welcome_index", {

  please_if: function() {
    return $("body").hasClasses("welcome", "index");
  },

  please: function() {

    store.clearAll();
    console.log("Version : " + clara.version);

    $(".c-newhomehero-discovertxt").click(function(e){$(".c-seevideo").click()})

    $(".c-newhomehero-discovertxt").click(function(e){$(".c-seevideo").click()})
    $('.c-newhomehero-discovertxt').hover(function() {
        $('.c-seevideo').addClass('hover');
    }, function(){
        $('.c-seevideo').removeClass('hover');
    })

    var sticky_calc = function() {      
      var ELT = "input.c-main-cta2"
      var top_of_element = $(ELT).offset().top;
      var bottom_of_element = $(ELT).offset().top + $(ELT).outerHeight();
      var bottom_of_screen = $(window).scrollTop() + $(window).innerHeight();
      var top_of_screen = $(window).scrollTop();

      if ((bottom_of_screen > top_of_element) && (top_of_screen < bottom_of_element)){
          // main CTA is visible, hide recall of CTA
          $(".c-home-sticky").css("display", "none")
      } else {
          // main CTA not visible, display recall of CTA
          $(".c-home-sticky").css("display", "block")
      }
    };
    sticky_calc();
    $(window).scroll(sticky_calc);

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
      e.preventDefault();
      var href = url;
      var local_ga = _.get(window, "ga");
      if (typeof local_ga === "function") {
        local_ga('send', 'event', 'home', 'chip', event_name);
      }
      location.href = href;
    }

    var intercept_filters_links = function() {

      $("a.c-am-i-eligible").click(function(e) {
        e.preventDefault();
        var href = this.href;
        var choosen_filter = $(this).data('filter');
        localStorage.setItem("choosen_filters", JSON.stringify([choosen_filter]));          
        var local_ga = _.get(window, "ga")
        if (typeof local_ga === "function") {
          local_ga('send', 'event', 'home', 'chip', choosen_filter);
        }
        location.href = href;
      });

    }

    // Filters : bind links, load images on scroll
    var already_scrolled = false;
    intercept_filters_links();
    $(document).scroll(function() {
      var scroll_position = $(document).scrollTop();
      if (scroll_position > 50 && !already_scrolled) {
        $(".c-home-catalog-replacable").replaceTagName("img")
        already_scrolled = true;
      }
    }); 

  }
});

