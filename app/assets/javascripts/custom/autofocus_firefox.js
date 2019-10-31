clara.load_js(function only_if(){return $("input.c-field").hasAttribute("autofocus")}, function() {

  $( "input:visible:first" ).focus(); // for focus on firefox
  
});