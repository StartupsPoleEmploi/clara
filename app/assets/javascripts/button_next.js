$(document).on('ready turbolinks:load', function() {

  $('.js-next').click(function(e){
    setTimeout(function(){ 
      $('.c-turbolinks-transition').removeClass('is-hidden');
      Turbolinks.controller.adapter.progressBar.setValue(0);
      Turbolinks.controller.adapter.progressBar.show();
    }, 400);
  });

});
