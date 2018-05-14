$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('stats', 'index')) {

    new Chartist.Bar('.ct-chart', {
      labels: ['Conseillers', 'Non-conseillers'],
      series: [
        [5, 4]
      ]
    }, {
      seriesBarDistance: 10,
      reverseData: true,
      horizontalBars: true,
      axisY: {
        offset: 70
      }
    });

    console.log('stats index loaded');
    
  }
});
