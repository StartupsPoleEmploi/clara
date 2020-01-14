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
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_one_per_type)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception de la région Bretagne; du département 01 Ain; de la ville Île-Tudy 29.", res)
  end

  test '.call a nice sentence if 2 towns only are filled' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_two_towns)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des villes Île-Tudy 29, Renescure 59.", res)
  end

  test '.call a nice sentence if 2 departements only are filled' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_two_departements)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des départements 01 Ain, 44 Loire-Atlantique.", res)
  end

  test '.call a nice sentence if 2 regions only are filled' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_two_regions)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des régions Bretagne, Corse.", res)
  end

  test '.call a nice sentence if all things are filled with multiple values' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_multiple_per_type)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des régions Bretagne, Corse; des départements 01 Ain, 44 Loire-Atlantique; des villes Île-Tudy 29, Renescure 59.", res)
  end

  def _except_one_per_type
    {"selection"=>"tout_sauf", "town"=>[{"29085"=>"Île-Tudy 29"}], "department"=>[{"01"=>"01 Ain"}], "region"=>[{"BRE"=>"Bretagne"}]}
  end

  def _except_two_towns
    {"selection"=>"tout_sauf", "town"=>[{"29085"=>"Île-Tudy 29"}, {"59497"=>"Renescure 59"}]}
  end

  def _except_two_departements
    {"selection"=>"tout_sauf", "department"=>[{"01"=>"01 Ain"}, {"44"=>"44 Loire-Atlantique"}]}
  end

  def _except_two_regions
    {"selection"=>"tout_sauf", "region"=>[{"BRE"=>"Bretagne"}, {"COR"=>"Corse"}]}
  end

  def _except_multiple_per_type
    {"selection"=>"tout_sauf", "region"=>_except_two_regions["region"], "department"=>_except_two_departements["department"], "town"=>_except_two_towns["town"]}
  end

end
