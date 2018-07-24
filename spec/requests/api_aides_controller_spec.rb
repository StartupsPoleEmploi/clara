require "rails_helper"

describe Api::V1::ApiAidesController, type: :request do

  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: create(:user, :fake).id }).token
    {
      "Authorization": "Bearer #{token}"
    }
  end

  describe 'Nominal aids/detail/:aid_slug' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      create(:aid, :aid_qpv_and_zrr, name: "Aide Qpv ET Zrr")    
      track_layer = spy('HttpService')
      TrackCallService.set_instance(track_layer)
      get '/api/v1/aids/detail/aide-qpv-et-zrr', {headers: authenticated_header} 
      json_returned = JSON.parse(response.body)
      response_returned = response
    end
    after do
      TrackCallService.set_instance(nil)
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/detail/:aid_slug", "foo@bar.com")
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns detail of an aid' do
      expect(json_returned["aid"]).not_to eq nil
      expect(json_returned["aid"]["name"]).to eq 'Aide Qpv ET Zrr'
    end
  end

  describe 'NOT_FOUND aids/detail/:aid_slug' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      create(:aid, :aid_qpv_and_zrr, name: "Aide Qpv ET Zrr")    
      track_layer = spy('HttpService')
      TrackCallService.set_instance(track_layer)
      get '/api/v1/aids/detail/wrong_slug', {headers: authenticated_header} 
      json_returned = JSON.parse(response.body)
      response_returned = response
    end
    after do
      TrackCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/detail/:aid_slug", "foo@bar.com")
    end
    it 'Returns a unsuccessful answer' do
      expect(response_returned).not_to be_success
    end
    it 'With code 404' do
      expect(response_returned).to have_http_status(404)
    end
  end

  describe 'aids/eligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      _stub_qpv_with_INSIDE_QPV
      _stub_zrr_with_INSIDE_ZRR
      _stub_ban_with_correct_values
      track_layer = spy('HttpService')
      TrackCallService.set_instance(track_layer)

      create(:aid, :aid_qpv_and_zrr, name: "Aide Qpv ET Zrr")    
      get '/api/v1/aids/eligible', { headers: authenticated_header, params: {location_stree_number: "9 BIS", location_label:"Boulevard d'Alsace", location_citycode: "59350"} } 
      json_returned = JSON.parse(response.body)
      response_returned = response
    end
    after do
      TrackCallService.set_instance(nil)
      _unstub_qpv
      _unstub_zrr
      _unstub_ban
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/eligible", "foo@bar.com")
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns all eligible aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'Aide Qpv ET Zrr'
    end
    it 'Returns asker, only non-empty fields' do
      asker = json_returned["asker"]
      expect(asker["v_qpv"]).not_to eq nil
      expect(asker["v_age"]).to eq nil
    end
  end

  describe 'aids/ineligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      _stub_qpv_with_OUTSIDE_QPV # !! outside... thus the aid is NOT eligible
      _stub_zrr_with_INSIDE_ZRR
      _stub_ban_with_correct_values
      track_layer = spy('HttpService')
      TrackCallService.set_instance(track_layer)
      
      create(:aid, :aid_qpv_and_zrr, name: "Aide Qpv ET Zrr")    
      get '/api/v1/aids/ineligible', { headers: authenticated_header, params: {location_stree_number: "9 BIS", location_label:"Boulevard d'Alsace", location_citycode: "59350"} } 
      json_returned = JSON.parse(response.body)
      response_returned = response
    end
    after do
      TrackCallService.set_instance(nil)
      _unstub_qpv
      _unstub_zrr
      _unstub_ban
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/ineligible", "foo@bar.com")
    end
    it 'Returns all ineligible aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'Aide Qpv ET Zrr'
    end
    it 'Returns asker, only non-empty fields' do
      asker = json_returned["asker"]
      expect(asker["v_qpv"]).not_to eq nil
      expect(asker["v_age"]).to eq nil
    end
  end

  describe 'aids/uncertain' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      _stub_qpv_with_UNDEFINED_QPV # !! undefined... thus the aid is uncertain
      _stub_zrr_with_INSIDE_ZRR
      _stub_ban_with_correct_values
      track_layer = spy('HttpService')
      TrackCallService.set_instance(track_layer)
      
      create(:aid, :aid_qpv_and_zrr, name: "Aide Qpv ET Zrr")    
      get '/api/v1/aids/uncertain', { headers: authenticated_header, params: {location_stree_number: "9 BIS", location_label:"Boulevard d'Alsace", location_citycode: "59350"} } 
      json_returned = JSON.parse(response.body)
      response_returned = response
    end
    after do
      _unstub_qpv
      _unstub_zrr
      _unstub_ban
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/uncertain", "foo@bar.com")
    end
    it 'Returns all uncertain aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'Aide Qpv ET Zrr'
    end
    it 'Returns asker, only non-empty fields' do
      asker = json_returned["asker"]
      expect(asker["v_qpv"]).not_to eq nil
      expect(asker["v_age"]).to eq nil
    end
  end

  describe 'throttling' do
    before do
      ENV["THROTTLE_DURING_TEST"] = "true"
    end
    after do
      ENV["THROTTLE_DURING_TEST"] = nil
      Rails.cache.clear
    end
    it 'Must NOT return 429 if NOT too much call' do
      last_response = nil
      2.times do
        get "/api/v1/aids/eligible"
        last_response = response
      end
      expect(last_response.status).not_to eq(429)            
    end
    it 'Must return 429 if too much call' do
      last_response = nil
      15.times do
        get "/api/v1/aids/eligible"
        last_response = response
      end
      expect(last_response.status).to eq(429)      
    end
  end

  describe 'Unauthenticated' do
    it 'Without header, refuses to answer to aids/eligible (401)' do
      get '/api/v1/aids/eligible'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/eligible (401)' do
      get '/api/v1/aids/eligible', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'Without header, refuses to answer to aids/ineligible (401)' do
      get '/api/v1/aids/ineligible'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/ineligible (401)' do
      get '/api/v1/aids/ineligible', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'Without header, refuses to answer to aids/uncertain (401)' do
      get '/api/v1/aids/uncertain'
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
    it 'With a bad header, refuses to answer to aids/uncertain (401)' do
      get '/api/v1/aids/uncertain', headers: { "Authorization": "Bearer foobar"}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end

  describe 'ping' do 
    before do
      get '/api/v1/ping', { headers: authenticated_header }
    end
    it 'With code 200' do 
        expect(response_returned).to have_http_status(200)
    end
  end

  def _stub_qpv_with_INSIDE_QPV
    qpv_layer = instance_double("QpvService")
    allow(qpv_layer).to receive(:setDetailedQPV).and_return(true)
    allow(qpv_layer).to receive(:isDetailedQPV).and_return("en_qpv")
    QpvService.set_instance(qpv_layer)
  end

  def _stub_qpv_with_OUTSIDE_QPV
    qpv_layer = instance_double("QpvService")
    allow(qpv_layer).to receive(:setDetailedQPV).and_return(true)
    allow(qpv_layer).to receive(:isDetailedQPV).and_return("hors_qpv")
    QpvService.set_instance(qpv_layer)
  end

  def _stub_qpv_with_UNDEFINED_QPV
    qpv_layer = instance_double("QpvService")
    allow(qpv_layer).to receive(:setDetailedQPV).and_return(true)
    allow(qpv_layer).to receive(:isDetailedQPV).and_return("erreur_injoignable")
    QpvService.set_instance(qpv_layer)
  end

  def _stub_zrr_with_INSIDE_ZRR    
    zrr_layer = instance_double("ZrrService")
    allow(zrr_layer).to receive(:isZRR).and_return("en_zrr")
    ZrrService.set_instance(zrr_layer)
  end

  def _stub_ban_with_correct_values
    ban_layer = instance_double("BanService")
    allow(ban_layer).to receive(:get_zipcode_and_cityname).and_return(["59440", "Avesnelles"])
    BanService.set_instance(ban_layer)    
  end

  def _unstub_qpv
    QpvService.set_instance(nil)
  end

  def _unstub_zrr
    ZrrService.set_instance(nil)
  end

  def _unstub_ban
    BanService.set_instance(nil)
  end


end
