require 'rails_helper'

describe GetRuleValueTranslation do

  describe ".call" do
    it 'Returns empty string by default' do
      #given
      #when
      result = GetRuleValueTranslation.new(nil, nil).call
      #then
      expect(result).to eq ""
    end
    it 'Returns string version of key_value if variable_id is missing' do
      #given
      #when
      result = GetRuleValueTranslation.new(nil, 123).call
      #then
      expect(result).to eq "123"
    end
    it 'Can return the translated value of a Rule' do
      #given
      rule = build(:rule, :old_inscription)
      #when
      result = GetRuleValueTranslation.new(rule.variable_id, 'moins_d_un_an').call
      #then
      expect(result).to eq "moins d'un an"
    end
    it 'Can returns another translated value of a Rule' do
      #given
      rule = build(:rule, :old_inscription)
      #when
      result = GetRuleValueTranslation.new(rule.variable_id, 'plus_d_un_an').call
      #then
      expect(result).to eq "plus d'un an"
    end
    it 'Can return the normal value of a Rule if there is no translation' do
      #given
      rule = build(:rule, :be_paris)
      #when
      result = GetRuleValueTranslation.new(rule.variable_id, "75056").call
      #then
      expect(result).to eq "75056"
    end
    it 'Can return another normal value of a Rule if there is no translation' do
      #given
      rule = build(:rule, :be_paris)
      #when
      result = GetRuleValueTranslation.new(rule.variable_id, "75001").call
      #then
      expect(result).to eq "75001"
    end
    it 'Can return a void value for a composite rule' do
      #given
      rule = build(:rule, :be_an_adult_and_a_spectacles)
      #when
      result = GetRuleValueTranslation.new(rule.variable_id, "").call
      #then
      expect(result).to eq ""
    end
  end

end
