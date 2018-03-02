//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery/jquery
//= require other_component

describe('other_component_spec.js', function() {

  it('Needs other_component_spec to be mapped to global clara.other_component', function() {
    expect(clara).toBeDefined();
    expect(clara.other_component).toBeDefined();
  });

  describe('Instanciation', function() {
    beforeEach(function() {
      $('body').append(nominal_content());
    });

    afterEach(function() {
      $('#valid-root').remove();
    });
    it('Return false when not instanciated', function() {
      expect(clara.other_component()).toEqual(false);  
    });
    it('Needs to be initiated from a DOM element', function() {
      expect(clara.other_component("#valid-root")).toEqual(true);  
    });
    it('If bad input return false', function() {
      expect(clara.other_component("#valid-root")).toEqual(true);  
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
