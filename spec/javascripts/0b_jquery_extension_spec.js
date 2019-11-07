describe("jQuery extension", function () {

  describe("$.paramUpdate", function () {



    it("Should add parameters to a naked  URL", function () {
      //given
      var url = "i.am.a.naked/url"
      //when
      var param = { key: "test_param", value: 42 }
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("i.am.a.naked/url&test_param=42")
    });

    it("Should change the existing parameter with integer value of the URL", function () {
      //given
      var url = "i.have&int_param=1"
      //when
      var param = { key: "int_param", value: 10 }
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("i.have&int_param=10")
    });

    it("Should change the existing parameter value with 'undefined' if no value is set", function () {
      //given
      var url = "i.have&int_param=1"
      //when
      var param = { key: "int_param" }
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("i.have&int_param=undefined")
    });

    it("Should add a new parameter in url if no corresponding param exist in original url", function () {
      //given
      var url = "i.have&another_param=another_value"
      //when
      var param = { key: "non_existant_param", value: "test_value" }
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("i.have&another_param=another_value&non_existant_param=test_value")
    });

    it("Should set value to '[object Object]' if given parameter value is an object ", function () {
      //given
      var url = "i.have&test_param=test_value"
      //when
      var test_object = { key: "nested_key", value: "nested_value" }
      var param = { key: "non_existant_param", value: test_object }
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("i.have&test_param=test_value&non_existant_param=[object Object]")
    });

    it("Should set value to '[object Object]' if given parameter value is an object ", function () {
      //given
      var url = "i.have&test_param=test_value"
      //when
      var test_object = { key: "nested_key", value: "nested_value" }
      var param = { key: "non_existant_param", value: test_object }
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("i.have&test_param=test_value&non_existant_param=[object Object]")
    });

    it("Should change parameter value even if url contains only parameter", function () {
      //given
      var url = "&alone_param=alone_value"
      //when
      var param = { key: "alone_param", value: "new_value" }
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("&alone_param=new_value")
    });

    it("Should add parameter even if url is blank", function () {
      //given
      var url = ""
      //when
      var param = { key: "new_param", value: "param_value" }
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("&new_param=param_value")
    });

    it("Should add parameter as even if url is blank and parameter is a blank string", function () {
      //given
      var url = ""
      //when
      var param = ""
      url = $.paramUpdate(url, param);
      //then
      expect(url).toEqual("&undefined=undefined")
    });

  }
  )

  describe("$.urlParam", function () {
    it("Should return null when url contains no parameter", function () {
      //given
      window.location.href = "http://clara.com";
      //when
      var name = ""
      res = $.urlParam(name)
      //then
      expect(res).toEqual(null)
    });
    it("Should return blank string when url parameter has no value", function () {
      //given
      window.location.href = "http://clara.com&empty_param";
      //when
      var name = ""
      res = $.urlParam(name)
      //then
      expect(res).toEqual("")
    });
    it("Should return parameter value when url parameter has a value", function () {
      //given
      window.location.href = "http://clara.com&empty_param=filled_value";
      //when
      var name = ""
      res = $.urlParam(name)
      //then
      expect(res).toEqual("filled_value")
    });
  }
}

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
