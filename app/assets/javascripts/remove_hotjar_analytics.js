$(document).on('turbolinks:load', function () {
  var disable_analytics = _.get(window, 'gon.disable_analytics');
  if (disable_analytics === true) {
    $( "script[src*='analytics.com']" ).remove();    
    window.ga = function(){console.log("analytics has been removed")};    
  }
});
