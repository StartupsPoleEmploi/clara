require 'rails_helper'

describe TranslateB64AskerService do

  it '.into_b64 Should translate an inputed-asker into a non-user-friendly string' do
    #given
    asker = create(:asker, :full_user_input)
    #when
    sut = TranslateB64AskerService.new.into_b64(asker)
    #then
    expect(sut).to eq("MzUsMSxvLG8sMyxvLHAsNzkzNTEsMzQwLG4=")
  end

  it '.into_b64 The generated string must be an list of properties once decoded' do
    #given
    asker = create(:asker, :full_user_input)
    str = TranslateB64AskerService.new.into_b64(asker)
    #when
    sut = Base64.urlsafe_decode64(str)
    #then
    expect(sut).to eq("35,1,o,o,3,o,p,79351,340,n")
  end

  it '.from_b64 Should return an asker' do
    #given
    #when
    sut = TranslateB64AskerService.new.from_b64("MjYsNCxvLDMsbyxtLDgyNzEyLDIwMDMsbg==")
    #then
    expect(sut.is_a?(Asker)).to eq(true)
  end

  it '.from_b64 asker properties must be filled' do
    #given
    #when
    sut = TranslateB64AskerService.new.from_b64("MzQsMixvLDEsMyxuLHAsOTExMTQsMTQzLG8=")
    #then
    expect(sut.v_handicap)            .to eq("false")
    expect(sut.v_spectacle)           .to eq("true")
    expect(sut.v_cadre)               .to eq("true")
    expect(sut.v_diplome)             .to eq("niveau_3")
    expect(sut.v_category)            .to eq("cat_12345")
    expect(sut.v_duree_d_inscription) .to eq("plus_d_un_an")
    expect(sut.v_allocation_value_min).to eq("143")
    expect(sut.v_allocation_type)     .to eq("ASS_AER_APS_AS-FNE")
    expect(sut.v_age)                 .to eq("34")
    expect(sut.v_location_citycode)   .to eq("91114")
  end

  it '.into_b64 and .from_b64, when chained, must end up with the same asker' do
    #given
    original_asker = create(:asker, :full_user_input)
    service = TranslateB64AskerService.new
    #when
    recreated_asker = service.from_b64(service.into_b64(original_asker))
    #then
    expect(original_asker.attributes).to eq(recreated_asker.attributes)
  end

end
