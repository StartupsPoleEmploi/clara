//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require other_component

describe('other_component_spec.js', function() {

  it('Needs other_component_spec to be mapped to global clara.other_component', function() {
    expect(clara).toBeDefined();
    expect(clara.other_component).toBeDefined();
  });

});
