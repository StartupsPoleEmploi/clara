require "test_helper"

class RuleTreeServiceCalcFloatLtTest < ActiveSupport::TestCase
  
  test ".calculate float, 34.11, less_than, 18.65 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34.11", "less_than", "18.65", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 99.05, less_than, 18.65 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.05", "less_than", "18.65", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 18.65, less_than, 18.65 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.65", "less_than", "18.65", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 3.1, less_than, 18.65 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "3.1", "less_than", "18.65", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, -32.23, less_than, 18.65 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32.23", "less_than", "18.65", "float", ""
    #then
    assert_equal(true, res)
  end

end
