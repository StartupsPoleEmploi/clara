require "test_helper"

class SerializeResultsServiceApiEligibleTest < ActiveSupport::TestCase
  
  test '_.api_eligible' do
    #given
    #when
    res = SerializeResultsService.get_instance.api_eligible(asker, filters, need_filters, custom_filters, custom_parent_filters)
    #then
    assert_equal([], res)
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

end
