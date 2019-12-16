require "test_helper"

class RuleTreeServiceCalcFloatNamTest < ActiveSupport::TestCase
  

  test ".calculate float, 11.34, not_amongst, 11.34,22.55,33.03 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "11.34", "not_amongst", "11.34,22.55,33.03", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 42.26, not_amongst, 1.01,99.22,42.26,657.2 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "42.26", "not_amongst", "1.01,99.22,42.26,657.2", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 18.01, not_amongst, 1.77,99.22,42.00,657.2 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "not_amongst", "1.77,99.22,42.00,657.2", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 0.00, not_amongst, 1.00,2.00,3.00 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "0.00", "not_amongst", "1.00,2.00,3.00", "float", ""
    #then
    assert_equal(true, res)
  end

end
