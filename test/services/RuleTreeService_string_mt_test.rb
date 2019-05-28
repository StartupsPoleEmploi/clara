require "test_helper"

class RuleTreeServiceStringMtTest < ActiveSupport::TestCase

  
  test ".calculate string, 34, more_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "more_than", "18", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 99, more_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "more_than", "18", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 18, more_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "more_than", "18", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 3, more_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "3", "more_than", "18", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, -32, more_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32", "more_than", "18", "string", ""
    #then
    assert_equal(false, res)
  end

end
