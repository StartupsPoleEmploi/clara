//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require other_component

describe('other_component_spec.js', function() {

  it('Needs other_component_spec to be mapped to global clara.other_component', function() {
    expect(clara).toBeDefined();
    expect(clara.other_component).toBeDefined();
  });

  describe('Instanciation', function() {
    it('Return false when not instanciated', function() {
      expect(clara.other_component()).toEqual(false);  
    });
    it('Needs to be initiated from a DOM element', function() {
      expect(clara.other_component("#valid-root")).toEqual(true);  
    });
  });
});
