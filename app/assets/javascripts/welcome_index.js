//= require fontfaceobserver


load_js_for_page(["welcome", "index"], function() {

  store.clearAll();
  
  $.getJSON('https://api.ipify.org?format=jsonp&callback=?', function(data) {
    var current_ip = _.get(data, 'ip');
    var pe_ips = _.split(_.get(window, 'clara.env.ARA_URL_PE'), ",");
    if (_.includes(pe_ips, current_ip)) {
      console.log("Bienvenue chez Pôle Emploi");
      if (typeof ga === "function") ga('set', 'dimension1', 'true');
    } else {
      console.log("Bienvenue");
      if (typeof ga === "function") ga('set', 'dimension1', 'false');
    }
    console.log("IP : " + current_ip);
    console.log("Date : " + _.fullDateFr());
    console.log("Version : " + clara.version);
  });


var roboto400 = new FontFaceObserver("Roboto", {
  weight: 400
});
var roboto500 = new FontFaceObserver("Roboto", {
  weight: 500
});
var roboto700 = new FontFaceObserver("Roboto", {
  weight: 700
});

Promise.all([
  roboto400.load(),
  roboto500.load(),
  roboto700.load()
]).then(function() {
  document.documentElement.className += " fonts-loaded";
  console.log("Roboto font is available")
});

});
