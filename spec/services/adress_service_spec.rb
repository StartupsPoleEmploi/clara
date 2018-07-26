require 'rails_helper'

describe AddressService do
  describe '.upload' do
    it 'should inject an adress into asker' do
      #given
      #when
      #then
      expect(asker.v_location_label).to eq('')
      expect(asker.v_location_route).to eq('')
      expect(asker.v_location_city).to eq('')
      expect(asker.v_location_zipcode).to eq('')
      expect(asker.v_location_citycode).to eq('')
      expect(asker.v_location_street_number).to eq('')
      expect(asker.v_location_state).to eq('')
    end
  end

end

