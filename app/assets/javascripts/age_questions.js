load_js_for_page(["age_questions", "new"], function() {
    //https://stackoverflow.com/a/24271309/2595513
    $('input#age').on('keydown keyup', function(e) {
      if (
        $(this).val() > 99 &&
        e.keyCode != 46 && // delete
        e.keyCode != 8 // backspace
      ) {
        e.preventDefault();
        $(this).val(99);
      }
    });
});
