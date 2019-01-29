//= require custom/aides/aides_track_filter.js
describe('aides_track_filter.js', function() {

  describe('Nominal', function() {
    beforeEach(function(){
      _.set(window, "ga", _.noop)
    });
    afterEach(function(){
      delete window.ga
    });
    it('Nominal : should track', function() {
      var return_val = {};
      spyOn(window, 'ga').and.callFake(function(a, b, c, d, e) {
        return_val = {
          a:a,
          b:b,
          c:c,
          d:d,
          e:e,
        };
      });
      clara.aides_track_filter.please("my_filter");
      expect(return_val).toEqual(
        {
          a: "send",
          b: "event",
          c: "results",
          d: "filter",
          e: "my_filter"
        });
    });
  });

});
