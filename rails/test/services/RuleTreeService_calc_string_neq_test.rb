require "test_helper"

class RuleTreeServiceCalcStringNeqTest < ActiveSupport::TestCase

  
  test ".calculate string, 34, not_equal, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "not_equal", "18", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 99, not_equal, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "not_equal", "18", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 18, not_equal, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "not_equal", "18", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 99, not_equal, 99 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "not_equal", "99", "string", ""
    #then
    assert_equal(false, res)
  end

end
