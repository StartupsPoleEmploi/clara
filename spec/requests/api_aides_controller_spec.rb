require "rails_helper"

describe Api::V1::ApiAidesController, type: :request do
  
  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: create(:user, :fake).id }).token
    {
      "Authorization": "Bearer #{token}"
    }
  end

  describe 'Nominal' do
    json_returned = nil
    response_returned = nil
    before do
      if !json_returned
        create(:aid, :aid_harki, name: "aide harki")
        create(:aid, :aid_not_harki, name: "aide not_harki")
        create(:aid, :aid_adult_and_harki, name: "aide aid_adult_and_harki")
        get '/api/v1/aides?v_harki=oui', headers: authenticated_header
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns all eligible aids' do
      expect(json_returned["all_eligible"].size).to eq 1
      expect(json_returned["all_eligible"][0]["name"]).to eq 'aide harki'
    end
    it 'Returns all ineligible aids' do
      expect(json_returned["all_ineligible"].size).to eq 1
      expect(json_returned["all_ineligible"][0]["name"]).to eq 'aide not_harki'
    end
    it 'Returns all uncertain aids' do
      expect(json_returned["all_uncertain"].size).to eq 1
      expect(json_returned["all_uncertain"][0]["name"]).to eq 'aide aid_adult_and_harki'
    end
  end

  describe 'Unauthenticated' do
    it 'Without header, refuses to answer' do
      get '/api/v1/aides?v_harki=oui'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer' do
      get '/api/v1/aides?v_harki=oui', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end

end
