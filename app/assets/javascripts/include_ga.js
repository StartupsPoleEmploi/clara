$(document).on('ready', function () {
  if (clara.ga_is_disabled) {
    $( "script[src*='analytics.com']" ).remove();    
    _.set(window, 'ga', function(){});
  } else {
    if (_.get(window, 'ga')) {
      // ok, analytics loaded, do nothing
    } else {
      //load analytics
      if (_.get(window, 'clara.ga_id')) {
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){ (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o), m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m) })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');                
      }
    }
  }
});
