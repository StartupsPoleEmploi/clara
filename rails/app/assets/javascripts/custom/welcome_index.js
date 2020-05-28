clara.load_js(function only_if(){return $("body").hasClasses("welcome", "index")}, function() {

  var local_ga = _.get(window, "ga");
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

  $(".c-chip-crea").click(function(){
    if (typeof local_ga === "function") {
      local_ga('send', 'event', 'home', 'chip', 'creation');
    }    
  });
  $(".c-chip-amob").click(function(){
    if (typeof local_ga === "function") {
      local_ga('send', 'event', 'home', 'chip', 'mobilite');
    }    
  });
  $(".c-chip-formation").click(function(){
    if (typeof local_ga === "function") {
      local_ga('send', 'event', 'home', 'chip', 'formation');
    }    
  });
  $(".c-chip-projetpro").click(function(){
    if (typeof local_ga === "function") {
      local_ga('send', 'event', 'home', 'chip', 'projetpro');
    }    
  });




});
