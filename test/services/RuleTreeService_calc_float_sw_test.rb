require "test_helper"

class RuleTreeServiceCalcFloatSwTest < ActiveSupport::TestCase

  
  test ".calculate float, 34.22, starts_with, 3.99 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34.22", "starts_with", "3.99", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 123.33, starts_with, 12.98 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123.33", "starts_with", "12.98", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 123.33, starts_with, 123.33 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123.33", "starts_with", "123.33", "float", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate float, 18.08, starts_with, 2.11 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18.08", "starts_with", "2.11", "float", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate float, 99.19, starts_with, 92 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99.19", "starts_with", "92", "float", ""
    #then
    assert_equal(false, res)
  end

end
