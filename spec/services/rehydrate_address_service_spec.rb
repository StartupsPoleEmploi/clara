require 'rails_helper'

describe RehydrateAddressService do

  describe 'Nominal' do
    it 'Returs empty asker if arg is wrong' do
      output = RehydrateAddressService.new.from_citycode!(Date.new)
      expect(output).to eq(Asker.new)
    end
    it 'Rehydrate address from citycode' do
      output = RehydrateAddressService.new.from_citycode!(Asker.new(v_location_citycode: "59035"))
      expect(output).to eq(Asker.new(v_location_citycode: "59035"))
    end
  end

end
