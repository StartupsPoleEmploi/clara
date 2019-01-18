require 'rails_helper'

describe HydrateAddress do

  before do
    _fake_is_zrr
    _fake_get_zip_city_region
  end
  describe "call" do
    it "Raise an error if arg is not a asker attributes hash" do
      # given
      # when
      # then
      expect { HydrateAddress.call(asker_attributes: //) }.to raise_error(ArgumentError)
    end
    it "Do not raise an error if arg is a asker attributes hash" do
      # given
      # when
      # then
      expect { HydrateAddress.call(asker_attributes: Asker.new.attributes) }.not_to raise_error
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
