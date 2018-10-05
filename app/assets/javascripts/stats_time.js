_.set(window, 'clara.draw_stats_time', function() {
  var loaded = JSON.parse($('.ct-savedtime').attr('data-loaded'));

  new Chartist.Bar('.ct-savedtime', {
    labels: loaded["ordered_label"],
    series: [loaded["ordered_serie"]]
  }, {
    height: 300,
    showArea: true,
    axisX: {
      // On the x-axis start means top and end means bottom
      position: 'start'
    },
    axisY: {
      // On the y-axis start means left and end means right
      position: 'end'
    }
  });
});



$(document).on('ready', function () {
  if ($('body').hasClasses('stats', 'time')) {

    if (_.get(window, 'Chartist')) {
      clara.draw_stats_time();
    } else {
      $.getScript( "https://cdnjs.cloudflare.com/ajax/libs/chartist/0.11.0/chartist.min.js", function( data, textStatus, jqxhr ) {
        $.getScript( "https://cdnjs.cloudflare.com/ajax/libs/chartist-plugin-legend/0.6.2/chartist-plugin-legend.min.js", function( data, textStatus, jqxhr ) {
          $.getScript( "https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js", function( data, textStatus, jqxhr ) {
            console.log("Chartist, plugin, and momentjs loaded ")
            clara.draw_stats_time();
          });
        });
      });
    }

  }
});
