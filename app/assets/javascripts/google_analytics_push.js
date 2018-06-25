$( document ).ready(function(event) {
  if (typeof ga === "function") {
    ga("set", "location", location.pathname + location.search);
    return ga("send", "pageview");
  }
});
