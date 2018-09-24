$(document).on('ready turbolinks:load', function () {
  if ($('body').hasClass('welcome', 'index')) {
    var cookiesBannerStorage = store.set("ok_for_all_cookies", "true")
    if (localStorage) {
      localStorage.clear();
    }
  }
});
