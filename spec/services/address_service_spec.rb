require 'rails_helper'

describe AddressService do

  describe '.upload' do
    it 'Should inject an address into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.label = 'myLabel'
      address.route = 'myRoute'
      address.city = 'myCity'
      address.zipcode = 'myZipCode'
      address.citycode = 'myCityCode'
      address.street_number = 'myStreetNumber'
      address.state = 'myState'
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

  describe '.download' do
    it 'Should received an address from an asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_label = 'myLabel'
      asker.v_location_route = 'myRoute'
      asker.v_location_city = 'myCity'
      asker.v_location_zipcode = 'myZipCode'
      asker.v_location_citycode = 'myCityCode'
      asker.v_location_street_number = 'myStreetNumber'
      asker.v_location_state = 'myState'
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.label).to eq('myLabel')
      expect(address.route).to eq('myRoute')
      expect(address.city).to eq('myCity')
      expect(address.zipcode).to eq('myZipCode')
      expect(address.citycode).to eq('myCityCode')
      expect(address.street_number).to eq('myStreetNumber')
      expect(address.state).to eq('myState')
    end
  end

  describe '.reset' do
    it 'Should reset the asker' do
      #given
      #when
      #then
      expect(asker.v_location_label).to eq(nil)
      expect(asker.v_location_route).to eq(nil)
      expect(asker.v_location_city).to eq(nil)
      expect(asker.v_location_zipcode).to eq(nil)
      expect(asker.v_location_citycode).to eq(nil)
      expect(asker.v_location_street_number).to eq(nil)
      expect(asker.v_location_state).to eq(nil)
    end
  end

end

