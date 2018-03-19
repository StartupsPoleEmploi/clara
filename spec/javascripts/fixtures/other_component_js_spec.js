//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery/jquery
//= require other_component

describe('other_component_spec.js', function() {

  var root_element;

  it('Needs other_component_spec to be mapped to global clara.other_component', function() {
    expect(clara).toBeDefined();
    expect(clara.other_component).toBeDefined();
  });

  describe('Instanciation', function() {
    beforeEach(function() {
      $('body').append(nominal_content());
    });

    afterEach(function() {
      $(root_element).remove();
    });
    it('Return false when not instanciated', function() {
      expect(clara.other_component()).toEqual(false);
    });
    it('Needs to be initiated from a DOM element', function() {
      expect(clara.other_component(root_element)).toEqual(true);
    });
    it('If bad input harki return false', function() {
      $('#val_harki').attr('id', 'azerty')
      expect(clara.other_component(root_element)).toEqual(false);
    });
    it('If bad input detenu return false', function() {
      $('#val_detenu').attr('id', 'azerty')
      expect(clara.other_component(root_element)).toEqual(false);
    });
    it('If bad input pi return false', function() {
      $('#val_pi').attr('id', 'azerty')
      expect(clara.other_component(root_element)).toEqual(false);
    });
    it('If bad input handicap return false', function() {
      $('#val_handicap').attr('id', 'azerty')
      expect(clara.other_component(root_element)).toEqual(false);
    });
  });
  describe('When click on "Je ne suis dans aucune de ces situations" ', function() {
    beforeEach(function() {
      $('body').append(nominal_content());
      clara.other_component(root_element);
      $('input#none').trigger('click');
    });
    afterEach(function() {
      $(root_element).remove();
    });
    it('Should check input#none"', function() {
      expect($('input#none').is(':checked')).toEqual(true);
    });
    it('Should uncheck input#val_harki', function() {
      expect($('input#val_harki').is(':checked')).toEqual(false);
    });
    it('Should uncheck input#val_pi', function() {
      expect($('input#val_pi').is(':checked')).toEqual(false);
    });
    it('Should uncheck input#val_handicap', function() {
      expect($('input#val_handicap').is(':checked')).toEqual(false);
    });
    it('Should uncheck input#val_detenu', function() {
      expect($('input#val_detenu').is(':checked')).toEqual(false);
    });
  });

  describe('When click on "Enfant/petit enfant de harki"', function() {
    beforeEach(function() {
      $('body').append(nominal_content());
      clara.other_component(root_element);
      $('input#val_harki').trigger('click');
    });
    afterEach(function() {
      $(root_element).remove();
    });
    it('Should check input#val_harki', function() {
      expect($('input#val_harki').is(':checked')).toEqual(true);
    });
    it('Should uncheck input#none', function() {
      expect($('input#none').is(':checked')).toEqual(false);
    });
  });
  describe('When click on "Ex détenu(e), prévenu(e)..."', function() {
    beforeEach(function() {
      $('body').append(nominal_content());
      clara.other_component(root_element);
      $('input#val_detenu').trigger('click');
    });
    afterEach(function() {
      $(root_element).remove();
    });
    it('Should check input#val_detenu', function() {
      expect($('input#val_detenu').is(':checked')).toEqual(true);
    });
    it('Should uncheck input#none', function() {
      expect($('input#none').is(':checked')).toEqual(false);
    });
  });

  describe('When click on "Bénéficiaire dune protection internationale"', function() {
    beforeEach(function() {
      $('body').append(nominal_content());
      clara.other_component(root_element);
      $('input#val_pi').trigger('click');
    });
    afterEach(function() {
      $(root_element).remove();
    });
    it('Should check input#val_pi', function() {
      expect($('input#val_pi').is(':checked')).toEqual(true);
    });
    it('Should uncheck input#none', function() {
      expect($('input#none').is(':checked')).toEqual(false);
    });
  });
  describe('Bénéficiaire de lobligation demploi (reconnu(e) en situation de handicap)"', function() {
    beforeEach(function() {
      $('body').append(nominal_content());
      clara.other_component();
      $('input#val_handicap').trigger('click');
    });
    afterEach(function() {
      $(root_element).remove();
    });
    it('Should check input#val_handicap', function() {
      expect($('input#val_handicap').is(':checked')).toEqual(true);
    });
    it('Should uncheck input#none', function() {
      expect($('input#none').is(':checked')).toEqual(false);
    });
  });


  function nominal_content() {
    return '' +
    '<div id="valid-root">' +
      '<input type="checkbox" id="val_harki" >' +
      '<input type="checkbox" id="val_pi" >' +
      '<input type="checkbox" id="val_handicap" >' +
      '<input type="checkbox" id="none" >' +
      '<input type="checkbox" id="val_detenu" >' +
    '</div>';
  }
});
