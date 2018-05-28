$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('stats') && $('body').hasClass('time')) {

    // see https://stackoverflow.com/a/37770048/2595513
    function fmtMSS(s){return(s-(s%=60))/60+(9<s?':':':0')+s}

    /**
    * Load saved time
    */
    var json_data =_.get(JSON.parse($('.ct-savedtime').attr('data-loaded')), 'json_data');
    // [{Number: "1", User: "551c6f46", Date Submitted: "2018-04-23 12:59:47", Country: "France", …}]

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

    var time_won = [0,5,10,15,20];

    var minutes_won = _.map(ordered_serie, function(val, index){return time_won[index] * val})
    // [0, 420, 670, 435, 1460]

    var minute_won_per_advisor = _.sum(minutes_won) / _.sum(ordered_serie)
    // 10.05050505050505

    var seconds_won_per_advisor = minute_won_per_advisor * 60

    var text_for_minutes = fmtMSS(seconds_won_per_advisor).split(":")[0]
    var text_for_seconds = Math.floor(_.toNumber(fmtMSS(seconds_won_per_advisor).split(":")[1]))
    


    $('.c-stats-savedtime__number').text(text_for_minutes + ' minutes ' + text_for_seconds + ' secondes ')

    new Chartist.Bar('.ct-savedtime', {
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
