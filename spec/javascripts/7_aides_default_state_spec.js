//= require custom/aides/please_get_aides_default_state.js
describe('please_get_aides_default_state.js', function() {

  it('Should have please_get_aides_default_state mapped to clara', function() {
    expect(clara.please_get_aides_default_state).toBeDefined();
  });

  describe('State is existing', function() {
    beforeEach(function() {
    });
    it('extract data from store thanks to state_key', function() {
      // given
      spyOn(clara.please_get_state_key, "main_function").and.callFake(_.wrap("key_in_store"));
      spyOn(store, "get")
      // when
      res = clara.please_get_aides_default_state.main_function("my_initial_state");
      // then
      expect(store.get).toHaveBeenCalledWith("key_in_store");
    });
    it('returns given initial state if previous_state is not yet existing', function() {
      spyOn(store, "get").and.callFake(_.wrap(null));
      res = clara.please_get_aides_default_state.main_function("my_initial_state");
      expect(res).toEqual("my_initial_state");
    });
    it('returns given initial state if previous_state exists but as empty object', function() {
      spyOn(store, "get").and.callFake(_.wrap({}));
      res = clara.please_get_aides_default_state.main_function("my_initial_state");
      expect(res).toEqual("my_initial_state");
    });
    it('returns previous state if previous_state exists as non-empty object', function() {
      spyOn(store, "get").and.callFake(_.wrap({state:42}));
      res = clara.please_get_aides_default_state.main_function("my_initial_state");
      expect(res).toEqual({state:42});
    });
  });

});
  
