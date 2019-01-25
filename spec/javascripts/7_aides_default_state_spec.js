//= require custom/aides/please_get_aides_default_state.js
describe('please_get_aides_default_state.js', function() {

  it('Should have please_get_aides_default_state mapped to clara', function() {
    expect(clara.please_get_aides_default_state).toBeDefined();
  });

  describe('State is existing', function() {
    beforeEach(function() {
    });
    it('returns given initial state if not yet existing', function() {
      spyOn(clara.please_get_state_key, "main_function").and.callFake(function(){return null});
        res = clara.please_get_aides_default_state.main_function("my_initial_state");
        expect(res).toEqual("my_initial_state");
    });
  });

});
