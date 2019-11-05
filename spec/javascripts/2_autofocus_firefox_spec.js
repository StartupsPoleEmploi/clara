//= require custom/autofocus_firefox

// describe('autofocus_firefox.js', function () {
//   beforeEach(function () {
//     $(document.body).append("<form><input></input><input></input></form>")
//     $("input:first").addClass("without_autofocus c-field")
//     $("input:last").addClass("with_autofocus c-field")
//     $("input.with_autofocus").attr('autofocus', 'autofocus');
//   });
//   afterEach(function () {
//     $("form").remove()
//   });
//   it('Needs clara.autofocus_firefox to be defined', function () {
//     expect(clara.autofocus_firefox).toBeDefined();
//   });
//   it("Should not focus on input without autofocus", function () {
//     expect($('input.without_autofocus').is(":focus")).toEqual(false)
//   });
//   it("Input with autofocus attribute should have with_autofocus class", function () {
//     expect($("input.c-field").attr("autofocus").hasClasses("with_autofocus")).toEqual(true)
//   });
//   it("Should focus on input with autofocus", function () {
//     expect($("input.c-field").attr("autofocus").is(":focus")).toEqual(true)
//   });
//   it("Should focus on input with autofocus", function () {
//     expect($("input.with_autofocus").is(":focus")).toEqual(true)
//   });
// });
describe('autofocus_firefox.js', function () {

  // beforeEach(function () {
  //   // Please read https://html.spec.whatwg.org/multipage/common-microsyntaxes.html#boolean-attributes
  //   $(document.body).append('\
  //     <form id="tested_div"> \
  //       <input id="unassigned" autofocus> \
  //       <input id="empty"      autofocus=""> \
  //       <input id="false"      autofocus="false"> \
  //       <input id="true"       autofocus="true"> \
  //       <input id="autofocus"  autofocus="autofocus"> \
  //       <input id="wrong"      autofocus="wrong"> \
  //       <input id="no-autofocus"> \
  //       <input id="hiddened" type="hidden" autofocus> \
  //       <div id="simple-div" autofocus> \
  //     </form>')
  // });
  afterEach(function () {
    $('#tested_div').remove()
  });

  it('Needs clara.autofocus_firefox to be defined', function () {
    expect(clara.autofocus_firefox).toBeDefined();
  });
  describe("For an empty form", function () {
    beforeEach(function () {
      $(document.body).append('\
        <form id="tested_div"> \
        </form>')
    })
    it('Should not give focus', function () {
      expect($(":focus").length).toEqual(0)
    });
  });

});
