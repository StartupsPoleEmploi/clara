require 'rails_helper'

describe CompoundRule, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:rule_id) }
    it { is_expected.to have_db_column(:slave_rule_id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end
  describe 'association' do
    it { is_expected.to belong_to(:rule) }
    it { is_expected.to belong_to(:slave_rule) }
  end
end
