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

    var board = _.get(JSON.parse($('.ct-gabarline').attr('data-loaded')), '[0].data.rows');
    var grouped_board = _.groupBy(board, function(e) {
      return moment(_.get(e, 'dimensions[0]')).startOf('isoWeek');
    });
    var week_board = _.map(grouped_board, function(v, k) {
      return _.sum(
        _.map(v, function(m) {
          return _.toInteger(_.get(m, 'metrics[0].values[0]'));
        })
      );
    });

    new Chartist.Line(
      '.ct-gabarline',
      {
        labels: _.drop(_.times(_.size(week_board) + 1, Number)),
        series: [week_board]
      },
      {
        height: 300,
        low: 0,
        showArea: true
      }
    );

  }
});
