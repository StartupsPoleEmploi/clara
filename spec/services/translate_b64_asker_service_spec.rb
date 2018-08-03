require 'rails_helper'

describe TranslateB64AskerService do

  it 'Should translate an inputed-asker into a non-user-friendly string' do
    #given
    asker = create(:asker, :full_user_input)
    #when
    sut = TranslateB64AskerService.new.into_b64(asker)
    #then
    expect(sut).to eq("MzUsMSxvLDMsbyxwLDc5MzUxLDM0MCxu")
  end

  it 'The generated string must be an list properties once decoded' do
    #given
    asker = create(:asker, :full_user_input)
    #when
    str = TranslateB64AskerService.new.into_b64(asker)
    sut = Base64.urlsafe_decode64(str)
    #then
    expect(sut).to eq("35,1,o,3,o,p,79351,340,n")
  end

end
