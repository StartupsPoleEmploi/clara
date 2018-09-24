_.set(window, 'clara.include_hj', function(){
  

  //build google analytics default values and dimensions
  $.getJSON('https://api.ipify.org?format=jsonp&callback=?', function(data) {
    var current_ip = _.get(data, 'ip');
    var pe_ips = _.split(_.get(window, 'clara.env.ARA_URL_PE'), ",");
    if (_.includes(pe_ips, current_ip)) {
      //load hotjar
      _.unset(window, 'hj');
      (function(h,o,t,j,a,r){ h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)}; h._hjSettings={hjid:window.clara.hotjar_id,hjsv:5}; a=o.getElementsByTagName('head')[0]; r=o.createElement('script');r.async=1; r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv; a.appendChild(r); })(window,document,'//static.hotjar.com/c/hotjar-','.js?sv=');
    }
  });
})

_.set(window, 'clara.exclude_hj', function(){
  $( "script[src*='hotjar.com']" ).remove();    
  _.unset(window, 'hj');
});


$(document).on('turbolinks:load', function () {

  var hj_script_not_yet_loaded = $( "script[src*='hotjar.com']" ).length === 0;
  var user_disabled_hotjar = _.get(window, 'gon.disable_hotjar') === true;

  if (hj_script_not_yet_loaded && !user_disabled_hotjar) {
    clara.include_hj();
  } else if (user_disabled_hotjar && !hj_script_not_yet_loaded) {
    clara.exclude_hj();
  }

});
