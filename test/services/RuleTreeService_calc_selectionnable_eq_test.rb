require "test_helper"

class RuleTreeServiceCalcSelectionnableEqTest < ActiveSupport::TestCase


  test ".calculate selectionnable, niveau_4, equal, niveau_5 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_4", "equal", "niveau_5", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(false, res)
  end

  test ".calculate selectionnable, niveau_3, equal, niveau_5 => false" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_3", "equal", "niveau_5", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(false, res)
  end

  test ".calculate selectionnable, niveau_2, equal, niveau_2 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_2", "equal", "niveau_2", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(true, res)
  end

  test ".calculate selectionnable, niveau_infra_5, equal, niveau_infra_5 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "niveau_infra_5", "equal", "niveau_infra_5", "selectionnable", "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    assert_equal(true, res)
  end


end
