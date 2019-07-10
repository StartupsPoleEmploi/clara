require "test_helper"

class ResultSituationTest < ActiveSupport::TestCase
  
  test ".allocation_type Should respond 'ARE ASP' when category is ARE_ASP" do
    sut = ResultSituation.new(nil, {v_allocation_type: 'ARE_ASP'})
    assert_equal("ARE ASP", sut.allocation_type)
  end
  test '.allocation_type Should respond "ASS AER APS AS-FNE" when category is ASS_AER_APS_AS-FNE' do
    sut = ResultSituation.new(nil, {v_allocation_type: 'ASS_AER_APS_AS-FNE'})
    assert_equal("ASS AER APS AS-FNE", sut.allocation_type)
  end
  test '.allocation_type Should respond "RPS RFPA RFF ou pension de retraite" when category is RPS_RFPA_RFF_pensionretraite' do
    sut = ResultSituation.new(nil, {v_allocation_type: 'RPS_RFPA_RFF_pensionretraite'})
    assert_equal("RPS RFPA RFF ou pension de retraite", sut.allocation_type)
  end
  test '.allocation_type Should respond "RSA" when category is RSA' do
    sut = ResultSituation.new(nil, {v_allocation_type: 'RSA'})
    assert_equal("RSA", sut.allocation_type)
  end
  test '.allocation_type Should respond "AAH" when category is AAH' do
    sut = ResultSituation.new(nil, {v_allocation_type: 'AAH'})
    assert_equal("AAH", sut.allocation_type)
  end
  test '.allocation_type Should respond "aucune" when category is pas_indemnise' do
    sut = ResultSituation.new(nil, {v_allocation_type: 'pas_indemnise'})
    assert_equal("aucune", sut.allocation_type)
  end
  test '.allocation_type Should respond "indisponible" when category is unknown' do
    sut = ResultSituation.new(nil, {v_allocation_type: 'nothing_relevant'})
    assert_equal("indisponible", sut.allocation_type)
  end
  test '.allocation_type Should return a "indisponible" in the worst scenario' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.allocation_type)
  end


  test '.diplome Should respond "Bac +4 et +" when diplome is niveau_1' do
    sut = ResultSituation.new(nil, {v_diplome: 'niveau_1'})
    assert_equal("Bac +4 et +", sut.diplome)
  end
  test '.diplome Should respond "Bac +3" when diplome is niveau_2' do
    sut = ResultSituation.new(nil, {v_diplome: 'niveau_2'})
    assert_equal("Bac +3", sut.diplome)
  end
  test '.diplome Should respond "Bac +1 à +2" when diplome is niveau_3' do
    sut = ResultSituation.new(nil, {v_diplome: 'niveau_3'})
    assert_equal("Bac +1 à +2", sut.diplome)
  end
  test '.diplome Should respond "Bac" when diplome is niveau_4' do
    sut = ResultSituation.new(nil, {v_diplome: 'niveau_4'})
    assert_equal("Bac", sut.diplome)
  end
  test '.diplome Should respond "CAP BEP" when diplome is niveau_5' do
    sut = ResultSituation.new(nil, {v_diplome: 'niveau_5'})
    assert_equal("CAP BEP", sut.diplome)
  end
  test '.diplome Should respond "aucun" when diplome is niveau_infra_5' do
    sut = ResultSituation.new(nil, {v_diplome: 'niveau_infra_5'})
    assert_equal("aucun", sut.diplome)
  end
  test '.diplome Should respond "indisponible" when diplome is unknown' do
    sut = ResultSituation.new(nil, {asker: {v_diplome: 'nothing_relevant'}})
    assert_equal("indisponible", sut.diplome)
  end
  test '.diplome Should return a "indisponible" in the worst scenario' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.diplome)
  end


  test '.category Should respond "12345" when category is cat_12345' do
    sut = ResultSituation.new(nil, {v_category: 'cat_12345'})
    assert_equal("12345", sut.category)
  end
  test '.category Should respond "hors 12345" when category is autres_cat' do
    sut = ResultSituation.new(nil, {v_category: 'autres_cat'})
    assert_equal("hors 12345", sut.category)
  end
  test '.category Should respond "indisponible" when category is unknown' do
    sut = ResultSituation.new(nil, {v_category: 'nothing_relevant'})
    assert_equal("indisponible", sut.category)
  end
  test '.category Should return a "indisponible" in the worst scenario' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.category)
  end


  test '.duree_d_inscription Should respond "indisponible" when duree_d_inscription is nil' do
    sut = ResultSituation.new(nil, {v_duree_d_inscription: nil})
    assert_equal("indisponible", sut.duree_d_inscription)
  end
  test '.duree_d_inscription Should respond "moins d\'un an" when duree_d_inscription is "moins_d_un_an"' do
    sut = ResultSituation.new(nil, {v_duree_d_inscription: "moins_d_un_an"})
    assert_equal("moins d\'un an", sut.duree_d_inscription)
  end
  test '.duree_d_inscription Should respond "plus d\'un an" when duree_d_inscription is "plus_d_un_an"' do
    sut = ResultSituation.new(nil, {v_duree_d_inscription: "plus_d_un_an"})
    assert_equal("plus d\'un an", sut.duree_d_inscription)
  end
  test '.duree_d_inscription Should respond "non inscrit" when duree_d_inscription is "non_inscrit"' do
    sut = ResultSituation.new(nil, {v_duree_d_inscription: "non_inscrit"})
    assert_equal("non inscrit", sut.duree_d_inscription)
  end


  test '.age Should respond exactly the same thing as the given age' do
    sut = ResultSituation.new(nil, {v_age: 'anything'})
    assert_equal("anything", sut.age)
    sut = ResultSituation.new(nil, {v_age: 'any_other_thing'})
    assert_equal("any_other_thing", sut.age)
  end
  test '.age Should return "indisponible" in the worst scenario' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.age)
  end


  test '.zrr Should respond "oui" when given String is "oui"' do
    sut = ResultSituation.new(nil, {v_zrr: 'oui'})
    assert_equal("oui", sut.zrr)
  end
  test '.zrr Should respond "non" when given data is sth else than "true"' do
    sut = ResultSituation.new(nil, {v_zrr: 'rerere'})
    assert_equal("non", sut.zrr)
    sut = ResultSituation.new(nil, {v_zrr: Date.new})
    assert_equal("non", sut.zrr)
  end
  test '.zrr Should return "indisponible" when data is not available' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.zrr)
  end


  test '.handicap Should respond "oui" when given String is "oui"' do
    sut = ResultSituation.new(nil, {v_handicap: 'oui'})
    assert_equal("oui", sut.handicap)
  end
  test '.handicap Should respond "non" when given data is sth else than "true"' do
    sut = ResultSituation.new(nil, {v_handicap: 'rerere'})
    assert_equal("non", sut.handicap)
    sut = ResultSituation.new(nil, {v_handicap: Date.new})
    assert_equal("non", sut.handicap)
  end
  test '.handicap Should return "indisponible" when data is not available' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.handicap)
  end

  test '.cadre Should respond "oui" when given String is "oui"' do
    sut = ResultSituation.new(nil, {v_cadre: 'oui'})
    assert_equal("oui", sut.cadre)
  end
  test '.cadre Should respond "non" when given data is sth else than "true"' do
    sut = ResultSituation.new(nil, {v_cadre: 'rerere'})
    assert_equal("non", sut.cadre)
    sut = ResultSituation.new(nil, {v_cadre: Date.new})
    assert_equal("non", sut.cadre)
  end
  test '.cadre Should return "indisponible" when data is not available' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.cadre)
  end


  test '.spectacle Should respond "oui" when given String is "oui"' do
    sut = ResultSituation.new(nil, {v_spectacle: 'oui'})
    assert_equal("oui", sut.spectacle)
  end
  test '.spectacle Should respond "non" when given data is sth else than "true"' do
    sut = ResultSituation.new(nil, {v_spectacle: 'rerere'})
    assert_equal("non", sut.spectacle)
    sut = ResultSituation.new(nil, {v_spectacle: Date.new})
    assert_equal("non", sut.spectacle)
  end
  test '.spectacle Should return "indisponible" when data is not available' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.handicap)
  end


  test '.allocation_value_min Should respond exactly the same thing as the given allocation_value_min' do
    sut = ResultSituation.new(nil, {v_allocation_value_min: 'anything'})
    assert_equal("anything", sut.allocation_value_min)
    sut = ResultSituation.new(nil, {v_allocation_value_min: 'any_other_thing'})
    assert_equal("any_other_thing", sut.allocation_value_min)
  end
  test '.allocation_value_min Should return "indisponible" in the worst scenario' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("indisponible", sut.allocation_value_min)
  end


  test '.location_label Should respond exactly the same thing as the given location_label' do
    sut = ResultSituation.new(nil, {v_location_label: 'anything'})
    assert_equal("anything", sut.location_label)
    sut = ResultSituation.new(nil, {v_location_label: 'any_other_thing'})
    assert_equal("any_other_thing", sut.location_label)
  end
  test '.location_label Should return "indisponible" in the worst scenario' do
    sut = ResultSituation.new(nil, nil)
    assert_equal("Non renseignée", sut.location_label)
  end


end
