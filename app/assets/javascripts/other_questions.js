load_js_prod(function only_if(){return $("body").hasClasses("other_questions", "new")}, function() {

    $("input:checkbox:first").focus();

    $( 'input#none' ).click(function() {
      $('input#val_spectacle').prop('checked', false);
      $('input#val_handicap').prop('checked', false);
      $('input#val_cadre').prop('checked', false);
    });   

    $( 'input#val_spectacle' ).click(function() {
      $('input#none').prop('checked', false);
    });   

    $( 'input#val_handicap' ).click(function() {
      $('input#none').prop('checked', false);
    });
    
    $( 'input#val_cadre' ).click(function() {
      $('input#none').prop('checked', false);
    });
    
});
