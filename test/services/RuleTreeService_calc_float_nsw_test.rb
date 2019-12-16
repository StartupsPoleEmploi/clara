require "test_helper"

class RuleTreeServiceCalcFloatNswTest < ActiveSupport::TestCase

  
  test ".calculate float, 34.02, not_starts_with, 3 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34.02", "not_starts_with", "3", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 123.29, not_starts_with, 123.2 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123.29", "not_starts_with", "123.2", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 123.29, not_starts_with, 123.29 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123.29", "not_starts_with", "123.29", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 18.11, not_starts_with, 2.74 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.11", "not_starts_with", "2.74", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 99.21, not_starts_with, 92.44 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.21", "not_starts_with", "92.44", "float", ""
    #then
    assert_equal(true, res)
  end

end
