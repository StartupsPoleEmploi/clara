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
    sut = DetailItemViewObject.new(nil, {html_content: "<p>Plusieurs dispositifs permettent de financer une formation :&nbsp;</p>\r\n"})
    #when
    res = sut.empty_content?
    #then
    assert_equal(false, res)
  end


  def actual_buggy_content
    "<p>&nbsp;</p>\r\n" +
    "\r\n" +
    "<p>&nbsp;</p>\r\n" +
    "\r\n" +
    "<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n"
  end
end
