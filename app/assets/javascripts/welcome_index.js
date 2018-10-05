_.set(window, 'clara.include_ga', function(){
  
      ga('set', 'dimension1', 'true');
      console.log("Bienvenue");
      ga('set', 'dimension1', 'false');
    console.log("IP : " + current_ip);
    console.log("Date : " + _.fullDateFr());
    console.log("Version : " + clara.version);
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
