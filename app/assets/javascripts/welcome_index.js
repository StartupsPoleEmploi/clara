$(document).on('ready turbolinks:load', function () {
  if ($('body').hasClass('welcome', 'index')) {
    var old_cookie_preference = store.get("old_cookie_preference")
    store.clearAll();
    store.set("old_cookie_preference", old_cookie_preference);

    if (store.get("old_cookie_preference") === "true") {
      $('.c-cookies-banner-container').hide();
    }

    $('.c-cookies-button').on("click", function (e) {
      // hide...
      $('.c-cookies-banner-container').hide();
      // and don't reappear
      store.set("old_cookie_preference", "true");
    });

  }
});
