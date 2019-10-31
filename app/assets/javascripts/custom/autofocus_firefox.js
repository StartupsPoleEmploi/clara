clara.load_js(function only_if(){return $("input").hasAttribute("autofocus")}, function() {

  $( "input:visible:first" ).focus(); // for focus on firefox
  
});