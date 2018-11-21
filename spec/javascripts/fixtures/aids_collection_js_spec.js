//= require lodash/lodash
//= require lodash/lodash_extension
//= require load_js_prod
//= require jquery
//= require administrate/aids_collection
describe('aids_collection.js', function() {

  // inspired by https://stackoverflow.com/a/14292476/2595513
  var htmlContent;
  var find_col_nb_for;
  var extract_column_for;
  var clean_column_of;
  var find_row_whose_id_is;
  var find_cell_for;
  var treat_successfully_retrieved_filters;
  var extract_all_ids;
  beforeEach(function(){
    find_col_nb_for = _.get(window, "clara.aids.find_col_nb_for");
    extract_column_for = _.get(window, "clara.aids.extract_column_for");
    clean_column_of = _.get(window, "clara.aids.clean_column_of");
    find_row_whose_id_is = _.get(window, "clara.aids.find_row_whose_id_is");
    find_cell_for = _.get(window, "clara.aids.find_cell_for");
    treat_successfully_retrieved_filters = _.get(window, "clara.aids.treat_successfully_retrieved_filters");
    extract_all_ids = _.get(window, "clara.aids.extract_all_ids");
    htmlContent = $(MagicLamp.load("realistic_paginated_aid_collection"));
    $(document.body).append(htmlContent);
  });
  afterEach(function(){
    // comment line below so that can you see the table inside the browser when debugging
    $('table[aria-labelledby="page-title"]').remove();
    htmlContent = null;
  });

  describe('clara.aids.find_col_nb_for', function() {
    it('Shoud define a clara.aids.find_col_nb_for function', function() {
      expect(_.isFunction(find_col_nb_for)).toEqual(true);
    });  
    it('Is able to find column number (1) of column "id" in a paginated collection', function() {
      // When
      var res = find_col_nb_for("id");
      // Then
      expect(res).toEqual(1);
    });  
    it('Is able to find column number (7) of column "filters" in a paginated collection', function() {
      // When
      var res = find_col_nb_for("filters");
      // Then
      expect(res).toEqual(7);
    });  
    it('Is able to find column number (5) of column "need_filters" in a paginated collection', function() {
      // When
      var res = find_col_nb_for("need_filters");
      // Then
      expect(res).toEqual(5);
    });  
    it('Is able to find column number (6) of column "custom_filters" in a paginated collection', function() {
      // When
      var res = find_col_nb_for("custom_filters");
      // Then
      expect(res).toEqual(6);
    });  
    it('Should return -1 for a column that doesn\'t exist', function() {
      // When
      var res = find_col_nb_for("unexisting_value");
      // Then
      expect(res).toEqual(-1);
    });  
  });

  describe('clara.aids.extract_column_for', function() {
    it('Shoud define a clara.aids.extract_column_for function', function() {
      expect(_.isFunction(extract_column_for)).toEqual(true);
    });  
    it('Should be able to extract column that has all IDs', function() {
      var res = extract_column_for("id");
      expect(res.length).toEqual(20);
      expect($(res).map(function(i,e){return $(e).text().trim()}).toArray()).toEqual(["29", "32", "31", "38", "27", "66", "7", "35", "82", "39", "81", "90", "75", "21", "44", "93", "52", "57", "28", "68"]);
    });  
  });
  
  describe('clara.aids.clean_column_of', function() {
    it('Shoud define a clara.aids.clean_column_of function', function() {
      expect(_.isFunction(clean_column_of)).toEqual(true);
    });  
    it('Should be able to clean column that has all IDs', function() {
      // Given
      expect($(extract_column_for("id")).map(function(i,e){return $(e).text().trim()}).toArray()).toEqual(["29", "32", "31", "38", "27", "66", "7", "35", "82", "39", "81", "90", "75", "21", "44", "93", "52", "57", "28", "68"]);
      // When
      var res = clean_column_of("id");
      // Then
      expect($(extract_column_for("id")).map(function(i,e){return $(e).text().trim()}).toArray()).toEqual(["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]);
    });  
  });
  
  describe('clara.aids.find_row_whose_id_is', function() {
    it('Shoud define a clara.aids.find_row_whose_id_is function', function() {
      expect(_.isFunction(find_row_whose_id_is)).toEqual(true);
    });  
    it('Should return a jQuery object', function() {
      var res = find_row_whose_id_is(7);
      expect(res instanceof jQuery).toEqual(true);
    });  
    it('Should return a jQuery object row', function() {
      var res = find_row_whose_id_is(7);
      expect(res.prop("tagName")).toEqual("TR");
    });  
    it('Row with given ID (7) is "Autre frais dérogatoire"', function() {
      var res = find_row_whose_id_is(7);
      expect(res.attr("data-url")).toEqual("/admin/aids/autres-frais-derogatoires");
    });  
  });
  
  describe('clara.aids.find_cell_for', function() {
    it('Shoud define a clara.aids.find_cell_for function', function() {
      expect(_.isFunction(find_cell_for)).toEqual(true);
    });  
    it('Should return a jQuery object', function() {
      var $row = find_row_whose_id_is(7);
      var res = find_cell_for($row, "need_filters");
      expect(res instanceof jQuery).toEqual(true);
    });  
    it('Should return a jQuery object cell', function() {
      var $row = find_row_whose_id_is(7);
      var res = find_cell_for($row, "need_filters");
      expect(res.prop("tagName")).toEqual("TD");
    });  
    it('Row with given ID (7) and filter "need_filters" has position(x,y) 5, 7 in the table', function() {
      var $row = find_row_whose_id_is(7);
      var res = find_cell_for($row, "need_filters");
      // See https://stackoverflow.com/a/1775509/2595513
      expect(res[0].cellIndex).toEqual(5);
      expect(res[0].parentNode.rowIndex).toEqual(7);
    });  
    it('Row with given ID (7) and filter "filters" has position(x,y) 7, 7 in the table', function() {
      var $row = find_row_whose_id_is(7);
      var res = find_cell_for($row, "filters");
      // See https://stackoverflow.com/a/1775509/2595513
      expect(res[0].cellIndex).toEqual(7);
      expect(res[0].parentNode.rowIndex).toEqual(7);
    });  
  });
  
  describe('clara.aids.treat_successfully_retrieved_filters', function() {
    it('Shoud define a clara.aids.treat_successfully_retrieved_filters function', function() {
      expect(_.isFunction(treat_successfully_retrieved_filters)).toEqual(true);
    });  
    it('Should be able to put ftags inside the right cell', function() {
      // Given
      var $row = find_row_whose_id_is(7);
      var initial_cell_content = find_cell_for($row, "filters").html();
      expect(initial_cell_content).toEqual(' <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> 2 filter </a> ');
      // When
      var aids_from_api = [{"id":7,"filters":[{"id":4,"slug":"accompagne-recherche-emploi"},{"id":2,"slug":"se-deplacer"}],"custom_filters":[],"need_filters":[]}]
      treat_successfully_retrieved_filters(aids_from_api)
      // Then
      var $row = find_row_whose_id_is(7);
      var final_cell_content = find_cell_for($row, "filters").html();
      expect(final_cell_content).toEqual('<div class="ftag">accompagne-recherche-emploi</div><div class="ftag">se-deplacer</div>');

    });  
  });
  
  describe('clara.aids.extract_all_ids', function() {
    it('Shoud define a clara.aids.extract_all_ids function', function() {
      expect(_.isFunction(extract_all_ids)).toEqual(true);
    });  
    it('Should return an array', function() {
      expect(_.isArray(extract_all_ids())).toEqual(true);
    });  
    it('Should return the correct array of integer', function() {
      expect(extract_all_ids()).toEqual([ 29, 32, 31, 38, 27, 66, 7, 35, 82, 39, 81, 90, 75, 21, 44, 93, 52, 57, 28, 68 ]);
    });  
  });
  

});
