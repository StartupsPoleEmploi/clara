$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('stats', 'index')) {
    
    new Chartist.Bar(
      '.ct-chart',
      {
        series: [{ name: 'Conseillers', data: [6000] }, { name: 'Demandeurs', data: [8000] }]
      },
      {
        seriesBarDistance: 10,
        plugins: [Chartist.plugins.legend()],
        reverseData: true,
        horizontalBars: true,
        seriesBarDistance: 30,
        axisY: {
          offset: 70
        }
      }
    );

   
    var lines = _.map(_.get(JSON.parse($('.ct-gabarline').attr('data-loaded')), "[0].data.rows"), function(e) {return _.get(e, "metrics[0].values[0]");})

    new Chartist.Line(
      '.ct-gabarline',
      {
        series: [lines]
      },
      {
        height: 300,
        low: 0,
        showArea: true
      }
    );

    console.log('stats index loaded');
  }
});
