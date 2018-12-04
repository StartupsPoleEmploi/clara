describe("jQuery extension", function() {

  beforeEach(function(){
    $(document.body).addClass("aaa")
    $(document.body).addClass("bbb")
    $(document.body).addClass("ccc")
  });
  afterEach(function(){
    $(document.body).removeClass("aaa")
    $(document.body).removeClass("bbb")
    $(document.body).removeClass("ccc")
  });
  describe('$.hasClasses', function() {
    it("Should return true if given element has all classes", function() {
      expect($('body').hasClasses("aaa", "bbb", "ccc")).toEqual(true)
    });
    it("Should return true if given element has all classes (random order)", function() {
      expect($('body').hasClasses("ccc", "bbb", "aaa")).toEqual(true)
    });
    it("Should return true if given element has some (but not all) classes", function() {
      expect($('body').hasClasses("bbb", "aaa")).toEqual(true)
    });
    it("Should return true if given element has the only given class", function() {
      expect($('body').hasClasses("bbb")).toEqual(true)
    });
    it("Should return false if none of the given classes are present", function() {
      expect($('body').hasClasses("xxx", "yyy", "zzz")).toEqual(false)
    });
    it("Should return false if the given class is not present", function() {
      expect($('body').hasClasses("yyy")).toEqual(false)
    });
    it("Should return false if one of the given class is not present", function() {
      expect($('body').hasClasses("ccc", "bbb", "zzz", "aaa")).toEqual(false)
    });
    it("Should return false if wrong param (a Date) is given", function() {
      expect($('body').hasClasses(new Date(123456789))).toEqual(false)
    });
    it("Should return false if undefined is given", function() {
      expect($('body').hasClasses(undefined)).toEqual(false)
    });
    it("Should return false if empty String is given", function() {
      expect($('body').hasClasses(" ")).toEqual(false)
    });
  });


});
