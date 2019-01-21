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

  def _nb_of_errors_for(rule)
    rule.errors.messages.size
  end

  describe 'Validation' do
    it 'Can validate a valid Rule' do
      #given
      rule = create(:rule, :be_an_adult)
      #when
      # rule.kind="blazer"
      rule.valid?
      #then
      expect(_nb_of_errors_for(rule)).to eq 0
    end
  end

end
