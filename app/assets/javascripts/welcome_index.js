clara.load_js(function only_if(){return $("body").hasClasses("welcome", "index")}, function() {

  store.clearAll();
  console.log("Version : " + clara.version);


});
