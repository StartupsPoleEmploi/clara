require 'rails_helper'

describe AidCalculationService do


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
  cache_layer = nil

  before(:all) do
    the_asker = Asker.new(v_age: '42', v_qpv: 'indisponible')

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean

    r_adult = create(:rule, :be_an_adult, name: "r_adult")
    r_adult_and_qpv = create(:rule, :be_an_adult_and_in_qpv, name: "r_adult_and_qpv")
    r_young = create(:rule, :not_be_an_adult, name: "r_young")
    c_contract_type = create(:contract_type, :contract_type_1, name: "c_contract_type")

    active_and_eligible_aid_1     = create(:aid, name: 'active_and_eligible_aid_1', rule: r_adult, contract_type: c_contract_type)
    active_and_eligible_aid_2     = create(:aid, name: 'active_and_eligible_aid_2', rule: r_adult, contract_type: c_contract_type)
    inactive_and_eligible_aid_1   = create(:aid, name: 'inactive_and_eligible_aid_1', rule: r_adult, archived_at: DateTime.new, contract_type: c_contract_type)
    inactive_and_eligible_aid_2   = create(:aid, name: 'inactive_and_eligible_aid_2', rule: r_adult, archived_at: DateTime.new, contract_type: c_contract_type)
    active_and_uncertain_aid_1    = create(:aid, name: 'active_and_uncertain_aid_1', rule: r_adult_and_qpv, contract_type: c_contract_type)
    active_and_uncertain_aid_2    = create(:aid, name: 'active_and_uncertain_aid_2', rule: r_adult_and_qpv, contract_type: c_contract_type)
    inactive_and_uncertain_aid_1  = create(:aid, name: 'inactive_and_uncertain_aid_1', rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c_contract_type)
    inactive_and_uncertain_aid_2  = create(:aid, name: 'inactive_and_uncertain_aid_2', rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c_contract_type)
    active_and_ineligible_aid_1   = create(:aid, name: 'active_and_ineligible_aid_1', rule: r_young)
    active_and_ineligible_aid_2   = create(:aid, name: 'active_and_ineligible_aid_2', rule: r_young)
    inactive_and_ineligible_aid_1 = create(:aid, name: 'inactive_and_ineligible_aid_1', rule: r_young, archived_at: DateTime.new)
    inactive_and_ineligible_aid_2 = create(:aid, name: 'inactive_and_ineligible_aid_2', rule: r_young, archived_at: DateTime.new)

  end
  describe "Instantiation" do
    it "Calcul must occur on instantiation" do
      #given
      #when
      sut = AidCalculationService.get_instance(the_asker)
      #then
      expect(sut._all_aids).to eq("blabla")
    end
  end

end
