require 'rails_helper'

describe AidtreeService do

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
    c = create(:contract_type, :contract_type_1)

    active_and_eligible_aid_1     = create(:aid, name: 'active_and_eligible_aid_1', rule: r_adult, contract_type: c)
    active_and_eligible_aid_2     = create(:aid, name: 'active_and_eligible_aid_2', rule: r_adult, contract_type: c)
    inactive_and_eligible_aid_1   = create(:aid, name: 'inactive_and_eligible_aid_1', rule: r_adult, archived_at: DateTime.new, contract_type: c)
    inactive_and_eligible_aid_2   = create(:aid, name: 'inactive_and_eligible_aid_2', rule: r_adult, archived_at: DateTime.new, contract_type: c)
    active_and_uncertain_aid_1    = create(:aid, name: 'active_and_uncertain_aid_1', rule: r_adult_and_qpv, contract_type: c)
    active_and_uncertain_aid_2    = create(:aid, name: 'active_and_uncertain_aid_2', rule: r_adult_and_qpv, contract_type: c)
    inactive_and_uncertain_aid_1  = create(:aid, name: 'inactive_and_uncertain_aid_1', rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c)
    inactive_and_uncertain_aid_2  = create(:aid, name: 'inactive_and_uncertain_aid_2', rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c)
    active_and_ineligible_aid_1   = create(:aid, name: 'active_and_ineligible_aid_1', rule: r_young)
    active_and_ineligible_aid_2   = create(:aid, name: 'active_and_ineligible_aid_2', rule: r_young)
    inactive_and_ineligible_aid_1 = create(:aid, name: 'inactive_and_ineligible_aid_1', rule: r_young, archived_at: DateTime.new)
    inactive_and_ineligible_aid_2 = create(:aid, name: 'inactive_and_ineligible_aid_2', rule: r_young, archived_at: DateTime.new)

  end

  describe ".go" do

    it 'Given 6 activated aids, should not return nil' do
      # given
      # when
      result = AidtreeService.get_instance.go(the_asker)
      # then
      expect(result).not_to be nil
    end

    it 'Given 6 activated aids, should return 6 items' do
      # given
      # when
      result = AidtreeService.get_instance.go(the_asker)
      # then
      expect(result.count).to eq(6)
    end

  end

end
