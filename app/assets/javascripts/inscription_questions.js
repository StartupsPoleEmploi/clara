load_js_prod(function only_if(){return $("body").hasClasses("inscription_questions", "new")}, function() {

  $("input:radio:first").focus();
  
});
