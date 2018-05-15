$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('stats', 'index')) {
    /**
    * Load from PE / not from PE
    */
    var all_pe = _.get(JSON.parse($('.ct-gape').attr('data-loaded')), '[0].data.rows')
    var pe_discriminator_function = function(e){ return _.toBoolean(_.get(e, 'dimensions[0]'))}
    var inside_pe = _.filter(all_pe, pe_discriminator_function)
    var outside_pe = _.reject(all_pe, pe_discriminator_function)
    var advisor_nb = _.toInteger(_.get(inside_pe, '[0].metrics[0].values[0]'))
    var asker_nb = _.toInteger(_.get(outside_pe, '[0].metrics[0].values[0]'))
    var total_nb = advisor_nb + asker_nb
    new Chartist.Bar(
      '.ct-gape',
      {
        series: [{ name: 'Conseillers ' + _.toPercentage(advisor_nb, total_nb), data: [advisor_nb] }, { name: 'Demandeurs ' + _.toPercentage(asker_nb, total_nb), data: [asker_nb] }]
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


    /**
    * Load sessions
    */
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
    var nice_keys = _.map(_.keys(grouped_board), function(e){return _.split(e, " ")[1] + " " + _.split(e, " ")[2] + " " + _.split(e, " ")[3]})
    
    new Chartist.Line(
      '.ct-gabarline',
      {
        labels: nice_keys,
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
