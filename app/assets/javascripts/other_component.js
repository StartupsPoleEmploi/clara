_.set(window, 'clara.other_component',

	function other_component(){
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

  };
	);