clara.js_define("peconnect_callback", {

    please_if: function() {
      return $(".peconnect.callback").exists();
    },

    please: function() {
      $('.js-modal').on('click', function(e) { 
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
        }, 500)
      })
      
      $('.js-modal').click();

      if ($('.c-filterbox2.u-display-none').exists()) {
        var $lastbox = $('.c-filterbox2.u-display-none').last()
        $( "<button id='display_more_filters'>Afficher plus</button>" ).insertAfter( $lastbox );
        $('button#display_more_filters').on('click', function(e) { 

          e.preventDefault();

          if ($('.c-filterbox2.u-display-none').exists()) {
            $('.c-filterbox2.u-display-none').addClass('tohide');
            $('.c-filterbox2.u-display-none').removeClass('u-display-none'); 
            $('#display_more_filters').html('Afficher moins')           
          } else if ($('.c-filterbox2.tohide').exists()) {
            $('.c-filterbox2.tohide').addClass('u-display-none');
            $('.c-filterbox2.u-display-none').removeClass('tohide');            
            $('#display_more_filters').html('Afficher plus')           
          }

        })
      }
      
    }
});

