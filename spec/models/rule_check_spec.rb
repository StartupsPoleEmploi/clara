require 'rails_helper'

describe RuleCheck, type: :model do

  describe 'database columns' do
    it { is_expected.to have_db_column (:id) }
    it { is_expected.to have_db_column (:name) }
    it { is_expected.to have_db_column (:created_at) }
    it { is_expected.to have_db_column (:updated_at) }
  end

end
