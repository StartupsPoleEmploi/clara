require "test_helper"

class RuleTreeServiceCalcStringAmTest < ActiveSupport::TestCase
  

  test ".calculate string, 11, amongst, 11,22,33 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "11", "amongst", "11,22,33", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 42, amongst, 1,99,42,657 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "42", "amongst", "1,99,42,657", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 18, amongst, 1,99,42,657 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "amongst", "1,99,42,657", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 0, amongst, 1,2,3 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "0", "amongst", "1,2,3", "string", ""
    #then
    assert_equal(false, res)
  end

end
