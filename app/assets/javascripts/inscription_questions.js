load_js_for_page(["inscription_questions", "new"], function() {

  $("input:radio:first").focus();

  var roboto = new FontFaceObserver('Roboto');

  roboto.load().then(function () {
    document.body.className += " fonts-loaded";
  });


});
