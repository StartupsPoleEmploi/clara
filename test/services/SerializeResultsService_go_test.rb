require "test_helper"

class SerializeResultsServiceGoTest < ActiveSupport::TestCase
  
  test '_.go' do
    #given
    allow(AidCalculationService).to receive(:get_instance).and_return(calculator)
    allow(ContractType).to receive(:all).and_return([{"contract_types":42}])
    allow(Filter).to receive(:all).and_return([{"id":42}])
    #when
    res = SerializeResultsService.get_instance.go(asker)
    #then
    assert_equal(
      {:flat_all_eligible=>"every_eligible", 
        :flat_all_uncertain=>"every_uncertain", 
        :flat_all_ineligible=>"every_ineligible", 
        :flat_all_contract=>[{"contract_types"=>42}], 
        :flat_all_filter=>[{"id"=> 42}], 
        :asker=>{"v_handicap"=>"oui", "v_spectacle"=>"oui", "v_cadre"=>"non", "v_diplome"=>"niveau_4", "v_category"=>"cat_12345", "v_duree_d_inscription"=>"moins_d_un_an", "v_allocation_value_min"=>"434", "v_allocation_type"=>"RPS_RFPA_RFF_pensionretraite", "v_qpv"=>nil, "v_zrr"=>"oui", "v_age"=>"33", "v_location_label"=>nil, "v_location_route"=>nil, "v_location_city"=>nil, "v_location_country"=>nil, "v_location_zipcode"=>nil, "v_location_citycode"=>"02004", "v_location_street_number"=>nil, "v_location_state"=>nil}
      }, 
      res
    )
  end

  def calculator
    OpenStruct.new(
        every_eligible: "every_eligible", 
        every_ineligible: "every_ineligible", 
        every_uncertain: "every_uncertain", 
    )
  end

  def asker
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
