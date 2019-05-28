require "test_helper"

class RuleTreeServiceCalcSelectionnableMoetTest < ActiveSupport::TestCase


  test ".calculate selectionnable, niveau_4, more_or_equal_than, niveau_5 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_4", "more_or_equal_than", "niveau_5", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(true, res)
  end

  test ".calculate selectionnable, niveau_3, more_or_equal_than, niveau_5 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_3", "more_or_equal_than", "niveau_5", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(true, res)
  end

  test ".calculate selectionnable, niveau_2, more_or_equal_than, niveau_2 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_2", "more_or_equal_than", "niveau_2", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(true, res)
  end

  test ".calculate selectionnable, niveau_3, more_or_equal_than, niveau_2 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_3", "more_or_equal_than", "niveau_2", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(false, res)
  end

  test ".calculate selectionnable, niveau_infra_5, more_or_equal_than, niveau_2 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_infra_5", "more_or_equal_than", "niveau_2", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(false, res)
  end



end
