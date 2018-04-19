
$(document).on('turbolinks:request-start', function() {
  window.patience_please = true;
  setTimeout(function(){ 
      if (window.patience_please) {
        $('.c-turbolinks-transition').removeClass('is-hidden');
      }
  }, 400);
});

$(document).on('turbolinks:request-end', function() {
  window.patience_please = false;
  $('.c-turbolinks-transition').addClass('is-hidden');
});
