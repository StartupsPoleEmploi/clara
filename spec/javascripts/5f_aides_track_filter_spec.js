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
      spyOn(window, 'ga');
      clara.aides_track_filter.please("my_filter")
      expect(ga).toHaveBeenCalledWith('send', 'event', 'results', 'filter', 'my_filter');
    });
  });

});
