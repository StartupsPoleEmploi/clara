require "test_helper"

class RuleTreeServiceCalcStringLtTest < ActiveSupport::TestCase
  
  test ".calculate string, 34, less_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "less_than", "18", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 99, less_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "less_than", "18", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 18, less_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "less_than", "18", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 0, less_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "0", "less_than", "18", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, -32, less_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32", "less_than", "18", "string", ""
    #then
    assert_equal(true, res)
  end

end
