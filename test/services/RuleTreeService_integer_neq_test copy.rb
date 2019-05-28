require "test_helper"

class RuleTreeServiceIntegerNeqTest < ActiveSupport::TestCase

  
  test ".calculate integer, 34, not_equal, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "not_equal", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 99, not_equal, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "not_equal", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 18, not_equal, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "not_equal", "18", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 99, not_equal, 99 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "not_equal", "99", "integer", ""
    #then
    assert_equal(false, res)
  end

end
