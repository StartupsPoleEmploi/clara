require 'rails_helper'

describe User, type: :model do

  describe 'self.from_token_request' do
    it 'Returns a user from database, if properly required within request' do
      # given
      fake_user = create(:user, :fake)
      fake_request = OpenStruct.new({params: {"auth" => {"email" => "foo@bar.com"}}})
      # when
      sut = User.from_token_request(fake_request)
      # then
      expect(sut).to eq fake_user
    end
  end

end
