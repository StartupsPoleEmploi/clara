clara.js_define("admin_flash", {

    please_if: function() {
      return $("#tooltip_flash").length > 0;
    },

    please: function() {
      
      $(".js-tooltip").click();
      
      function height() {
        return $(".tooltip__wrapper").outerHeight();
      }

      function defer() { 
        if (_.isBlank(height())) { 
          setTimeout(function() { defer() }, 100); 
        } else { 
          $("#js-tooltip").css("height", height() + 5 + "px")
        } 
      }

      defer()

      setTimeout(
        function(){
          $("#js-tooltip-close").click();
        }, 
        10000
      );

    },

});

