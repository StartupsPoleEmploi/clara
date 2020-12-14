require "test_helper"

class CreateFakeDataTest < ActiveSupport::TestCase

  test ".call, creates data" do
    #given
    assert_equal 0, Rule.all.count
    #when
    CreateFakeData.new.call
    #then
    assert_equal 3, Rule.all.count
  end

end

