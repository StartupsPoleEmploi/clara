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


});
