//= require lodash/lodash
//= require lodash/lodash_extension
//= require jquery
//= require administrate/aids_collection
describe('aids_collection.js', function() {

  describe('clara.aids.find_col_nb_for', function() {
    // inspired by https://stackoverflow.com/a/14292476/2595513
    var htmlContent;
    var find_col_nb_for;
    beforeEach(function(){
      find_col_nb_for = _.get(window, "clara.aids.find_col_nb_for");
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
      expect(_.isFunction(find_col_nb_for)).toEqual(true);
    });  
    it('Is able to find column number (1) of column "id" in a paginated collection', function() {
      // when
      var res = find_col_nb_for("id");
      // the
      expect(res).toEqual(1);
    });  
    it('Is able to find column number (7) of column "filters" in a paginated collection', function() {
      // when
      var res = find_col_nb_for("filters");
      // the
      expect(res).toEqual(7);
    });  
    it('Is able to find column number (5) of column "need_filters" in a paginated collection', function() {
      // when
      var res = find_col_nb_for("need_filters");
      // the
      expect(res).toEqual(5);
    });  
    it('Is able to find column number (6) of column "custom_filters" in a paginated collection', function() {
      // when
      var res = find_col_nb_for("custom_filters");
      // the
      expect(res).toEqual(6);
    });  
    it('Should return -1 for a column that doesn\'t exist', function() {
      // when
      var res = find_col_nb_for("unexisting_value");
      // the
      expect(res).toEqual(-1);
    });  
  });

  describe('clara.aids.extract_column_for', function() {
    // inspired by https://stackoverflow.com/a/14292476/2595513
    var htmlContent;
    var extract_column_for;
    beforeEach(function(){
      extract_column_for = _.get(window, "clara.aids.extract_column_for");
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
    it('Shoud define a clara.aids.extract_column_for function', function() {
      expect(_.isFunction(extract_column_for)).toEqual(true);
    });  
    it('Should be able to extract column that has all IDs', function() {
      var res = extract_column_for("id");
      expect(res.length).toEqual(20);
      expect($(res).map(function(i,e){return $(e).text().trim()}).toArray()).toEqual(["29", "32", "31", "38", "27", "66", "7", "35", "82", "39", "81", "90", "75", "21", "44", "93", "52", "57", "28", "68"]);
    });  
  });
  

});
