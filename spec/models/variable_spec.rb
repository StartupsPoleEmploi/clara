require 'rails_helper'

describe Variable, type: :model do

  describe 'database columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:variable_type) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
    it { is_expected.to have_db_column(:description) }
  end
  describe 'association' do
    it { is_expected. to have_many(:rule) }
  end
  describe 'validates' do
    context 'variable_type' do
      it { is_expected.not_to allow_value('').for(:variable_type) }
      it { is_expected.to allow_value('ma variable_type').for(:variable_type) }
      it { is_expected.to allow_value(4).for(:variable_type) }
    end
  end
  describe 'enum' do
    it 'variable_type should be an integer or string' do
      create(:variable, variable_type: 'string')
      create(:variable, variable_type: 4)
      expect(variable_type.is_a? Integer).to eq true
      expect(variable_type.is_a? String).to eq true
    end
  end
end

