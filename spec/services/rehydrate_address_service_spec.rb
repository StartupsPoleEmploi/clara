require 'rails_helper'

describe RehydrateAddressService do

  describe 'Nominal' do
    it 'Returs empty asker if arg is wrong' do
      output = RehydrateAddressService.new.from_citycode!(Date.new)
      expect(output).to eq(Asker.new)
    end
    describe 'Rehydrate address from citycode' do
      before do
        ban_layer = instance_double("BanService")
        allow(ban_layer).to receive(:get_zipcode_and_cityname).and_return(["59440", "Avesnelles"])
        BanService.set_instance(ban_layer)
      end      
      after do
        BanService.set_instance(nil)     
      end      
      it 'Nominal' do
        output = RehydrateAddressService.new.from_citycode!(Asker.new(v_location_citycode: "59035"))
        expect(output).to eq(Asker.new(v_location_citycode: "59035", v_location_city:"Avesnelles", v_location_zipcode: "59440"))
      end
    end
  end

end
