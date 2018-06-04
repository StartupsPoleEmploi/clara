require 'rails_helper'

describe ActivatedModelsService do

  describe 'Cache is off, various data in database' do
    before do
      the_asker = Asker.new(v_age: '42')

      f_filter_1 = create(:filter, name: "used_filter_1")
      f_filter_2 = create(:filter, name: "used_filter_2")
      f_filter_3 = create(:filter, name: "unused_filter_3")
      r_adult = create(:rule, :be_an_adult, name: "r_adult_used")
      r_young = create(:rule, :not_be_an_adult, name: "r_young_unused")
      c_contract_type_1 = create(:contract_type, :contract_type_1, name: "c_contract_type_used")
      c_contract_type_2 = create(:contract_type, :contract_type_2, name: "c_contract_type_unused")

      active_and_eligible_aid_1 = create(:aid, name: 'active_and_eligible_aid_1', rule: r_adult, contract_type: c_contract_type_1, filters:[f_filter_1, f_filter_2])
      inactive_and_eligible_aid_1   = create(:aid, name: 'inactive_and_eligible_aid_1' , rule: r_adult, archived_at: DateTime.new, contract_type: c_contract_type_1)

    end
    before do
      disable_cache_service
    end
    after do
      enable_cache_service
    end
    it 'Must return activated aids, all filters, all rules, all contracts' do
      #given
      #when
      sut = ActivatedModelsService.get_instance.read
      p '- - - - - - - - - - - - - - sut- - - - - - - - - - - - - - - -' 
      pp sut
      p ''
      #then
      expect(sut).to eq(realistic_results)
    end
  end

  def realistic_results
    {"all_activated_aids"=>
      [{"id"=>1,
        "name"=>"active_and_eligible_aid_1",
        "what"=>nil,
        "slug"=>"active_and_eligible_aid_1",
        "short_description"=>nil,
        "how_much"=>nil,
        "additionnal_conditions"=>nil,
        "how_and_when"=>nil,
        "limitations"=>nil,
        "rule_id"=>1,
        "ordre_affichage"=>0,
        "contract_type_id"=>1,
        "last_update"=>nil,
        "filters"=>
         [{"id"=>1},
          {"id"=>2}]
        }],
      "all_filters"=>
        [{"id"=>1,
          "name"=>"used_filter_1"},
         {"id"=>2,
          "name"=>"used_filter_2"},
         {"id"=>3,
          "name"=>"unused_filter_3"}],
      "all_contracts"=>
        [{"id"=>1,
          "name"=>"c_contract_type_used",
          "description"=>"d1",
          "ordre_affichage"=>0,
          "icon"=>nil,
          "slug"=>"c_contract_type_used",
          "category"=>"aide",
          "business_id"=>"b1"},
         {"id"=>2,
          "name"=>"c_contract_type_unused",
          "description"=>"d2",
          "ordre_affichage"=>0,
          "icon"=>nil,
          "slug"=>"c_contract_type_unused",
          "category"=>"dispositif",
          "business_id"=>"b2"}],
        "all_rules"=>
          [{"id"=>1,
            "name"=>"r_adult_used",
            "value_eligible"=>"18",
            "operator_type"=>"more_than",
            "composition_type"=>nil,
            "variable_id"=>1,
            "description"=>nil,
            "value_ineligible"=>nil},
           {"id"=>2,
            "name"=>"r_young_unused",
            "value_eligible"=>"18",
            "operator_type"=>"less_than",
            "composition_type"=>nil,
            "variable_id"=>2,
            "description"=>nil,
            "value_ineligible"=>nil}]
  }
  end

end
