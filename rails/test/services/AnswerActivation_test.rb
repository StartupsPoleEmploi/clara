require "test_helper"

class AnswerActivationTest < ActiveSupport::TestCase

  test '.get_value, By default, returns false' do
    #given
    #when
    res = AnswerActivation.new.get_value
    #then
    assert_equal res, false
  end

  test '.get_value, when switching, returns true' do
    # given
    AnswerActivation.new.get_value
    AnswerActivation.new.switch_value
    #when
    res = AnswerActivation.new.get_value
    #then
    assert_equal res, true
  end
  test '.get_value, when switching twice, returns false' do
    #given
    AnswerActivation.new.get_value
    AnswerActivation.new.switch_value
    AnswerActivation.new.switch_value
    #when
    res = AnswerActivation.new.get_value
    #then
    assert_equal res, false
  end

end
