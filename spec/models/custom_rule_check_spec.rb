require 'rails_helper'

describe CustomRuleCheck, type: :model do

  describe 'database columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:rule_id) }
    it { is_expected.to have_db_column(:result) }
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:hsh) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  describe 'association' do
    it { is_expected.to belong_to(:rule) }
  end

  describe 'validates' do
    it { is_expected.not_to allow_value('').for(:name) }
    it { is_expected.to allow_value('ma regle custom').for(:name) }    
  end
  
end

