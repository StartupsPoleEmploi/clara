//= require a11y-autocomplete/namespacing
//= require a11y-autocomplete/accessibility-helpers
//= require a11y-autocomplete/accessible_autocomplete
//= require custom/address_questions
describe('address_questions.js', function() {

  describe('Definitions', function() {
    it('Needs clara to be defined', function() {
      expect(clara).toBeDefined();
    });
    it('Needs clara.a11y to be defined', function() {
      expect(clara.a11y).toBeDefined();
    });
    it('Needs clara.a11y.autocomplete to be defined', function() {
      expect(clara.a11y.autocomplete).toBeDefined();
    });
    it('Needs clara.search1 to be defined', function() {
      expect(clara.search1).toBeDefined();
    });
  });

  it('Should be able to autocomplete every 5 chars', function() {
    expect(clara.search1.autocomplete_every).toBe(5);
  });
  it('Should have autocompletion mapped to the #search input', function() {
    expect(clara.search1.search_selector).toBe('#search');
  });
  describe('.search1.contentOfInputManuallyChanged', function() {
    var all_selectors = ['citycode', 'administrative_area_level_1', 'country', 'postal_code', 'street_number', 'locality', 'route'];
    beforeEach(function() {
      _.each(all_selectors, function(selector){$('body').append("<input id='" + selector + "' value='sth'/>")});
    });
    afterEach(function() {
      _.each(all_selectors, function(selector){$("#" + selector).remove()});
    });
    it('Must reset values of #citycode, #administrative_area_level_1, #country, #postal_code, #street_number, #locality, #route', function() {
      // given
      _.each(all_selectors, function(selector){expect($('#' + selector).val()).toEqual('sth')})
      // when
      clara.search1.contentOfInputManuallyChanged();
      // then
      _.each(all_selectors, function(selector){expect($('#' + selector).val()).toEqual('')})
    });
  });
  describe('.search1.errorOccured', function() {
    var all_selectors = ['search', 'citycode', 'administrative_area_level_1', 'country', 'postal_code', 'street_number', 'locality', 'route'];
    beforeEach(function() {
      _.each(all_selectors, function(selector){$('body').append("<input id='" + selector + "' value='sth'/>")});
      $('body').append('<div class="c-address__explanation">Some explanation</div>');
      $('body').append('<div class="c-address__content">Some content</div>');
    });
    afterEach(function() {
      _.each(all_selectors, function(selector){$("#" + selector).remove()});
      $('.c-address__explanation').remove();
      $('.c-address__content').remove();
    });
    it('Must reset values of #search, #citycode, #administrative_area_level_1, #country, #postal_code, #street_number, #locality, #route', function() {
      // given
      _.each(all_selectors, function(selector){expect($('#' + selector).val()).toEqual('sth')})
      // when
      clara.search1.errorOccured();
      // then
      _.each(all_selectors, function(selector){expect($('#' + selector).val()).toEqual('')})
    });
    it('Must hide content', function() {
      // given
      expect($('.c-address__content:visible').length).toEqual(1)
      // when
      clara.search1.errorOccured();
      // then
      expect($('.c-address__content:visible').length).toEqual(0)
    });
    it('Must express that we are sorry', function() {
      // given
      expect($('.c-address__explanation .sorry').length).toEqual(0)
      // when
      clara.search1.errorOccured();
      // then
      expect($('.c-address__explanation .sorry').length).toEqual(1)
    });
  });
  describe('.search1.url', function() {
    it('Should be defined', function() {
      expect(clara.search1.url).toBeDefined();
    });
    it('Should return undefined if window.clara.env.ARA_URL_GEO_API is not properly set', function() {
      _.set(window, 'clara.env.ARA_URL_GEO_API', undefined)
      expect(clara.search1.url()).toEqual(undefined);
    });
    it('Should get window.clara.env.ARA_URL_GEO_API', function() {
      _.set(window, 'clara.env.ARA_URL_GEO_API', 'http://url_api_geo.com/')
      expect(clara.search1.url()).toEqual('http://url_api_geo.com/communes?codePostal=');
    });
  });
  describe('.search1.buildResultsFromAjax', function() {
    it('Should be defined', function() {
      expect(clara.search1.buildResultsFromAjax).toBeDefined();
    });
    it('Should return list of towns', function() {
      var pivot_map = {};
      var geo_api_code_postal = MagicLamp.loadJSON("geo_api_code_postal");
      // when
      var output = clara.search1.buildResultsFromAjax(geo_api_code_postal, pivot_map);
      // then
      expect(output).toEqual(["44240 La Chapelle-sur-Erdre", "44240 Sucé-sur-Erdre"]);
    });
    it('pivot_map must be correctly assigned', function() {
      var pivot_map = {};
      var geo_api_code_postal = MagicLamp.loadJSON("geo_api_code_postal");
      var french_arrondissement_input = MagicLamp.loadJSON("french_arrondissement_input");
      var expected_output = {
        "44240 La Chapelle-sur-Erdre": {
          "zipcode": "44240",
          "citycode": "44035",
          "locality": "La Chapelle-sur-Erdre",
          "country": "France",
        },
        "44240 Sucé-sur-Erdre": {
          "zipcode": "44240",
          "citycode": "44201",
          "locality": "Sucé-sur-Erdre",
          "country": "France",
        }
      };
      // when
      clara.search1.buildResultsFromAjax(geo_api_code_postal, pivot_map);
      // then
      expect(pivot_map).toEqual(expected_output);
    });
  });
});
