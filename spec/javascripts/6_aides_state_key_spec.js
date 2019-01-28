//= require custom/aides/aides_state_key.js
describe('aides_state_key.js', function() {

  it('Should have aides_state_key mapped to clara', function() {
    expect(clara.aides_state_key).toBeDefined();
  });

  describe('URL is http://clara.com/aides?for_id=foridval', function() {
    beforeEach(function() {
      var url_to_test = "http://clara.com/aides?for_id=foridval";
      spyOn($, "currentUrl").and.callFake(function(){return url_to_test});
    });
    it('clara.aides_state_key.main_function() returns state_of_foridval', function() {
        res = clara.aides_state_key.main_function();
        expect(res).toEqual("state_of_foridval");
    });
  });

});
