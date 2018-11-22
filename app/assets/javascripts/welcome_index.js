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


  var roboto = new FontFaceObserver('Roboto');

  roboto.load().then(function () {
    document.body.className += " fonts-loaded";
    console.log("Police roboto est prête")
  });
 

});
