require "test_helper"

class RuleTreeServiceStringNswTest < ActiveSupport::TestCase

  
  test ".calculate string, 34, not_starts_with, 3 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "not_starts_with", "3", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 123, not_starts_with, 12 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123", "not_starts_with", "12", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 123, not_starts_with, 123 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "123", "not_starts_with", "123", "string", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate string, 18, not_starts_with, 2 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "not_starts_with", "2", "string", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate string, 99, not_starts_with, 92 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "not_starts_with", "92", "string", ""
    #then
    assert_equal(true, res)
  end

end
