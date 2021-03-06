require "test_helper"

class RuleTreeServiceCalcNoRuleTypeTest < ActiveSupport::TestCase

  
  test ".calculate unexisting type, 34, starts_with, 3 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "starts_with", "3", "unexisting", ""
    #then
    assert_equal(false, res)
  end
  test ".calculate string, 34, starts_with, 3 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "starts_with", "3", "string", ""
    #then
    assert_equal(true, res)
  end
end
