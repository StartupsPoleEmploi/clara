require 'rails_helper'

describe Aid, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:what) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
    it { is_expected.to have_db_column(:slug) }
    it { is_expected.to have_db_column(:short_description) }
    it { is_expected.to have_db_column(:how_much) }
    it { is_expected.to have_db_column(:additionnal_conditions) }
    it { is_expected.to have_db_column(:how_and_when) }
    it { is_expected.to have_db_column(:rule_id) }
    it { is_expected.to have_db_column(:ordre_affichage) }
    it { is_expected.to have_db_column(:contract_type_id) }
    it { is_expected.to have_db_column(:archived_at) }
    it { is_expected.to have_db_column(:last_update) }
  end

  describe 'validation' do
    context 'name' do
      it { is_expected.not_to allow_value('').for(:name) }
      it { is_expected.to allow_value('mon aide clara').for(:name) }
      it 'should have a unique name' do
        create(:aid, name: 'unique name')
        should validate_uniqueness_of(:name)
      end
    end
  end

  describe 'association'  do
    it { is_expected.to belong_to(:rule)}
    it { is_expected.to belong_to(:contract_type)}
  end

  describe '.unarchived' do
    it 'Gives the aids that are NOT archived' do
      # given
      sut = create(:aid, :aid_harki, name: 'aaa')
      # when
      is_unarchived = Aid.unarchived.where(:id => sut.id).present? 
      # then
      expect(is_unarchived).to eq(true)
    end
    it 'DO NOT gives the aids that are archived' do
      # given
      sut = create(:aid, :aid_harki, name: 'bbb', archived_at: Date.new)
      # when
      is_unarchived = Aid.unarchived.where(:id => sut.id).present? 
      # then
      expect(is_unarchived).to eq(false)
    end
  end
  describe '.linked_to_rule' do
    it 'Gives the aids that linked to a root rule' do
      # given
      sut = create(:aid, :aid_harki, name: 'ccc')
      # when
      is_linked_to_a_root_rule = Aid.linked_to_rule.where(:id => sut.id).present? 
      # then
      expect(is_linked_to_a_root_rule).to eq(true)
    end
    it 'Gives the aids that linked to a root rule' do
      # given
      sut = create(:aid, name: 'ddd')
      # when
      is_linked_to_a_root_rule = Aid.linked_to_rule.where(:id => sut.id).present? 
      # then
      expect(is_linked_to_a_root_rule).to eq(false)
    end
  end
  describe '.activated' do
    it 'Should return true if the aid is both unarchived, and linked to a root rule' do
      # given
      sut = create(:aid, :aid_harki, name: 'eee')
      expect(sut.archived_at).to eq(nil)
      expect(sut.rule).not_to eq(nil)
      # when
      is_activated = Aid.activated.where(:id => sut.id).present? 
      # then
      expect(is_activated).to eq(true)
    end
    it 'Should return false if the aid is NOT unarchived, and linked to a root rule' do
      # given
      sut = create(:aid, :aid_harki, name: 'fff', archived_at: Date.new)
      expect(sut.archived_at).not_to eq(nil)
      expect(sut.rule).not_to eq(nil)
      # when
      is_activated = Aid.activated.where(:id => sut.id).present? 
      # then
      expect(is_activated).to eq(false)
    end
    it 'Should return false if the aid is unarchived, and NOT linked to a root rule' do
      # given
      sut = create(:aid, name: 'ddd', archived_at: Date.new)
      expect(sut.archived_at).not_to eq(nil)
      expect(sut.rule).to eq(nil)
      # when
      is_activated = Aid.activated.where(:id => sut.id).present? 
      # then
      expect(is_activated).to eq(false)
    end
  end

end
