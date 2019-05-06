describe("Lodash extension", function() {

  describe("_.nextElementLooped", function() {
    it ("Should be defined", function() {
      expect(_.nextElementLooped).toBeDefined();
    });
    it ("Should give next element in array", function() {
      var input = ['a', 'b', 'c'];
      var target = 'b';
      var output = 'c';
      expect(_.nextElementLooped(input, target)).toEqual(output);
    });
    it ("Should give first element if last is given", function() {
      var input = ['a', 'b', 'c'];
      var target = 'c';
      var output = 'a';
      expect(_.nextElementLooped(input, target)).toEqual(output);
    });
    it ("Should return null if element is not in array", function() {
      var input = ['a', 'b', 'c'];
      var target = 4;
      var output = null;
      expect(_.nextElementLooped(input, target)).toEqual(output);
    });
    it ("Should return null if no array is given", function() {
      var input = new Date();
      var target = 'b';
      var output = null;
      expect(_.nextElementLooped(input, target)).toEqual(output);
    });
  });

  describe("_.none", function() {
    var ALL_FALSE = {e_0: false, e_1: false};
    var ALL_TRUE = {e_0: true, e_1: true};
    var ALL_MIX = {e_0: true, e_1: false};
    it ("Should be defined", function() {
      expect(_.none).toBeDefined();
    });
    it ("Should transform ALL_FALSE into true", function() {
      expect(_.none(ALL_FALSE)).toEqual(true);
    });
    it ("Should transform (mix of false and true) into (false)", function() {
      expect(_.none(ALL_MIX)).toEqual(false);
    });
    it ("Should transform ALL_TRUE into false", function() {
      expect(_.none(ALL_TRUE)).toEqual(false);
    });
  });

  describe("_.toPropArray", function() {
    it ("Should be defined", function() {
      expect(_.toPropArray).toBeDefined();
    });
    it ("Should transform an array to a table of properties", function() {
      var input = {a:1, b:2};
      var output = [{prop:'a', value:1}, {prop:'b', value:2}];
      expect(_.toPropArray(input)).toEqual(output);
    });
    it ("Combine to/fromPropArray should give the same array", function() {
      var reflective = [{prop:'a', value:1}, {prop:'b', value:2}];
      expect(_.toPropArray(_.fromPropArray(reflective))).toEqual(reflective);
    });
  });

  describe("_.fromPropArray", function() {
    it ("Should be defined", function() {
      expect(_.fromPropArray).toBeDefined();
    });
    it ("Should an array of props into an object", function() {
      var input = [{prop:'a', value:1}, {prop:'b', value:2}];
      var output = {a:1, b:2};
      expect(_.fromPropArray(input)).toEqual(output);
    });
    it ("Combine from/toPropArray should give the same object", function() {
      var reflective = {a:1, b:2};
      expect(_.fromPropArray(_.toPropArray(reflective))).toEqual(reflective);
    });
  });

  describe("_.injectToPropArray", function() {
    it ("Should be defined", function() {
      expect(_.injectToPropArray).toBeDefined();
    });
    it ("Should inject property of source into destination", function() {
      var source = [{prop:'a', value:1}, {prop:'b', value:2}];
      var destination = [{prop:'a', value:null}, {prop:'b', value:'beta'}];
      _.injectToPropArray(source,destination);
      expect(destination).toEqual([{prop:'a', value:1}, {prop:'b', value:2}]);
    });
    it ("Should convert non-existing source property into null-value destination property", function() {
      var source = [{prop:'a', value:1}, {prop:'b', value:2}];
      var destination = [{prop:'a', value:null}, {prop:'b', value:'beta'}, {prop:'c', value:'ce'}];
      _.injectToPropArray(source,destination);
      expect(destination).toEqual([{prop:'a', value:1}, {prop:'b', value:2}, {prop:'c', value:null}]);
    });
  });

  describe("_.isBlank", function() {
    it ("Should be defined", function() {
      expect(_.isBlank).toBeDefined();
    });
    it ("_.isBlank(undefined) is true", function() {
      expect(_.isBlank(undefined)).toEqual(true);
    });
    it ("_.isBlank(null) is true", function() {
      expect(_.isBlank(null)).toEqual(true);
    });
    it ("_.isBlank() is true", function() {
      expect(_.isBlank()).toEqual(true);
    });
    it ("_.isBlank(NaN) is true", function() {
      expect(_.isBlank(NaN)).toEqual(true);
    });
    it ("_.isBlank('') is true", function() {
      expect(_.isBlank('')).toEqual(true);
    });
    it ("_.isBlank('  ') is true", function() {
      expect(_.isBlank('  ')).toEqual(true);
    });
    it ("_.isBlank('a') is false", function() {
      expect(_.isBlank('a')).toEqual(false);
    });
    it ("_.isBlank(' a ') is false", function() {
      expect(_.isBlank(' a ')).toEqual(false);
    });
    it ("_.isBlank(-1) is false", function() {
      expect(_.isBlank(-1)).toEqual(false);
    });
    it ("_.isBlank(0) is true", function() {
      expect(_.isBlank(0)).toEqual(true);
    });
    it ("_.isBlank(4.2) is false", function() {
      expect(_.isBlank(4.2)).toEqual(false);
    });
    it ("_.isBlank({}) is true", function() {
      expect(_.isBlank({})).toEqual(true);
    });
    it ("_.isBlank([]) is true", function() {
      expect(_.isBlank([])).toEqual(true);
    });
    it ("_.isBlank({a:2}) is false", function() {
      expect(_.isBlank({a:2})).toEqual(false);
    });
    it ("_.isBlank([43,88]) is false", function() {
      expect(_.isBlank([43,88])).toEqual(false);
    });
    it ("_.isBlank(/^/) is false", function() {
      expect(_.isBlank(/^/)).toEqual(false);
    });
    it ("_.isBlank(new Date()) is false", function() {
      expect(_.isBlank(new Date())).toEqual(false);
    });
  });

});
