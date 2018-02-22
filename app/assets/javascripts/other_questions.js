$(document).on('ready turbolinks:load', function() {
  if ($( 'body' ).hasClass('other_questions', 'new' )) {

    $( 'input#none' ).click(function() {
      $('input#val_harki').prop('checked', false);
      $('input#val_detenu').prop('checked', false);
      $('input#val_pi').prop('checked', false);
      $('input#val_handicap').prop('checked', false);
    });   

    $( 'input#val_harki' ).click(function() {
      $('input#none').prop('checked', false);
    });   

    $( 'input#val_detenu' ).click(function() {
      $('input#none').prop('checked', false);
    });   

    $( 'input#val_pi' ).click(function() {
      $('input#none').prop('checked', false);
    });   

    $( 'input#val_handicap' ).click(function() {
      $('input#none').prop('checked', false);
    });   

  }
});
