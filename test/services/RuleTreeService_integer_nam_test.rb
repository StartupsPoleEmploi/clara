require "test_helper"

class RuleTreeServiceIntegerNamTest < ActiveSupport::TestCase
  

  test ".calculate integer, 11, not_amongst, 11,22,33 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "11", "not_amongst", "11,22,33", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 42, not_amongst, 1,99,42,657 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "42", "not_amongst", "1,99,42,657", "integer", ""
    #then
    assert_equal(false, res)
  end

  test ".calculate integer, 18, not_amongst, 1,99,42,657 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "18", "not_amongst", "1,99,42,657", "integer", ""
    #then
    assert_equal(true, res)
  end

  test ".calculate integer, 0, not_amongst, 1,2,3 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "0", "not_amongst", "1,2,3", "integer", ""
    #then
    assert_equal(true, res)
  end

end
