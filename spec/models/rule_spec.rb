require 'rails_helper'

describe Rule, type: :model do

  describe '.calculate' do
    it 'by default return false' do
      # given
      # when
      output = Rule.new.send(:calculate, nil, nil, nil)
      # then
      expect(output).to eq(false)
    end
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
      complex_rule = create(:rule, :be_an_adult_or_a_harkis)
      # when
      complex_rule.valid?
      # then
      expect(complex_rule.errors[:non_empty_rule].length).to eq 0
    end
  end

  describe '.validate_non_ambiguous_type' do
    before(:each) do |example|
      if example.metadata[:need_init]
        @ambiguous_rule = create(:rule, :be_an_adult_or_a_harkis)
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
      complex_rule = create(:rule, :be_an_adult_and_a_harkis)
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
      complex_rule = create(:rule, :be_an_adult_or_a_harkis)
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
      ambiguous_rule = create(:rule, :be_an_adult_or_a_harkis)
      ambiguous_rule.value_eligible = '42'
      # when
      ambiguous_rule.valid?
      #then
      expect(ambiguous_rule.errors[:complex_rule_mandatory_fields].length).to eq 0
    end
    it 'should NOT be valid if slave_rules is missing' do
      #given
      incomplete_complex_rule = create(:rule, :be_an_adult_or_a_harkis)
      incomplete_complex_rule.slave_rules = []
      # when
      incomplete_complex_rule.valid?
      #then
      expect(incomplete_complex_rule).not_to be_valid
      expect(incomplete_complex_rule.errors[:complex_rule_mandatory_fields].length).to eq 1
    end
    it 'should NOT be valid if composition_type are missing' do
      #given
      incomplete_complex_rule = create(:rule, :be_an_adult_or_a_harkis)
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
      complex_rule = create(:rule, :be_an_adult_or_a_harkis)
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

  describe ".evaluate ADULT" do
    subject { rule.evaluate(criterion_hash) }
    let(:rule) { create :rule, :be_an_adult }
    context 'should return "uncertain" when criterion hash is empty' do
      let(:criterion_hash) { {} }
      it { expect(subject).to eq 'uncertain' }
    end
    context 'should return "ineligible" when criteria is present and NOT satisfied' do
      let(:criterion_hash) { {v_age: 12} }
      it { expect(subject).to eq 'ineligible' }
    end
    context 'should return "eligible" when criteria is present and satisfied' do
      let(:criterion_hash) { {v_age: 34} }
      it { expect(subject).to eq 'eligible' }
    end
    context 'should return "ineligible" when criteria is "wrong_input"' do
      let(:criterion_hash) { {v_age: 'wrong_input'} }
      it { expect(subject).to eq 'ineligible'}
    end
    context 'should return "ineligible" when criteria is "azerty"' do
      let(:criterion_hash) { {v_age: 'azerty'} }
      it { expect(subject).to eq 'ineligible'}
    end
    context 'should return "uncertain" when criteria is NOT present' do
      let(:criterion_hash) { {v_harki: 'any'} }
      it { expect(subject).to eq 'uncertain'}
    end
    context 'should return "uncertain" when criteria is present but nil' do
      let(:criterion_hash) { {v_age: nil} }
      it { expect(subject).to eq 'uncertain'}
    end
  end

  describe ".evaluate CHILD" do
    subject { rule.evaluate(criterion_hash) }
    let(:rule) { create :rule, :be_a_child }
    context 'should return "uncertain" when criterion hash is empty' do
      let(:criterion_hash) { {} }
      it { expect(subject).to eq 'uncertain' }
    end
    context 'should return "ineligible" when criteria is present and NOT satisfied' do
      let(:criterion_hash) { {v_age: 42} }
      it { expect(subject).to eq 'ineligible' }
    end
    context 'should return "eligible" when criteria is present and satisfied' do
      let(:criterion_hash) { {v_age: 14} }
      it { expect(subject).to eq 'eligible' }
    end
    context 'should return "eligible" when criteria is present, a string, and satisfied' do
      let(:criterion_hash) { {v_age: "14"} }
      it { expect(subject).to eq 'eligible' }
    end
    context 'should return "ineligible" when criteria is present, a string, and outside range' do
      let(:criterion_hash) { {v_age: "24"} }
      it { expect(subject).to eq 'ineligible' }
    end
    context 'should return "ineligible" when criteria is present, a float within range' do
      let(:criterion_hash) { {v_age: 14.2} }
      it { expect(subject).to eq 'ineligible' }
    end
    context 'should return "ineligible" when criteria is present, a float outside range' do
      let(:criterion_hash) { {v_age: 24.2} }
      it { expect(subject).to eq 'ineligible' }
    end
    context 'should return "ineligible" when criteria is present, a string that represents a float within range' do
      let(:criterion_hash) { {v_age: "14.2"} }
      it { expect(subject).to eq 'ineligible' }
    end
    context 'should return "ineligible" when criteria is present, a string that represents a float outside range' do
      let(:criterion_hash) { {v_age: "24.2"} }
      it { expect(subject).to eq 'ineligible' }
    end
    context 'should return "ineligible" when criteria is "not_applicable"' do
      let(:criterion_hash) { {v_age: 'not_applicable'} }
      it { expect(subject).to eq 'ineligible'}
    end
    context 'should return "ineligible" when criteria is "wrong_input"' do
      let(:criterion_hash) { {v_age: 'wrong_input'} }
      it { expect(subject).to eq 'ineligible'}
    end
    context 'should return "uncertain" when criteria is NOT present' do
      let(:criterion_hash) { {v_harki: 'any'} }
      it { expect(subject).to eq 'uncertain'}
    end
    context 'should return "uncertain" when criteria is present but nil' do
      let(:criterion_hash) { {v_age: nil} }
      it { expect(subject).to eq 'uncertain'}
    end
  end


  describe "UNCERTAIN .evaluate" do
    subject { rule.evaluate(criterion_hash) }
    let(:rule) { create :rule, :be_in_qpv }
    context 'should return "uncertain" when criterion hash is empty' do
      let(:criterion_hash) { {} }
      it { expect(subject).to eq 'uncertain' }
    end
    context 'should return "uncertain" when criteria is present but with unknown value' do
      let(:criterion_hash) { {v_qpv: 'foo'} }
      it { expect(subject).to eq 'uncertain' }
    end
    context 'should return "ineligible" when criteria is present as ineligible' do
      let(:criterion_hash) { {v_qpv: 'hors_qpv'} }
      it { expect(subject).to eq 'ineligible' }
    end
    context 'should return "eligible" when criteria is present and satisfied' do
      let(:criterion_hash) { {v_qpv: 'en_qpv'} }
      it { expect(subject).to eq 'eligible' }
    end
  end



  describe ".resolve" do

    subject { rule.resolve(asker.attributes) }
    context 'with an Integer' do
      let(:asker) { create :asker, v_age: '19'}
      let(:variable) { create :variable, :age}

      context 'more_or_equal_than an Integer, limit case, "eligible"' do
        let(:rule) { create :rule, operator_type: :more_or_equal_than, value_eligible: '19', variable: variable }
        context '19 is more or equal than 19' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'more_or_equal_than an Integer, nominal case, "eligible"' do
        let(:rule) { create :rule, operator_type: :more_or_equal_than, value_eligible: '12', variable: variable }
        context '19 is more or equal than 12' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'more_or_equal_than an Integer, nominal case, "ineligible"' do
        let(:rule) { create :rule, operator_type: :more_or_equal_than, value_eligible: '27', variable: variable }
        context '19 is not more or equal than 27' do
          it { expect(subject).to eq "ineligible" }
        end
      end
      context 'less_or_equal_than an Integer, limit case, "eligible"' do
        let(:rule) { create :rule, operator_type: :less_or_equal_than, value_eligible: '19', variable: variable }
        context '19 is less or equal than 19' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'less_or_equal_than an Integer, nominal case, "eligible"' do
        let(:rule) { create :rule, operator_type: :less_or_equal_than, value_eligible: '27', variable: variable }
        context '19 is less or equal than 27' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'less_or_equal_than an Integer, nominal case, "ineligible"' do
        let(:rule) { create :rule, operator_type: :less_or_equal_than, value_eligible: '12', variable: variable }
        context '19 is not less or equal than 12' do
          it { expect(subject).to eq "ineligible" }
        end
      end
      context 'more_than an Integer, "eligible"' do
        let(:rule) { create :rule, operator_type: :more_than, value_eligible: '18', variable: variable }
        context '19 is more than 18' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'more_than an Integer, "ineligible"' do
        let(:rule) { create :rule, operator_type: :more_than, value_eligible: '20', variable: variable }
        context '19 is more than 20' do
          it { expect(subject).to eq "ineligible" }
        end
      end
      context 'less_than an Integer, "eligible"' do
        let(:rule) { create :rule, operator_type: :less_than, value_eligible: '20', variable: variable }
        context '19 is less than 20' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'less_than an Integer, "ineligible"' do
        let(:rule) { create :rule, operator_type: :less_than, value_eligible: '17', variable: variable }
        context '19 is less than 17' do
          it { expect(subject).to eq "ineligible" }
        end
      end
      context 'equal an Integer, "eligible"' do
        let(:rule) { create :rule, operator_type: :eq, value_eligible: '19', variable: variable }
        context '19 equal 19' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'equal an Integer, "ineligible"' do
        let(:rule) { create :rule, operator_type: :eq, value_eligible: '20', variable: variable }
        context '19 equal 20' do
          it { expect(subject).to eq "ineligible" }
        end
      end
    end
    context 'with a String' do
      let(:asker) { create :asker, v_allocation_type: 'ASS_AER_ATA_APS_AS-FNE'}
      let(:variable) { create :variable, variable_type: :string, name: 'v_allocation_type'}
      context 'equal a String, "eligible"' do
        let(:rule) { create :rule, operator_type: :eq, value_eligible: 'ASS_AER_ATA_APS_AS-FNE', variable: variable }
        context 'ASS_AER_ATA_APS_AS-FNE equal ASS_AER_ATA_APS_AS-FNE' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'equal String, "ineligible"' do
        let(:rule) { create :rule, operator_type: :eq, value_eligible: 'not_ASS_AER_ATA_APS_AS-FNE', variable: variable }
        context 'not_ASS_AER_ATA_APS_AS-FNE equal ASS_AER_ATA_APS_AS-FNE' do
          it { expect(subject).to eq "ineligible" }
        end
      end
      context 'not_equal a String, "eligible"' do
        let(:rule) { create :rule, operator_type: :not_equal, value_eligible: 'aaa', variable: variable }
        context 'aaa not_equal ASS_AER_ATA_APS_AS-FNE' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'not_equal String, "ineligible"' do
        let(:rule) { create :rule, operator_type: :not_equal, value_eligible: 'ASS_AER_ATA_APS_AS-FNE', variable: variable }
        context 'ASS_AER_ATA_APS_AS-FNE equal ASS_AER_ATA_APS_AS-FNE' do
          it { expect(subject).to eq "ineligible" }
        end
      end
      context 'starts_with String, "eligible"' do
        let(:rule) { create :rule, operator_type: :starts_with, value_eligible: 'ASS', variable: variable }
        context 'ASS_AER_ATA_APS_AS-FNE starts_with ASS' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'starts_with String, case unsensitive, "eligible"' do
        let(:rule) { create :rule, operator_type: :starts_with, value_eligible: 'ass', variable: variable }
        context 'ASS_AER_ATA_APS_AS-FNE starts_with ass' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'starts_with String, case accent and non-alphanumeric, "eligible"' do
        let(:rule) { create :rule, operator_type: :starts_with, value_eligible: 'â-ss', variable: variable }
        context 'ASS_AER_ATA_APS_AS-FNE starts_with â-ss' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'starts_with String, "ineligible"' do
        let(:rule) { create :rule, operator_type: :starts_with, value_eligible: 'XXX', variable: variable }
        context 'ASS_AER_ATA_APS_AS-FNE starts_with XXX' do
          it { expect(subject).to eq "ineligible" }
        end
      end
    end

    context 'with an AND rule' do
      let(:rule) { create :rule, :be_an_adult_and_a_harkis }
      context 'without any condition' do
        let(:asker) { create :asker, :ado}
        it { expect(subject).to eq "ineligible" }
      end
      context 'and only one condition' do
        let(:asker) { create :asker, :adult}
        it { expect(subject).to eq "ineligible" }
      end
      context 'and with the other condition' do
        let(:asker) { create :asker, :harki, :ado }
        it { expect(subject).to eq "ineligible" }
      end
      context 'and the two conditions' do
        let(:asker) { create :asker, :harki, v_age: '38' }
        it { expect(subject).to eq "eligible" }
      end
    end


    context 'with an OR rule' do
      let(:rule) { create :rule, :be_an_adult_or_a_harkis }
      context 'without any condition' do
        let(:asker) { create :asker, :ado }
        it { expect(subject).to eq "ineligible" }
      end
      context 'and only one condition' do
        let(:asker) { create :asker }
        it { expect(subject).to eq "eligible" }
      end
      context 'and only one condition' do
        let(:asker) { create :asker }
        it { expect(subject).to eq "eligible" }
      end
      context 'and with the other condition only' do
        let(:asker) { create :asker, :harki, :ado }
        it { expect(subject).to eq "eligible" }
      end
      context 'and the two conditions' do
        let(:asker) { create :asker, :harki, v_age: 38 }
        it { expect(subject).to eq "eligible" }
      end
    end

    context 'UNCERTAIN with an AND rule' do
      let(:rule) { create :rule, :be_an_adult_and_in_qpv }
      context 'without any condition' do
        let(:asker) { create :asker, :ado}
        it { expect(subject).to eq "ineligible" }
      end
      context '1st is eligible, 2nd is not existing (default value applies)' do
        let(:asker) { create :asker, :adult}
        it { expect(subject).to eq "uncertain" }
      end
      context '1st is eligible, 2nd is not eligible' do
        let(:asker) { create :asker, :adult, v_qpv: 'hors_qpv' }
        it { expect(subject).to eq "ineligible" }
      end
      context '1st is eligible, 2nd is eligible' do
        let(:asker) { create :asker, :adult, v_qpv: 'en_qpv' }
        it { expect(subject).to eq "eligible" }
      end
      context '1st is ineligible, 2nd is eligible' do
        let(:asker) { create :asker, :ado, v_qpv: 'en_qpv' }
        it { expect(subject).to eq "ineligible" }
      end
      context '1st is ineligible, 2nd is explicitly uncertain' do
        let(:asker) { create :asker, :ado, v_qpv: 'foo' }
        it { expect(subject).to eq "ineligible" }
      end
      context '1st is eligible, 2nd is explicitly uncertain' do
        let(:asker) { create :asker, :adult, v_qpv: 'foo' }
        it { expect(subject).to eq "uncertain" }
      end
    end

    context 'UNCERTAIN with an OR rule' do
      let(:rule) { create :rule, :be_an_adult_or_in_qpv }
      context 'without any condition' do
        let(:asker) { create :asker, :ado}
        it { expect(subject).to eq "uncertain" }
      end
      context '1st is eligible, 2nd is not existing (default value applies)' do
        let(:asker) { create :asker, :adult}
        it { expect(subject).to eq "eligible" }
      end
      context '1st is eligible, 2nd is not eligible' do
        let(:asker) { create :asker, :adult, v_qpv: 'hors_qpv' }
        it { expect(subject).to eq "eligible" }
      end
      context '1st is eligible, 2nd is eligible' do
        let(:asker) { create :asker, :adult, v_qpv: 'en_qpv' }
        it { expect(subject).to eq "eligible" }
      end
      context '1st is ineligible, 2nd is eligible' do
        let(:asker) { create :asker, :ado, v_qpv: 'en_qpv' }
        it { expect(subject).to eq "eligible" }
      end
      context '1st is ineligible, 2nd is explicitly uncertain' do
        let(:asker) { create :asker, :ado, v_qpv: 'foo' }
        it { expect(subject).to eq "uncertain" }
      end
      context '1st is eligible, 2nd is explicitly uncertain' do
        let(:asker) { create :asker, :adult, v_qpv: 'foo' }
        it { expect(subject).to eq "eligible" }
      end
    end

    context 'with (rule_a AND rule_b) OR rule_c' do
      let(:rule) { build :rule, name: 'be_an_adult_and_a_harkis_OR_be_handicaped', composition_type: :or_rule }
      before do
        rule.slave_rules << [create(:rule, :be_an_adult_and_a_harkis), create(:rule, :be_handicaped)]
      end
      context 'with rule_c=true only' do
        let(:asker) { create :asker, :handicaped }
        it { expect(subject).to eq "eligible" }
      end
      context 'with rule_a=true AND rule_b=true only' do
        let(:asker) { create :asker, :harki, v_age: '38' }
        it { expect(subject).to eq "eligible" }
      end
      context 'with rule_b=true only' do
        let(:asker) { create :asker, :harki, :ado, v_handicap: 'false' }
        it { expect(subject).to eq "ineligible" }
      end
    end
  end

end
