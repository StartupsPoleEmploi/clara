//= require lodash/lodash
//= require jquery/jquery
describe('External libs', function() {
  it('Should have jquery 3.2.1', function() {
    expect($.fn.jquery).toBe('3.2.1');
  });
  it('Should have lodash 4.17.4', function() {
    expect(_.VERSION).toBe('4.17.4');
  });
});
