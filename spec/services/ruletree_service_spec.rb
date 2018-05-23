require 'rails_helper'

describe RuletreeService do

  cache_layer = nil
  
  describe 'instantiation' do
    before do
      the_asker = Asker.new(v_age: '42', v_spectacle: 'non')
      r_adult = create(:rule, :be_an_adult, name: "r_adult_rts")
      r_spectacle = create(:rule, :be_a_spectacle, name: "r_spectacle_rts")
      r_adult_and_spectacle = create(:rule, name: "r_adult_and_spectacle_rts", slave_rules: [r_adult, r_spectacle], composition_type: :and_rule)
      r_adult_or_spectacle = create(:rule, name: "r_adult_or_spectacle_rts", slave_rules: [r_adult, r_spectacle], composition_type: :or_rule)
    end
    describe 'Cache Read, already something inside the database' do
      before do
        cache_layer = instance_double("CacheService")
        allow(cache_layer).to receive(:read).and_return('[{}]')
        allow(cache_layer).to receive(:write).and_return(nil)
        CacheService.set_instance(cache_layer)        
      end
      after do
        CacheService.set_instance(nil)        
      end
      it 'Must have read key "all_rules_json" from cache' do
        # given
        # when
        RuletreeService.get_instance
        # then
        expect(cache_layer).to have_received(:read).with("all_rules_json")
      end
      it 'Must NOT write anything to cache' do
        # given
        # when
        RuletreeService.get_instance
        # then
        expect(cache_layer).not_to have_received(:write)
      end
      it 'Must fetch results from cache, if any' do
        # given
        # when
        sut = RuletreeService.get_instance._all_rules
        # then
        expect(sut.size).to eq(1)
      end
    end
    describe 'Cache Write, nothing inside the database' do
      before do
        cache_layer = instance_double("CacheService")
        allow(cache_layer).to receive(:read).and_return(nil)
        allow(cache_layer).to receive(:write).and_return(nil)
        CacheService.set_instance(cache_layer)        
      end
      after do
        CacheService.set_instance(nil)        
      end
      it 'Must WRITE the list to the cache' do
        # given
        # when
        RuletreeService.get_instance
        # then
        expect(cache_layer).to have_received(:write).with("all_rules_json", anything)
      end
      it 'Must fetch results from DB' do
        # given
        # when
        # sut = RuletreeService.get_instance._all_rules_json
        # p '- - - - - - - - - - - - - - sut- - - - - - - - - - - - - - - -' 
        # p sut.inspect
        # p ''
        # then
        expect(RuletreeService.get_instance._all_rules.size).to eq(4)
      end
    end
  end


  describe ".evaluate ADULT" do
    subject { RuletreeService.get_instance.evaluate(rule, criterion_hash) }
    let(:rule) { create :rule, :be_an_adult; JSON.parse(Rule.last.to_json(:include => [:slave_rules, :variable])) }
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
      let(:criterion_hash) { {v_spectacle: 'any'} }
      it { expect(subject).to eq 'uncertain'}
    end
    context 'should return "uncertain" when criteria is present but nil' do
      let(:criterion_hash) { {v_age: nil} }
      it { expect(subject).to eq 'uncertain'}
    end
  end

  describe ".evaluate CHILD" do
    subject { RuletreeService.get_instance.evaluate(rule, criterion_hash) }
    let(:rule) { create :rule, :be_a_child; JSON.parse(Rule.last.to_json(:include => [:slave_rules, :variable])) }
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
      let(:criterion_hash) { {v_spectacle: 'any'} }
      it { expect(subject).to eq 'uncertain'}
    end
    context 'should return "uncertain" when criteria is present but nil' do
      let(:criterion_hash) { {v_age: nil} }
      it { expect(subject).to eq 'uncertain'}
    end
  end

  describe "UNCERTAIN .evaluate" do
    subject { RuletreeService.get_instance.evaluate(rule, criterion_hash) }
    let(:rule) { create :rule, :be_in_qpv; JSON.parse(Rule.last.to_json(:include => [:slave_rules, :variable])) }
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
    subject { RuletreeService.get_instance._stub_all_rules([rule.to_json(:include => [:slave_rules, :variable])]);RuletreeService.get_instance.resolve(rule.id, asker.attributes) }
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
      let(:rule) { create :rule, :be_an_adult_and_a_spectacles }
      context 'without any condition' do
        let(:asker) { create :asker, :ado}
        it { expect(subject).to eq "ineligible" }
      end
      context 'and only one condition' do
        let(:asker) { create :asker, :adult}
        it { expect(subject).to eq "ineligible" }
      end
      context 'and with the other condition' do
        let(:asker) { create :asker, :spectacle, :ado }
        it { expect(subject).to eq "ineligible" }
      end
      context 'and the two conditions' do
        let(:asker) { create :asker, :spectacle, v_age: '38' }
        it { expect(subject).to eq "eligible" }
      end
    end
    context 'with an OR rule' do
      let(:rule) { create :rule, :be_an_adult_or_a_spectacles }
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
        let(:asker) { create :asker, :spectacle, :ado }
        it { expect(subject).to eq "eligible" }
      end
      context 'and the two conditions' do
        let(:asker) { create :asker, :spectacle, v_age: 38 }
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
      let(:rule) { create :rule, name: 'be_an_adult_and_a_spectacles_OR_be_handicaped', composition_type: :or_rule, slave_rules: [create(:rule, :be_an_adult_and_a_spectacles), create(:rule, :be_handicaped)]}
      context 'with rule_c=true only' do
        let(:asker) { create :asker, :handicaped }
        it { expect(subject).to eq "eligible" }
      end
      context 'with rule_a=true AND rule_b=true only' do
        let(:asker) { create :asker, :spectacle, v_age: '38' }
        it { expect(subject).to eq "eligible" }
      end
      context 'with rule_b=true only' do
        let(:asker) { create :asker, :spectacle, :ado, v_handicap: 'false' }
        it { expect(subject).to eq "ineligible" }
      end
    end
  end
end
