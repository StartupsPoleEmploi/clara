//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require cookies


describe('cookies.js', function() {

  it('Should have clara mapped', function() {
    expect(clara).toBeDefined();
  });

  it('Should have cookies mapped to clara', function() {
    expect(clara.cookies).toBeDefined();
  });

  beforeEach(function() { 
    $('body').append(' <input id="authorize_all" name="control_all" type="radio" value="authorize_all"></input>           \
                            <input id="forbid_all" name="control_all" type="radio" value="forbid_all"></input>          \
                            <input id="authorize_statistic" name="statistic" type="radio" value="authorize_statistic"></input>                                             \
                            <input id="forbid_statistic" name="statistic" type="radio" value="forbid_statistic"></input>              \
                            <input id="authorize_navigation" name="navigation" type="radio" value="authorize_navigation"></input>  \
                            <input id="forbid_navigation" name="navigation" type="radio" value="forbid_navigation"></input>                         \
                        ');
  });

/*  afterEach(function() {
    $("#authorize_all").remove();
    $("#forbid_all").remove();
    $("#authorize_statistic").remove();
    $("#authorize_navigation").remove();
    $("#forbid_navigation").remove();
    $("#forbid_statistic").remove();
  })*/

  it("Should check all checkbox when you click on 'Tout Autoriser'", function() {
    // given
    // when
    clara.cookies();
    // then
    expect($("#authorize_statistic").is(":checked")).toBe(true)
    expect($("#authorize_navigation").is(":checked")).toBe(true)
  });
});
