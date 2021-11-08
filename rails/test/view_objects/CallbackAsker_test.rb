require "test_helper"

class CallbackAskerTest < ActiveSupport::TestCase
  

  test ".inscription by default" do
    #given
    asker = _realistic_asker
    sut = CallbackAsker.new(nil, {asker: asker, meta: {}})
    #when
    res = sut.inscription
    #then
    assert_equal('indisponible', res)
  end
  
  test ".inscription 'oui'" do
    #given
    asker = _realistic_asker
    asker[:v_inscrit] = 'oui'
    sut = CallbackAsker.new(nil, {asker: asker, meta: {}})
    #when
    res = sut.inscription
    #then
    assert_equal('Inscrit à Pôle Emploi', res)
  end

  test ".inscription 'en_recherche'" do
    #given
    asker = _realistic_asker
    asker[:v_inscrit] = 'en_recherche'
    sut = CallbackAsker.new(nil, {asker: asker, meta: {}})
    #when
    res = sut.inscription
    #then
    assert_equal("En recherche d'emploi sans y être inscrit", res)
  end
  
  test ".duree_d_inscription default" do
    #given
    asker = _realistic_asker
    sut = CallbackAsker.new(nil, {asker: asker, meta: {}})
    #when
    res = sut.duree_d_inscription
    #then
    assert_equal("plus d'un an", res)
  end
  
  test ".categorie default" do
    #given
    asker = _realistic_asker
    sut = CallbackAsker.new(nil, {asker: asker, meta: {}})
    #when
    res = sut.categorie
    #then
    assert_equal("hors 12345", res)
  end
  
  test ".allocation_type default" do
    #given
    asker = _realistic_asker
    sut = CallbackAsker.new(nil, {asker: asker, meta: {}})
    #when
    res = sut.allocation_type
    #then
    assert_equal("ARE ASP", res)
  end
  
  def _realistic_asker
    Asker.new(
      v_handicap: "oui",
      v_spectacle: "non",
      v_cadre: "oui",
      v_diplome: 'niveau_3',
      v_category: 'autres_cat',
      v_duree_d_inscription: 'plus_d_un_an',
      v_allocation_value_min: 340,
      v_allocation_type: 'ARE_ASP',
      v_age: 35,
      v_location_citycode: '79351',
      v_location_zipcode: '91800',
    )
  end
end
