//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require a11y-autocomplete/namespacing
//= require a11y-autocomplete/accessibility-helpers
//= require a11y-autocomplete/accessible_autocomplete
//= require address_questions
describe('address_questions.js', function() {
  var typical_input = {};

  beforeEach(function() {
    typical_input = {
      attribution: 'BAN',
      licence: 'ODbL 1.0',
      query: '8 bd du port',
      type: 'FeatureCollection',
      version: 'draft',
      features: [
        {
          properties: {
            context: '80, Somme, Picardie',
            housenumber: '8',
            label: '8 Boulevard du Port 80000 Amiens',
            postcode: '80000',
            citycode: '80021',
            id: 'ADRNIVX_0000000260875032',
            score: 0.3351181818181818,
            name: '8 Boulevard du Port',
            city: 'Amiens',
            type: 'housenumber'
          },
          geometry: {
            type: 'Point',
            coordinates: [2.29009, 49.897446]
          },
          type: 'Feature'
        },
        {
          properties: {
            context: '34, Herault, Languedoc-Roussillon',
            housenumber: '8',
            label: '8 Boulevard du Port 34140 Meze',
            postcode: '34140',
            citycode: '34157',
            id: 'ADRNIVX_0000000284423783',
            score: 0.3287575757575757,
            name: '8 Boulevard du Port',
            city: 'Meze',
            type: 'housenumber'
          },
          geometry: {
            type: 'Point',
            coordinates: [3.605875, 43.425232]
          },
          type: 'Feature'
        }
      ]
    };
  });

  it('Needs autocompletion to be mapped to global clara.a11y', function() {
    expect(clara).toBeDefined();
    expect(clara.a11y).toBeDefined();
    expect(clara.a11y.autocomplete).toBeDefined();
  });

  it('Should be able to autocomplete every 1 chars', function() {
    expect(clara.a11y.search1.autocomplete_every).toBe(1);
  });
  it('Should have autocompletion mapped to the #search input', function() {
    expect(clara.a11y.search1.search_selector).toBe('#search');
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
      clara.a11y.search1.contentOfInputManuallyChanged();
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
      clara.a11y.search1.errorOccured();
      // then
      _.each(all_selectors, function(selector){expect($('#' + selector).val()).toEqual('')})
    });
    it('Must hide content', function() {
      // given
      expect($('.c-address__content:visible').length).toEqual(1)
      // when
      clara.a11y.search1.errorOccured();
      // then
      expect($('.c-address__content:visible').length).toEqual(0)
    });
    it('Must express that we are sorry', function() {
      // given
      expect($('.c-address__explanation .sorry').length).toEqual(0)
      // when
      clara.a11y.search1.errorOccured();
      // then
      expect($('.c-address__explanation .sorry').length).toEqual(1)
    });
  });
  describe('.search1.transformInputVal', function() {
    it('Should be defined', function() {
      expect(clara.a11y.search1.transformInputVal).toBeDefined();
    });
    it('Should transform "bd" into "boulevard"', function() {
      expect(clara.a11y.search1.transformInputVal('11 bd machin')).toEqual('11 boulevard machin');
    });
    it('Should transform "BD" into "boulevard"', function() {
      expect(clara.a11y.search1.transformInputVal('11 BD machin')).toEqual('11 boulevard machin');
    });
  });
  describe('.search1.url', function() {
    it('Should be defined', function() {
      expect(clara.a11y.search1.url).toBeDefined();
    });
    it('Should return undefined if window.clara.env.ARA_URL_BAN is not properly set', function() {
      _.set(window, 'clara.env.ARA_URL_BAN', undefined)
      expect(clara.a11y.search1.url()).toEqual(undefined);
    });
    it('Should get window.clara.env.ARA_URL_BAN', function() {
      _.set(window, 'clara.env.ARA_URL_BAN', 'http://url_from_ban.com')
      expect(clara.a11y.search1.url()).toEqual('http://url_from_ban.com');
    });
  });
  describe('.search1.buildResultsFromAjax', function() {
    it('Should be defined', function() {
      expect(clara.a11y.search1.buildResultsFromAjax).toBeDefined();
    });
    it('Should return labels', function() {
      var pivot_map = {};
      // when
      var output = clara.a11y.search1.buildResultsFromAjax(typical_input, pivot_map);
      // then
      expect(output).toEqual(['80000 Amiens', '34140 Meze']);
    });
    it('Should assign results from ajax to given pivot_map', function() {
      var pivot_map = {};
      var expected_output = {
        '34140 Meze': {
          citycode: '34157',
          context: '34, Herault, Languedoc-Roussillon',
          postcode: '34140',
          housenumber: '8',
          city: 'Meze',
          street: undefined,
          name: '8 Boulevard du Port',
          type: 'housenumber'
        },
        '80000 Amiens': {
          citycode: '80021',
          context: '80, Somme, Picardie',
          postcode: '80000',
          housenumber: '8',
          city: 'Amiens',
          street: undefined,
          name: '8 Boulevard du Port',
          type: 'housenumber'
        }
        
      };

      // when
      clara.a11y.search1.buildResultsFromAjax(typical_input, pivot_map);
      // then
      expect(pivot_map).toEqual(expected_output);
    });
  });
});
