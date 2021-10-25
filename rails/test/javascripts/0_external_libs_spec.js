describe('External libs', function() {
  it('Should have jquery 3.6.0', function() {
    expect($.fn.jquery).toBe('3.6.0');
  });
  it('Should have lodash 4.17.5', function() {
    expect(_.VERSION).toBe('4.17.5');
  });
});
