//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require administrate/aids_collection
describe('aids_collection.js', function() {
  it('Shoud define a clara.aids.query_string function', function() {
      expect(_.isFunction(_.get(window, "clara.aids.query_string"))).toEqual(true);
    });  
});
