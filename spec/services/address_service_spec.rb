require 'rails_helper'

describe AddressService do
  describe '.upload' do
    it 'should inject few props' do
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
      expect(asker.attributes.compact).to eq({ 
         "v_location_city" => "cit",
         "v_location_citycode" => "cityc",
         "v_location_country" => "cou",
         "v_location_label" => "lab",
         "v_location_route" => "rou",
         "v_location_state" => "sta",
         "v_location_street_number" => "street_n",
         "v_location_zipcode" => "zip"
      })
    end
  end
  describe '.reset' do
    it 'should reset all' do
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
      expect(asker.attributes.compact).not_to eq({})
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.attributes.compact).to eq({})
    end
  end
  describe '.download' do
    it 'should download' do
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
      expect(address.attributes.symbolize_keys).to eq(
        city: "cit",
        citycode: "cityc",
        country: "cou",
        label: "lab",
        route: "rou",
        state: "sta",
        street_number: "street_n",
        zipcode: "zip"
      )
    end
  end
end
