$(document).on('ready turbolinks:load', function () {
  if ($('body').hasClass('stats') && $('body').hasClass('time')) {

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

  }
});
