require "rails_helper"

describe Api::V1::ApiAidesController, type: :request do
  
  before(:each) do
    create(:aid, :aid_harki, name: "aide harki")
    create(:aid, :aid_not_harki, name: "aide not_harki")
    create(:aid, :aid_adult_and_harki, name: "aide aid_adult_and_harki")    
  end

  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: create(:user, :fake).id }).token
    {
      "Authorization": "Bearer #{token}"
    }
  end

  describe 'Nominal translation' do
    spied_result_service = nil
    before do
      # asker_called = {
      #    "v_handicap"=>nil,
      #    "v_harki"=>"oui",
      #    "v_detenu"=>nil,
      #    "v_protection_internationale"=>nil,
      #    "v_diplome"=>nil,
      #    "v_category"=>nil,
      #    "v_duree_d_inscription"=>nil,
      #    "v_allocation_value_min"=>nil,
      #    "v_allocation_type"=>nil,
      #    "v_qpv"=>nil,
      #    "v_zrr"=>nil,
      #    "v_age"=>nil,
      #    "v_location_label"=>nil,
      #    "v_location_route"=>nil,
      #    "v_location_city"=>nil,
      #    "v_location_country"=>nil,
      #    "v_location_zipcode"=>nil,
      #    "v_location_citycode"=>nil,
      #    "v_location_street_number"=>nil,
      #    "v_location_state"=>nil
      #  }
      asker_called = Asker.new(v_harki: "oui", v_handicap: "oui", v_detenu: "oui", v_protection_internationale: "oui", v_diplome: "niveau_1", v_category: "cat_12345", v_duree_d_inscription: "plus_d_un_an", v_allocation_type: "ARE_ASP")
      result_layer = instance_double("SerializeResultsService")
      expect(result_layer).to receive(:jsonify_eligible).with(asker_called)
      SerializeResultsService.set_instance(result_layer)
    end
    after do
      SerializeResultsService.set_instance(nil)
    end    
    it 'Should translate all params properly' do
      #given
      #when
      get '/api/v1/aids/eligible', { headers: authenticated_header, params: {harki: true, disabled: true, ex_invict: true, international_protection: true, diploma: "level_1", category: "categories_12345", inscription_period: "more_than_a_year", allocation_type: "ARE"} } 
      #then
      # See above : expect(result_layer)... 
    end
  end

  describe 'Nominal aids/eligible' do
    json_returned = nil
    response_returned = nil
    before do
      if !json_returned
        get '/api/v1/aids/eligible?harki=true', headers: authenticated_header
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
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'aide harki'
    end
  end

  describe 'Nominal aids/ineligible' do
    json_returned = nil
    response_returned = nil
    before do
      if !json_returned
        get '/api/v1/aids/ineligible?harki=true', headers: authenticated_header
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
    it 'Returns all ineligible aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'aide not_harki'
    end
  end

  describe 'Nominal aids/uncertain' do
    json_returned = nil
    response_returned = nil
    before do
      if !json_returned
        get '/api/v1/aids/uncertain?harki=true', headers: authenticated_header
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
    it 'Returns all uncertain aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'aide aid_adult_and_harki'
    end
  end

  describe 'Unauthenticated' do
    it 'Without header, refuses to answer to aids/eligible' do
      get '/api/v1/aids/eligible?v_harki=oui'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/eligible' do
      get '/api/v1/aids/eligible?v_harki=oui', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'Without header, refuses to answer to aids/ineligible' do
      get '/api/v1/aids/ineligible?v_harki=oui'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/uncertain' do
      get '/api/v1/aids/uncertain?v_harki=oui', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'Without header, refuses to answer to aids/uncertain' do
      get '/api/v1/aids/uncertain?v_harki=oui'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/ineligible' do
      get '/api/v1/aids/ineligible?v_harki=oui', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end

end
