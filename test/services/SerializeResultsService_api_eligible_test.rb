require "test_helper"

class SerializeResultsServiceApiEligibleTest < ActiveSupport::TestCase
  
  def setup
    allow(JsonModelsService).to receive(:custom_parent_filters).and_return(custom_parent_filters)
    allow(JsonModelsService).to receive(:custom_filters).and_return(custom_filters)
    allow(JsonModelsService).to receive(:need_filters).and_return(need_filters)
    allow(JsonModelsService).to receive(:filters).and_return(filters)
    allow(JsonModelsService).to receive(:rules).and_return(rules)
    allow(JsonModelsService).to receive(:aids).and_return(aids)
    allow(JsonModelsService).to receive(:contracts).and_return(contracts)
    allow(JsonModelsService).to receive(:variables).and_return(variables)
  end

  test '_.api_eligible, only one filter' do
    #given
    #when
    res = SerializeResultsService.get_instance.api_eligible(asker, filters, "", "", "")
    #then
    assert_equal([vsi], res)
  end

  def vsi
    {"name"=>"Volontariat de solidarité internationale (VSI)", "slug"=>"vsi-volontariat-de-solidarite-internationale", "short_description"=>"Missions effectuées en dehors de l'espace économique européen et au sein d'associations agréées", "filters"=>[{"id"=>7, "slug"=>"travailler-a-l-international"}], "custom_filters"=>[], "need_filters"=>[], "contract_type"=>"emploi-international"}
  end

  def filters
    "travailler-a-l-international"
  end

  def need_filters
    "trouver-des-pistes-de-metiers-diversifees"
  end

  def custom_filters
    "jeunes"
  end

  def custom_parent_filters
    "public"
  end

  def asker
    Asker.new({
      v_age: "33", 
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

  def need_filters
    [
      {"id" => 7, "slug" => "acceder-a-un-moyen-de-transport"},
      {"id" => 10, "slug" => "trouver-des-pistes-de-metiers-diversifees"} 
    ]
  end

  def custom_parent_filters
    [
      {"id" => 1, "slug" => "prestataire"},
      {"id" => 2,"slug" => "public"}
    ]
  end

  def custom_filters
    [
      {"id" => 1,"slug" => "pole-emploi","custom_parent_filter_id" => 1},
      {"id" => 2,"slug" => "partenaire","custom_parent_filter_id" => 1}
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
      "filters" => [{
        "id" => 7,
        "slug" => "travailler-a-l-international"
      }],
      "custom_filters" => [],
      "need_filters" => []
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
