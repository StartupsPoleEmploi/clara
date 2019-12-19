require "test_helper"

class RuleTreeServiceCalcStringSwTest < ActiveSupport::TestCase

  
  test ".calculate string, 34, starts_with, 3 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "starts_with", "3", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 123, starts_with, 12 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123", "starts_with", "12", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 123, starts_with, 123 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123", "starts_with", "123", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 18, starts_with, 2 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "starts_with", "2", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 99, starts_with, 92 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "starts_with", "92", "string", ""
    #then
    assert_equal(false, res)
  end

end
