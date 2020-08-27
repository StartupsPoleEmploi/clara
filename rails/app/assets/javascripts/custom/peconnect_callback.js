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
              url: '/welcome/disconnect_from_peconnect?json=true',
              type: "POST",
              contentType: "application/json",
              data: {
              },
              success: function(resp){ 
                console.log("disconnected - ok");
                console.log(resp);
                window.document.location = resp.redirection_url;
              },
              error: function(e){ 
                console.log("disconnected - error");
                console.log(e);
                window.document.location = '/';
              },
            });
          })
          $('.simple-modal-overlay').on('click', redirect_on_close)
        }, 500)
      })
      
      $('.js-modal').click();
      
    }
});

