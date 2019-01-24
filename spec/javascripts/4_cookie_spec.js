//= require custom/edit_cooky
describe('edit_cooky.js', function() {

  it('Should have edit_cooky mapped to clara', function() {
    expect(clara.edit_cooky).toBeDefined();
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
    
  describe('setup_authorize_all_callbacks', function() {
    it('Should check authorize_statistic when you click on authorize_all', function() {
      //given
      clara.edit_cooky.setup_authorize_all_callbacks();
      //when
      $('#authorize_all').click();
      //then
      expect($("#authorize_statistic").is(":checked")).toBe(true);
    });
    it('Should check authorize_navigation when you click on authorize_all', function() {
      //given
      clara.edit_cooky.setup_authorize_all_callbacks();
      //when
      $('#authorize_all').click();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(true);
    });
    it('Should not check forbid_navigation when you click on authorize_all', function() {
      //given
      clara.edit_cooky.setup_authorize_all_callbacks();
      //when
      $('#authorize_all').click();
      //then
      expect($("#forbid_navigation").is(":checked")).toBe(false);
    });
    it('Should not check forbid_statistic when you click on authorize_all', function() {
      //given
      clara.edit_cooky.setup_authorize_all_callbacks();
      //when
      $('#authorize_all').click();
      //then
      expect($("#forbid_statistic").is(":checked")).toBe(false);
    });

  });

  describe('setup_forbid_all', function() {
    it('Should check forbid_statistic when you setup forbid_all', function() {
      //given
      clara.edit_cooky.setup_forbid_all_callbacks();
      //when
      $('#forbid_all').click();
      //then
      expect($("#forbid_statistic").is(":checked")).toBe(true);
      expect($("#forbid_navigation").is(":checked")).toBe(true);
    });
    it('Should not check authorize_navigation when you setup forbid_all', function() {
      //given
      clara.edit_cooky.setup_forbid_all_callbacks();
      //when
      $('#forbid_all').click();
      //then
      expect($("#authorize_navigation").is(":checked")).toBe(false);
      expect($("#authorize_statistic").is(":checked")).toBe(false);
    });
  }); 
});
