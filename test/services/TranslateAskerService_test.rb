require "test_helper"

class TranslateAskerServiceTest < ActiveSupport::TestCase
  
  test ".to_french" do
    #given
    #when
    res = TranslateAskerService.new.to_french(realistic_api_asker)
    #then
    assert_equal(true, res.is_a?(Asker))
    assert_equal("33", res.v_age)
    assert_equal("ARE_ASP", res.v_allocation_type)
    assert_equal("434", res.v_allocation_value_min)
    assert_equal("non", res.v_cadre)
    assert_equal("cat_12345", res.v_category)
    assert_equal("niveau_4", res.v_diplome)
    assert_equal("moins_d_un_an", res.v_duree_d_inscription)
    assert_equal("oui", res.v_handicap)
    assert_equal("02004", res.v_location_citycode)
    assert_equal("oui", res.v_spectacle)
    assert_nil(res.v_zrr)
  end

  def realistic_api_asker
    ApiAsker.new(v_age: "33",
                  v_allocation_type: "ARE_ASP",
                  v_allocation_value_min: "434",
                  v_cadre: "false",
                  v_category: "categories_12345",
                  v_diplome: "level_4",
                  v_duree_d_inscription: "less_than_a_year",
                  v_handicap: "true",
                  v_location_city: nil,
                  v_location_citycode: "02004",
                  v_location_country: nil,
                  v_location_label: nil,
                  v_location_route: nil,
                  v_location_state: nil,
                  v_location_street_number: nil,
                  v_location_zipcode: nil,
                  v_qpv: nil,
                  v_spectacle: "true",
                  v_zrr: nil)
  end

end
