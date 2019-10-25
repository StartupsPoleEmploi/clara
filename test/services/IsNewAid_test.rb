require "test_helper"

class IsNewAidTest < ActiveSupport::TestCase
  
test "Newly created aid input in IsNewAid call returns true" do
  #given
  new_aid = Aid.new(
    :name => "test",
    :what => "test")
  #when
  res = IsNewAid.new.call(new_aid)
  #then
  assert_equal(true, res)
end

test "Updated aid input in IsNewAid call returns false" do
  #given
  modified_aid = Aid.new(
    :name => "test",
    :what => "test")
  modified_aid.updated_at = Date.new
  #when
  res = IsNewAid.new.call(modified_aid)
  #then
  assert_equal(false, res)
end

test "Wrong input in IsNewAid call raises error" do
  #given
  not_an_aid = "Je ne suis pas une aide"
  #then
  assert_raises ArgumentError do
    #when
    IsNewAid.new.call(not_an_aid)
  end
end

end
