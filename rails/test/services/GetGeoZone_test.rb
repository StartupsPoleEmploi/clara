require "test_helper"

class GetGeoZoneTest < ActiveSupport::TestCase

  test '.call RIEN_SAUF a nice sentence if all town, departement and region are filled' do
    #given
    returned = _except_one_per_type
    returned["selection"] = "rien_sauf"
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(returned)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Uniquement la région Bretagne; le département 01 Ain; la ville Île-Tudy 29.", res)
  end
  
  test '.call RIEN_SAUF a nice sentence if 2 towns only are filled' do
    #given
    returned = _except_two_towns
    returned["selection"] = "rien_sauf"
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(returned)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Uniquement les villes Île-Tudy 29, Renescure 59.", res)
  end

  test '.call RIEN_SAUF a nice sentence if 2 departements only are filled' do
    #given
    returned = _except_two_departements
    returned["selection"] = "rien_sauf"
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(returned)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Uniquement les départements 01 Ain, 44 Loire-Atlantique.", res)
  end

  test '.call RIEN_SAUF a nice sentence if 2 regions only are filled' do
    #given
    returned = _except_two_regions
    returned["selection"] = "rien_sauf"
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(returned)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Uniquement les régions Bretagne, Corse.", res)
  end

  test '.call RIEN_SAUF a nice sentence if all things are filled with multiple values' do
    #given
    returned = _except_multiple_per_type
    returned["selection"] = "rien_sauf"
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(returned)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Uniquement les régions Bretagne, Corse; les départements 01 Ain, 44 Loire-Atlantique; les villes Île-Tudy 29, Renescure 59.", res)
  end

  test '.call RIEN_SAUF only departements missing' do
    #given
    returned = _except_multiple_per_type
    returned["selection"] = "rien_sauf"
    returned["department"] = []
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(returned)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Uniquement les régions Bretagne, Corse; les villes Île-Tudy 29, Renescure 59.", res)
  end

  test '.call should return "Toute la France" by default' do
    #given
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France", res)

  end

  test '.call TOUT_SAUF a nice sentence if all town, departement and region are filled' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_one_per_type)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception de la région Bretagne; du département 01 Ain; de la ville Île-Tudy 29.", res)
  end

  test '.call TOUT_SAUF a nice sentence if 2 towns only are filled' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_two_towns)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des villes Île-Tudy 29, Renescure 59.", res)
  end

  test '.call TOUT_SAUF a nice sentence if 2 departements only are filled' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_two_departements)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des départements 01 Ain, 44 Loire-Atlantique.", res)
  end

  test '.call TOUT_SAUF a nice sentence if 2 regions only are filled' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_two_regions)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des régions Bretagne, Corse.", res)
  end

  test '.call TOUT_SAUF a nice sentence if all things are filled with multiple values' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_except_multiple_per_type)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des régions Bretagne, Corse; des départements 01 Ain, 44 Loire-Atlantique; des villes Île-Tudy 29, Renescure 59.", res)
  end

  test '.call TOUT_SAUF_DOMTOM' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_not_domtom)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France, à l'exception des DOM-TOM", res)
  end

  test '.call DOMTOM_SEULEMENT' do
    #given
    allow_any_instance_of(ExtractGeoForAid).to receive(:call).and_return(_domtom_only)
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Uniquement les DOM-TOM", res)
  end

  test '.call integration' do
    #given
    c = ContractType.new(name: 'r_fake_' + rand(36**8).to_s(36), ordre_affichage: 42)
    c.save
    v = Variable.new(name: 'r_fake_' + rand(36**8).to_s(36), variable_kind: "string")
    v.save
    r1 = Rule.new(name: "r_fake_" + rand(36**8).to_s(36), kind: "simple", variable: v, operator_kind: "more_than", description: "age...", value_eligible: "42")
    r1.save 
    r2 = Rule.new(
        name: "r_akfejtcdsvxmyblu_region_starts_with_bretagne_id_48035229939258206",
        value_eligible: "Bretag",
        variable: v,
        description: "Résider dans la région Bretagne",
        kind: "simple",
        operator_kind: "starts_with",
    )
    r2.save 
    r_root = Rule.new(
       name: "r_akfejtcdsvxmyblu_box_all",
       value_eligible: nil,
       composition_type: "and_rule",
       kind: "composite",
       slave_rules: [r1, r2]
    )
    r_root.save 
    aid = Aid.new(name: 'r_fake_' + rand(36**8).to_s(36), ordre_affichage: 43, contract_type: c, rule: r_root)
    aid.save
    #when
    res = aid.zone_geo
    #then
    assert_equal("Uniquement la région Bretagne.", res)
  end

  def _domtom_only
    {"selection"=>"domtom_seulement"}
  end

  def _not_domtom
    {"selection"=>"tout_sauf_domtom"}
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
