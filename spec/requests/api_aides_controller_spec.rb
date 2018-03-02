require "rails_helper"

describe Api::V1::ApiAidesController, type: :request do
  
  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: create(:user, :fake).id }).token
    {
      "Authorization": "Bearer #{token}"
    }
  end

  describe 'Nominal' do
    it 'Returns all eligible, uncertain, and ineligible aids' do
      get '/api/v1/aides', headers: authenticated_header
      json = JSON.parse(response.body)
      expect(response).to be_success
    end
  end

end
