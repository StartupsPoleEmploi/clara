$(document).on('ready turbolinks:load', function () {
  if ($('body').hasClass('welcome', 'index')) {
    if (localStorage) {
      localStorage.clear();
    }
  }
});
