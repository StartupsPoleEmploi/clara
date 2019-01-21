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
    describe 'Simple rule' do
      it 'Can validate a valid simple Rule' do
        #given
        rule = build(:rule, :be_an_adult)
        #when
        rule.valid?
        #then
        expect(_nb_of_errors_for(rule)).to eq 0
      end
      it 'Can invalidate a simple Rule if kind is not valid' do
        #given
        rule = build(:rule, :be_an_adult)
        rule.kind = "wrong_value"
        #when
        rule.valid?
        #then
        expect(_nb_of_errors_for(rule)).to eq 1
      end
      describe 'Can invalidate a simple Rule if an unauthorized field is filled' do
        it 'rule.slave_rules is not authorized for a simple rule' do
          #given
          rule = build(:rule, :be_an_adult)
          rule.slave_rules = [build(:rule, :be_paris), build(:rule, :be_a_child)]
          #when
          rule.valid?
          #then
          expect(_nb_of_errors_for(rule)).to eq 1
        end
        it 'rule.composition_type is not authorized for a simple rule' do
          #given
          rule = build(:rule, :be_an_adult)
          rule.composition_type = :and_rule
          #when
          rule.valid?
          #then
          expect(_nb_of_errors_for(rule)).to eq 1
        end
        it 'rule.value_ineligible is deprecated, thus is not authorized for a simple rule' do
          #given
          rule = build(:rule, :be_an_adult)
          rule.value_ineligible = "43"
          #when
          rule.valid?
          #then
          expect(_nb_of_errors_for(rule)).to eq 1
        end
      end
      describe 'Can invalidate a simple Rule if a mandatory field is missing' do
        it 'rule.name is mandatory for a simple rule' do
          #given
          rule = build(:rule, :be_an_adult)
          rule.name = ""
          #when
          rule.valid?
          #then
          expect(_nb_of_errors_for(rule)).to eq 1
        end
        it 'rule.description is optional for a simple rule' do
          #given
          rule = build(:rule, :be_an_adult)
          rule.description = ""
          #when
          rule.valid?
          #then
          expect(_nb_of_errors_for(rule)).to eq 0
        end
        it 'rule.variable is mandatory for a simple rule' do
          #given
          rule = build(:rule, :be_an_adult)
          rule.variable = nil
          #when
          rule.valid?
          #then
          expect(_nb_of_errors_for(rule)).to eq 1
        end
        it 'rule.operator_type is mandatory for a simple rule' do
          #given
          rule = build(:rule, :be_an_adult)
          rule.operator_type = nil
          #when
          rule.valid?
          #then
          expect(_nb_of_errors_for(rule)).to eq 1
        end
        it 'rule.value_eligible is mandatory for a simple rule' do
          #given
          rule = build(:rule, :be_an_adult)
          rule.value_eligible = nil
          #when
          rule.valid?
          #then
          expect(_nb_of_errors_for(rule)).to eq 1
        end
      end
    end
  end

end
