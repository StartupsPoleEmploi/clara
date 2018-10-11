//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require cookies
//= require redux/redux

describe('cookies.js', function() {

  describe('There are buttons for authorize_all, forbid_all, authorize_statistic, forbid_statistic, authorize_navigation, forbid_navigation ', function(){
    beforeEach(function() {
      $('body').append('<button id="authorize_all">Tout autoriser</button>');
      $('body').append('<button id="forbid_all">Tout autoriser</button>');
      $('body').append('<button id="authorize_statistic">Tout autoriser</button>');
      $('body').append('<button id="forbid_statistic">Tout autoriser</button>');
      $('body').append('<button id="authorize_navigation">Tout autoriser</button>');
      $('body').append('<button id="forbid_navigation">Tout autoriser</button>');
      var initial_state = {
        disable_statistic: false,
        disable_navigation: false 
      };
    });
    afterEach(function() {
      $('#authorize_all').remove()
      $('#forbid_all').remove()
      $('#authorize_statistic').remove()
      $('#forbid_statistic').remove()
      $('#authorize_navigation').remove()
      $('#forbid_navigation').remove()
      var initial_state = {};
    });

    //TESTING DOM
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
    it('Needs to have an authorize_navigation button',function(){
      expect($('#authorize_navigation').length).toEqual(1);
    });
    it('Needs to have a forbid_navigation button',function(){
      expect($('#forbid_navigation').length).toEqual(1);
    });
    it('Needs')

      describe('Redux tests', function(){
        it('Should return the initial state', function() {
          expect(store.getState()).toEqual({
            disable_statistic: false,
            disable_navigation: false
          });
        });
      });
  });
});
