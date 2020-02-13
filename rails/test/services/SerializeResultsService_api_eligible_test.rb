require "test_helper"

class SerializeResultsServiceApiEligibleTest < ActiveSupport::TestCase
  
  def setup
    allow(JsonModelsService).to receive(:filters).and_return(filters)
    allow(JsonModelsService).to receive(:rules).and_return(rules)
    allow(JsonModelsService).to receive(:aids).and_return(aids)
    allow(JsonModelsService).to receive(:contracts).and_return(contracts)
    allow(JsonModelsService).to receive(:variables).and_return(variables)
  end

  test '_.api_eligible, yes' do
    #given
    above_18_asker = asker_without_age
    above_18_asker.v_age = "38"
    #when
    res = SerializeResultsService.get_instance.api_eligible(above_18_asker, filters)
    #then
    assert_equal([vsi], res)
  end
  test '_.api_eligible, no' do
    #given
    #when
    res = SerializeResultsService.get_instance.api_eligible(asker_without_age, filters)
    #then
    assert_equal([], res)
  end
  test '_.api_ineligible, yes' do
    #given
    under_18_asker = asker_without_age
    under_18_asker.v_age = "16"
    #when
    res = SerializeResultsService.get_instance.api_ineligible(under_18_asker, filters)
    #then
    assert_equal([vsi], res)
  end
  test '_.api_ineligible, no' do
    #given
    #when
    res = SerializeResultsService.get_instance.api_ineligible(asker_without_age, filters)
    #then
    assert_equal([], res)
  end
  test '_.api_uncertain, yes' do
    #given
    #when
    res = SerializeResultsService.get_instance.api_uncertain(asker_without_age, filters)
    #then
    assert_equal([vsi], res)
  end
  test '_.api_uncertain, no' do
    #given
    above_18_asker = asker_without_age
    above_18_asker.v_age = "38"
    #when
    res = SerializeResultsService.get_instance.api_uncertain(above_18_asker, filters)
    #then
    assert_equal([], res)
  end

  def vsi
    {"name"=>"Volontariat de solidarité internationale (VSI)", "slug"=>"vsi-volontariat-de-solidarite-internationale", "short_description"=>"Missions effectuées en dehors de l'espace économique européen et au sein d'associations agréées", "filters"=>[{"slug"=>"travailler-a-l-international", "id"=>7}], "contract_type"=>"emploi-international"}
  end

  def filters
    "travailler-a-l-international"
  end

  def asker_without_age
    Asker.new({
      v_allocation_type: "ARE_ASP", 
      v_allocation_value_min: "434", 
      v_cadre: "non", 
      v_category: "cat_12345", 
      v_diplome: "niveau_4", 
      v_duree_d_inscription: "moins_d_un_an", 
      v_handicap: "oui", 
      v_location_city: nil, 
      v_location_citycode: "02004", 
      v_location_country: nil, 
      v_location_label: nil, 
      v_location_route: nil, 
      v_location_state: nil, 
      v_location_street_number: nil, 
      v_location_zipcode: nil, 
      v_qpv: nil, 
      v_spectacle: "oui", 
      v_zrr: "oui"
    })
  end

  def filters
    [
      {"id" => 7,"slug" => "travailler-a-l-international", "ordre_affichage" => 2},
      {"id" => 3,"slug" => "garder-enfant","ordre_affichage" => 3} 
    ]
  end

  def rules
    [{
      "id" => 61,
      "name" => "r_age_sup_18",
      "value_eligible" => "17",
      "variable_id" => 1,
      "operator_kind" => "more_than",
      "slave_rules" => []
    }]
  end

  def contracts
    [{
      "id" => 3,
      "name" => "Emploi international",
      "slug" => "emploi-international"
    }]
  end

  def aids
    [{
      "id" => 34,
      "name" => "Volontariat de solidarité internationale (VSI)",
      "slug" => "vsi-volontariat-de-solidarite-internationale",
      "short_description" => "Missions effectuées en dehors de l'espace économique européen et au sein d'associations agréées",
      "rule_id" => 61,
      "ordre_affichage" => 64,
      "contract_type_id" => 3,
      "filters" => [
        {"slug" => "travailler-a-l-international", "id" => 7}
      ],
    }]
  end

  def variables
    [{
      "id" => 1,
      "name" => "v_age",
      "description" => "",
      "elements" => "",
      "name_translation" => "âge",
      "elements_translation" => "",
      "variable_kind" => "integer"
    }]
  end

end
