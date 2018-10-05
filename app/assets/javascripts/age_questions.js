$(document).on('ready', function () {
  if ($('body').hasClass('age_questions', 'new')) {
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
  }
});
