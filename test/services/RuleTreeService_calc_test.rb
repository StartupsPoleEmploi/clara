require "test_helper"

class RuleTreeServiceCalcIntegerAmTest < ActiveSupport::TestCase
  

  test ".calculate nominal => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "33", "amongst", "11,22,33,44", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate unexisting type => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "33", "amongst", "11,22,33,44", "unexisting", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate unexisting op_kind => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "33", "unexisting", "11,22,33,44", "integer", ""
    #then
    assert_equal(false, res)
  end
end
