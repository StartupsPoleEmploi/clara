require "test_helper"

class RuleTreeServiceCalcIntegerLoetTest < ActiveSupport::TestCase
  

  test ".calculate integer, 34, less_or_equal_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "less_or_equal_than", "18", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 99, less_or_equal_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "less_or_equal_than", "18", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 18, less_or_equal_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "less_or_equal_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 3, less_or_equal_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "3", "less_or_equal_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, -32, less_or_equal_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32", "less_or_equal_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

end
