clara.js_define("admin_accordion", {

  please_if: function () {
    return $(".js-accordion").length > 0;
  },

  please: function () {
    $(".field-unit").addClass("js-accordion__panel");
    $(".field-unit__label label[for]").addClass("js-accordion__header");
    $('.js-accordion').accordion();
    $("#accordion_0-0_tab").html("<span class='field-unit__label-mandatory'>*</span><span>&nbsp;</span><span>" + $("#accordion_0-0_tab").html() + "</span>")
    $("#accordion_0-2_tab").html("<span class='field-unit__label-mandatory'>*</span><span>&nbsp;</span><span>" + $("#accordion_0-2_tab").html() + "</span>")
    $("#accordion_0-3_tab").html("<span class='field-unit__label-mandatory'>*</span><span>&nbsp;</span><span>" + $("#accordion_0-3_tab").html() + "</span>")

    $("#accordion_0-1_tab").html("<span>" + $("#accordion_0-1_tab").html() + "</span><span>&nbsp;</span><span class='field-unit__label-optional'>Facultatif</span>")
    $("#accordion_0-4_tab").html("<span>" + $("#accordion_0-4_tab").html() + "</span><span>&nbsp;</span><span class='field-unit__label-optional'>Facultatif</span>")

    $(".js-accordion__header span").on("click", function(e){
      $(this).parent(".js-accordion__header").click()
      // $(".js-accordion__header").click();
      return false;
      // e.preventDefault();
    });

  }

});

