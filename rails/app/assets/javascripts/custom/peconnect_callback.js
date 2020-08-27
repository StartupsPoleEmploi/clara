clara.js_define("peconnect_callback", {

    please_if: function() {
      return $(".peconnect.callback").exists();
    },

    please: function() {
      console.log("defining");


      function redirect_on_close() {
        window.document.location = '/';
      }

      $('.js-modal').on('click', function(e) { 
        console.log("open js-modal"); 
        setTimeout(function () {
          $('#js-modal-close').on('click', function(){
            $.ajax({
              url: '/welcome/disconnect_from_peconnect',
              type: "POST",
              data: {
              },
              success: function(resp){ 
                console.log("disconnected - ok");
                // redirect_on_close();
              },
              error: function(e){ 
                console.log("disconnected - error");
                redirect_on_close();
              },
            });
          })
          $('.simple-modal-overlay').on('click', redirect_on_close)
        }, 500)
      })
      
      $('.js-modal').click();
      
    }
});

