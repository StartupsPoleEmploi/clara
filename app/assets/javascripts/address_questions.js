$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('address_questions', 'new')) {

    $('#search').on("change", function(e) {
        $('#address_form input').val('')
        $('input#location_label').val($('#search').val())
    });

    // Quite hacky, but more than enough to cover
    setTimeout(removeNonFranceResults, 2000)

    function removeNonFranceResults() {
        $(".pac-container").on("DOMSubtreeModified",function(){
          $.each($(".pac-container .pac-item"), function() {
            var str = $(this).text();
            // console.log(str)
            if (
              str.match(/, France$/) || 
              str.match(/, Saint-Barthélemy$/) || 
              str.match(/, Saint-Martin$/) || 
              str.match(/, Réunion$/) ||
              str.match(/Guadeloupe$/) || // buggy for Guadeloupe, no comma here
              str.match(/, Polynésie française$/) ||
              str.match(/, Mayotte$/) ||
              str.match(/, Guyane française$/) ||
              str.match(/, Saint-Pierre-et-Miquelon$/)) {
              // Keep it
            } else {
              // Remove it
              $(this).remove()
            }
          })
        });        
    }


    /* Autocomplete
    ––––––––––––––––––––––––––––––––––––––––––––––––––*/
    function initializeAutocomplete(id) {
      var element = document.getElementById(id);

      if (element) {
        var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
        // fr = france (1 rue sebastiani par ex)
        // bl = saint-barth (1 rue august nyman par ex)
        // mf = saint-martin (1 rue low town par ex)
        // re = la reunion (1 rue mac auliffe par ex)
        // gp = guadeloupe (1 route de caduc par ex)
        // pf = polynésie française (1 avenue du chef Vaira'atoa par ex)
        // yt = mayotte (1 Rue Mangua M'Kakassi par ex)
        // gf = guyane (1 Rue Madame Payée par ex)
        // pm = st pierre et miquelon (1 Rue Gloanec par ex)
        // autocomplete.setComponentRestrictions({'country': ['fr', 'bl', 'mf', 're', 'gp', 'pf', 'yt', 'gf', 'pm']});
        // autocomplete.setComponentRestrictions({'country': ['gp', 'pf', 'yt', 'gf', 'pm', 'fr']});
        // autocomplete.setComponentRestrictions({'country': ['fr']});
        google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
        google.maps.event.addListenerOnce(autocomplete, 'idle', function(){
            removeNonFranceResults()
        });
        google.maps.event.addDomListener(element, 'keydown', function(event) { 
          if (event.keyCode === 13) { 
            event.preventDefault()
        }
        }); 
      }
    }
    
    function onPlaceChanged() {

      var place = this.getPlace();

      $('#address_form input').val('')
      $('input#location_label').val($('#search').val())

      var postcode = _.get(_.first(_.filter(place.address_components, function(e) {return _.includes(e.types, "postal_code")})), 'long_name');

      var maybe_street_number = _.toInteger($('#search').val().split(' ')[0])

      if (postcode) {
        $("input.js-next").prop('disabled', true);
        $.get({
          url: window.clara.env.ARA_URL_BAN + place.formatted_address + '&limit=1&postcode=' + postcode,
          success: function(e) {
            $("input.js-next").prop('disabled', false);
            var citycode = _.get(e, "features[0].properties.citycode")
            $('input#citycode').val(citycode);
          },
          error: function(e) {
            $("input.js-next").prop('disabled', false);
          },
          timeout:2003
        });        
      }

      // console.log(place);  // Uncomment this line to view the full object returned by Google API.

      _.each(place.address_components, function (address_component){
        var input_target = address_component.types[0];
        $('#address_form  input#' + input_target).val(address_component.long_name);
      });

      if ($('#address_form  input#street_number').val() === '') {
        if (maybe_street_number !== 0) {
          $('#address_form  input#street_number').val(maybe_street_number)
        } 
      }

    }

    initializeAutocomplete("search")

    /* Encourage
    ––––––––––––––––––––––––––––––––––––––––––––––––––*/
    if (PNotify && localStorage && _.isEmpty(localStorage.getItem("soon_finished_info"))) {
     localStorage.setItem("soon_finished_info", "true");
     setTimeout(function(){
       PNotify.removeAll();
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
