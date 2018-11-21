//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require administrate/aids_collection
describe('aids_collection.js', function() {
  describe('clara.aids.find_col_nb_for', function() {
    var htmlContent;

    beforeEach(function(){
      var realistic_paginated_aid_collection = MagicLamp.load("realistic_paginated_aid_collection");
      htmlContent = $(realistic_paginated_aid_collection);
      $(document.body).append(htmlContent);
    });
    afterEach(function(){
      htmlContent.remove();
      htmlContent = null;
    });
    it('Shoud define a clara.aids.find_col_nb_for function', function() {
      expect(_.isFunction(_.get(window, "clara.aids.find_col_nb_for"))).toEqual(true);
    });  
    it('Is able to find column number of column "id" in a paginated collection', function() {
      // given
      var find_col_nb_for = _.get(window, "clara.aids.find_col_nb_for");
      // when
      var res = find_col_nb_for("id");
      // the
      expect(res).toEqual(1);
    });  
  });
});
