describe("jQuery extension", function () {

  describe("$.paramUpdate", function () {



    it("Should add parameters to a naked  URL", function () {
      //given
      url = "i.am.a.naked/url"
      //when
      param = "test_param=42"
      $.paramUpdate(url, param)
      //then
      expect(url.toEqual("i.am.a.naked/url?test_param=42"))
    });

    it("Should change the existing parameter with integer value of the URL", function () {
      //given
      url = "i.have?parameter=1"
      //when
      $.paramUpdate(url, 10)
      //then
      expect(url.toEqual("i.have?parameter=10"))
    });
  }
  )

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

  describe('$.hasAttribute', function () {
    beforeEach(function () {
      $(document.body).append('\
        <div id="tested_div" \
             class="aaa" \
             attr-with-value="true" \
             attr-without-value="" \
             attr-without-assignment \
             data-thing="foo" \
       ></div>')
    });
    afterEach(function () {
      $('#tested_div').remove()
    });

    it("Should return true if given element has an id", function () {
      expect($('#tested_div').hasAttribute("id")).toEqual(true)
    });
    it("Should return true if given element has a class", function () {
      expect($('#tested_div').hasAttribute("class")).toEqual(true)
    });
    it("Should return true for a custom attribute (data-*)", function () {
      expect($("#tested_div").hasAttribute("data-thing")).toEqual(true)
    });
    it("Should return true if given element has the given attribute with a value", function () {
      expect($('#tested_div').hasAttribute("attr-with-value")).toEqual(true)
    });
    it("Should return true if given element has the given attribute without value", function () {
      expect($("#tested_div").hasAttribute("attr-without-value")).toEqual(true)
    });
    it("Should return true if given element has the given attribute without assignment", function () {
      expect($("#tested_div").hasAttribute("attr-without-assignment")).toEqual(true)
    });
    it("Should return false if given element has no attribute (example 1)", function () {
      expect($("#tested_div").hasAttribute("unexisting")).toEqual(false)
    });
    it("Should return false if given element has no attribute (example 2)", function () {
      expect($("#tested_div").hasAttribute("not-existing")).toEqual(false)
    });
    it("Should return false if given element has wrong type (regex)", function () {
      expect($("#tested_div").hasAttribute(/^/)).toEqual(false)
    });
    it("Should return false if given element has wrong type (array)", function () {
      expect($("#tested_div").hasAttribute([])).toEqual(false)
    });
    it("Should return false if no element given", function () {
      expect($("#tested_div").hasAttribute()).toEqual(false)
    });
    it("Should return false if null element given", function () {
      expect($("#tested_div").hasAttribute(null)).toEqual(false)
    });
    it("Should return false if DOM element do not exists", function () {
      expect($("#unexisting_element").hasAttribute("id")).toEqual(false)
    });
  });
});
