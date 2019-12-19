require 'rails_helper'
require 'securerandom'

describe RuletreeService do

  describe ".evaluate ADULT" do
    subject { RuletreeService.new.evaluate(rule, criterion_hash) }
    before do
      create :rule, :be_an_adult, name: 'an_adult', kind: "simple"
    end
    let(:rule) {JSON.parse(Rule.last.to_json(:include => [:slave_rules])) }
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
    before do
      create :rule, :be_a_child, kind: "simple"
    end
    subject { RuletreeService.new.evaluate(rule, criterion_hash) }
    let(:rule) { JSON.parse(Rule.last.to_json(:include => [:slave_rules])) }
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

end
