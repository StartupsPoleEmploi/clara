require "test_helper"

class RuleTreeServiceCalcFloatAmTest < ActiveSupport::TestCase
  

  test ".calculate float, 11.01, amongst, 11.01,22.31,33.82 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "11.01", "amongst", "11.01,22.31,33.82", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 42.23, amongst, 1.45,99.4,42.23,657.9 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "42.23", "amongst", "1.45,99.4,42.23,657.9", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 18.00, amongst, 1.01,99,42.00,657.43 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.00", "amongst", "1.01,99,42.00,657.43", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 0.02, amongst, 1.02,2.44,3.00 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "0.02", "amongst", "1.02,2.44,3.00", "float", ""
    #then
    assert_equal(false, res)
  end

end
