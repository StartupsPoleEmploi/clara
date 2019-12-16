require "test_helper"

class RuleTreeServiceCalcFloatMoetTest < ActiveSupport::TestCase




  test ".calculate float, 34.89, more_or_equal_than, 18.76 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34.89", "more_or_equal_than", "18.76", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 99.3, more_or_equal_than, 18.76 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.3", "more_or_equal_than", "18.76", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 18.76, more_or_equal_than, 18.76 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.76", "more_or_equal_than", "18.76", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 3.15, more_or_equal_than, 18.76 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "3.15", "more_or_equal_than", "18.76", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, -32.55, more_or_equal_than, 18.76 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32.55", "more_or_equal_than", "18.76", "float", ""
    #then
    assert_equal(false, res)
  end

end
