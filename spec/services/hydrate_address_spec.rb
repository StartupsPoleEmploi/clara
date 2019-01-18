require 'rails_helper'

describe HydrateAddress do

  before do
    _fake_is_zrr
    _fake_get_zip_city_region
  end
  describe ".call" do
    it "Raise an error if arg is not a asker attributes hash" do
      expect { HydrateAddress.call(asker_attributes: //) }.to raise_error(ArgumentError)
    end
    it "Do not raise an error if arg is a asker attributes hash" do
      expect { HydrateAddress.call(asker_attributes: Asker.new.attributes) }.not_to raise_error
    end
    it "Returns an asker" do
      subject = HydrateAddress.call(asker_attributes: Asker.new.attributes) 
      expect(subject.is_a?(Asker)).to eq(true)
    end
    it "Returns an asker with same attributes if citycode is not here" do
      asker = Asker.new(v_location_zipcode: "02340")
      returned_asker = HydrateAddress.call(asker_attributes: asker.attributes) 
      expect(returned_asker.is_a?(Asker)).to eq(true)
      expect(returned_asker.attributes).to eq(asker.attributes)
    end
    it "Returns an asker with same attributes if zipcode is already here" do
      asker = Asker.new(v_location_citycode: "02004", v_location_zipcode: "02340")
      returned_asker = HydrateAddress.call(asker_attributes: asker.attributes) 
      expect(returned_asker.is_a?(Asker)).to eq(true)
      expect(returned_asker.attributes).to eq(asker.attributes)
    end
    it "Returns an asker with fulfilled geo attributes if citycode is here, but not zipcode" do
      asker = Asker.new(v_location_citycode: "02004")
      returned_asker = HydrateAddress.call(asker_attributes: asker.attributes) 
      expect(returned_asker.is_a?(Asker)).to eq(true)
      expect(returned_asker.attributes).to eq(asker.attributes)
    end
  end

  def _fake_is_zrr
    is_zrr = class_double("IsZrr").as_stubbed_const
    allow(is_zrr).to receive(:call).and_return("oui")
  end

  def _fake_get_zip_city_region
    get_zip_city_region = class_double("GetZipCityRegion").as_stubbed_const
    allow(get_zip_city_region).to receive(:call).and_return( ['59440', 'Avesnelles', 'Hauts-de-France (Nord-Pas-de-Calais)'])
  end

end
