//= require custom/aides/aides_state_key.js
describe('aides_state_key.js', function() {

  describe('URL is http://clara.com/aides?for_id=foridval', function() {
    beforeEach(function() {
      var url_to_test = "http://clara.com/aides?for_id=foridval";
      spyOn($, "currentUrl").and.callFake(function(){return url_to_test});
    });
    it('clara.aides_state_key.please() returns state_of_foridval', function() {
        res = clara.aides_state_key.please();
        expect(res).toEqual("state_of_foridval");
    });
  });

});
