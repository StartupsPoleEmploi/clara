_.set(window, 'clara.init_contact', _.throttle(function() {
      $('.c-contact-input').on('keydown', function(e){
        console.log('hi33');
        $elt = $(e);
        console.log($elt);
      })
    }, 1000)
);


$(document).on('ready turbolinks:load', function () {
  if ($( 'body' ).hasClass('contact', 'index' )) {

    clara.init_contact();

  }
});
