$(document).on('ready turbolinks:load', function(event) {
  if (typeof ga === "function") {
    ga("set", "location", _.get(event, "originalEvent.data.url"));
    return ga("send", "pageview");
  }
});
