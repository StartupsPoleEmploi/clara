_.set(window, 'clara.a11y.search1', {
  search_selector: '#search',
  results_selector: '#results',
  arialive_selector: '[aria-live]',
  autocomplete_every: 1,
  errorOccured: function() {
    $('input#search').val('');
    this.resetAllCalculatedFields();
    $('.c-address__explanation').empty();
    $('.c-address__content').hide();
    $('.c-address__explanation').append('<div class="h5-like sorry">Le service d\'adresse est <strong>momentanément indisponible</strong>, veuillez nous en excuser.<div>Cliquez sur "Continuer".</div></div>');
  },
  url: function() {
    return _.get(window, 'clara.env.ARA_URL_BAN');
  },
  buildResultsFromAjax: function(feature_collection, pivot_map) {
    console.log(feature_collection)
    var properties = _.map(feature_collection.features, 'properties');
    console.log(properties)

    function extract_props(the_name) {
      var local_collection = _.map(properties, the_name);
      return _.map(local_collection, function(e) {
        return _.zipObject([the_name], [e]);
      });
    }
    var address_data = _.map(extract_props('citycode'), function(e, i) {
      return _.assign(
        {},
        extract_props('citycode')[i],
        extract_props('context')[i],
        extract_props('postcode')[i],
        extract_props('housenumber')[i],
        extract_props('city')[i],
        extract_props('street')[i],
        extract_props('name')[i],
        extract_props('type')[i]
        );
    });

    console.log(address_data)
    var filtered_address_data = _.filter(address_data, function(a){return a.type ===  "municipality"});
    var mapped_address_data = _.map(filtered_address_data, function(e) {return e.postcode + " " + e.city})
    _.assign(pivot_map, _.zipObject(mapped_address_data, address_data));

    return mapped_address_data;
  },
  contentOfInputManuallyChanged: function() {
    this.resetAllCalculatedFields();
  },
  resetAllCalculatedFields: function() {
    $('#citycode').val('');
    $('#administrative_area_level_1').val('');
    $('#country').val('');
    $('#postal_code').val('');
    $('#street_number').val('');
    $('#locality').val('');
    $('#route').val('');
  },
  newResultEntered:  function(the_input_val, pivot_map) {
    var obj = pivot_map[the_input_val];
    if (_.isPlainObject(obj)) {
      var the_name = obj.name;
      var the_street = obj.street;
      var the_type = obj.type;

      var the_route = null;
      if (the_type === 'housenumber' || the_type === 'street') {
        the_route = the_street ? the_street : the_name;
      }

      $('#citycode').val(obj.citycode);
      $('#administrative_area_level_1').val(_.last(obj.context.split(', ')));
      $('#country').val('France');
      $('#postal_code').val(obj.postcode);
      $('#street_number').val(obj.housenumber);
      $('#locality').val(obj.city);
      $('#route').val(the_route);
      $('#location_label').val($(clara.a11y.search1.search_selector).val().trim());

      $('.js-next').focus();
    }
  },
  transformInputVal: function(input_val) {
    if (_.includes(input_val.toLowerCase(), ' bd ')) {
      return input_val.toLowerCase().replace(' bd ', ' boulevard ');
    } else {
      return input_val;
    }
  }
});

$(document).on('ready turbolinks:load', function () {
  // Turbolinks breaks PNotify context, needs to reinstantiate it here 
  // See https://stackoverflow.com/a/28220612/2595513
  PNotify.prototype.options.stack  = {
    dir1: "down",
    dir2: "left",
    push: "bottom",
    spacing1: 25,
    spacing2: 25,
    context: $("body")
  };
  if ($('body').hasClass('address_questions', 'new')) {

    /* Init
    ––––––––––––––––––––––––––––––––––––––––––––––––––*/
    $(clara.a11y.search1.search_selector).focus();

    /* Autocomplete
    ––––––––––––––––––––––––––––––––––––––––––––––––––*/
    clara.a11y.autocomplete(clara.a11y.search1);

    /* Encourage
    ––––––––––––––––––––––––––––––––––––––––––––––––––*/
    if (PNotify && localStorage && _.isEmpty(localStorage.getItem("soon_finished_info"))) {
     localStorage.setItem("soon_finished_info", "true");
     PNotify.removeAll();
     setTimeout(function(){
       new PNotify({
        title: 'Plus que 2 questions',
        type: 'info',
        buttons:{
          sticker: false,
        },
        text: "Plus que 2 questions et vous obtenez vos résultats (celle-ci est facultative)"
      });
     }, 500);
   }

 }
});
