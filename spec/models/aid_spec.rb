require 'rails_helper'

describe Aid, type: :model do
  
  it "is valid with valid attributes"
  it "is not valid without a name"
  it "is not valid without date creation"
  it "is not valid without slug"
  it "is not valid without a name"
  it "is not valid without a description"
  it "is not valid without a price"
  it "is not valid without additionnal_conditions"
  it "is not valid without how and when"
  it "is not valid without limitations"
  it "is not valid without rule_id"
  it "is not valid without ordre_affichage"
  it "is not valid without contract_type"
  it "is not valid without archived_at"

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
