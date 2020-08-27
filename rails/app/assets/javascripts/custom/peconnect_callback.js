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

      if ($('.c-filterbox2.hidden').exists()) {
        // console.log($('.c-filterbox2.hidden').last());
        var $lastbox = $('.c-filterbox2.hidden').last()
        $( "<button id='display_more_filters'>Afficher plus</button>" ).insertAfter( $lastbox );
        $('#display_more_filters').on('click', function(e) { 

          e.preventDefault();

          if ($('.c-filterbox2.hidden').exists()) {
            $('.c-filterbox2.hidden').addClass('tohide');
            $('.c-filterbox2.hidden').removeClass('hidden'); 
            $('#display_more_filters').html('Afficher moins')           
          } else if ($('.c-filterbox2.tohide').exists()) {
            $('.c-filterbox2.tohide').addClass('hidden');
            $('.c-filterbox2.hidden').removeClass('tohide');            
            $('#display_more_filters').html('Afficher plus')           
          }

        })
      }
      
    }
});

