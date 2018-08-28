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
      if response_returned == nil
        create(:aid, :aid_adult_or_spectacle, name: "Aide Adulte ou Spectacle")    
        track_layer = spy('HttpService')
        TrackCallService.set_instance(track_layer)
        get '/api/v1/aids/detail/aide-adulte-ou-spectacle', {headers: authenticated_header} 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/detail/:aid_slug", "foo@bar.com")
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns detail of an aid' do
      expect(json_returned["aid"]).not_to eq nil
      expect(json_returned["aid"]["name"]).to eq 'Aide Adulte ou Spectacle'
    end
  end

  describe 'NOT_FOUND aids/detail/:aid_slug' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        create(:aid, :aid_adult_or_spectacle, name: "Aide Adulte ou Spectacle")    
        track_layer = spy('HttpService')
        TrackCallService.set_instance(track_layer)
        get '/api/v1/aids/detail/wrong_slug', {headers: authenticated_header} 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
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

  describe 'Nominal /api/v1/aids/eligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        aide_right_filter = create(:aid, :aid_adult_or_spectacle, name: "Aide Adulte ou Spectacle Filtre", short_description: "adult and spectacle with right filter")    
        aide_wrong_filter = create(:aid, :aid_adult, name: "Aide Adulte", short_description: "adult with wrong filter")    
        create(:aid, :aid_adult_and_spectacle, name: "Aide Adulte et Spectacle")    
        filter_used = create(:filter, name: 'filter-used')
        filter_unused = create(:filter, name: 'filter-unused')
        track_layer = spy('HttpService')
        TrackCallService.set_instance(track_layer)
        get '/api/v1/aids/eligible', params: {   
          "spectacle"               => "false",
          "disabled"                => "true",
          "diploma"                 => "level_3",
          "category"                => "other_categories",
          "inscription_period"      => "less_than_a_year",
          "allocation_type"         => "ASS_AER_ATA_APS_ASFNE",
          "monthly_allocation_value"=> "1230",
          "age"                     => "42",
          "location_citycode"       => "02004"
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackCallService.set_instance(nil)
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
    it 'Returns eligible aids only, and calculated asker' do
      expect(json_returned).to eq(
        {
          "asker" => {
            "spectacle"=>"false", 
            "disabled"=>"true", 
            "diploma"=>"level_3", 
            "category"=>"other_categories", 
            "inscription_period"=>"less_than_a_year", 
            "zrr"=>"false", 
            "allocation_type"=>"ASS_AER_ATA_APS_ASFNE", 
            "monthly_allocation_value"=>"1230", 
            "age"=>"42", 
            "location_citycode"=>"02004"
          }, 
          "aids"=>[
            {"name"=>"Aide Adulte ou Spectacle", 
              "slug"=>"aide-adulte-ou-spectacle", 
              "short_description"=>"a short description"}
          ]
        }
        )
    end
  end

  describe 'throttling' do
    # before do
    #   ENV["THROTTLE_DURING_TEST"] = "true"
    # end
    # after do
    #   ENV["THROTTLE_DURING_TEST"] = nil
    #   Rails.cache.clear
    # end
    # it 'Must NOT return 429 if NOT too much call' do
    #   last_response = nil
    #   2.times do
    #     get "/api/v1/aids/eligible"
    #     last_response = response
    #   end
    #   expect(last_response.status).not_to eq(429)            
    # end
    # it 'Must return 429 if too much call' do
    #   last_response = nil
    #   15.times do
    #     get "/api/v1/aids/eligible"
    #     last_response = response
    #   end
    #   expect(last_response.status).to eq(429)      
    # end
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

  describe 'Ping' do 
    response_returned = nil
    before do
      get '/api/v1/ping'
      response_returned = response
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

  def _stub_ban_with_correct_values
    ban_layer = instance_double("BanService")
    allow(ban_layer).to receive(:get_zipcode_and_cityname).and_return(["59440", "Avesnelles"])
    BanService.set_instance(ban_layer)    
  end

  def _unstub_qpv
    QpvService.set_instance(nil)
  end

  def _unstub_ban
    BanService.set_instance(nil)
  end


end
