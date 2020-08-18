require "test_helper"

class PeconnectActivationTest < ActiveSupport::TestCase

  test ".get_value returns false by default" do
    #given
    #when
    res = PeconnectActivation.new.get_value
    #then
    assert_equal false, res
  end

  test ".switch_value switch value to the opposite" do
    #given
    #when
    PeconnectActivation.new.switch_value
    first_return = PeconnectActivation.new.get_value
    PeconnectActivation.new.switch_value
    second_return = PeconnectActivation.new.get_value
    #then
    assert_equal true, first_return
    assert_equal false, second_return
  end


end
