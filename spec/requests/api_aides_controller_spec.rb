require "rails_helper"

describe Api::V1::ApiAidesController, type: :request do
  
  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: create(:user, :fake).id }).token
    {
      "Authorization": "Bearer #{token}"
    }
  end


  describe 'Nominal translation' do

    result_layer = nil
    hydratation_layer = nil
    asker_called = nil

    before do
      asker_called = Asker.new(v_harki: "oui", v_handicap: "oui", v_detenu: "oui", v_protection_internationale: "oui", v_diplome: "niveau_1", v_category: "cat_12345", v_duree_d_inscription: "plus_d_un_an", v_allocation_type: "ARE_ASP", v_allocation_value_min: 1242, v_age: "42", v_location_street_number: "9 BIS", v_location_label: "Boulevard d'Alsace", v_location_citycode: "59350")
      
      result_layer = instance_double("SerializeResultsService")
      allow(result_layer).to receive(:jsonify_eligible).and_return({}.to_json)
      SerializeResultsService.set_instance(result_layer)

      hydratation_layer = instance_double("RehydrateAddressService")
      allow(hydratation_layer).to receive(:from_citycode!).and_return(Asker.new)
      RehydrateAddressService.set_instance(hydratation_layer)
    end

    after do
      SerializeResultsService.set_instance(nil)
      RehydrateAddressService.set_instance(nil)
    end    

    it 'Should translate all params properly' do
      get '/api/v1/aids/eligible', { headers: authenticated_header, params: {harki: true, disabled: true, ex_invict: true, international_protection: true, diploma: "level_1", category: "categories_12345", inscription_period: "more_than_a_year", allocation_type: "ARE", monthly_allocation_value: 1242, age: 42, location_street_number: "9 BIS", location_label: "Boulevard d'Alsace", location_citycode: "59350"} } 
      expect(hydratation_layer).to have_received(:from_citycode!).with(asker_called)
    end

  end


  describe 'Without GeoLoc aids/eligible' do
    json_returned = nil
    response_returned = nil
    before do
      if !json_returned
        create(:aid, :aid_harki, name: "aide harki")
        create(:aid, :aid_not_harki, name: "aide not_harki")
        create(:aid, :aid_adult_and_harki, name: "aide aid_adult_and_harki")    
        get '/api/v1/aids/eligible', { headers: authenticated_header, params: {harki: true} } 
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

  describe 'WITH GEOLOC aids/eligible' do
    json_returned = nil
    response_returned = nil
    before do
      qpv_and_zrr_both_ok
      if !json_returned
        create(:aid, :aid_qpv_and_zrr)    
        get '/api/v1/aids/eligible', { headers: authenticated_header, params: {location_stree_number: "9 BIS", location_label:"Boulevard d'Alsace", location_citycode: "59350"} } 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      enable_qpv_zrr_service
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns all eligible aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'aide blabla'
    end
  end

  describe 'Without GeoLoc aids/ineligible' do
    json_returned = nil
    response_returned = nil
    before do
      if !json_returned
        create(:aid, :aid_harki, name: "aide harki")
        create(:aid, :aid_not_harki, name: "aide not_harki")
        create(:aid, :aid_adult_and_harki, name: "aide aid_adult_and_harki")    
        get '/api/v1/aids/ineligible', { headers: authenticated_header, params: {harki: true} } 
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

  describe 'Without GeoLoc aids/uncertain' do
    json_returned = nil
    response_returned = nil
    before do
      if !json_returned
        create(:aid, :aid_harki, name: "aide harki")
        create(:aid, :aid_not_harki, name: "aide not_harki")
        create(:aid, :aid_adult_and_harki, name: "aide aid_adult_and_harki")    
        get '/api/v1/aids/uncertain', { headers: authenticated_header, params: {harki: true} }
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
      get '/api/v1/aids/eligible'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/eligible' do
      get '/api/v1/aids/eligible', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'Without header, refuses to answer to aids/ineligible' do
      get '/api/v1/aids/ineligible'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/ineligible' do
      get '/api/v1/aids/ineligible', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'Without header, refuses to answer to aids/uncertain' do
      get '/api/v1/aids/uncertain'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/uncertain' do
      get '/api/v1/aids/uncertain', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end

end
