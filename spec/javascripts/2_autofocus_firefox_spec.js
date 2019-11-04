//= require custom/autofocus_firefox
describe('autofocus_firefox.js', function () {
  beforeEach(function () {
    $(document.body).append("<form><input></input><input></input></form>")
    $("input:first").addClass("without_autofocus c-field")
    $("input:last").addClass("with_autofocus c-field")
    $("input.with_autofocus").attr('autofocus', 'autofocus');
  });
  afterEach(function () {
    $("form").remove()
  };
  it('Needs clara.autofocus_firefox to be defined', function () {
    expect(clara.autofocus_firefox).toBeDefined();
  });
  it("Should not focus on input without autofocus", function () {
    expect($('input.without_autofocus').is(":focus")).toEqual(false)
  });
  it("Input with autofocus attribute should have with_autofocus class", function () {
    expect($("input.c-field").attr("autofocus").hasClasses("with_autofocus").toEqual(true)
  });
  it("Should focus on input with autofocus", function () {
    expect($("input.c-field").attr("autofocus").is(":focus")).toEqual(true)
  });
  it("Should focus on input with autofocus", function () {
    expect($("input.with_autofocus").is(":focus")).toEqual(true)
  });
});
