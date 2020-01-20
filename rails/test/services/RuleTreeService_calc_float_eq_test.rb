require "test_helper"

class RuleTreeServiceCalcFloatEqTest < ActiveSupport::TestCase


  test ".calculate float, 34.07, equal, 18.25 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34.07", "equal", "18.25", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 99.28, equal, 18.02 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.28", "equal", "18.02", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 18.1, equal, 18.10 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.1", "equal", "18.10", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 99.550, equal, 99.55 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.550", "equal", "99.55", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 99.04, unexisting, 99.04 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.04", "unexisting", "99.04", "float", ""
    #then
    assert_equal(false, res)
  end

end
