require "test_helper"

class TranslateAskerServiceTest < ActiveSupport::TestCase
  
  test ".to_french" do
    #given
    #when
    res = TranslateAskerService.new.to_french(realistic_api_asker)
    #then
    assert_equal(true, res.is_a?(Asker))
    assert_equal("33", res.v_age)
    assert_equal("RPS_RFPA_RFF_pensionretraite", res.v_allocation_type)
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

  test ".from_french" do
    #given
    #when
    res = TranslateAskerService.new.from_french(realistic_asker)
    #then
    assert_equal(true, res.is_a?(Hash))
    assert_equal("33", res[:age])
    assert_equal("RPS_RFPA_RFF_PENSION", res[:allocation_type])
    assert_equal("434", res[:monthly_allocation_value])
    assert_equal("false", res[:executive])
    assert_equal("categories_12345", res[:category])
    assert_equal("level_4", res[:diploma])
    assert_equal("less_than_a_year", res[:inscription_period])
    assert_equal("true", res[:disabled])
    assert_equal("02004", res[:location_citycode])
    assert_equal("true", res[:spectacle])
  end

  def realistic_api_asker
    ApiAsker.new(v_age: "33",
                  v_allocation_type: "RPS_RFPA_RFF_PENSION",
                  v_allocation_value_min: "434",
                  v_cadre: "false",
                  v_category: "categories_12345",
                  v_diplome: "level_4",
                  v_duree_d_inscription: "less_than_a_year",
                  v_handicap: "true",
                  v_location_city: nil,
                  v_location_citycode: "02004",
                  v_spectacle: "true",
                )
  end

  def realistic_asker
    Asker.new({
                  "v_handicap" => "oui",
                 "v_spectacle" => "oui",
                     "v_cadre" => "non",
                   "v_diplome" => "niveau_4",
                  "v_category" => "cat_12345",
       "v_duree_d_inscription" => "moins_d_un_an",
      "v_allocation_value_min" => "434",
           "v_allocation_type" => "RPS_RFPA_RFF_pensionretraite",
                       "v_zrr" => "oui",
                       "v_age" => "33",
         "v_location_citycode" => "02004",
    })
  end

end
