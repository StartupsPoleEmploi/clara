require "test_helper"

class RuleTreeServiceIntegerNswTest < ActiveSupport::TestCase

  
  test ".calculate integer, 34, not_starts_with, 3 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "not_starts_with", "3", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 123, not_starts_with, 12 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123", "not_starts_with", "12", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 123, not_starts_with, 123 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123", "not_starts_with", "123", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 18, not_starts_with, 2 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "not_starts_with", "2", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 99, not_starts_with, 92 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "not_starts_with", "92", "integer", ""
    #then
    assert_equal(true, res)
  end

end
