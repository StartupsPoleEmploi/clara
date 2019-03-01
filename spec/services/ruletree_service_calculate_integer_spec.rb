require 'rails_helper'
require 'securerandom'

describe RuletreeService do



  describe '.calculate' do

    it 'calculates integer, less_or_equal_than, more' do
      #given
      operator_kind = "less_or_equal_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 22
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'calculates integer, less_or_equal_than, eq' do
      #given
      operator_kind = "less_or_equal_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 18
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates integer, less_or_equal_than, less' do
      #given
      operator_kind = "less_or_equal_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 16
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates integer, less_than, more' do
      #given
      operator_kind = "less_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 22
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'calculates integer, less_than, eq' do
      #given
      operator_kind = "less_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 18
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'calculates integer, less_than, less' do
      #given
      operator_kind = "less_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 16
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates integer, more_or_equal_than, more' do
      #given
      operator_kind = "more_or_equal_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 22
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates integer, more_or_equal_than, equal' do
      #given
      operator_kind = "more_or_equal_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 18
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates integer, NOT more_or_equal_than, less' do
      #given
      operator_kind = "more_or_equal_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 16
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end


    it 'calculates integer, equal, equal' do
      #given
      operator_kind = "equal"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 34
      rule_value = "34"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates integer, equal, diff' do
      #given
      operator_kind = "equal"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 35
      rule_value = "34"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'calculates integer, not_equal, diff' do
      #given
      operator_kind = "not_equal"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 35
      rule_value = "34"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates integer, not_equal, eq' do
      #given
      operator_kind = "not_equal"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 34
      rule_value = "34"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'calculates integer, more_than, more' do
      #given
      operator_kind = "more_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 22
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end

    it 'calculates integer, more_than, eq' do
      #given
      operator_kind = "more_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 18
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end

    it 'calculates integer, more_than, less' do
      #given
      operator_kind = "more_than"
      rule_h = build(:rule, :be_an_adult, name: 'an_adult', operator_kind: operator_kind).attributes
      criterion_value = 16
      rule_value = "18"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end
    it 'calculates integer, amongst, nominal, true' do
      #given
      operator_kind = "amongst"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "11"
      rule_value = "11,22,33"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(true)
    end
    it 'calculates integer, amongst, nominal, false' do
      #given
      operator_kind = "amongst"
      rule_h = build(:rule, operator_kind: operator_kind).attributes
      criterion_value = "42"
      rule_value = "11,22,33"
      rule_type = "integer"
      sut = RuletreeService.new
      #when
      res = sut.send :calculate, rule_h, criterion_value, rule_value, rule_type, ""
      #then
      expect(res).to eq(false)
    end


  end
end
