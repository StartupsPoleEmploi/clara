require 'rails_helper'

describe TranslateB64AskerService do

  it 'Should translate an inputed-asker into a non-user-friendly string' do
    #given
    asker = create(:asker, :full_user_input)
    #when
    result = TranslateB64AskerService.new.into_b64(asker)
    #then
    expect(result).to eq("MzUsMSxvLDMsbyxwLDc5MzUxLDM0MCxu")
    # expect(Base64.urlsafe_decode64(asker_64))
  end

end
