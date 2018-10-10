//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require cookies

describe('cookies.js', function() {
  describe('There are an authorize_all button, a forbid_all button', function(){
    beforeEach(function() {
      $('body').append('<button id="authorize_all">Tout autoriser</button>')
      $('body').append('<button id="forbid_all">Tout autoriser</button>')
      $('body').append('<button id="authorize_statistic">Tout autoriser</button>')
    });
    afterEach(function() {
      $('#authorize_all').remove()
      $('#forbid_all').remove()
      $('#authorize_statistic').remove()
    })

    it('Needs to be mapped to global clara', function() {
      expect(clara).toBeDefined();
    });

    it('Needs to have an authorize_all button',function(){
      expect($('#authorize_all').length).toEqual(1);
    });

    it('Needs to have a forbid_all button',function(){
      expect($('#forbid_all').length).toEqual(1);
    });

    it('Needs to have a authorize_statistic button',function(){
      expect($('#authorize_statistic').length).toEqual(1);
    });
    it('Needs to have a forbid_statistic button',function(){
      expect($('#forbid_statistic').length).toEqual(1);
    });

  });

});
