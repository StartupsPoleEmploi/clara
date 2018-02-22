require 'rails_helper'

describe AidService do

  active_and_eligible_aid_1     = nil
  active_and_eligible_aid_2     = nil
  inactive_and_eligible_aid_1   = nil
  inactive_and_eligible_aid_2   = nil
  active_and_uncertain_aid_1    = nil
  active_and_uncertain_aid_2    = nil
  inactive_and_uncertain_aid_1  = nil
  inactive_and_uncertain_aid_2  = nil
  active_and_ineligible_aid_1   = nil
  active_and_ineligible_aid_2   = nil
  inactive_and_ineligible_aid_1 = nil
  inactive_and_ineligible_aid_2 = nil
  the_asker = nil

  before(:all) do
    the_asker = Asker.new(v_age: '42', v_qpv: 'indisponible')

    r_adult = create(:rule, :be_an_adult)
    r_adult_and_qpv = create(:rule, :be_an_adult_and_in_qpv)
    r_young = create(:rule, :not_be_an_adult)

    active_and_eligible_aid_1     = create(:aid, name: 'active_and_eligible_aid_1', rule: r_adult)
    active_and_eligible_aid_2     = create(:aid, name: 'active_and_eligible_aid_2', rule: r_adult)
    inactive_and_eligible_aid_1   = create(:aid, name: 'inactive_and_eligible_aid_1', rule: r_adult, archived_at: DateTime.new)
    inactive_and_eligible_aid_2   = create(:aid, name: 'inactive_and_eligible_aid_2', rule: r_adult, archived_at: DateTime.new)
    active_and_uncertain_aid_1    = create(:aid, name: 'active_and_uncertain_aid_1', rule: r_adult_and_qpv)
    active_and_uncertain_aid_2    = create(:aid, name: 'active_and_uncertain_aid_2', rule: r_adult_and_qpv)
    inactive_and_uncertain_aid_1  = create(:aid, name: 'inactive_and_uncertain_aid_1', rule: r_adult_and_qpv, archived_at: DateTime.new)
    inactive_and_uncertain_aid_2  = create(:aid, name: 'inactive_and_uncertain_aid_2', rule: r_adult_and_qpv, archived_at: DateTime.new)
    active_and_ineligible_aid_1   = create(:aid, name: 'active_and_ineligible_aid_1', rule: r_young)
    active_and_ineligible_aid_2   = create(:aid, name: 'active_and_ineligible_aid_2', rule: r_young)
    inactive_and_ineligible_aid_1 = create(:aid, name: 'inactive_and_ineligible_aid_1', rule: r_young, archived_at: DateTime.new)
    inactive_and_ineligible_aid_2 = create(:aid, name: 'inactive_and_ineligible_aid_2', rule: r_young, archived_at: DateTime.new)

  end

  describe ".all_eligible" do
    it 'Should return all eligible aid only : archived, uncertain and ineligible are not returned' do

      # given
      # when
      result = AidService.all_eligible(the_asker)
      # then
      expect(result).not_to be nil
      expect(result.count).to eq(2)
      expect(result.include?(active_and_eligible_aid_1)).to eq(true)
      expect(result.include?(active_and_eligible_aid_2)).to eq(true)

    end
  end

  describe ".all_ineligible" do
    it 'Should return all ineligible aid only : archived, eligible, and uncertain are not returned' do

      # given
      # when
      result = AidService.all_ineligible(the_asker)
      # then
      expect(result).not_to be nil
      expect(result.count).to eq(2)
      expect(result.include?(active_and_ineligible_aid_1)).to eq(true)
      expect(result.include?(active_and_ineligible_aid_2)).to eq(true)
    end
  end

  describe ".all_uncertain" do
    it 'Should return all uncertain aid only : archived, eligible and ineligible are not returned' do

      # given
      # when
      result = AidService.all_uncertain(the_asker)
      # then
      expect(result).not_to be nil
      expect(result.count).to eq(2)
      expect(result.include?(active_and_uncertain_aid_1)).to eq(true)
      expect(result.include?(active_and_uncertain_aid_2)).to eq(true)

    end
  end

  describe '.activated_and_eligible?' do
    it 'Should return TRUE if asker is ELIGIBLE' do
      expect(AidService.new(active_and_eligible_aid_1).activated_and_eligible?(the_asker)).to eq(true)
    end
    it 'Should return FALSE if asker ELIGIBLE, aid ARCHIVED' do
      expect(AidService.new(inactive_and_eligible_aid_1).activated_and_eligible?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker is INELIGIBLE' do
      expect(AidService.new(active_and_ineligible_aid_1).activated_and_eligible?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker INELIGIBLE, aid ARCHIVED' do
      expect(AidService.new(inactive_and_ineligible_aid_1).activated_and_eligible?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker UNCERTAIN' do
      expect(AidService.new(active_and_uncertain_aid_1).activated_and_eligible?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker UNCERTAIN, aid ARCHIVED' do
      expect(AidService.new(inactive_and_uncertain_aid_1).activated_and_eligible?(the_asker)).to eq(false)
    end
  end

  describe '.activated_and_ineligible?' do
    it 'Should return FALSE if asker is ELIGIBLE' do
      expect(AidService.new(active_and_eligible_aid_1).activated_and_ineligible?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker ELIGIBLE, aid ARCHIVED' do
      expect(AidService.new(inactive_and_eligible_aid_1).activated_and_ineligible?(the_asker)).to eq(false)
    end
    it 'Should return TRUE if asker is INELIGIBLE' do
      expect(AidService.new(active_and_ineligible_aid_1).activated_and_ineligible?(the_asker)).to eq(true)
    end
    it 'Should return FALSE if asker INELIGIBLE, aid ARCHIVED' do
      expect(AidService.new(inactive_and_ineligible_aid_1).activated_and_ineligible?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker UNCERTAIN' do
      expect(AidService.new(active_and_uncertain_aid_1).activated_and_ineligible?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker UNCERTAIN, aid ARCHIVED' do
      expect(AidService.new(inactive_and_uncertain_aid_1).activated_and_ineligible?(the_asker)).to eq(false)
    end
  end

  describe '.activated_and_uncertain?' do
    it 'Should return FALSE if asker is ELIGIBLE' do
      expect(AidService.new(active_and_eligible_aid_1).activated_and_uncertain?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker ELIGIBLE, aid ARCHIVED' do
      expect(AidService.new(inactive_and_eligible_aid_1).activated_and_uncertain?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker is INELIGIBLE' do
      expect(AidService.new(active_and_ineligible_aid_1).activated_and_uncertain?(the_asker)).to eq(false)
    end
    it 'Should return FALSE if asker INELIGIBLE, aid ARCHIVED' do
      expect(AidService.new(inactive_and_ineligible_aid_1).activated_and_uncertain?(the_asker)).to eq(false)
    end
    it 'Should return TRUE if asker UNCERTAIN' do
      expect(AidService.new(active_and_uncertain_aid_1).activated_and_uncertain?(the_asker)).to eq(true)
    end
    it 'Should return FALSE if asker UNCERTAIN, aid ARCHIVED' do
      expect(AidService.new(inactive_and_uncertain_aid_1).activated_and_uncertain?(the_asker)).to eq(false)
    end
  end


end
