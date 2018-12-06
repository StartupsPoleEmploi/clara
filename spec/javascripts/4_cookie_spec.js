//= require cookies
describe('cookies.js', function() {

  it('Should have cookies mapped to clara', function() {
    expect(clara.cookies).toBeDefined();
  });

  beforeEach(function() { 

    $('body').append('\
      <div class="test-only">\
        <input id="authorize_all"        name="control_all" type="button" value="authorize_all">\
        <input id="forbid_all"           name="control_all" type="button" value="forbid_all">\
        <input id="authorize_statistic"  name="statistic"   type="radio"  value="authorize_statistic">\
        <input id="forbid_statistic"     name="statistic"   type="radio"  value="forbid_statistic">\
        <input id="authorize_navigation" name="navigation"  type="radio"  value="authorize_navigation">\
        <input id="forbid_navigation"    name="navigation"  type="radio"  value="forbid_navigation">\
        <div id="hj-script">\
        <div id="ga-script">\
      </div>\
    ');

  });

  afterEach(function() {
    $(".test-only").remove();
  })
    
  describe('radiobuttons_state', function() {
    it('Should say yes to analytics if ga-create script is already here', function() {
      //given
      expect($("#authorize_statistic").is(":checked")).toBe(false);
      //when
      clara.cookies.setup_initial_radiobuttons_state();
      //then
      expect($("#authorize_statistic").is(":checked")).toBe(true);
    });
    it('Should say yes to hotjar if hj-create script is already here', function() {
      //given
      expect($("#authorize_navigation").is(":checked")).toBe(false);
      //when
      clara.cookies.setup_initial_radiobuttons_state();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(true);
    });
    it('Should say no to analytics if ga-create script is not already here', function() {
      //given
      clara.cookies.setup_initial_radiobuttons_state();
      expect($("#authorize_statistic").is(":checked")).toBe(true);
      //when
      $("#ga-script").remove();
      //then
      clara.cookies.setup_initial_radiobuttons_state();
      expect($("#authorize_statistic").is(":checked")).toBe(false);
    });
    it('Should say no to hotjar if hj-create script is not already here', function() {
      //given
      clara.cookies.setup_initial_radiobuttons_state();
      expect($("#authorize_navigation").is(":checked")).toBe(true);
      //when
      $("#hj-script").remove();
      //then
      clara.cookies.setup_initial_radiobuttons_state();
      expect($("#authorize_navigation").is(":checked")).toBe(false);
    });

  });

  describe('setup_authorize_all_callbacks', function() {
    it('Should check authorize_statistic when you click on authorize_all', function() {
      //given
      clara.cookies.setup_authorize_all_callbacks();
      //when
      $('#authorize_all').click();
      //then
      expect($("#authorize_statistic").is(":checked")).toBe(true);
    });
    it('Should check authorize_navigation when you click on authorize_all', function() {
      //given
      clara.cookies.setup_authorize_all_callbacks();
      //when
      $('#authorize_all').click();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(true);
    });
    it('Should not check forbid_navigation when you click on authorize_all', function() {
      //given
      clara.cookies.setup_authorize_all_callbacks();
      //when
      $('#authorize_all').click();
      //then
      expect($("#forbid_navigation").is(":checked")).toBe(false);
    });
    it('Should not check forbid_statistic when you click on authorize_all', function() {
      //given
      clara.cookies.setup_authorize_all_callbacks();
      //when
      $('#authorize_all').click();
      //then
      expect($("#forbid_statistic").is(":checked")).toBe(false);
    });

  });

  describe('forbid_all', function() {
    it('Should check forbid_statistic when you click on forbid_all', function() {
      //given
      clara.cookies.setup_forbid_all_callbacks();
      //when
      $('#forbid_all').click();
      //then
      expect($("#forbid_statistic").is(":checked")).toBe(true);
    });
    it('Should check forbid_navigation when you click on forbid_all', function() {
      //given
      clara.cookies.setup_forbid_all_callbacks();
      //when
      $('#forbid_all').click();
      //then
      expect($("#forbid_navigation").is(":checked")).toBe(true);
    });

    it('Should not check authorize_navigation when you click on forbid_all', function() {
      //given
      clara.cookies.setup_forbid_all_callbacks();
      //when
      $('#forbid_all').click();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(false);
    });
    it('Should not check authorize_statistic when you click on forbid_all', function() {
      //given
      clara.cookies.setup_forbid_all_callbacks();
      //when
      $('#forbid_all').click();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(false);
    });
  }); 
});
