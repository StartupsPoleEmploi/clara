describe("jQuery extension", function () {

  describe("$.betterFloat returns a better float", function () {
    it("Should return '12,53' for '12a,,53'", function () {
      //when
      var res = $.betterFloat("12a,,53")
      //then
      expect(res).toEqual('12,53')
    });
  });

  describe("$.urlParam for URL http://clara.com", function () {
    beforeEach(function() {
      //given
      spyOn($, "currentUrl").and.callFake(function(){return "http://clara.com"});
    });
    it("Should return null when url contains no parameter", function () {
      //when
      var res = $.urlParam("")
      //then
      expect(res).toEqual(null)
    });
  });

  describe("$.urlParam for URL http://clara.com?empty_param", function () {
    beforeEach(function() {
      //given
      spyOn($, "currentUrl").and.callFake(function(){return "http://clara.com"});
    });
    it("Should return null when url contains an empty parameter (no value)", function () {
      //when
      var res = $.urlParam("empty_param")
      //then
      expect(res).toEqual(null)
    });
  });

  describe("$.urlParam for URL http://clara.com?void_param=&other=42", function () {
    beforeEach(function() {
      //given
      spyOn($, "currentUrl").and.callFake(function(){return "http://clara.com?void_param=&other=42"});
    });
    it("Should return \"\" when url contains a void parameter (value is present but blank)", function () {
      //when
      var res = $.urlParam("void_param")
      //then
      expect(res).toEqual("")
    });
  });

  describe("$.urlParam for URL http://clara.com?filled_param=filled_value", function () {
    beforeEach(function() {
      //given
      spyOn($, "currentUrl").and.callFake(function(){return "http://clara.com?filled_param=filled_value"});
    });
    it("Should return parameter value when url parameter has a value (example 1)", function () {
      //when
      var res = $.urlParam("filled_param")
      //then
      expect(res).toEqual("filled_value")
    });
  });

  describe("$.urlParam for URL http://clara.com?named_parameter=param_value", function () {
    beforeEach(function() {
      //given
      spyOn($, "currentUrl").and.callFake(function(){return "http://clara.com?named_parameter=param_value"});
    });
    it("Should return parameter value when url parameter has a value (example 2)", function () {
      //when
      var res = $.urlParam("named_parameter")
      //then
      expect(res).toEqual("param_value")
    });
  });

  describe('$.hasClasses', function () {
    beforeEach(function () {
      $(document.body).append('\
        <div id="tested_div" class="aaa bbb ccc">\
      ')
    });
    afterEach(function () {
      $('#tested_div').remove()
    });
    it("Should return true if given element has all classes", function () {
      expect($('#tested_div').hasClasses("aaa", "bbb", "ccc")).toEqual(true)
    });
    it("Should return true if given element has all classes (random order)", function () {
      expect($('#tested_div').hasClasses("ccc", "bbb", "aaa")).toEqual(true)
    });
    it("Should return true if given element has some (but not all) classes", function () {
      expect($('#tested_div').hasClasses("bbb", "aaa")).toEqual(true)
    });
    it("Should return true if given element has the only given class", function () {
      expect($('#tested_div').hasClasses("bbb")).toEqual(true)
    });
    it("Should return false if none of the given classes are present", function () {
      expect($('#tested_div').hasClasses("xxx", "yyy", "zzz")).toEqual(false)
    });
    it("Should return false if the given class is not present", function () {
      expect($('#tested_div').hasClasses("yyy")).toEqual(false)
    });
    it("Should return false if one of the given class is not present", function () {
      expect($('#tested_div').hasClasses("ccc", "bbb", "zzz", "aaa")).toEqual(false)
    });
    it("Should return false if wrong param (a Date) is given", function () {
      expect($('#tested_div').hasClasses(new Date(123456789))).toEqual(false)
    });
    it("Should return false if undefined is given", function () {
      expect($('#tested_div').hasClasses(undefined)).toEqual(false)
    });
    it("Should return false if empty String is given", function () {
      expect($('#tested_div').hasClasses(" ")).toEqual(false)
    });
  });

});
