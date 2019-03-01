require 'rails_helper'
require 'securerandom'

describe RuletreeService do

  describe '.calculate' do

    it 'Selectionnable, equal, same string => TRUE' do
      #given
      operator_kind = "equal"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_4"
      rule_value = "niveau_4"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(true)
    end
    it 'Selectionnable, equal, not same string => FALSE' do
      #given
      operator_kind = "equal"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_4"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(false)
    end
    it 'Selectionnable, not_equal, same string => FALSE' do
      #given
      operator_kind = "not_equal"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_4"
      rule_value = "niveau_4"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(false)
    end
    it 'Selectionnable, not_equal, diff string => TRUE' do
      #given
      operator_kind = "not_equal"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_4"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(true)
    end
    it 'Selectionnable, more_than, true' do
      #given
      operator_kind = "more_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_4"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(true)
    end
    it 'Selectionnable, more_than, false' do
      #given
      operator_kind = "more_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_infra_5"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(false)
    end
    it 'Selectionnable, more_than, false (because eq)' do
      #given
      operator_kind = "more_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_5"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(false)
    end
    it 'Selectionnable, more_or_equal_than, true' do
      #given
      operator_kind = "more_or_equal_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_4"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(true)
    end
    it 'Selectionnable, more_or_equal_than, false' do
      #given
      operator_kind = "more_or_equal_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_infra_5"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(false)
    end
    it 'Selectionnable, more_or_equal_than, true (because eq)' do
      #given
      operator_kind = "more_or_equal_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_5"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(true)
    end
    it 'Selectionnable, less_than, false' do
      #given
      operator_kind = "less_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_4"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(false)
    end
    it 'Selectionnable, less_than, true' do
      #given
      operator_kind = "less_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_infra_5"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(true)
    end
    it 'Selectionnable, less_than, false (because eq)' do
      #given
      operator_kind = "less_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_5"
      rule_value = "niveau_5"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
      #then
      expect(res).to eq(false)
    end
  end
  it 'Selectionnable, less_or_equal_than, false' do
    #given
    operator_kind = "less_or_equal_than"
    rule_h = build(:rule, operator_kind: operator_kind).attributes
    criterion_value = "niveau_4"
    rule_value = "niveau_5"
    rule_type = "selectionnable"
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    expect(res).to eq(false)
  end
  it 'Selectionnable, less_or_equal_than, true' do
    #given
    operator_kind = "less_or_equal_than"
    rule_h = build(:rule, operator_kind: operator_kind).attributes
    criterion_value = "niveau_infra_5"
    rule_value = "niveau_5"
    rule_type = "selectionnable"
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    expect(res).to eq(true)
  end
  it 'Selectionnable, less_or_equal_than, true (because eq)' do
    #given
    operator_kind = "less_or_equal_than"
    rule_h = build(:rule, operator_kind: operator_kind).attributes
    criterion_value = "niveau_5"
    rule_value = "niveau_5"
    rule_type = "selectionnable"
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1"
    #then
    expect(res).to eq(true)
  end
end
