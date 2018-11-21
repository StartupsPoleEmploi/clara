//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require administrate/aids_collection
describe('aids_collection.js', function() {
  describe('clara.aids.find_col_nb_for', function() {
    
    // inspired by https://stackoverflow.com/a/14292476/2595513
    var htmlContent;
    beforeEach(function(){
      var realistic_paginated_aid_collection = MagicLamp.load("realistic_paginated_aid_collection");
      htmlContent = $(realistic_paginated_aid_collection);
      htmlContent.attr("id", "realistic_paginated_aid_collection")
      $(document.body).append(htmlContent);
    });
    afterEach(function(){
      // comment line below so that can you see the table inside the browser when debugging
      $('table[aria-labelledby="page-title"]').remove();
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
