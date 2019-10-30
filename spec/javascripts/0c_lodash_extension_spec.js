describe("Lodash extension", function () {

  describe("_.none", function () {
    var ALL_FALSE = { e_0: false, e_1: false };
    var ALL_TRUE = { e_0: true, e_1: true };
    var ALL_MIX = { e_0: true, e_1: false };

    it("Should be defined", function () {
      expect(_.none).toBeDefined();
    });
    it("Should transform ALL_FALSE into true", function () {
      expect(_.none(ALL_FALSE)).toEqual(true);
    });
    it("Should transform (mix of false and true) into (false)", function () {
      expect(_.none(ALL_MIX)).toEqual(false);
    });
    it("Should transform ALL_TRUE into false", function () {
      expect(_.none(ALL_TRUE)).toEqual(false);
    });
  });

  describe("_.isBlank", function () {
    it("Should be defined", function () {
      expect(_.isBlank).toBeDefined();
    });
    it("_.isBlank(undefined) is true", function () {
      expect(_.isBlank(undefined)).toEqual(true);
    });
    it("_.isBlank(null) is true", function () {
      expect(_.isBlank(null)).toEqual(true);
    });
    it("_.isBlank() is true", function () {
      expect(_.isBlank()).toEqual(true);
    });
    it("_.isBlank(NaN) is true", function () {
      expect(_.isBlank(NaN)).toEqual(true);
    });
    it("_.isBlank('') is true", function () {
      expect(_.isBlank('')).toEqual(true);
    });
    it("_.isBlank('  ') is true", function () {
      expect(_.isBlank('  ')).toEqual(true);
    });
    it("_.isBlank('a') is false", function () {
      expect(_.isBlank('a')).toEqual(false);
    });
    it("_.isBlank(' a ') is false", function () {
      expect(_.isBlank(' a ')).toEqual(false);
    });
    it("_.isBlank(-1) is false", function () {
      expect(_.isBlank(-1)).toEqual(false);
    });
    it("_.isBlank(0) is true", function () {
      expect(_.isBlank(0)).toEqual(true);
    });
    it("_.isBlank(4.2) is false", function () {
      expect(_.isBlank(4.2)).toEqual(false);
    });
    it("_.isBlank({}) is true", function () {
      expect(_.isBlank({})).toEqual(true);
    });
    it("_.isBlank([]) is true", function () {
      expect(_.isBlank([])).toEqual(true);
    });
    it("_.isBlank({a:2}) is false", function () {
      expect(_.isBlank({ a: 2 })).toEqual(false);
    });
    it("_.isBlank([43,88]) is false", function () {
      expect(_.isBlank([43, 88])).toEqual(false);
    });
    it("_.isBlank(/^/) is false", function () {
      expect(_.isBlank(/^/)).toEqual(false);
    });
    it("_.isBlank(new Date()) is false", function () {
      expect(_.isBlank(new Date())).toEqual(false);
    });
  });

  describe("_.count", function () {
    it("Should be defined", function () {
      expect(_.count).toBeDefined();
    });
    it("Should return 0 if wrong params given", function () {
      expect(_.count(new Date())).toEqual(0);
      expect(_.count([42, 12, 0, 5])).toEqual(0);
    });
    it("Should return number of truthy predicated in a collection", function () {
      expect(_.count([1,2,3,4,5,6], function(e) {return e % 2 === 0})).toEqual(3);
    });
    it("Should return number of truthy predicated in a collection (exemple 2)", function () {
      expect(_.count(["a", "ab", "k"], function(e) {return e.indexOf("a") >= 0 })).toEqual(2);
    });

  });

  describe("_.isNotBlank", function () {
    it("Should be defined", function () {
      expect(_.isNotBlank).toBeDefined();
    });
    it("_.isNotBlank(undefined) is false", function () {
      expect(_.isNotBlank(undefined)).toEqual(false);
    });
    it("_.isNotBlank(null) is false", function () {
      expect(_.isNotBlank(null)).toEqual(false);
    });
    it("_.isNotBlank() is false", function () {
      expect(_.isNotBlank()).toEqual(false);
    });
    it("_.isNotBlank(NaN) is false", function () {
      expect(_.isNotBlank(NaN)).toEqual(false);
    });
    it("_.isNotBlank('') is false", function () {
      expect(_.isNotBlank('')).toEqual(false);
    });
    it("_.isNotBlank('  ') is false", function () {
      expect(_.isNotBlank('  ')).toEqual(false);
    });
    it("_.isNotBlank('a') is true", function () {
      expect(_.isNotBlank('a')).toEqual(true);
    });
    it("_.isNotBlank(' a ') is true", function () {
      expect(_.isNotBlank(' a ')).toEqual(true);
    });
    it("_.isNotBlank(-1) is true", function () {
      expect(_.isNotBlank(-1)).toEqual(true);
    });
    it("_.isNotBlank(0) is false", function () {
      expect(_.isNotBlank(0)).toEqual(false);
    });
    it("_.isNotBlank(4.2) is true", function () {
      expect(_.isNotBlank(4.2)).toEqual(true);
    });
    it("_.isNotBlank({}) is false", function () {
      expect(_.isNotBlank({})).toEqual(false);
    });
    it("_.isNotBlank([]) is false", function () {
      expect(_.isNotBlank([])).toEqual(false);
    });
    it("_.isNotBlank({a:2}) is true", function () {
      expect(_.isNotBlank({ a: 2 })).toEqual(true);
    });
    it("_.isNotBlank([43,88]) is true", function () {
      expect(_.isNotBlank([43, 88])).toEqual(true);
    });
    it("_.isNotBlank(/^/) is true", function () {
      expect(_.isNotBlank(/^/)).toEqual(true);
    });
    it("_.isNotBlank(new Date()) is true", function () {
      expect(_.isNotBlank(new Date())).toEqual(true);
    });
  });



  describe("_.findNested", function () {
    it("Should be defined", function () {
      expect(_.findNested).toBeDefined();
    });
    it("Should return nested properties, if there is multiple found, return them in array", function () {
      expect(
        _.findNested(
          { 'aa': 1, 
            'bb': 2, 
            'cc': {'d':{'x':9}}, 
            dd:{'d':{'y':9}}},
        'd')).toEqual([{x: 9}, {y: 9}]);
    });
    it("Should return nested properties, if one found, return one element in array", function () {
      expect(_.findNested({a: {b:2}}, 'b')).toEqual([2]);
    });
    it("Should return an empty array if problem", function () {
      expect(_.findNested()).toEqual([]);
    });
  });
  describe("_.deepSearch", function () {
    it("Should be defined", function () {
      expect(_.deepSearch).toBeDefined();
    });
  });
  describe("_.insertAt", function () {
    it("Should be defined", function () {
      expect(_.insertAt).toBeDefined();
    });
        it("Should insert a value in an array at the right index", function () {
      expect(_.insertAt([1,2,4],2,3)).toEqual(undefined);
    });
  });


});
