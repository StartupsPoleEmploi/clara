require 'rails_helper'

describe Aid, type: :model do

  describe '.unarchived' do
    it 'Gives the aids that are NOT archived' do
      # given
      sut = create(:aid, :aid_spectacle, name: 'aaa')
      # when
      is_unarchived = Aid.unarchived.where(:id => sut.id).present? 
      # then
      expect(is_unarchived).to eq(true)
    end
    it 'DO NOT gives the aids that are archived' do
      # given
      sut = create(:aid, :aid_spectacle, name: 'bbb', archived_at: Date.new)
      # when
      is_unarchived = Aid.unarchived.where(:id => sut.id).present? 
      # then
      expect(is_unarchived).to eq(false)
    end
  end
  describe '.linked_to_rule' do
    it 'Gives the aids that linked to a root rule' do
      # given
      sut = create(:aid, :aid_spectacle, name: 'ccc')
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
      sut = create(:aid, :aid_spectacle, name: 'eee')
      expect(sut.archived_at).to eq(nil)
      expect(sut.rule).not_to eq(nil)
      # when
      is_activated = Aid.activated.where(:id => sut.id).present? 
      # then
      expect(is_activated).to eq(true)
    end
    it 'Should return false if the aid is NOT unarchived, and linked to a root rule' do
      # given
      sut = create(:aid, :aid_spectacle, name: 'fff', archived_at: Date.new)
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
