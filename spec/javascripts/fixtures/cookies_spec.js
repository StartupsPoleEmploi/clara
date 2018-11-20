//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require cookies

describe('Cookies.js', function() {
  it('Should have clara mapped', function() {
    expect(clara).toBeDefined();
  });
  it("Should check all checkbox when you click on 'Tout Autoriser'", function() {
    // given
    // when
    // then
    expect($("#authorize_statistic").is(":checked")).toBe(true)
    expect($("#authorize_navigation").is(":checked")).toBe(true)
  });
});
