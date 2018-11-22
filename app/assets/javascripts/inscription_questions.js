load_js_for_page(["inscription_questions", "new"], function() {

  $("input:radio:first").focus();

  var roboto400 = new FontFaceObserver("Roboto", {
  weight: 400
  });
  var roboto500 = new FontFaceObserver("Roboto", {
    weight: 500
  });
  var roboto700 = new FontFaceObserver("Roboto", {
    weight: 700
  });

  Promise.all([
    roboto400.load(),
    roboto500.load(),
    roboto700.load()
  ]).then(function() {
    document.documentElement.className += " fonts-loaded";
    console.log("Roboto font is available")
  });
  
});
