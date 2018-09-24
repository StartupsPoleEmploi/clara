_.set(window, 'clara.include_ga', function(){
  
  //load google analytics scripts
  _.unset(window, 'ga');
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){ (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o), m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m) })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');                

  //build google analytics default values and dimensions
  ga("create", window.clara.ga_id, "auto");
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
})

_.set(window, 'clara.exclude_ga', function(){
  $( "script[src*='analytics.com']" ).remove();    
  _.set(window, 'ga', {});
  // window.ga = function(){console.log("analytics has been removed")}; 
});


$(document).on('turbolinks:load', function () {

  var ga_script_not_yet_loaded = $( "script[src*='analytics.com']" ).length === 0;
  var user_disabled_analytics = _.get(window, 'gon.disable_analytics') === true;

  if (ga_script_not_yet_loaded && !user_disabled_analytics) {
    clara.include_ga();
  } else if (user_disabled_analytics) {
    clara.exclude_ga();
  }

});
