require 'rails_helper'

describe AddressService do

  describe '.upload' do
    it 'should inject address_type into asker' do
      #given
      asker = Asker.new
      address = AddressForm.new
      address.label = 'location_label' 
      #when
      AddressService.new.upload(address, asker)
      #then
      expect(asker.v_location_label).to eq("location_label")
    end
  end

#  describe '.download' do
#    it 'Returns address_type from given asker' do
#
#    end
#  end

end
