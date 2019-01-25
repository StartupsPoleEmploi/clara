//= require custom/aides/please_set_aides_state.js
describe('please_set_aides_state.js', function() {

  it('Should have please_get_aides_default_state mapped to clara', function() {
    expect(clara.please_set_aides_state).toBeDefined();
  });

  describe('_extract_from_state', function() {
    it('extract data from store thanks to state_key', function() {
      var realistic_state = MagicLamp.loadJSON("nominal_aides_state");
      var res = clara.please_set_aides_state._extract_from_state(realistic_state);
      expect(res).toEqual(["blabla"])
    });
  });

});
  
