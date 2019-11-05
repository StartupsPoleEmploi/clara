//= require custom/autofocus_firefox

describe('autofocus_firefox.js', function () {

  afterEach(function () {
    $('#tested_div').remove()
  });

  describe('.please_if', function() {
    it('returns true if there is a DOM element with the "autofocus" attribute', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <div id="simple-div" autofocus>\
         </form>'
      )
      //when
      res = clara.autofocus_firefox.please_if()
      //then
      expect(res).toEqual(true)
    });
    it('returns true if there is a deeply nested DOM element with the "autofocus" attribute', function() {
      //given
      //when
      //then
    });
    it('returns true if there is a multiple DOM elements with the "autofocus" attribute', function() {
      //given
      //when
      //then
    });
    it('returns false if there is no DOM element with the autofocus attribute (example 1)', function() {
      //given
      //when
      //then
    });
    it('returns false if there is no DOM element with the autofocus attribute (example 2)', function() {
      //given
      //when
      //then
    });
  });

  describe('.please', function() {
    it('DO NOT give focus to a DOM element WITHOUT autofocus_firefox triggered', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <input id="simple-div">\
         </form>'
      )
      //when
      // NOT CALLED DELIBERATELY
      //then
      expect($(":focus").length).toEqual(0)
    });
    it('DO NOT give focus to a DOM element WITHOUT autofocus attribute', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <input id="simple-div">\
         </form>'
      )
      //when
      res = clara.autofocus_firefox.please()
      //then
      expect($(":focus").length).toEqual(0)
    });
    it('Gives focus to a DOM element with autofocus attribute', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <input id="simple-div" autofocus>\
         </form>'
      )
      //when
      res = clara.autofocus_firefox.please()
      //then
      expect($(":focus").length).toEqual(1)
      expect($($(":focus")[0]).attr('id')).toEqual("simple-div")
    });
    it('Gives focus to a DOM element with autofocus attribute=\"\"', function() {
      // COMPLETE HERE
    });
    it('Gives focus to a DOM element with autofocus attribute=\"autofocus\"', function() {
      // COMPLETE HERE
    });
    it('DO NOT give focus to a DOM element that is not focusable (a DIV is not focusable)', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <div id="simple-div" autofocus>\
         </form>'
      )
      //when
      res = clara.autofocus_firefox.please()
      //then
      expect($(":focus").length).toEqual(0)
    });
    it('Gives focus to FIRST dom element with autofocus attribute', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <input id="first-div" autofocus>\
           <input id="second-div" autofocus>\
           <input id="third-div" autofocus>\
         </form>'
      )
      //when
      res = clara.autofocus_firefox.please()
      //then
      expect($(":focus").length).toEqual(1)
      expect($($(":focus")[0]).attr('id')).toEqual("first-div")
    });
  });

});
