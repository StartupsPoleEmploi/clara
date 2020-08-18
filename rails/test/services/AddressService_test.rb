require "test_helper"

class AddressServiceTest < ActiveSupport::TestCase

  test ".upload should inject few props" do
    #given
    asker = Asker.new
    address = AddressForm.new(
      label: "lab", 
      route: "rou", 
      city: "cit", 
      country: "cou", 
      zipcode: "zip", 
      citycode: "cityc", 
      street_number: "street_n", 
      state: "sta")
    #when
    AddressService.new.upload(address, asker)
    #then
    assert_equal({ 
       "v_location_city" => "cit",
       "v_location_citycode" => "cityc",
       "v_location_country" => "cou",
       "v_location_label" => "lab",
       "v_location_route" => "rou",
       "v_location_state" => "sta",
       "v_location_street_number" => "street_n",
       "v_location_zipcode" => "zip"
    },
    asker.attributes.compact)
  end

  test '.reset should reset all' do
    #given
    asker = Asker.new(
      "v_location_city" => "cit",
      "v_location_citycode" => "cityc",
      "v_location_country" => "cou",
      "v_location_label" => "lab",
      "v_location_route" => "rou",
      "v_location_state" => "sta",
      "v_location_street_number" => "street_n",
      "v_location_zipcode" => "zip"
    )
    assert_not_equal({}, asker.attributes.compact)
    #when
    AddressService.new.reset(asker)
    #then
    assert_equal({}, asker.attributes.compact)
  end

  test '.download should download' do
    #given
    asker = Asker.new
    address = AddressForm.new
    asker = Asker.new(
      v_location_city: "cit",
      v_location_citycode: "cityc",
      v_location_country: "cou",
      v_location_label: "lab",
      v_location_route: "rou",
      v_location_state: "sta",
      v_location_street_number: "street_n",
      v_location_zipcode: "zip"
    )
    #when
    AddressService.new.download(address, asker)
    #then
    assert_equal({
      city: "cit",
      citycode: "cityc",
      country: "cou",
      label: "lab",
      route: "rou",
      state: "sta",
      street_number: "street_n",
      zipcode: "zip"
    }, 
    address.attributes.symbolize_keys
    )
  end

end
