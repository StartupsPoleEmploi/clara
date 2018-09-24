$(document).on('ready', function () {

console.log('loading');

  //load google analytics
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){ (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o), m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m) })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');                

  if (window.is_google_analytics_session_already_defined) {
    // Do nothing
  } else {
    //load google analytics
    ga("create", window.clara.ga_id, "auto");
    window.is_google_analytics_session_already_defined = true;
    $.getJSON('https://api.ipify.org?format=jsonp&callback=?', function(data) {
      var current_ip = _.get(data, 'ip');
      var pe_ips = _.split(_.get(window, 'clara.env.ARA_URL_PE'), ",");
      if (_.includes(pe_ips, current_ip)) {
        console.log("Bienvenue chez Pôle Emploi");
        ga('set', 'dimension1', 'true');
      } else {
        console.log("Bienvenue");
        ga('set', 'dimension1', 'false');
      }
      console.log("IP : " + current_ip);
      console.log("Date : " + _.fullDateFr());
      console.log("Version : " + clara.version);
    });
  }

});
