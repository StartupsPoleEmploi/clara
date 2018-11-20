//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require cookies

describe('cookies.js', function() {
  it('Should have clara mapped', function() {
    expect(clara).toBeDefined();
  });
  it("Should check all checkbox when you click on 'Tout Autoriser'", function() {
    // given
    $('body').append('<input id="authorize_all" name="control_all" type="radio" value="authorize_all"></input>');
    $('body').append('<input id="forbid_all" name="control_all" type="radio" value="forbid_all"></input>');
    $('body').append('<input id="authorize_statistic" name="statistic" type="radio" value="authorize_statistic"></input>');
    $('body').append('<input id="forbid_statistic" name="statistic" type="radio" value="forbid_statistic"></input>');
    $('body').append('<input id="authorize_navigation" name="statistic" type="radio" value="authorize_navigation"></input>');
    $('body').append('<input id="forbid_navigation" name="statistic" type="radio" value="forbid_navigation"></input>');
    // when
    test()
    // then
    expect($("#authorize_statistic").is(":checked")).toBe(true)
    expect($("#authorize_navigation").is(":checked")).toBe(true)
  });
});
