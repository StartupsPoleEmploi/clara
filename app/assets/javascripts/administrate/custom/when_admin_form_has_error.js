clara.js_define("when_admin_form_has_error", {

    trigger_function: function() {
      return $(".field-unit-error-msg").length > 0;
    },
    main_function: function() {
      $(".field-unit-error-msg").each(function(i,e) {
        var $e = $(e);
        var $previous = $e.prev();
        $e.appendTo($previous);
      });
    },

});

