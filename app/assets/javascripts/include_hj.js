_.set(window, 'clara.include_hj', function(){
  
  //load google analytics scripts
  _.unset(window, 'hj');

  //build google analytics default values and dimensions
  $.getJSON('https://api.ipify.org?format=jsonp&callback=?', function(data) {
    var current_ip = _.get(data, 'ip');
    var pe_ips = _.split(_.get(window, 'clara.env.ARA_URL_PE'), ",");
    if (_.includes(pe_ips, current_ip)) {
    }
  });
})

_.set(window, 'clara.exclude_hj', function(){
  $( "script[src*='hotjar.com']" ).remove();    
  _.set(window, 'hj', {});
});


$(document).on('turbolinks:load', function () {

  var ga_script_not_yet_loaded = $( "script[src*='hotjar.com']" ).length === 0;
  var user_disabled_hotjar = _.get(window, 'gon.disable_hotjar') === true;

  if (ga_script_not_yet_loaded && !user_disabled_hotjar) {
    clara.include_hj();
  } else if (user_disabled_hotjar) {
    clara.exclude_hj();
  }

});
