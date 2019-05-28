require "test_helper"

class RuleTreeServiceCalcStringEqTest < ActiveSupport::TestCase

  
  test ".calculate string, 34, equal, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "equal", "18", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 99, equal, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "equal", "18", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 18, equal, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "equal", "18", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 99, equal, 99 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "equal", "99", "string", ""
    #then
    assert_equal(true, res)
  end

end
