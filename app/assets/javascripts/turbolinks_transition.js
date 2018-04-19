
$(document).on('turbolinks:request-start', function() {
  $('.c-turbolinks-transition').removeClass('is-hidden');
});

$(document).on('turbolinks:request-end', function() {
  $('.c-turbolinks-transition').addClass('is-hidden');
});


$(document).on('turbolinks:request-start', function() {
  console.log("turbolinks:request-start")
});

$(document).on('turbolinks:request-end', function() {
  console.log("turbolinks:request-end")
});

$(document).on('turbolinks:before-cache', function() {
  console.log("turbolinks:before-cache")
});
