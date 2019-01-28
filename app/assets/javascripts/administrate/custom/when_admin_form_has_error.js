clara.js_define("when_admin_form_has_error", {

    please_if: function() {
      return $(".field-unit-error-msg").length > 0;
    },
    please: function() {
      $(".field-unit-error-msg").each(function(i,e) {
        var $e = $(e);
        var $previous = $e.prev();
        $e.appendTo($previous);
      });
    },

});

