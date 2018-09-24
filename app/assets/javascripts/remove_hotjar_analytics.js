$(document).on('turbolinks:load', function () {
  console.log(!_.get(window, 'gon.disable_analytics'))
});
