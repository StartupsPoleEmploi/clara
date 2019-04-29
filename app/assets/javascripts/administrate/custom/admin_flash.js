clara.js_define("admin_flash", {

    please_if: function() {
      return $("#tooltip_flash").length > 0;
    },

    please: function() {
      $(".js-tooltip").click();
      
      setTimeout(
        function(){
          $("#js-tooltip-close").click();
        }, 
        10000
      );

    },

});

