require "test_helper"

class DetailItemViewObjectTest < ActiveSupport::TestCase
  

  test "empty_content? is true if content is empty" do
    #given
    sut = DetailItemViewObject.new(nil, {html_content: "<p>&nbsp;</p>"})
    #when
    res = sut.empty_content?
    #then
    assert_equal(true, res)
  end
  test "empty_content? is true if content is buggy" do
    #given
    sut = DetailItemViewObject.new(nil, {html_content: actual_buggy_content})
    #when
    res = sut.empty_content?
    #then
    assert_equal(true, res)
  end
  test "empty_content? is false if content is not empty" do
    #given
    sut = DetailItemViewObject.new(nil, {html_content: "<div>hello</div>"})
    #when
    res = sut.empty_content?
    #then
    assert_equal(false, res)
  end
  test "empty_content? is false if content is not empty (realistic content)" do
    #given
    sut = DetailItemViewObject.new(nil, {html_content: realistic_content})
    #when
    res = sut.empty_content?
    #then
    assert_equal(false, res)
  end

  test "actual_content just return an html safe version of content" do
    #given
    sut = DetailItemViewObject.new(nil, {html_content: realistic_content})
    #when
    res = sut.actual_content
    #then
    assert_equal(realistic_content, res)
  end

  test "actual_content returns a String if a String is given" do
    #given
    sut = DetailItemViewObject.new(nil, {html_content: "abc"})
    #when
    res = sut.actual_content
    #then
    assert_equal("abc", res)
  end

  test "actual_content doesnt fail on nil" do
    #given
    sut = DetailItemViewObject.new(nil, {html_content: nil})
    #when
    res = sut.actual_content
    #then
    assert_equal("", res)
  end


  def realistic_content
    "<p>Plusieurs dispositifs :&nbsp;</p>\r\n"
  end

  def actual_buggy_content
    "<p>&nbsp;</p>\r\n" +
    "\r\n" +
    "<p>&nbsp;</p>\r\n" +
    "\r\n" +
    "<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n"
  end
end
