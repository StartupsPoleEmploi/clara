//= require custom/autofocus_forced

describe('autofocus_forced.js', function () {

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
      res = clara.autofocus_forced.please_if()
      //then
      expect(res).toEqual(true)
    });

    it('returns true if there is a deeply nested DOM element with the "autofocus" attribute');
    
    it('returns true if there is a multiple DOM elements with the "autofocus" attribute');
    
    it('returns false if there is no DOM element with the autofocus attribute (example 1)');
    
    it('returns false if there is no DOM element with the autofocus attribute (example 2)');

  });

  describe('.please', function() {
    it('DO NOT give focus to a DOM element WITHOUT autofocus_forced triggered', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <input id="simple-div">\
         </form>'
      )
      //when
      // NOT CALLED DELIBERATELY
      //then
      expect($('#simple-div').get(0)).not.toBe(document.activeElement);
    });
    it('DO NOT give focus to a DOM element WITHOUT autofocus attribute', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <input id="simple-div">\
         </form>'
      )
      //when
      res = clara.autofocus_forced.please()
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
      res = clara.autofocus_forced.please()
      //then
      expect($('#simple-div').get(0)).toBe(document.activeElement);
    });

    it('Gives focus to a DOM element with autofocus attribute=\"\"');
    
    it('Gives focus to a DOM element with autofocus attribute=\"autofocus\"');
    
    it('DO NOT give focus to a DOM element that is not focusable (a DIV is not focusable)', function() {
      //given
      $(document.body).append(
        '<form id="tested_div">\
           <div id="simple-div" autofocus>\
         </form>'
      )
      //when
      res = clara.autofocus_forced.please()
      //then
      expect($('#simple-div').get(0)).not.toBe(document.activeElement);
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
      res = clara.autofocus_forced.please()
      //then
      expect($('#first-div').get(0)).toBe(document.activeElement);
    });
  });

});
