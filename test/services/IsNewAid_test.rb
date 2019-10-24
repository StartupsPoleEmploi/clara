require "test_helper"

class IsNewAidTest < ActiveSupport::TestCase
  
test "Newly created aid input in IsNewAid call returns true" do
  test = Aid.create(
    :name => "test",
    :what => "test")
    res = IsNewAid.new.call(test)
    assert_equal(true, res)
end

end
