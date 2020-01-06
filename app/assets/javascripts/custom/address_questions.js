_.set(window, 'clara.search1', {
  search_selector: '#search',
  results_selector: '#results',
  arialive_selector: '[aria-live]',
  autocomplete_every: 5,
  errorOccured: function(e) {
    $('input#search').val('');
    this.resetAllCalculatedFields();
    $('.c-address__explanation').empty();
    $('.c-address__content').hide();
    $('.c-address__explanation').append('<div class="h5-like sorry">Le service d\'adresse est <strong>momentanément indisponible</strong>, veuillez nous en excuser.<div>Cliquez sur "Continuer".</div></div>');
  },
  url: function() {
    return _.get(window, 'clara.env.ARA_URL_GEO_API') + "communes?codePostal=";
  },
  buildResultsFromAjax: function(feature_collection, pivot_map) {
    var result = _.map(feature_collection, function(e) {return e.codesPostaux[0] + " " + e.nom  })
    var mapped_address_data = _.map(feature_collection, function(e){
      return {
        country: "France",
        zipcode: e.codesPostaux[0],
        citycode: e.code,
        locality: e.nom,
      }
    });
    _.assign(pivot_map, _.zipObject(result, mapped_address_data))
    return result;
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
    console.log("pivot_map")
    console.log(pivot_map)
    console.log(the_input_val)
    var obj = pivot_map[the_input_val];
    if (_.isPlainObject(obj)) {

      $('#citycode').val(obj.citycode);
      $('#country').val(obj.country);
      $('#postal_code').val(obj.zipcode);
      $('#locality').val(obj.locality);

      $('.js-next').focus();
    }
  },
  transformInputVal: function(input_val) {
    return input_val;
  }
});


clara.load_js(function only_if(){return $("body").hasClasses("address_questions", "new")}, function() {


    /* Init
    ––––––––––––––––––––––––––––––––––––––––––––––––––*/
    if ($(clara.search1.search_selector).val() === "") {
      // Must set type="number" dynamically like this, or tanaguru test won't pass
      $(clara.search1.search_selector).prop("type", "number");
    }
    $(clara.search1.search_selector).focus();

    /* Autocomplete
    ––––––––––––––––––––––––––––––––––––––––––––––––––*/
    clara.a11y.autocomplete(clara.search1);


});
