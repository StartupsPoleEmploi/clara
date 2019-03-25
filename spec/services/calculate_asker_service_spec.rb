require 'rails_helper'

describe CalculateAskerService do

  before do
    _fake_is_zrr
#    _fake_get_zip_city_region
  end

  describe '.calculate_zrr' do
    it 'Should calculate zrr' do
      # given
      asker = Asker.new
      asker.v_location_citycode = "20245"
      IsZrr.new.call("20245")
      # when
      CalculateAskerService.new(asker).calculate_zrr!
      # then
      expect(asker.v_zrr).to eq("oui")

    end
  end

  def _fake_is_zrr
    allow_any_instance_of(IsZrr).to receive(:call)
  end

=begin  def _fake_get_zip_city_region
    allow_any_instance_of(GetZipCityRegion).to receive(:call).and_return(['59440', 'Avesnelles', 'Hauts-de-France (Nord-Pas-de-Calais)'])
  end
=end

end
