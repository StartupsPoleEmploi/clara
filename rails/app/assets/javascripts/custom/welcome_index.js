clara.load_js(function only_if(){return $("body").hasClasses("welcome", "index")}, function() {

  store.clearAll();
  console.log("Version : " + clara.version);

  $(document).scroll(function() {
    var scroll_position = $(document).scrollTop();
    if (scroll_position > 0) {
      $(".c-newhomehero__header").addClass("is-scrolled");
    } else {
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




});
