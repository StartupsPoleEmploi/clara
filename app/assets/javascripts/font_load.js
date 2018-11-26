clara.load_js(function only_if(){return true}, function() {

  var roboto = new FontFaceObserver('Roboto');

  roboto.load().then(function () {
    document.body.className += " fonts-loaded";
  });
  
});



