_.set(window, 'clara.other_component',

  function other_component(root_element) {

    function $d(selector) {
      return $(root_element + ' ' + selector);
    }

    if (
      $(root_element + ' input#val_harki').length &&
      $(root_element + ' input#val_detenu').length &&
      $(root_element + ' input#val_pi').length &&
      $(root_element + ' input#val_handicap').length &&
      $(root_element + ' input#none').length
    ) {
      return true;
    } else {
      return false;
    }

    function register_callbacks() {
      $d('input#val_harki').click(function(e) {
        $('input#none').prop('checked', false);
      });
      $d('input#val_detenu').click(function(e) {
        $('input#none').prop('checked', false);
      });
      $d('input#val_pi').click(function(e) {
        $('input#none').prop('checked', false);
      });
      $d('input#val_handicap').click(function(e) {
        $('input#none').prop('checked', false);
      });
      $d('input#none').click(function(e) {
        $('input#val_harki').prop('checked', false);
        $('input#val_detenu').prop('checked', false);
        $('input#val_pi').prop('checked', false);
        $('input#val_handicap').prop('checked', false);
      });
    };

    register_callbacks();



  });
