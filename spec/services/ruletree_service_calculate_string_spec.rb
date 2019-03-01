require 'rails_helper'
require 'securerandom'

describe RuletreeService do

  describe '.calculate' do

    it 'calculates string, starts_with, same string' do
      #given
      operator_kind = "starts_with"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = 'ASS'
      rule_value = "ASS"
      rule_type = "string"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates string, starts_with, same string that starts with' do
      #given
      operator_kind = "starts_with"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = 'ASSandsoon'
      rule_value = "ASS"
      rule_type = "string"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates string, starts_with, same string that DONT starts with' do
      #given
      operator_kind = "starts_with"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = 'AaASSoon'
      rule_value = "ASS"
      rule_type = "string"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'calculates string, not_starts_with, with a string that do not start with' do
      #given
      operator_kind = "not_starts_with"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = 'AaASSoon'
      rule_value = "ASS"
      rule_type = "string"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates string, not_starts_with, with a string that start with' do
      #given
      operator_kind = "not_starts_with"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = 'AaASSoon'
      rule_value = "AaASSo"
      rule_type = "string"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'calculates string, amongst, nominal, true' do
      #given
      operator_kind = "amongst"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "11"
      rule_value = "11,22,33"
      rule_type = "string"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates string, amongst, nominal, false' do
      #given
      operator_kind = "amongst"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "42"
      rule_value = "11,22,33"
      rule_type = "string"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'Unknown operator' do
      #given
      operator_kind = "unknown"
      rule_h = build(:rule).attributes
      rule_h["operator_kind"] = "unknown"
      criterion_value = 'ASS'
      rule_value = "ASS"
      rule_type = "string"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

  end
end
