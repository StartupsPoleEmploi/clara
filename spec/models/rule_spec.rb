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

  describe '.validate_non_ambiguous_type' do
    before(:each) do |example|
      if example.metadata[:need_init]
        @ambiguous_rule = create(:rule, :be_an_adult_or_a_spectacles)
        @ambiguous_rule.value_eligible = '42'


        expect(@ambiguous_rule.is_complex_rule?).to eq true
        expect(@ambiguous_rule.is_simple_rule?).to eq true
        expect(@ambiguous_rule.is_ambiguous_rule?).to eq true
      end
    end
    it 'cannot have a field of each type', :need_init do
      # when
      @ambiguous_rule.valid?
      # then
      expect(@ambiguous_rule.errors[:non_ambiguous_type].length).to eq 1
    end
    it 'cannot have all fields', :need_init do
      # given
      @ambiguous_rule.composition_type = :and_rule
      @ambiguous_rule.operator_type = :more_than
      @ambiguous_rule.variable = create(:variable, :age)
      # when
      @ambiguous_rule.valid?
      # then
      expect(@ambiguous_rule.errors[:non_ambiguous_type].length).to eq 1
    end
    it 'can be a simple rule' do
      #given
      simple_rule = create(:rule, :be_an_adult)
      #when
      simple_rule.valid?
      # then
      expect(simple_rule.errors[:non_ambiguous_type].length).to eq 0
    end
    it 'can be a complex rule' do
      #given
      complex_rule = create(:rule, :be_an_adult_and_a_spectacles)
      #when
      complex_rule.valid?
      # then
      expect(complex_rule.errors[:non_ambiguous_type].length).to eq 0
    end
    it 'can be an empty rule' do
      # given
      empty_rule  = build(:rule)
      # when
      empty_rule.valid?
      # then
      expect(empty_rule.errors[:non_ambiguous_type].length).to eq 0
    end
  end

  describe '.validate_complex_rule_mandatory_fields' do
    it 'should be valid for a correct complex rule' do
      #given
      complex_rule = create(:rule, :be_an_adult_or_a_spectacles)
      # when
      complex_rule.valid?
      #then
      expect(complex_rule.errors[:complex_rule_mandatory_fields].length).to eq 0
    end
    it 'should be valid for a correct simple rule' do
      #given
      simple_rule = create(:rule, :be_an_adult)
      # when
      simple_rule.valid?
      #then
      expect(simple_rule.errors[:complex_rule_mandatory_fields].length).to eq 0
    end
    it 'should be valid for an ambiguous complex rule' do
      #given
      ambiguous_rule = create(:rule, :be_an_adult_or_a_spectacles)
      ambiguous_rule.value_eligible = '42'
      # when
      ambiguous_rule.valid?
      #then
      expect(ambiguous_rule.errors[:complex_rule_mandatory_fields].length).to eq 0
    end
    it 'should NOT be valid if slave_rules is missing' do
      #given
      incomplete_complex_rule = create(:rule, :be_an_adult_or_a_spectacles)
      incomplete_complex_rule.slave_rules = []
      # when
      incomplete_complex_rule.valid?
      #then
      expect(incomplete_complex_rule).not_to be_valid
      expect(incomplete_complex_rule.errors[:complex_rule_mandatory_fields].length).to eq 1
    end
    it 'should NOT be valid if composition_type are missing' do
      #given
      incomplete_complex_rule = create(:rule, :be_an_adult_or_a_spectacles)
      incomplete_complex_rule.composition_type = nil
      # when
      incomplete_complex_rule.valid?
      #then
      expect(incomplete_complex_rule).not_to be_valid
      expect(incomplete_complex_rule.errors[:complex_rule_mandatory_fields].length).to eq 1
    end
  end

  describe '.validate_simple_rule_mandatory_fields' do
    it 'should be valid for a correct simple rule' do
      #given
      simple_rule = create(:rule, :be_an_adult)
      # when
      simple_rule.valid?
      #then
      expect(simple_rule.errors[:simple_rule_mandatory_fields].length).to eq 0
    end
    it 'should be valid for a correct complex rule' do
      #given
      complex_rule = create(:rule, :be_an_adult_or_a_spectacles)
      # when
      complex_rule.valid?
      #then
      expect(complex_rule.errors[:simple_rule_mandatory_fields].length).to eq 0
    end
    it 'should be valid for an ambiguous simple rule' do
      #given
      ambiguous_rule = create(:rule, :be_an_adult)
      ambiguous_rule.value_eligible = '42'
      # when
      ambiguous_rule.valid?
      #then
      expect(ambiguous_rule.errors[:simple_rule_mandatory_fields].length).to eq 0
    end
    it 'should NOT be valid if variable is missing' do
      #given
      incomplete_simple_rule = build(:rule, name: 'incomplete', operator_type: :more_than, value_eligible: '42')
      # when
      incomplete_simple_rule.valid?
      #then
      expect(incomplete_simple_rule.errors[:simple_rule_mandatory_fields].length).to eq 1
    end
    it 'should NOT be valid if operator_type is missing' do
      #given
      incomplete_simple_rule = build(:rule, name: 'incomplete', value_eligible: '42', variable: create(:variable, :age))
      # when
      incomplete_simple_rule.valid?
      #then
      expect(incomplete_simple_rule.errors[:simple_rule_mandatory_fields].length).to eq 1
    end
    it 'should NOT be valid if value is missing' do
      #given
      incomplete_simple_rule = build(:rule, name: 'incomplete', value_eligible: '42', operator_type: :more_than)
      # when
      incomplete_simple_rule.valid?
      #then
      expect(incomplete_simple_rule.errors[:simple_rule_mandatory_fields].length).to eq 1
    end
  end

end
