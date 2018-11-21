//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require cookies


describe('cookies.js', function() {

  function setUpHTMLFixture() {
          $('body').append(' <input id="authorize_all" name="control_all" type="radio" value="authorize_all"></input>           \
                                      <input id="forbid_all" name="control_all" type="radio" value="forbid_all"></input>          \
                                      <input id="authorize_statistic" name="statistic" type="radio" value="authorize_statistic"></input>                                             \
                                      <input id="forbid_statistic" name="statistic" type="radio" value="forbid_statistic"></input>              \
                                      <input id="authorize_navigation" name="navigation" type="radio" value="authorize_navigation"></input>  \
                                      <input id="forbid_navigation" name="navigation" type="radio" value="forbid_navigation"></input>                         \
                                  ');
  }

  
  it('Should have clara mapped', function() {
    expect(clara).toBeDefined();
    expect(clara.cookies).toBeDefined();
  });

  beforeEach(function() { 
    setUpHTMLFixture();
  });

  it("Should check all checkbox when you click on 'Tout Autoriser'", function() {
    // given
    // when
    // then
//    expect($("#authorize_statistic").is(":checked")).toBe(true)
//    expect($("#authorize_navigation").is(":checked")).toBe(true)
  });
});
