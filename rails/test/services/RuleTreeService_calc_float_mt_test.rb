require "test_helper"

class RuleTreeServiceCalcFloatMtTest < ActiveSupport::TestCase

  
  test ".calculate float, 34.26, more_than, 18.05 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34.26", "more_than", "18.05", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 99.8, more_than, 18.05 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.8", "more_than", "18.05", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 18.05, more_than, 18.05 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.05", "more_than", "18.05", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 3.00, more_than, 18.05 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "3.00", "more_than", "18.05", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, -32.01, more_than, 18.05 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32.01", "more_than", "18.05", "float", ""
    #then
    assert_equal(false, res)
  end

end
