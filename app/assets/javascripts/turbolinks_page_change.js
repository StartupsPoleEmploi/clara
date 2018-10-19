
$(document).on('turbolinks:request-start', function() {
  window.patience_please = true;
  setTimeout(function(){ 
      if (window.patience_please) {
        $('.c-turbolinks-transition').removeClass('u-hidden');
      }
  }, 400);
});

$(document).on('turbolinks:request-end', function() {
  window.patience_please = false;
  $('.c-turbolinks-transition').addClass('u-hidden');
});

// DEBUG MODE

$(document).on('turbolinks:request-start', function() {console.log('turbolinks:request-start')})
$(document).on('turbolinks:request-end', function() {console.log('turbolinks:request-end')})
$(document).on('turbolinks:click', function() {console.log('turbolinks:click')})
$(document).on('turbolinks:visit', function() {console.log('turbolinks:visit')})
$(document).on('turbolinks:before-cache', function() {console.log('turbolinks:before-cache')})
$(document).on('turbolinks:before-render', function() {console.log('turbolinks:before-render')})
$(document).on('turbolinks:render', function() {console.log('turbolinks:render')})
$(document).on('turbolinks:load', function() {console.log('turbolinks:load')})
