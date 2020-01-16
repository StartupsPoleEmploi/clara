require "test_helper"

class TranslateB64AskerServiceTest < ActiveSupport::TestCase
  
  test '.into_b64 Should translate an inputed-asker into a non-user-friendly string' do
    #given
    asker = realistic_asker
    #when
    sut = TranslateB64AskerService.new.into_b64(asker)
    #then
    assert_equal("MzUsMSxvLG8sMyxvLHAsNzkzNTEsOTE4MDAsMzQwLG4=", sut)
  end

  test '.into_b64 The generated string must be an list of properties once decoded' do
    #given
    asker = realistic_asker
    str = TranslateB64AskerService.new.into_b64(asker)
    #when
    sut = Base64.urlsafe_decode64(str)
    #then
    assert_equal("35,1,o,o,3,o,p,79351,91800,340,n", sut)
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
    sut = TranslateB64AskerService.new.from_b64("MzQsNCxuLDEsMyxuLHAsMzQxNzIsMzQwNzAsbm90X2FwcGxpY2FibGUsbg==")
    #then
    assert_equal("non", sut.v_handicap)
    assert_equal("non", sut.v_spectacle)
    assert_equal("non", sut.v_cadre)
    assert_equal("niveau_3", sut.v_diplome)
    assert_equal("cat_12345", sut.v_category)
    assert_equal("plus_d_un_an", sut.v_duree_d_inscription)
    assert_equal("not_applicable", sut.v_allocation_value_min)
    assert_equal("RSA", sut.v_allocation_type)     
    assert_equal("34", sut.v_age)                 
    assert_equal("34172", sut.v_location_citycode)   
    assert_equal("34070", sut.v_location_zipcode)   
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
      v_location_zipcode: '91800',
    )
  end

end
