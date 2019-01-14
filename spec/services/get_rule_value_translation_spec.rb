require 'rails_helper'

describe GetRuleValueTranslation do

  describe ".call" do
    it 'Can return the translated value of a Rule' do
      #given
      rule_under_test = build(:rule, :old_inscription)
      #when
      res = GetRuleValueTranslation.call(
        variable_id: rule_under_test.variable_id, 
        key_value: 'moins_d_un_an'
      )
      #then
      expect(result).to eq 'blabla'
    end
  end

end
