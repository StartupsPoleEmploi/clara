require "test_helper"

class GetGeoZoneTest < ActiveSupport::TestCase
  
  def setup
  end
  
  test '.call should return "Toute la France" by default' do
    #given
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France", res)

  end

  test '.call a nice sentence if all town, departement and region are filled' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_nominal_extraction)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception de la région Bretagne; du département 01 Ain; de la ville Île-Tudy 29.", res)
  end

  def _nominal_extraction
    {"selection"=>"tout_sauf", "town"=>[{"29085"=>"Île-Tudy 29"}], "department"=>[{"01"=>"01 Ain"}], "region"=>[{"BRE"=>"Bretagne"}]}
  end

end
