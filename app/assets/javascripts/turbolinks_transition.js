
// $(document).on('turbolinks:request-start', function() {
//   $('.c-turbolinks-transition').removeClass('is-hidden');
// });

$(document).on('turbolinks:request-end turbolinks:before-cache', function() {
  $('.c-turbolinks-transition').addClass('is-hidden');
});
