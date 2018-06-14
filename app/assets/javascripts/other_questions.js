$( document ).ready(function() {
  if ($( 'body' ).hasClass('other_questions', 'new' )) {

    $( 'input#none' ).click(function() {
      $('input#val_spectacle').prop('checked', false);
      $('input#val_handicap').prop('checked', false);
    });   

    $( 'input#val_spectacle' ).click(function() {
      $('input#none').prop('checked', false);
    });   

    $( 'input#val_handicap' ).click(function() {
      $('input#none').prop('checked', false);
    });   

  }
});
