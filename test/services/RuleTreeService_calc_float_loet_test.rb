require "test_helper"

class RuleTreeServiceCalcFloatLoetTest < ActiveSupport::TestCase
  

  test ".calculate float, 34.12, less_or_equal_than, 18.25 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34.12", "less_or_equal_than", "18.25", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 99, less_or_equal_than, 18.25 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "less_or_equal_than", "18.25", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 18.25, less_or_equal_than, 18.25 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.25", "less_or_equal_than", "18.25", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 3.1, less_or_equal_than, 18.25 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "3.1", "less_or_equal_than", "18.25", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, -32.11, less_or_equal_than, 18.25 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32.11", "less_or_equal_than", "18.25", "float", ""
    #then
    assert_equal(true, res)
  end

end
