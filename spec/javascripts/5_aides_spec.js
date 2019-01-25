//= require custom/aides
describe('aides.js', function() {

  beforeEach(function() { 
    MagicLamp.load("aides");
  });

  it('Should have aides mapped to clara', function() {
    expect(clara.aides).toBeDefined();
  });


});
