$(document).on('turbolinks:load', function () {
  if (typeof ga === "function" && !_.get(window, 'gon.disable_analytics')) {
    ga("set", "location", location.pathname + location.search);
    return ga("send", "pageview");
  }
});
