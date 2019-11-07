require "test_helper"

class HydrateAddressnTest < ActiveSupport::TestCase
  def asker_attributes_test
    {
          "v_handicap" => "non",
          "v_spectacle" => "oui",
          "v_cadre" => "non",
          "v_diplome" => "niveau_1",
          "v_category" => nil,
          "v_duree_d_inscription" => "non_inscrit",
          "v_allocation_value_min" => "43",
          "v_allocation_type" => "ASS_AER_APS_AS-FNE",
          "v_qpv" => nil,
          "v_zrr" => nil,
          "v_age" => "54",
          "v_location_label" => nil,
          "v_location_route" => nil,
          "v_location_city" => nil,
          "v_location_country" => nil,
          "v_location_zipcode" => nil,
          "v_location_citycode" => "44047",
          "v_location_street_number" => nil,
          "v_location_state" => nil,
        }
  end

  test ".call should return an Asker instance" do
    #given
    asker_attributes_hash = self.asker_attributes_test
    #when
    result = HydrateAddress.new.call(asker_attributes_hash)
    #then
    assert_instance_of(Asker, result)
  end
  test ".call should raise an error if asker_attributes are not valid" do
    #given
    asker_attributes_hash = {
      "unknown_key" => nil,
      "unknown_key_2" => 42,
      "unknown_key_3" => "unknown_value",
    }
    #when
    result = HydrateAddress.new
    #then
    assert_raises("Arguments must be attributes of an Asker") { result.call(asker_attributes_hash) }
  end
end
