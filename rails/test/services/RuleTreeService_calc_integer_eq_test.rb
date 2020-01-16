require "test_helper"

class RuleTreeServiceCalcIntegerEqTest < ActiveSupport::TestCase


  test ".calculate integer, 34, equal, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "equal", "18", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 99, equal, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "equal", "18", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 18, equal, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "equal", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 99, equal, 99 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "equal", "99", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 99, unexisting, 99 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "unexisting", "99", "integer", ""
    #then
    assert_equal(false, res)
  end

end
