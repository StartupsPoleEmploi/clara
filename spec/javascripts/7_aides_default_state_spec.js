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
    it('returns PREVIOUS state, if previous_state exists as non empty object, and raw data of previous_state didnt change', function(){      
      spyOn(clara.aides_get_state, "please").and.callFake(_.wrap({state:42}));
      spyOn(clara.aides_extract_raw_data, "please").and.returnValues(["a", "b"], ["a", "b"]);
      res = clara.aides_default_state.please("my_initial_state");
      expect(res).toEqual({state:42});      
    });
    it('returns INITIAL state, if previous_state exists as non empty object, but actual state changed', function() {
      spyOn(clara.aides_get_state, "please").and.callFake(_.wrap({state:42}));
      spyOn(clara.aides_extract_raw_data, "please").and.returnValues(["a", "b"], ["x", "y"]);
      res = clara.aides_default_state.please("my_initial_state");
      expect(res).toEqual("my_initial_state");      
    });
  });

});
  
