//= require custom/aides/aides
describe('aides.js', function() {

  beforeEach(function() { 
    MagicLamp.load("aides");
  });
  afterEach(function() { 
    $(".magic-lamp").remove();
  });

  it('Should have aides mapped to clara', function() {
    expect(clara.aides).toBeDefined();
  });

});
