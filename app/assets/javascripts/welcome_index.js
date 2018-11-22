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



/*var fontRoboto = new FontFaceObserver('Roboto');
var fontSansSerif = new FontFaceObserver('sans-serif');

fontSansSerif.load().then(function () {
  console.log('Family SansSerif is available');
});

fontRoboto.load().then(function () {
  console.log('Family Roboto is available');
});
*/

/*var fontRoboto = new FontFaceObserver('Roboto');
var fontSansSerif = new FontFaceObserver('sans-serif');

Promise.all([fontRoboto.load(), fontSansSerif.load()]).then(function () {
  console.log('Family roboto & sans-serif serie have loaded');
});*/

/*var observer = new FontFaceObserver("Roboto", {
  weight: 400
});

observer.load(null, 40).then(function() {
  console.log("Font is available");
}, function() {
  console.log("Font is not available after waiting 5 seconds");
});*/

var font = new FontFaceObserver('Roboto');

font.load().then(function () {
  document.documentElement.className += " fonts-loaded";
});


});
