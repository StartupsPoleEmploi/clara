//= require custom/aides/aides_default_state.js
describe('aides_default_state.js', function() {

  describe('State is existing', function() {
    beforeEach(function() {
    });
    it('returns given INITIAL state if previous_state is not yet existing', function() {
      spyOn(clara.aides_get_state, "please").and.callFake(_.wrap(null));
      var res = clara.aides_default_state.please("my_initial_state");
      expect(res).toEqual("my_initial_state");
    });
    it('returns given INITIAL state if previous_state exists but as empty object', function() {
      spyOn(clara.aides_get_state, "please").and.callFake(_.wrap({}));
      var res = clara.aides_default_state.please("my_initial_state");
      expect(res).toEqual("my_initial_state");
    });
    // it('returns previous state if previous_state exists as non-empty object', function() {
    //   spyOn(clara.aides_get_state, "please").and.callFake(_.wrap({state:42}));
    //   res = clara.aides_default_state.please("my_initial_state");
    //   expect(res).toEqual({state:42});
    // });
    it('returns PREVIOUS state, if previous_state exists as non empty object, and raw data of previous_state didnt change');
    it('returns INITIAL state, if previous_state exists as non empty object, and raw data of previous_state actually changed', function(){
    //   spyOn(clara.aides_get_state, "please").and.callFake(_.wrap({state:42}));
    //   res = clara.aides_default_state.please("my_initial_state");
    //   expect(res).toEqual({state:42});      
    });
  });

});
  
