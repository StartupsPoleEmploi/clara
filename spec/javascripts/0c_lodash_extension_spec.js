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
  });
  describe("_.isNotBlank", function () {
    it("Should be defined", function () {
      expect(_.isNotBlank).toBeDefined();
    });
  });
  describe("_.findNested", function () {
    it("Should be defined", function () {
      expect(_.findNested).toBeDefined();
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
  });


});
