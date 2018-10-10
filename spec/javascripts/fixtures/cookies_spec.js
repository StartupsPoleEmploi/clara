//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require cookies

describe('cookies.js', function() {

  it('Needs to be mapped to global clara', function() {
    expect(clara).toBeDefined();
  });

  it('Needs to have a authorize_all button',function(){
    expect($('#authorize_all').length).toEqual(1)
  })

});
