clara.load_js(function only_if(){return $("body").hasClasses("grade_questions", "new")}, function() {

  $("input:radio:first").focus();
  
});
