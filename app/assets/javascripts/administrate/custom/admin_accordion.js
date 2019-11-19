clara.js_define("admin_accordion", {

  please_if: function () {
    return $(".js-accordion").length > 0;
  },

  please: function () {
    $(".field-unit").addClass("js-accordion__panel");
    $(".field-unit__label label[for]").addClass("js-accordion__header");
    $('.js-accordion').accordion();
    $("button.js-hide-convention").click(function () {
      $("button.alert-convention").hide()
    })
  }

});

