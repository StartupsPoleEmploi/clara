require 'rails_helper'
require 'database_cleaner'

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

  before(:all) do
    the_asker = Asker.new(v_age: '42', v_qpv: 'indisponible')

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean

    r_adult = create(:rule, :be_an_adult, name: "r_adult")
    r_adult_and_qpv = create(:rule, :be_an_adult_and_in_qpv, name: "r_adult_and_qpv")
    r_young = create(:rule, :not_be_an_adult, name: "r_young")
    c_contract_type = create(:contract_type, :contract_type_1, name: "c_contract_type")

    active_and_eligible_aid_1     = create(:aid, name: 'active_and_eligible_aid_1', rule: r_adult, contract_type: c_contract_type)
    active_and_eligible_aid_2     = create(:aid, name: 'active_and_eligible_aid_2' , rule: r_adult, contract_type: c_contract_type)
    inactive_and_eligible_aid_1   = create(:aid, name: 'inactive_and_eligible_aid_1' , rule: r_adult, archived_at: DateTime.new, contract_type: c_contract_type)
    inactive_and_eligible_aid_2   = create(:aid, name: 'inactive_and_eligible_aid_2' , rule: r_adult, archived_at: DateTime.new, contract_type: c_contract_type)
    active_and_uncertain_aid_1    = create(:aid, name: 'active_and_uncertain_aid_1' , rule: r_adult_and_qpv, contract_type: c_contract_type)
    active_and_uncertain_aid_2    = create(:aid, name: 'active_and_uncertain_aid_2' , rule: r_adult_and_qpv, contract_type: c_contract_type)
    inactive_and_uncertain_aid_1  = create(:aid, name: 'inactive_and_uncertain_aid_1' , rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c_contract_type)
    inactive_and_uncertain_aid_2  = create(:aid, name: 'inactive_and_uncertain_aid_2' , rule: r_adult_and_qpv, archived_at: DateTime.new, contract_type: c_contract_type)
    active_and_ineligible_aid_1   = create(:aid, name: 'active_and_ineligible_aid_1' , rule: r_young)
    active_and_ineligible_aid_2   = create(:aid, name: 'active_and_ineligible_aid_2' , rule: r_young)
    inactive_and_ineligible_aid_1 = create(:aid, name: 'inactive_and_ineligible_aid_1' , rule: r_young, archived_at: DateTime.new)
    inactive_and_ineligible_aid_2 = create(:aid, name: 'inactive_and_ineligible_aid_2' , rule: r_young, archived_at: DateTime.new)

  end

  before do
    disable_cache_service
  end
  after do
    enable_cache_service
  end
  describe "Instantiation" do

    it 'Calcul must occur on instantiation' do
      # given
      # when
      sut = AidCalculationService.get_instance(the_asker)
      # then
      expect(sut._all_aids.all? { |a| !a["eligibility"].blank? }).to eq true
    end
    it '.all_eligible' do
      # given
      service = AidCalculationService.get_instance(the_asker)
      # when
      sut = service.all_eligible
      # then
      ordered_sut = sut.sort_by { |h| h["name"] }
      realistic_all_eligible = modify_array(realistic_all_eligible_result)
      realistic_ordered_sut  = modify_array(ordered_sut)
      expect(realistic_ordered_sut).to eq realistic_all_eligible
    end
    it '.all_uncertain' do
      # given
      service = AidCalculationService.get_instance(the_asker)
      # when
      sut = service.all_uncertain
      # then
      ordered_sut = sut.sort_by { |h| h["name"] }
      realistic_all_uncertain = modify_array(realistic_all_uncertain_result)
      realistic_ordered_sut  = modify_array(ordered_sut)
      expect(realistic_ordered_sut).to eq realistic_all_uncertain
    end
    it '.all_ineligible' do
      # given
      service = AidCalculationService.get_instance(the_asker)
      # when
      sut = service.all_ineligible
      # then
      ordered_sut = sut.sort_by { |h| h["name"] }
      realistic_all_ineligible = modify_array(realistic_all_ineligible_result)
      realistic_ordered_sut  = modify_array(ordered_sut)
      expect(realistic_ordered_sut).to eq realistic_all_ineligible
    end
  end

  def modify_array(the_array) # modify all hashes so that test remains consistent
    the_array.map { |e| modify_hash(e)  }
  end

  def modify_hash(the_hash) # modify some value so that test remains consistent
    the_hash["id"] = "EXISTING" if the_hash["id"]
    the_hash["rule_id"] = "EXISTING" if the_hash["rule_id"]
    the_hash["created_at"] = "EXISTING" if the_hash["created_at"]
    the_hash["updated_at"] = "EXISTING" if the_hash["updated_at"]
    the_hash["contract_type_id"] = "EXISTING" if the_hash["contract_type_id"]
    the_hash["contract_type"]["created_at"] = "EXISTING" if the_hash["contract_type"] && the_hash["contract_type"]["created_at"]
    the_hash["contract_type"]["updated_at"] = "EXISTING" if the_hash["contract_type"] && the_hash["contract_type"]["updated_at"]
    the_hash["contract_type"]["id"] = "EXISTING" if the_hash["contract_type"] && the_hash["contract_type"]["id"]
  end


  def realistic_all_eligible_result
     [{"id"=>1,
       "name"=>"active_and_eligible_aid_1",
       "what"=>nil,
       "created_at"=>"2018-05-24T12:44:22.696Z",
       "updated_at"=>"2018-05-24T12:44:22.696Z",
       "slug"=>"active_and_eligible_aid_1",
       "short_description"=>nil,
       "how_much"=>nil,
       "additionnal_conditions"=>nil,
       "how_and_when"=>nil,
       "limitations"=>nil,
       "rule_id"=>1,
       "ordre_affichage"=>0,
       "contract_type_id"=>1,
       "archived_at"=>nil,
       "last_update"=>nil,
       "contract_type"=>
        {"id"=>1,
         "name"=>"c_contract_type",
         "description"=>"d1",
         "created_at"=>"2018-05-24T12:44:22.669Z",
         "updated_at"=>"2018-05-24T12:44:22.669Z",
         "ordre_affichage"=>0,
         "icon"=>nil,
         "slug"=>"c_contract_type",
         "category"=>"aide",
         "business_id"=>"b1"},
       "eligibility"=>"eligible",
       "contract_type_order"=>0,
       "contract_type_business_id"=>"b1",
       "contract_type_icon"=>nil,
       "contract_type_description"=>"d1"},

      {"id"=>2,
       "name"=>"active_and_eligible_aid_2",
       "what"=>nil,
       "created_at"=>"2018-05-24T12:44:22.705Z",
       "updated_at"=>"2018-05-24T12:44:22.705Z",
       "slug"=>"active_and_eligible_aid_2",
       "short_description"=>nil,
       "how_much"=>nil,
       "additionnal_conditions"=>nil,
       "how_and_when"=>nil,
       "limitations"=>nil,
       "rule_id"=>1,
       "ordre_affichage"=>0,
       "contract_type_id"=>1,
       "archived_at"=>nil,
       "last_update"=>nil,
       "contract_type"=>
        {"id"=>1,
         "name"=>"c_contract_type",
         "description"=>"d1",
         "created_at"=>"2018-05-24T12:44:22.669Z",
         "updated_at"=>"2018-05-24T12:44:22.669Z",
         "ordre_affichage"=>0,
         "icon"=>nil,
         "slug"=>"c_contract_type",
         "category"=>"aide",
         "business_id"=>"b1"},
       "eligibility"=>"eligible",
       "contract_type_order"=>0,
       "contract_type_business_id"=>"b1",
       "contract_type_icon"=>nil,
       "contract_type_description"=>"d1"}]
  end

  def realistic_all_uncertain_result
    [{"id"=>5,
       "name"=>"active_and_uncertain_aid_1",
       "what"=>nil,
       "created_at"=>"2018-05-24T12:54:09.107Z",
       "updated_at"=>"2018-05-24T12:54:09.107Z",
       "slug"=>"active_and_uncertain_aid_1",
       "short_description"=>nil,
       "how_much"=>nil,
       "additionnal_conditions"=>nil,
       "how_and_when"=>nil,
       "limitations"=>nil,
       "rule_id"=>4,
       "ordre_affichage"=>0,
       "contract_type_id"=>1,
       "archived_at"=>nil,
       "last_update"=>nil,
       "contract_type"=>
        {"id"=>1,
         "name"=>"c_contract_type",
         "description"=>"d1",
         "created_at"=>"2018-05-24T12:54:09.045Z",
         "updated_at"=>"2018-05-24T12:54:09.045Z",
         "ordre_affichage"=>0,
         "icon"=>nil,
         "slug"=>"c_contract_type",
         "category"=>"aide",
         "business_id"=>"b1"},
       "eligibility"=>"uncertain",
       "contract_type_order"=>0,
       "contract_type_business_id"=>"b1",
       "contract_type_icon"=>nil,
       "contract_type_description"=>"d1"},
      
      {"id"=>6,
       "name"=>"active_and_uncertain_aid_2",
       "what"=>nil,
       "created_at"=>"2018-05-24T12:54:09.115Z",
       "updated_at"=>"2018-05-24T12:54:09.115Z",
       "slug"=>"active_and_uncertain_aid_2",
       "short_description"=>nil,
       "how_much"=>nil,
       "additionnal_conditions"=>nil,
       "how_and_when"=>nil,
       "limitations"=>nil,
       "rule_id"=>4,
       "ordre_affichage"=>0,
       "contract_type_id"=>1,
       "archived_at"=>nil,
       "last_update"=>nil,
       "contract_type"=>
        {"id"=>1,
         "name"=>"c_contract_type",
         "description"=>"d1",
         "created_at"=>"2018-05-24T12:54:09.045Z",
         "updated_at"=>"2018-05-24T12:54:09.045Z",
         "ordre_affichage"=>0,
         "icon"=>nil,
         "slug"=>"c_contract_type",
         "category"=>"aide",
         "business_id"=>"b1"},
       "eligibility"=>"uncertain",
       "contract_type_order"=>0,
       "contract_type_business_id"=>"b1",
       "contract_type_icon"=>nil,
       "contract_type_description"=>"d1"}]
  end

  def realistic_all_ineligible_result
      [{"id"=>9,
       "name"=>"active_and_ineligible_aid_1",
       "what"=>nil,
       "created_at"=>"2018-05-24T12:57:09.990Z",
       "updated_at"=>"2018-05-24T12:57:09.990Z",
       "slug"=>"active_and_ineligible_aid_1",
       "short_description"=>nil,
       "how_much"=>nil,
       "additionnal_conditions"=>nil,
       "how_and_when"=>nil,
       "limitations"=>nil,
       "rule_id"=>5,
       "ordre_affichage"=>0,
       "contract_type_id"=>nil,
       "archived_at"=>nil,
       "last_update"=>nil,
       "eligibility"=>"ineligible",
       "contract_type_order"=>99999},
      
      {"id"=>10,
       "name"=>"active_and_ineligible_aid_2",
       "what"=>nil,
       "created_at"=>"2018-05-24T12:57:09.997Z",
       "updated_at"=>"2018-05-24T12:57:09.997Z",
       "slug"=>"active_and_ineligible_aid_2",
       "short_description"=>nil,
       "how_much"=>nil,
       "additionnal_conditions"=>nil,
       "how_and_when"=>nil,
       "limitations"=>nil,
       "rule_id"=>5,
       "ordre_affichage"=>0,
       "contract_type_id"=>nil,
       "archived_at"=>nil,
       "last_update"=>nil,
       "eligibility"=>"ineligible",
       "contract_type_order"=>99999}]
  end

end
