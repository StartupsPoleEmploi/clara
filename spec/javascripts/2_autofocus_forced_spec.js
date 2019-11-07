//= require custom/autofocus_forced

describe('autofocus_forced.js', function () {

  afterEach(function () {
    $('#tested_div').remove()
  });

  describe('.please_if', function () {
    it('returns true if there is a DOM element with the "autofocus" attribute', function () {
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

    it('returns true if there is a deeply nested DOM element with the "autofocus" attribute', function () {
      //given
      $(document.body).append(
        '<div id="tested_div">\
          <section>\
              <article>\
                  <div>\
                      <form>\
                          <div id="simple-div" autofocus>\
                      </form>\
                  </div>\
                  <div>\
                    <form>\
                      <input type="checkbox">\
                    </form>\
              </article >\
          </section >\
        </div >'
      )
      //when
      res = clara.autofocus_forced.please_if()
      //then
      expect(res).toEqual(true)
    });

    it('returns true if there is a multiple DOM elements with the "autofocus" attribute', function () {
      //given
      $(document.body).append(
        '<div id="tested_div">\
          <form action="action_test" method="post">\
              <input type="button" value="button_test" autofocus>\
              <textarea name="txtarea_test" autofocus=""></textarea>\
              <input type="color">\
              <input type="checkbox" autofocus="autofocus">\
          </form>\
          <form action="action_test_2" method="post">\
            <input type="password" value="button_test" autofocus>\
            <input type="number">\
            <input type="button" autofocus="choucroute">\
          </form>\
        </div>'
      )
      //when
      res = clara.autofocus_forced.please_if()
      //then
      expect(res).toEqual(true)
    });



    it('returns false if there is no DOM element with the autofocus attribute (example 1)', function () {
      //given
      $(document.body).append(
        '<div id="tested_div">\
          <form action="action_test" method="post">\
              <input type="button" value="button_test">\
              <textarea name="txtarea_test"></textarea>\
              <input type="checkbox">\
          </form>\
        </div>'
      )
      //when
      res = clara.autofocus_forced.please_if()
      //then
      expect(res).toEqual(false)
    });

    it('returns false if there is no DOM element with the autofocus attribute (example 2)', function () {
      //given
      $(document.body).append(
        '<div id="tested_div">\
          <div class="autofocus">\
              <ul id="autofocus">\
                  <li class="autofocus"></li>\
                  <li class="autofocus"></li>\
                  <li class="autofocus"></li>\
              </ul>\
              <form action="autofocus">\
                  <input type="color" name="autofocus" id="autofocus">\
              </form>\
          </div>\
        </div>'
      )
      //when
      res = clara.autofocus_forced.please_if()
      //then
      expect(res).toEqual(false)
    });
  });

  describe('.please', function () {
    it('DO NOT give focus to a DOM element WITHOUT autofocus_forced triggered', function () {
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
    it('DO NOT give focus to a DOM element WITHOUT autofocus attribute', function () {
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
    it('Gives focus to a DOM element with autofocus attribute', function () {
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

    it('Gives focus to a DOM element with autofocus attribute=\"\"', function () {
      //given
      $(document.body).append(
        '<div id="tested_div">\
          <form action="action_test" method="post">\
              <textarea id="textarea_focus" name="txtarea_test" autofocus=""></textarea>\
          </form>\
        </div>'
      )
      //when
      res = clara.autofocus_forced.please()
      //then
      expect($('#textarea_focus').get(0)).toBe(document.activeElement);
    });

    it('Gives focus to a DOM element with autofocus attribute=\"autofocus\"', function () {
      //given
      $(document.body).append(
        '<div id="tested_div">\
          <form action="action_test" method="post">\
              <input type="checkbox" id="checkbox_focus" autofocus="autofocus">\
          </form>\
        </div>'
      )
      //when
      res = clara.autofocus_forced.please()
      //then
      expect($('#checkbox_focus').get(0)).toBe(document.activeElement);
    });

    it('DO NOT give focus to a DOM element that is not focusable (a DIV is not focusable)', function () {
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
    it('Gives focus to FIRST dom element with autofocus attribute', function () {
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
