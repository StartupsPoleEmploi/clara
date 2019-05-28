require 'rails_helper'
require 'securerandom'

describe RuletreeService do

  describe ".resolve" do
    before do
      RuletreeService.new([rule.to_json(:include => [:slave_rules])], nil)
    end
    subject { RuletreeService.new.resolve(rule.id, asker.attributes) }
    context 'with a List of String' do
      let(:asker) { create :asker, v_location_citycode: '02004'}
      let(:variable) { create :variable, :location_citycode}
      context 'Amongst, yes' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :amongst, value_eligible: '02003,02004,02005', variable: variable }
        context '02004 is amongst 02003,02004,02005' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'Amongst, no' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :amongst, value_eligible: '12003,12004,12005', variable: variable }
        context '02004 is NOT amongst 12003,12004,12005' do
          it { expect(subject).to eq "ineligible" }
        end
      end
      context 'Not Amongst, yes' do
        let(:asker) { create :asker, v_location_citycode: '33404'}
        let(:rule) { create :rule, kind: "simple", operator_kind: :not_amongst, value_eligible: '02003,02004,02005', variable: variable }
        context '33404 is NOT amongst 02003,02004,02005' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'Not Amongst, no' do
        let(:asker) { create :asker, v_location_citycode: '12003'}
        let(:rule) { create :rule, kind: "simple", operator_kind: :not_amongst, value_eligible: '12003,12004,12005', variable: variable }
        context '12003 is NOT-NOT amongst 12003,12004,12005' do
          it { expect(subject).to eq "ineligible" }
        end
      end
    end
    context 'with a Selectionnable' do
      let(:asker) { create :asker, v_diplome: 'niveau_4'}
      let(:variable) { create :variable, :diplome}
      context 'I have Bac : more_or_equal_than nothing, yes' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :more_or_equal_than, value_eligible: 'niveau_infra_5', variable: variable }
        context 'Bac is better than nothing' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'I have Bac : more_or_equal_than Bac, yes' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :more_or_equal_than, value_eligible: 'niveau_4', variable: variable }
        context 'Bac is as good as Bac' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'I have Bac : more_or_equal_than Master, no' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :more_or_equal_than, value_eligible: 'niveau_1', variable: variable }
        context 'Bac is not as good as Bac+5' do
          it { expect(subject).to eq "ineligible" }
        end
      end
    end
    context 'with an Integer' do
      let(:asker) { create :asker, v_age: '19'}
      let(:variable) { create :variable, :age}
      context 'more_or_equal_than an Integer, nominal case, "eligible"' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :more_or_equal_than, value_eligible: '12', variable: variable }
        context '19 is more or equal than 12' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'more_or_equal_than an Integer, limit case, "eligible"' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :more_or_equal_than, value_eligible: '19', variable: variable }
        context '19 is more or equal than 19' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'more_or_equal_than an Integer, nominal case, "ineligible"' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :more_or_equal_than, value_eligible: '27', variable: variable }
        context '19 is not more or equal than 27' do
          it { expect(subject).to eq "ineligible" }
        end
      end
    end
    context 'with a String' do
      let(:asker) { create :asker, v_allocation_type: 'ASS_AER_APS_AS-FNE'}
      let(:variable) { create :variable, variable_kind: :string, name: 'v_allocation_type'}
      context 'equal a String, "eligible"' do
        let(:rule) { create :rule,  kind: "simple",operator_kind: :equal, value_eligible: 'ASS_AER_APS_AS-FNE', variable: variable }
        context 'ASS_AER_APS_AS-FNE equal ASS_AER_APS_AS-FNE' do
          it { expect(subject).to eq "eligible" }
        end
      end
      context 'equal String, "ineligible"' do
        let(:rule) { create :rule, kind: "simple", operator_kind: :equal, value_eligible: 'not_ASS_AER_APS_AS-FNE', variable: variable }
        context 'not_ASS_AER_APS_AS-FNE equal ASS_AER_APS_AS-FNE' do
          it { expect(subject).to eq "ineligible" }
        end
      end
    end
    context 'with an AND rule' do
      let(:rule) { create(:rule, :be_an_adult_and_a_spectacles) }
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
        let(:asker) { create :asker, :adult, v_qpv: "non" }
        it { expect(subject).to eq "ineligible" }
      end
      context '1st is eligible, 2nd is eligible' do
        let(:asker) { create :asker, :adult, v_qpv: "oui" }
        it { expect(subject).to eq "eligible" }
      end
      context '1st is ineligible, 2nd is eligible' do
        let(:asker) { create :asker, :ado, v_qpv: "oui" }
        it { expect(subject).to eq "ineligible" }
      end
      context '1st is ineligible, 2nd is explicitly uncertain' do
        let(:asker) { create :asker, :ado, v_qpv: 'foo' }
        it { expect(subject).to eq "ineligible" }
      end
      context '1st is eligible, 2nd is explicitly uncertain' do
        let(:asker) { create :asker, :adult, v_qpv: nil }
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
        let(:asker) { create :asker, :adult, v_qpv: "non" }
        it { expect(subject).to eq "eligible" }
      end
      context '1st is eligible, 2nd is eligible' do
        let(:asker) { create :asker, :adult, v_qpv: "oui" }
        it { expect(subject).to eq "eligible" }
      end
      context '1st is ineligible, 2nd is eligible' do
        let(:asker) { create :asker, :ado, v_qpv: "oui" }
        it { expect(subject).to eq "eligible" }
      end
      context '1st is ineligible, 2nd is explicitly uncertain' do
        let(:asker) { create :asker, :ado, v_qpv: nil }
        it { expect(subject).to eq "uncertain" }
      end
      context '1st is eligible, 2nd is explicitly uncertain' do
        let(:asker) { create :asker, :adult, v_qpv: 'foo' }
        it { expect(subject).to eq "eligible" }
      end
    end
    context 'with (rule_a AND rule_b) OR rule_c' do
      let(:rule) { create :rule, kind: "composite", name: 'be_an_adult_and_a_spectacles_OR_be_handicaped', composition_type: :or_rule, slave_rules: [create(:rule, :be_an_adult_and_a_spectacles), create(:rule, :be_handicaped)]}
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
