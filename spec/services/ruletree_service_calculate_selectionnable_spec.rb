require 'rails_helper'
require 'securerandom'

describe RuletreeService do

  describe '.calculate' do

    it 'calculates selectionnable, starts_with, same string' do
      #given
      operator_kind = "more_or_equal_than"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "niveau_1"
      rule_value = "niveau_4"
      rule_type = "selectionnable"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type
      #then
      expect(res).to eq(true)
    end
  end
end
