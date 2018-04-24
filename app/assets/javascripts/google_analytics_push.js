$(document).on('ready turbolinks:load', function(event) {
  if (typeof ga === "function") {
    ga("set", "location", event.originalEvent.data.url)
    return ga("send", "pageview");
  }
});
