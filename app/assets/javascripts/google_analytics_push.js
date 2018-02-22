$(document).on('ready turbolinks:load', function() {
  if (typeof ga === "function") {
    ga("set", "location", document.location.pathname);
    return ga("send", "pageview");
  }
});
