require "test_helper"

class IsNewAidTest < ActiveSupport::TestCase
  
test "Newly created aid input in IsNewAid call returns true" do
  new_aid = Aid.create(
    :name => "test",
    :what => "test")
    res = IsNewAid.new.call(new_aid)
    assert_equal(true, res)
end

test "Updated aid input in IsNewAid call returns false" do
  new_aid2 = Aid.create(
    :name => "test",
    :what => "test")
    new_aid2.what = "description updated"
    new_aid2.save
    res = IsNewAid.new.call(new_aid2)
    res = new_aid2.created_at
    assert_equal(false, res)
end

test "Wrong input in IsNewAid call raises error" do
not_an_aid = "Je ne suis pas une aide"
    expect { IsNewAid.new.call(not_an_aid) }.to raise_error(ArgumentError, "Only aid is allowed")
end

end
