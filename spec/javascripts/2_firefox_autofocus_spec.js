//= require custom/autofocus_firefox
describe('autofocus_firefox.js', function () {
  beforeEach(function () {
    $(document.body).append("<form><input></input><input></input></form>")
    $("input:first").addClass("without_autofocus c-field")
    $("input:last").addClass("with_autofocus c-field")
    $("input.with_autofocus").attr('autofocus', 'autofocus');
  });
  it('Needs clara.autofocus_firefox to be defined', function () {
    expect(clara.autofocus_firefox).toBeDefined();
  });
  it("Should not focus on input without autofocus", function () {
    expect($('input.without_autofocus').is(":focus")).toEqual(false)
  });
  it("Should focus on input with autofocus", function () {
    expect($("input:visible:first").is(":focus"))
  });
});
