load_js_for_page(["other_questions", "new"], function() {

    $("input:checkbox:first").focus();


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
    
});
