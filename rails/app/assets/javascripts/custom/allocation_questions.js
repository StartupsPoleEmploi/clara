// clara.load_js(function only_if(){return $("body").hasClasses("allocation_questions", "new")}, function() {

//   $("input:radio:first").focus();
  
// });

clara.js_define("new_allocation_question", {

    please: function() {
      if ($(".c-error-in-form").exists()) {
            $($(".c-error-in-form").detach()).appendTo(".c-fieldset");
      }
    },

});

