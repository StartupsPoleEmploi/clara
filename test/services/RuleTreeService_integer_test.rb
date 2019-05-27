require "test_helper"

class RuleTreeServiceIntegerTest < ActiveSupport::TestCase

  
  test ".calculate integer, 34, more_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "more_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 99, more_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "more_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 18, more_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "more_than", "18", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 3, more_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "3", "more_than", "18", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, -32, more_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32", "more_than", "18", "integer", ""
    #then
    assert_equal(false, res)
  end


  test ".calculate integer, 34, more_or_equal_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "more_or_equal_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 99, more_or_equal_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "99", "more_or_equal_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 18, more_or_equal_than, 18 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "more_or_equal_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 3, more_or_equal_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "3", "more_or_equal_than", "18", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, -32, more_or_equal_than, 18 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "-32", "more_or_equal_than", "18", "integer", ""
    #then
    assert_equal(false, res)
  end



end
