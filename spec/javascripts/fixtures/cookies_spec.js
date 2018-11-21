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
    $("#input_stat").remove();
    $("#input_nav").remove();
  })

  describe('init_cookies_preferences', function() {
    
    it("Arriving on the page authorize_navigation should be checked", function() {
      // given
      $("#authorize_all").prop("checked", true);
      // when
      clara.cookies.init_cookies_preferences();
      // then
      expect($("#authorize_navigation").is(":checked")).toBe(true);
    });

    it("Arriving on the page authorize_statistic should be checked", function() {
      // given
      $("#authorize_all").prop("checked", true);
      // when
      clara.cookies.init_cookies_preferences();
      // then
      expect($("#authorize_statistic").is(":checked")).toBe(true);
    });
    it("Arriving on the page forbid_statistic should be unchecked", function() {
      // given
      $("#authorize_all").prop("checked", true);
      // when
      clara.cookies.init_cookies_preferences();
      // then
      expect($("#forbid_statistic").is(":checked")).toBe(false);
    });
    it("Arriving on the page forbid_navigation should be unchecked", function() {
      // given
      $("#authorize_all").prop("checked", true);
      // when
      clara.cookies.init_cookies_preferences();
      // then
      expect($("#forbid_navigation").is(":checked")).toBe(false);
    });
    it("Arriving on the page input_nav should be unchecked", function() {
      // given
      $("#authorize_all").prop("checked", true);
      // when
      clara.cookies.init_cookies_preferences();
      // then
      expect($("#input_nav").is(":checked")).toBe(false);
    });
    it("Arriving on the page input_stat should be unchecked", function() {
      // given
      $("#authorize_all").prop("checked", true);
      // when
      clara.cookies.init_cookies_preferences();
      // then
      expect($("#input_stat").is(":checked")).toBe(false);
    });
  });

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
    it('Should not check input_nav when you click on authorize_all', function() {
      //given
      clara.cookies.authorize_all();
      //when
      $('#authorize_all').click();
      //then
      expect($("#input_nav").is(":checked")).toBe(false);
    });
    it('Should not check input_stat when you click on authorize_all', function() {
      //given
      clara.cookies.authorize_all();
      //when
      $('#authorize_all').click();
      //then
      expect($("#input_stat").is(":checked")).toBe(false);
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
    it('Should check input_nav when you click on forbid_all', function() {
      //given
      clara.cookies.forbid_all();
      //when
      $('#forbid_all').click();
      //then
      expect($("#input_nav").is(":checked")).toBe(true);
    });
    it('Should check input_stat when you click on forbid_all', function() {
      //given
      clara.cookies.forbid_all();
      //when
      $('#forbid_all').click();
      //then
      expect($("#input_stat").is(":checked")).toBe(true);
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

  describe('authorize_navigation', function() {
    it('Should uncheck forbid_all when you click on authorize_navigation', function() {
      //given
      clara.cookies.authorize_navigation();
      //when
      $('#authorize_navigation').click();
      //then
      expect($("#forbid_all").is(":checked")).toBe(false);
    });
    it('Should uncheck input_nav when you click on authorize_navigation', function() {
      //given
      clara.cookies.authorize_navigation();
      //when
      $('#authorize_navigation').click();
      //then
      expect($("#input_nav").is(":checked")).toBe(false);
    });
    it('Should check authorize_all when you click on authorize_navigation and if authorize_statistic is checked', function() {
      //given
      $("#authorize_statistic").prop("checked", true);
      clara.cookies.authorize_navigation();
      //when
      $('#authorize_navigation').click();
      //then
      expect($("#authorize_all").is(":checked")).toBe(true);
    });
  });

  describe('authorize_statistic', function() {
    it('Should uncheck forbid_all when you click on authorize_statistic', function() {
      //given
      clara.cookies.authorize_statistic();
      //when
      $('#authorize_statistic').click();
      //then
      expect($("#forbid_all").is(":checked")).toBe(false);
    });
    it('Should uncheck input_nav when you click on authorize_statistic', function() {
      //given
      clara.cookies.authorize_statistic();
      //when
      $('#authorize_statistic').click();
      //then
      expect($("#input_nav").is(":checked")).toBe(false);
    });
    it('Should check authorize_all when you click on authorize_statistic and if authorize_navigation is checked', function() {
      //given
      $("#authorize_navigation").prop("checked", true);
      clara.cookies.authorize_statistic();
      //when
      $('#authorize_statistic').click();
      //then
      expect($("#authorize_all").is(":checked")).toBe(true);
    });
  });

  describe('forbid_navigation', function() {
    it('Should uncheck authorize_all when you click on forbid_navigation', function() {
      //given
      clara.cookies.forbid_statistic();
      //when
      $('#authorize_statistic').click();
      //then
      expect($("#authorize_all").is(":checked")).toBe(false);
    });
  });
});
