//= require custom/aides/aides_get_state.js
//= require custom/aides/aides_state_key.js
describe('aides_get_state.js', function() {

  describe('Nominal', function() {
    beforeEach(function(){
      _.set(window, "store", {get: _.noop})
    });
    afterEach(function(){
      delete window.store
    });
    it('Nominal : get state', function() {
      // given
      spyOn(clara.aides_state_key, 'please').and.returnValue("a_key");
      spyOn(window.store, 'get').and.returnValue("returned_value");
      // when
      var result = clara.aides_get_state.please();
      // then
      expect(store.get).toHaveBeenCalledWith('a_key');
      expect(result).toEqual('returned_value');
    });
  });

});
