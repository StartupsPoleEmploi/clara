clara.js_define("peconnect_callback", {

    please_if: function() {
      return $(".peconnect.callback").exists();
    },

    please: function() {

      $('.js-modal').on('click', function(e) { 

        setTimeout(function () {
           $('#c-callback-submit2').on('click', function(e) { 
              $('#c-callback-submit1').click();
            });

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
                // window.document.location = '/';
              },
            });
          })
        }, 500)
        
      })
      
      $('.js-modal').click();

      if ($('.c-filterbox2.u-display-none').exists()) {
        var $lastbox = $('.c-filterbox2.u-display-none').last()
        $( "<button id='display_more_filters' class='callback-display-more'>Afficher plus</button>" ).insertAfter( $lastbox );
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
      

      if ($('.c-callback-userinfo').length > 3 ) {
        console.log("more than 3 userinfo");
        for (var i = $('.c-callback-userinfo').length - 1; i >= 3; i--) {
          $('.c-callback-userinfo:eq(' + i + ')').addClass('u-display-none')
        }
        $( "<button id='display_more_userinfo' class='callback-display-more'>Afficher plus</button>" ).insertAfter( $('.c-callback-userinfo').last() );
        $('button#display_more_userinfo').on('click', function(e) { 

          e.preventDefault();

          if ($('.c-callback-userinfo.u-display-none').exists()) {
            $('.c-callback-userinfo.u-display-none').addClass('tohide');
            $('.c-callback-userinfo.u-display-none').removeClass('u-display-none'); 
            $('#display_more_userinfo').html('Afficher moins')           
          } else if ($('.c-callback-userinfo.tohide').exists()) {
            $('.c-callback-userinfo.tohide').addClass('u-display-none');
            $('.c-callback-userinfo.u-display-none').removeClass('tohide');            
            $('#display_more_userinfo').html('Afficher plus')           
          }

        })
      }

    }
});

