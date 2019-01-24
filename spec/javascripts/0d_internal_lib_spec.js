//= require_tree ../../app/assets/javascripts/custom
describe("Internal libs", function() {

  function _test_presence(prop) {
    it('should have ' + prop + ' defined ', function() {
      expect(_.get(window, 'clara.' + prop)).toBeDefined();
    });
  }

  _.each(_.keys(_.get(window, "clara")), function(key) {
    _test_presence(key);
  });

});
