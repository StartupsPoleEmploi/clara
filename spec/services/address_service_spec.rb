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
    it 'Returns label from given asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_label = "label"
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.label).to eq("label")
    end
    it 'Returns route from given asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_route = "route"
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.route).to eq("route")
    end
    it 'Returns address_type from given asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_city = "city"
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.city).to eq("city")
    end
    it 'Returns country from given asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_country = "country"
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.country).to eq("country")
    end
    it 'Returns zipcode from given asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_zipcode = "zipcode"
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.zipcode).to eq("zipcode")
    end
    it 'Returns citycode from given asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_citycode = "citycode"
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.citycode).to eq("citycode")
    end
    it 'Returns street_number from given asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_street_number = "street_number"
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.street_number).to eq("street_number")
    end
    it 'Returns state from given asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      asker.v_location_state = "state"
      #when
      AddressService.new.download(address, asker)
      #then
      expect(address.state).to eq("state")
    end

  describe '.reset' do
    it 'Returns nil for v_location_label asker' do
      #given
      asker = Asker.new
      asker.v_location_label = "label"
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.v_location_label).to eq(nil)
    end
    it 'Returns nil for v_location_route asker' do
      #given
      asker = Asker.new
      asker.v_location_route = "route"
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.v_location_route).to eq(nil)
    end
    it 'Returns nil for v_location_city asker' do
      #given
      asker = Asker.new
      asker.v_location_city = "city"
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.v_location_city).to eq(nil)
    end
    it 'Returns nil for v_location_country asker' do
      #given
      asker = Asker.new
      asker.v_location_country = "country"
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.v_location_country).to eq(nil)
    end
    it 'Returns nil for v_location_zipcode asker' do
      #given
      asker = Asker.new
      asker.v_location_zipcode = "zipcode"
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.v_location_zipcode).to eq(nil)
    end
    it 'Returns nil for v_location_citycode asker' do
      #given
      asker = Asker.new
      asker.v_location_citycode = "citycode"
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.v_location_citycode).to eq(nil)
    end
    it 'Returns nil for v_location_street_number asker' do
      #given
      asker = Asker.new
      asker.v_location_street_number = "street_number"
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.v_location_street_number).to eq(nil)
    end
    it 'Returns nil for v_location_state asker' do
      #given
      asker = Asker.new
      asker.v_location_state = "state"
      #when
      AddressService.new.reset(asker)
      #then
      expect(asker.v_location_state).to eq(nil)
    end
  end

  end

end
