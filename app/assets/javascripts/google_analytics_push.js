$(document).on('ready turbolinks:load', function() {
  if (typeof ga === "function") {
    return ga("send", "pageview");
  }
});
