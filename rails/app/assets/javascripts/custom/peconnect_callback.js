clara.js_define("peconnect_callback", {

    please_if: function() {
      return $(".peconnect.callback").exists();
    },

    please: function() {
      console.log("defining");

      $('.c-footer-subtitle').on('click', function(e) { console.log("blabla"); })
      $('.js-modal').on('click', function(e) { 
        console.log("open js-modal"); 
        setTimeout(function () {
          $('#js-modal-close').on('click', function(e) { console.log("close"); })
          $('.simple-modal-overlay').on('click', function(e) { console.log("overlay"); })
        }, 500)
        
      })
      
    }
});

