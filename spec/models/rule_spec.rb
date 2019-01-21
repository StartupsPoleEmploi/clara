require 'rails_helper'

describe Rule, type: :model do

  describe 'Can destroy a complex rule' do
    it 'Should allow destruction of composite rule without destroying child rules' do
      #given
      complex_rule = create(:rule, :be_an_adult_or_a_spectacles, name: "to_be_destroyed")
      expect(rule_exists?("r_to_be_destroyed")).to eq true
      expect(rule_exists?("r_composed_be_a_spectacle1")).to eq true
      expect(rule_exists?("r_composed_be_an_adult1")).to eq true
      #when
      complex_rule.destroy
      #then
      expect(rule_exists?("r_to_be_destroyed")).to eq false
      expect(rule_exists?("r_composed_be_a_spectacle1")).to eq true
      expect(rule_exists?("r_composed_be_an_adult1")).to eq true
    end
  end

  def rule_exists?(name)
    Rule.find_by(name: name) != nil
  end

  describe '.validate_non_empty_rule' do
    it 'should NOT be valid for an empty rule' do
      # given
      empty_rule  = build(:rule)
      # when
      empty_rule.valid?
      # then
      expect(empty_rule.errors[:non_empty_rule].length).to eq 1
    end
    it 'should be valid for a simple rule' do
      # given
      simple_rule = create(:rule, :be_an_adult)
      # when
      simple_rule.valid?
      # then
      expect(simple_rule.errors[:non_empty_rule].length).to eq 0
    end
    it 'should be valid for a complex rule' do
      # given
      complex_rule = create(:rule, :be_an_adult_or_a_spectacles)
      # when
      complex_rule.valid?
      # then
      expect(complex_rule.errors[:non_empty_rule].length).to eq 0
    end
  end

end
