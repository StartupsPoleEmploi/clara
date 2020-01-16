require "test_helper"

class RuleTreeServiceCalcFloatNeqTest < ActiveSupport::TestCase

  
  test ".calculate float, 34.02, not_equal, 18.9 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34.02", "not_equal", "18.9", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 99.43, not_equal, 18.9 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.43", "not_equal", "18.9", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 18.9, not_equal, 18.9 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.9", "not_equal", "18.9", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 99.43, not_equal, 99.43 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.43", "not_equal", "99.43", "float", ""
    #then
    assert_equal(false, res)
  end

end
