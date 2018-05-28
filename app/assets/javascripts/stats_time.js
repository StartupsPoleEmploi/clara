$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('stats') && $('body').hasClass('time')) {

    /**
    * Load saved time
    */
    var json_data =_.get(JSON.parse($('.ct-gabarline').attr('data-loaded')), 'json_data');
    var time_only = _.map(json_data, 
      function(e){
        var res = {}
        res["id"] = e["User"];
        var time_key = _.findKey(b, function(val, key){return _.lowerCase(key).indexOf("combien de temps") > -1 });
        res["time"] = e[time_key];
        return res
      })

    new Chartist.Bar('.ct-chart', {
      labels: ['0 min', '5 à 10 min', '15 min', 'Thu', 'Fri', 'Sat', 'Sun'],
      series: [
        [5, 4, 3, 7, 5, 10, 3]
      ]
    }, {
      axisX: {
        // On the x-axis start means top and end means bottom
        position: 'start'
      },
      axisY: {
        // On the y-axis start means left and end means right
        position: 'end'
      }
    });

    // new Chartist.Line(
    //   '.ct-gabarline',
    //   {
    //     labels: nice_keys,
    //     series: [week_board]
    //   },
    //   {
    //     height: 300,
    //     low: 0,
    //     showArea: true
    //   }
    // );

  }
});
