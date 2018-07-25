require 'rails_helper'

describe ActivatedModelsService do

  describe 'Cache is off' do
    before do
      the_asker = Asker.new(v_age: '42', v_qpv: 'en_qpv')

      f_filter_1 = create(:filter, name: "used_filter_1", description: "a1")
      f_filter_2 = create(:filter, name: "used_filter_2", description: "a2")
      f_filter_3 = create(:filter, name: "unused_filter_3", description: "a3")
      r_adult_and_qpv = create(:rule, :be_an_adult_and_in_qpv, name: 'r_adult_and_qpv_used')
      r_adult = create(:rule, :be_an_adult, name: "r_adult_unused")
      c_contract_type_1 = create(:contract_type, :contract_type_1, name: "c_contract_type_used")
      c_contract_type_2 = create(:contract_type, :contract_type_2, name: "c_contract_type_unused")

      active_and_eligible_aid_1 = create(:aid, name: 'active_and_eligible_aid_1', rule: r_adult_and_qpv, contract_type: c_contract_type_1, filters:[f_filter_1, f_filter_2])
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
      modified_sut = change_ids_in_hash(sut)
      #then
      expect(modified_sut).to eq(change_ids_in_hash(realistic_results))
    end
  end

  describe 'Cache is on' do
    before do
      cache_layer = instance_double("CacheService")
      allow(cache_layer).to receive(:read).and_return(any_valid_json)
      CacheService.set_instance(cache_layer)
    end
    after do
      enable_cache_service
    end
    it 'Must return data from cache' do
      #given
      #when
      sut = ActivatedModelsService.get_instance.read
      #then
      expect(sut).to eq(JSON.parse(any_valid_json))      
    end
  end

  def any_valid_json
    "{\"magic_number\":42}"
  end

  def change_ids_in_hash(h)
    if h.is_a?(Hash)
      h.each do |key, val| 
        if val.is_a?(Array)
          change_ids_in_hash(val)
        elsif key == "id" || key.end_with?("_id")
          h[key] = "ANY"
        end
      end
    elsif h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) }
      h.each { |e| change_ids_in_hash(e)  }
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
    "rule_id"=>3,
    "ordre_affichage"=>0,
    "contract_type_id"=>1,
    "last_update"=>nil,
    "filters"=>[{"id"=>1}, {"id"=>2}]}],
"all_filters"=>
  [{"id"=>1, "name"=>"used_filter_1", "slug"=>"used_filter_1", "description"=>"a1"},
   {"id"=>2, "name"=>"used_filter_2", "slug"=>"used_filter_2", "description"=>"a2"},
   {"id"=>3, "name"=>"unused_filter_3", "slug"=>"unused_filter_3", "description"=>"a3"}],
"all_contracts"=>
  [{"id"=>1,
    "name"=>"c_contract_type_used",
    "plural"=>nil,
    "description"=>"d1",
    "ordre_affichage"=>0,
    "icon"=>nil,
    "slug"=>"c_contract_type_used",
    "category"=>"aide",
    "business_id"=>"b1"},
   {"id"=>2,
    "name"=>"c_contract_type_unused",
    "plural"=>nil,
    "description"=>"d2",
    "ordre_affichage"=>0,
    "icon"=>nil,
    "slug"=>"c_contract_type_unused",
    "category"=>"dispositif",
    "business_id"=>"b2"}],
"all_rules" => [{
  "id"=>1,
  "name"=>"r_composed_be_an_adult2",
  "value_eligible"=>"18",
  "operator_type"=>"more_than",
  "composition_type"=>nil,
  "variable_id"=>1,
  "description"=>nil,
  "value_ineligible"=>nil,
  "slave_rules"=>[]}, 
{"id"=>2,
  "name"=>"r_composed_be_qpv1",
  "value_eligible"=>"en_qpv",
  "operator_type"=>"eq",
  "composition_type"=>nil,
  "variable_id"=>2,
  "description"=>nil,
  "value_ineligible"=>"hors_qpv",
  "slave_rules"=>[]}, 
{"id"=>3,
  "name"=>"r_adult_and_qpv_used",
  "value_eligible"=>nil,
  "operator_type"=>nil,
  "composition_type"=>"and_rule",
  "variable_id"=>nil,
  "description"=>nil,
  "value_ineligible"=>nil,
  "slave_rules"=>[{"id"=>1}, {"id"=>2}]}, 
{"id"=>4,
  "name"=>"r_adult_unused",
  "value_eligible"=>"18",
  "operator_type"=>"more_than",
  "composition_type"=>nil,
  "variable_id"=>3,
  "description"=>nil,
  "value_ineligible"=>nil,
  "slave_rules"=>[]}],
"all_variables"=>
  [{"id"=>1, "name"=>"v_age", "variable_type"=>"integer", "description"=>nil},
   {"id"=>2, "name"=>"v_qpv", "variable_type"=>"string", "description"=>nil},
   {"id"=>3, "name"=>"v_age", "variable_type"=>"integer", "description"=>nil}]}
  end

end
