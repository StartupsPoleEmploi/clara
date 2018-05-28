$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('stats') && $('body').hasClass('time')) {

    console.log('load stats time')

    /**
    * Load saved time
    */
    var json_data =_.get(JSON.parse($('.ct-gabarline').attr('data-loaded')), 'json_data');
    // [{Number: "1", User: "551c6f46", Date Submitted: "2018-04-23 12:59:47", Country: "France", Source URL: "https://clara.pole-emploi.fr/aides?for_id=MjcsQVJF…sw45sZS1kZS1GcmFuY2UsNzAsOTMxMDAsbmlsLG91aSxuaWw=", …}]

    var time_only = _.map(json_data, 
      function(e){
        var res = {}
        res["id"] = e["User"];
        var time_key = _.findKey(e, function(val, key){return _.lowerCase(key).indexOf("combien de temps") > -1 });
        res["time"] = e[time_key];
        return res
      })
    //[{id: "551c6f46", time: "+ de 15 minutes"}, {id: "9a3135ea", time: "1 à 5 minutes"}, {...}]

    var grouped_time = _.groupBy(time_only, function(e) {return e["time"];});
    //{+ de 15 minutes: Array(6), 1 à 5 minutes: Array(5), 6 à 10 minutes: Array(6), 11 à 15 minutes: Array(4), 0 minutes: Array(4)}

    var mapped_grouped_time = _.mapValues(grouped_time, function(e){return _.size(e)})
    //{"+ de 15 minutes": 6, "1 à 5 minutes": 5, "6 à 10 minutes": 6, "11 à 15 minutes": 4, "0 minutes": 4}

    var ordered_label = _.orderBy(_.keys(grouped_time), function(e){return parseInt(e.split(" ")[0], 10)});
    // ["0 minutes", "1 à 5 minutes", "6 à 10 minutes", "11 à 15 minutes", "+ de 15 minutes"]

    var ordered_serie = _.map(ordered_label, function(e){return mapped_grouped_time[e];})
    // [4, 5, 6, 4, 6]

    new Chartist.Bar('.ct-gabarline', {
      labels: ordered_label,
      series: [ordered_serie]
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
