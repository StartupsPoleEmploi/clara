require "test_helper"

# See https://gist.github.com/ascendbruce/7070951
class IsValidJsonTest < ActiveSupport::TestCase

  test ".call : true - valid JSON object" do
    assert_equal true, IsValidJson.new.call(%({"a": "b", "c": 1, "d": true}))
    assert_equal true, IsValidJson.new.call("{}")
    assert_equal true, IsValidJson.new.call("[1, 2, 3]")
  end

  test ".call : false - may be a valid JSON string, but not a valid JSON object" do
    assert_equal false, IsValidJson.new.call("")
    assert_equal false, IsValidJson.new.call("123")
  end

  test ".call : false - not a valid JSON string" do
    assert_equal false, IsValidJson.new.call(nil)
    assert_equal false, IsValidJson.new.call(true)
    assert_equal false, IsValidJson.new.call(123)
  end

end
