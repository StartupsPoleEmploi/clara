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
      expect(result).to eq 'blabla'
    end
  end

end
