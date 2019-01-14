require 'rails_helper'

describe GetRuleValueTranslation do

  describe ".call" do
    it 'Can return the translated value of a Rule' do
      #given
      rule = build(:rule, :old_inscription)
      #when
      result = GetRuleValueTranslation.call(
        variable_id: rule.variable_id, 
        key_value: 'moins_d_un_an'
      )
      #then
      expect(result).to eq "moins d'un an"
    end
    it 'Can returns another translated value of a Rule' do
      #given
      rule = build(:rule, :old_inscription)
      #when
      result = GetRuleValueTranslation.call(
        variable_id: rule.variable_id, 
        key_value: 'plus_d_un_an'
      )
      #then
      expect(result).to eq "plus d'un an"
    end
    it 'Can return the normal value of a Rule if there is no translation' do
      #given
      rule = build(:rule, :be_paris)
      #when
      result = GetRuleValueTranslation.call(
        variable_id: rule.variable_id, 
        key_value: "75056"
      )
      #then
      expect(result).to eq "75056"
    end
  end

end
