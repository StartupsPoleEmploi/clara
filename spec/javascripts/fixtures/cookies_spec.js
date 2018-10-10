//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require cookies

describe('cookies.js', function() {
  describe('There are is authorize button', function(){
    beforeEach(function() {
      $('body').append('<button id="authorize_all">Tout autoriser</button>')
    });
    afterEach(function() {
      $('#authorize_all').remove()
    })

    it('Needs to be mapped to global clara', function() {
      expect(clara).toBeDefined();
    });

    it('Needs to have an authorize_all button',function(){
      expect($('#authorize_all').length).toEqual(1);
    });
  });

});
