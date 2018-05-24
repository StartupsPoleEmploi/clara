require 'rails_helper'

describe AidCalculationService do

  aidtree_layer = nil
  the_asker = Asker.new(v_age: '42', v_qpv: 'indisponible')
  possible_aidtree = [
    {"id"=>"EXISTING",
    "name"=>"active_and_eligible_aid_1",
    "what"=>"the_what",
    "created_at"=>"EXISTING",
    "updated_at"=>"EXISTING",
    "slug"=>"active_and_eligible_aid_1",
    "short_description"=>"the_short_description",
    "how_much"=>"the_how_much",
    "additionnal_conditions"=>"the_additionnal_conditions",
    "how_and_when"=>"the_how_and_when",
    "limitations"=>"the_limitations",
    "rule_id"=>"EXISTING",
    "ordre_affichage"=>0,
    "contract_type_id"=>"EXISTING",
    "archived_at"=>nil,
    "last_update"=>nil,
    "contract_type"=>
     {"id"=>"EXISTING",
      "name"=>"c_contract_type",
      "description"=>"d1",
      "created_at"=>"EXISTING",
      "updated_at"=>"EXISTING",
      "ordre_affichage"=>0,
      "icon"=>nil,
      "slug"=>"c_contract_type",
      "category"=>"aide",
      "business_id"=>"b1"}
    }
  ]

  describe "Instantiation" do
    before do
      aidtree_layer = instance_double("AidtreeService")
      allow(aidtree_layer).to receive(:go).and_return(possible_aidtree)
      AidtreeService.set_instance(aidtree_layer)
    end
    after do
      AidtreeService.set_instance(nil)
    end
    it 'Calcul must occur on instantiation' do
      sut = AidCalculationService.get_instance(the_asker)
      #then
      expect(sut._all_aids).to eq(possible_aidtree)
    end
    it 'Calcul must occur against the given asker' do
      sut = AidCalculationService.get_instance(the_asker)
      #then
      expect(aidtree_layer).to have_received(:go).with(the_asker)
    end
  end

end
