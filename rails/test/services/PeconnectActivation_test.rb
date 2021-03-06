require "test_helper"

class PeconnectActivationTest < ActiveSupport::TestCase

  test '.get_value, By default, returns false' do
    #given
    #when
    res = PeconnectActivation.new.get_value
    #then
    assert_equal res, false
  end

  test '.get_value, when switching, returns true' do
    # given
    PeconnectActivation.new.get_value
    PeconnectActivation.new.switch_value
    #when
    res = PeconnectActivation.new.get_value
    #then
    assert_equal res, true
  end
  test '.get_value, when switching twice, returns false' do
    #given
    PeconnectActivation.new.get_value
    PeconnectActivation.new.switch_value
    PeconnectActivation.new.switch_value
    #when
    res = PeconnectActivation.new.get_value
    #then
    assert_equal res, false
  end

end
