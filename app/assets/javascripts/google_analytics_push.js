$( document ).ready(function(event) {
  if (typeof ga === "function") {
    ga("set", "location", _.get(event, location.pathname + location.search));
    return ga("send", "pageview");
  }
});
