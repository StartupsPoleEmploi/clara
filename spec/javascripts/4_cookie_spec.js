//= require cookies
describe('cookies.js', function() {

  it('Should have cookies mapped to clara', function() {
    expect(clara.cookies).toBeDefined();
  });

  beforeEach(function() { 
    $('body').append(' <input id="authorize_all" name="control_all" type="button" value="authorize_all"></input>           \
                            <input id="forbid_all" name="control_all" type="button" value="forbid_all"></input>          \
                            <input id="authorize_statistic" name="statistic" type="radio" value="authorize_statistic"></input>                                             \
                            <input id="forbid_statistic" name="statistic" type="radio" value="forbid_statistic"></input>              \
                            <input id="authorize_navigation" name="navigation" type="radio" value="authorize_navigation"></input>  \
                            <input id="forbid_navigation" name="navigation" type="radio" value="forbid_navigation"></input>                         \
                            <input id="input_nav" type="checkbox" value="input_nav"></input>                         \
                            <input id="input_stat" type="checkbox" value="input_stat"></input>                         \
                        ');
  });

  afterEach(function() {
    $("#authorize_all").remove();
    $("#forbid_all").remove();
    $("#authorize_statistic").remove();
    $("#authorize_navigation").remove();
    $("#forbid_navigation").remove();
    $("#forbid_statistic").remove();
  })
    
  describe('authorize_all', function() {
    it('Should check authorize_statistic when you click on authorize_all', function() {
      //given
      clara.cookies.authorize_all();
      //when
      $('#authorize_all').click();
      //then
      expect($("#authorize_statistic").is(":checked")).toBe(true);
    });
    it('Should check authorize_navigation when you click on authorize_all', function() {
      //given
      clara.cookies.authorize_all();
      //when
      $('#authorize_all').click();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(true);
    });
    it('Should not check forbid_navigation when you click on authorize_all', function() {
      //given
      clara.cookies.authorize_all();
      //when
      $('#authorize_all').click();
      //then
      expect($("#forbid_navigation").is(":checked")).toBe(false);
    });
    it('Should not check forbid_statistic when you click on authorize_all', function() {
      //given
      clara.cookies.authorize_all();
      //when
      $('#authorize_all').click();
      //then
      expect($("#forbid_statistic").is(":checked")).toBe(false);
    });

  });

  describe('forbid_all', function() {
    it('Should check forbid_statistic when you click on forbid_all', function() {
      //given
      clara.cookies.forbid_all();
      //when
      $('#forbid_all').click();
      //then
      expect($("#forbid_statistic").is(":checked")).toBe(true);
    });
    it('Should check forbid_navigation when you click on forbid_all', function() {
      //given
      clara.cookies.forbid_all();
      //when
      $('#forbid_all').click();
      //then
      expect($("#forbid_navigation").is(":checked")).toBe(true);
    });

    it('Should not check authorize_navigation when you click on forbid_all', function() {
      //given
      clara.cookies.forbid_all();
      //when
      $('#forbid_all').click();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(false);
    });
    it('Should not check authorize_statistic when you click on forbid_all', function() {
      //given
      clara.cookies.forbid_all();
      //when
      $('#forbid_all').click();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(false);
    });
  }); 
});
