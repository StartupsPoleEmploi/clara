require 'rails_helper'

describe AddressService do

  describe '.upload' do
    it 'should inject an address into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      location.label = 'myLabel'
      location.route = 'myRoute'
      location.city = 'myCity'
      location.zipcode = 'myZipCode'
      location.citycode = 'myCityCode'
      location.street_number = 'myStreetNumber'
      location.state = 'myState'
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_label).to eq('myLabel')
      expect(asker.v_location_route).to eq('myRoute')
      expect(asker.v_location_city).to eq('myCity')
      expect(asker.v_location_zipcode).to eq('myZipCode')
      expect(asker.v_location_citycode).to eq('myCityCode')
      expect(asker.v_location_street_number).to eq('myStreetNumber')
      expect(asker.v_location_state).to eq('myState')
    end
  end
end

