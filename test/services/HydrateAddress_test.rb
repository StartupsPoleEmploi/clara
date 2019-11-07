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
  test ".call should return unchanged Asker instance if v_location_citycode.blank?" do
    #given
    asker_attributes_hash = self.asker_attributes_test
    asker_attributes_hash.v_location_citycode = nil
    asker_test = Asker.new(asker_attributes_hash)
    #when
    result = HydrateInscription.new.call(asker_attributes_hash)
    #then
    assert_same(asker_test, result)
  end
  test ".call should return unchanged Asker instance if v_location_zipcode.present?" do
    #given
    asker_attributes_hash = self.asker_attributes_test
    asker_attributes_hash.v_location_zipcode = 25454
    asker_test = Asker.new(asker_attributes_hash)
    #when
    result = HydrateInscription.new.call(asker_attributes_hash)
    #then
    assert_same(asker_test, result)
  end
  test ".call should return Asker instance with new v_zrr value " do
    #given
    asker_attributes_hash = self.asker_attributes_test
    zrr_test = IsZrr.new.call(asker_attributes_hash.v_location_citycode)
    #when
    result = HydrateInscription.new.call(asker_attributes_hash)
    #then
    assert_equal(zrr_test, result.v_location_citycode)
  end
end
