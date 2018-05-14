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

    new Chartist.Line(
      '.ct-gabarline',
      {
        labels: [1, 2, 3, 4, 5, 6, 7, 8],
        series: [[5, 9, 7, 8, 5, 3, 5, 4]]
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
