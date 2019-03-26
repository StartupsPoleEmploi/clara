require 'rails_helper'

describe AddressService do

  describe '.upload' do
    it 'should inject location_label into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.label = 'location_label' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_label).to eq("location_label")
    end
    it 'should inject location_route into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.route = 'location_route' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_route).to eq("location_route")
    end
    it 'should inject location_city into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.city = 'location_city' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_city).to eq("location_city")
    end
    it 'should inject location_country into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.country = 'location_country' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_country).to eq("location_country")
    end
    it 'should inject location_zipcode into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.zipcode = 'location_zipcode' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_zipcode).to eq("location_zipcode")
    end
    it 'should inject location_citycode into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.citycode = 'location_citycode' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_citycode).to eq("location_citycode")
    end
    it 'should inject location_street_number into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.street_number = 'location_street_number' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_street_number).to eq("location_street_number")
    end
    it 'should inject location_state into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.state = 'location_state' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_state).to eq("location_state")
    end
  end

  describe '.download' do
    it 'Returns address_type from given asker' do
      #given
      #when
      #then
      expect(address.label).to eq("label")
    end
  end

end
