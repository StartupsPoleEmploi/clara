require "test_helper"

class NewAidTwoTest < ActiveSupport::TestCase
  
  test '.display_convention? should return true by default' do
    #given
    # new_aid_two = NewAidStep.new(nil, {})
    new_aid_two = NewAidTwo.new(OpenStruct.new(session: {}), {})
    #when
    res = new_aid_two.display_convention?
    #then
    assert_equal(true, res)
  end
  test '.display_convention? should return false if display_convention in session is set' do
    #given
    # new_aid_two = NewAidStep.new(nil, {})
    new_aid_two = NewAidTwo.new(OpenStruct.new(session: {display_convention: "yes"}), {})
    #when
    res = new_aid_two.display_convention?
    #then
    assert_equal(false, res)
  end
end
