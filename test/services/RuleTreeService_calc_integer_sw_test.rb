require "test_helper"

class RuleTreeServiceCalcIntegerSwTest < ActiveSupport::TestCase

  
  test ".calculate integer, 34, starts_with, 3 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "starts_with", "3", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 123, starts_with, 12 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123", "starts_with", "12", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 123, starts_with, 123 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123", "starts_with", "123", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 18, starts_with, 2 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "starts_with", "2", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 99, starts_with, 92 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "starts_with", "92", "integer", ""
    #then
    assert_equal(false, res)
  end

end
