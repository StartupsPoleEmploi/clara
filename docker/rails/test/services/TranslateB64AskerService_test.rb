require "test_helper"

class TranslateB64AskerServiceTest < ActiveSupport::TestCase
  
  test '.into_b64 Should translate an inputed-asker into a non-user-friendly string' do
    #given
    asker = realistic_asker
    #when
    sut = TranslateB64AskerService.new.into_b64(asker)
    #then
    assert_equal("MzUsMSxvLG8sMyxvLHAsNzkzNTEsMzQwLG4=", sut)
  end

  test '.into_b64 The generated string must be an list of properties once decoded' do
    #given
    asker = realistic_asker
    str = TranslateB64AskerService.new.into_b64(asker)
    #when
    sut = Base64.urlsafe_decode64(str)
    #then
    assert_equal("35,1,o,o,3,o,p,79351,340,n", sut)
  end

  test '.from_b64 Should return an asker' do
    #given
    #when
    sut = TranslateB64AskerService.new.from_b64("MjYsNCxvLDMsbyxtLDgyNzEyLDIwMDMsbg==")
    #then
    assert_equal(true, sut.is_a?(Asker))
  end

  test '.from_b64 asker properties must be filled' do
    #given
    #when
    sut = TranslateB64AskerService.new.from_b64("MzQsMixvLDEsMyxuLHAsOTExMTQsMTQzLG8=")
    #then
    assert_equal("non", sut.v_handicap)
    assert_equal("oui", sut.v_spectacle)
    assert_equal("oui", sut.v_cadre)
    assert_equal("niveau_3", sut.v_diplome)
    assert_equal("cat_12345", sut.v_category)
    assert_equal("plus_d_un_an", sut.v_duree_d_inscription)
    assert_equal("143", sut.v_allocation_value_min)
    assert_equal("ASS_AER_APS_AS-FNE", sut.v_allocation_type)     
    assert_equal("34", sut.v_age)                 
    assert_equal("91114", sut.v_location_citycode)   
  end

  test '.into_b64 and .from_b64, when chained, must end up with the same asker' do
    #given
    original_asker = realistic_asker
    service = TranslateB64AskerService.new
    #when
    recreated_asker = service.from_b64(service.into_b64(original_asker))
    #then
    assert_equal(recreated_asker.attributes, original_asker.attributes)
  end

  def realistic_asker
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
    )
  end

end
