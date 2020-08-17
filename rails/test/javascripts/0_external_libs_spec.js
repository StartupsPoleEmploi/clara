describe('External libs', function() {
  it('Should have jquery 1.12.4', function() {
    expect($.fn.jquery).toBe('1.12.4');
  });
  it('Should have lodash 4.17.5', function() {
    expect(_.VERSION).toBe('4.17.5');
  });
});
