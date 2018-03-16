require 'rails_helper'

describe RehydrateAddressService do

  describe 'Everything works as expected' do
    qpv_layer = nil
    zrr_layer = nil
    ban_layer = nil
    sut = nil
    before do
        #given
        ban_layer = instance_double("BanService")
        allow(ban_layer).to receive(:get_zipcode_and_cityname).and_return(["59440", "Avesnelles"])
        BanService.set_instance(ban_layer)

        qpv_layer = instance_double("QpvService")
        allow(qpv_layer).to receive(:setDetailedQPV).and_return(true)
        allow(qpv_layer).to receive(:isDetailedQPV).and_return("en_qpv")
        QpvService.set_instance(qpv_layer)

        zrr_layer = instance_double("ZrrService")
        allow(zrr_layer).to receive(:isZRR).with("59035").and_return("en_zrr")
        ZrrService.set_instance(zrr_layer)

        #when
        sut = RehydrateAddressService.get_instance.from_citycode!(Asker.new(v_location_street_number: "9 BIS", v_location_route: "Avenue des champs", v_location_citycode: "59035"))

    end
    after do
        BanService.set_instance(nil)     
        QpvService.set_instance(nil)
        ZrrService.set_instance(nil)
    end
    it 'Must ask for BAN get_zipcode_and_cityname' do
      expect(ban_layer).to have_received(:get_zipcode_and_cityname).with("59035").once
    end
    it 'Must hydrate v_location_zipcode and v_location_city' do
      expect(sut.v_location_zipcode).to eq("59440")
      expect(sut.v_location_city).to eq("Avesnelles")
    end
    it 'Must ask for QPV .setDetailedQPV' do
      expect(qpv_layer).to have_received(:setDetailedQPV).with("9 BIS", "Avenue des champs", "59440", "Avesnelles").once
    end
    it 'Must ask for QPV .isDetailedQPV' do
      expect(qpv_layer).to have_received(:isDetailedQPV).with("9 BIS", "Avenue des champs", "59440", "Avesnelles").once
    end
    it 'Must hydrate v_qpv' do
      expect(sut.v_qpv).to eq("en_qpv")
    end
    it 'Must ask for ZRR .isZRR' do
      expect(zrr_layer).to have_received(:isZRR).with("59035").once
    end
    it 'Must hydrate v_zrr' do
      expect(sut.v_zrr).to eq("en_zrr")
    end
  end

end
