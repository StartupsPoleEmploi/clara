clara.load_js(function only_if(){return $("body").hasClasses("category_questions", "new")}, function() {

  $("input:radio:first").focus();
  
});
