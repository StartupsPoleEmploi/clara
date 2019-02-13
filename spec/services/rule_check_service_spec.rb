require 'rails_helper'

describe RuleCheckService do
  
  describe ".check_type" do
    it 'Can validate a integer rule' do
      rule_under_test = build(:rule, :be_an_adult)
      result = RuleCheckService.new.check_type(rule_under_test)
      expect(result).to eq 'ok'
    end
    it 'Can validate a string rule' do
      rule_under_test = build(:rule, :be_paris)
      result = RuleCheckService.new.check_type(rule_under_test)
      expect(result).to eq 'ok'
    end
    it 'Can validate a string rule with starts_with' do
      rule_under_test = build(:rule, :be_in_guyane)
      result = RuleCheckService.new.check_type(rule_under_test)
      expect(result).to eq 'ok'
    end
    it 'Return ok, if rule.value_eligible is correct' do
      rule_under_test = build(:rule, :be_a_spectacle)
      result = RuleCheckService.new.check_type(rule_under_test)
      expect(result).to eq 'ok'
    end
    it 'Return error, if rule.value_eligible is wrong' do
      rule_under_test = build(:rule, :be_a_spectacle)
      rule_under_test.value_eligible = nil
      result = RuleCheckService.new.check_type(rule_under_test)
      expect(result).to eq 'error'
    end
    it 'Return error if rule.variable.variable_kind does not exists' do
      v  = build(:variable, :handicap)
      v.variable_kind = nil
      rule_under_test = build(:rule, :be_handicaped, variable: v)
      result = RuleCheckService.new.check_type(rule_under_test)
      expect(result).to eq 'error'
    end
    it 'Return n/a if variable does not exists' do
      rule_under_test = build(:rule, :be_handicaped, variable: nil)
      result = RuleCheckService.new.check_type(rule_under_test)
      expect(result).to eq 'n/a'
    end
  end

  describe ".check_custom_rule" do
    it 'Checks custom rules, and fills given array' do
      # given
      rule1 = create(:rule, :be_an_adult, name: 'for_check_custom_rule')
      cr1 = create(:custom_rule_check, result: 'ineligible', name: 'nominal', rule: rule1)
      cr2 = create(:custom_rule_check, result: 'uncertain', name: 'error', rule: rule1)
      all_compositions = []
      # when
      result = RuleCheckService.new.check_custom_rule(rule1, all_compositions)
      # then
      expect(all_compositions.length).to eq(2)
      expect(all_compositions[0][:result]).to eq("error")
      expect(all_compositions[1][:result]).to eq("ok")
    end

  end

  describe ".extract_descriptions" do
    it 'returns an empty array if anything wrong occurs' do
      # given
      # when
      sut = RuleCheckService.new.send :extract_descriptions, Date.new
      # then
      expect(sut).to eq([])
    end

  end

end
