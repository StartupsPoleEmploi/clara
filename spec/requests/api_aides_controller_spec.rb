require "rails_helper"

describe Api::V1::ApiAidesController, type: :request do

  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: create(:user, :fake).id }).token
    {
      "Authorization": "Bearer #{token}"
    }
  end

  before do
    Rails.cache.clear
  end

  describe 'Nominal /filters' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        filter_1 = create(:filter, name: 'filter-1')
        filter_2 = create(:filter, name: 'filter-2')
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/filters', {headers: authenticated_header} 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/filters", "foo@bar.com")
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns all filters' do
      expect(json_returned).to eq(
        {
          "filters"=>
          [
            {"name"=>"filter-1", "slug"=>"filter-1"}, 
            {"name"=>"filter-2", "slug"=>"filter-2"}
          ]
        }
      )
    end
  end

  describe 'Nominal aids/detail/:aid_slug' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        create(:aid, :aid_adult_or_spectacle, name: "Aide Adulte ou Spectacle")    
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/detail/aide-adulte-ou-spectacle', {headers: authenticated_header} 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
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
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/detail/wrong_slug', {headers: authenticated_header} 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
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

  describe 'Nominal aids/eligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        # Filter_empty helps to show that we can require multiple filters, even un-needed ones.
        filter_empty = create(:filter, name: 'filter-empty')
        # The filter targeted
        filter_targeted = create(:filter, name: 'filter-targeted')
        # A filter not targeted, and not required
        filter_untargeted = create(:filter, name: 'filter-untargeted')
        # Aid that should be retrieved
        create(:aid, :aid_adult_or_spectacle, name: "Aide Adulte ou Spectacle Filtre", short_description: "adult and spectacle with right filter", filters:[filter_targeted], contract_type: create(:contract_type, :contract_type_1))    
        # Aid that should not be retrieved despite it is eligible : the filter is not targeted
        create(:aid, :aid_adult, name: "Aide Adulte", short_description: "adult with wrong filter", filters:[filter_untargeted])    
        # Aid that should not be retrieved despite correct filter : it is not eligible
        create(:aid, :aid_adult_and_spectacle, name: "Aide Adulte et Spectacle", filters:[filter_targeted])    
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/eligible', params: {   
          "spectacle"               => "false",
          "disabled"                => "true",
          "executive"               => "true",
          "diploma"                 => "level_3",
          "category"                => "other_categories",
          "inscription_period"      => "less_than_a_year",
          "allocation_type"         => "ASS_AER_APS_ASFNE",
          "monthly_allocation_value"=> "1230",
          "age"                     => "42",
          "location_citycode"       => "02004",
          "filters"                 => "filter-empty,filter-targeted"
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
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
    it 'Returns eligible, filtered aids only, and the calculated asker' do
      expect(json_returned).to eq(
        {
          "input" => {
            "asker" => {
              "spectacle" => "false", 
              "disabled" => "true", 
              "executive" => "true", 
              "diploma" => "level_3", 
              "category" => "other_categories", 
              "inscription_period" => "less_than_a_year", 
              "zrr" => "false", 
              "allocation_type" => "ASS_AER_APS_ASFNE", 
              "monthly_allocation_value" => "1230", 
              "age" => "42", 
              "location_citycode" => "02004"
            }, 
            "filters" => "filter-empty,filter-targeted"
          },
          "aids" => [{
            "name" => "Aide Adulte ou Spectacle Filtre",
            "slug" => "aide-adulte-ou-spectacle-filtre",
            "short_description" => "a short description",
            "filters" => [{
              "slug" => "filter-targeted"
            }],
            "custom_filters" => [],
            "need_filters" => [],
            "contract_type" => "n1"
          }],
        }
      )
    end
  end

  describe 'FUNCTIONAL ERROR aids/eligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/eligible', params: {   
          "age"                     => "142",
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/eligible", "foo@bar.com")
    end
    it 'Returns a unsuccessful answer' do
      expect(response_returned).not_to be_success
    end
    it 'With code 400' do
      expect(response_returned).to have_http_status(400)
    end
  end

  describe 'UNEXISTING FILTER aids/eligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/eligible', params: {   
          "filters"                     => "unexisting_filter",
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/eligible", "foo@bar.com")
    end
    it 'Returns a unsuccessful answer' do
      expect(response_returned).not_to be_success
    end
    it 'With code 400' do
      expect(response_returned).to have_http_status(400)
    end
  end

  describe 'Nominal aids/ineligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        # Filter_empty helps to show that we can require multiple filters, even un-needed ones.
        filter_empty = create(:filter, name: 'filter-empty')
        # The filter targeted
        filter_targeted = create(:filter, name: 'filter-targeted')
        # A filter not targeted, and not required
        filter_untargeted = create(:filter, name: 'filter-untargeted')
        # Aid that should be retrieved
        create(:aid, :aid_adult_and_spectacle, name: "Aide Adulte et Spectacle", filters:[filter_targeted], contract_type: create(:contract_type, :contract_type_1))    
        # Aid that should not be retrieved despite it is ineligible : the filter is not targeted
        create(:aid, :aid_adult, name: "Aide Adulte", short_description: "adult with wrong filter", filters:[filter_untargeted])    
        # Aid that should not be retrieved despite correct filter : it is not ineligible
        create(:aid, :aid_adult_or_spectacle, name: "Aide Adulte ou Spectacle Filtre", short_description: "adult and spectacle with right filter", filters:[filter_targeted])    
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/ineligible', params: {   
          "spectacle"               => "false",
          "disabled"                => "true",
          "executive"               => "true", 
          "diploma"                 => "level_3",
          "category"                => "other_categories",
          "inscription_period"      => "less_than_a_year",
          "allocation_type"         => "ASS_AER_APS_ASFNE",
          "monthly_allocation_value"=> "1230",
          "age"                     => "42",
          "location_citycode"       => "02004",
          "filters"                 => "filter-empty,filter-targeted"
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/ineligible", "foo@bar.com")
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns ineligible, filtered aids only, and the calculated asker' do
      expect(json_returned).to eq(
        {
          "input"=> {
            "asker"=> {
              "spectacle"=>"false",
              "disabled"=>"true",
              "executive" => "true", 
              "diploma"=>"level_3",
              "category"=>"other_categories",
              "inscription_period"=>"less_than_a_year",
              "zrr"=>"false",
              "allocation_type"=>"ASS_AER_APS_ASFNE",
              "monthly_allocation_value"=>"1230",
              "age"=>"42",
              "location_citycode"=>"02004"
            },
           "filters"=>"filter-empty,filter-targeted"
          },
          "aids"=>
            [{"name"=>"Aide Adulte et Spectacle",
              "slug"=>"aide-adulte-et-spectacle",
              "filters"=>[{"slug"=>"filter-targeted"}],
              "custom_filters"=>[],
              "need_filters"=>[],
              "contract_type"=>"n1"}]}
      )
    end
  end

  describe 'FUNCTIONAL ERROR aids/ineligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/ineligible', params: {   
          "age"                     => "142",
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/ineligible", "foo@bar.com")
    end
    it 'Returns a unsuccessful answer' do
      expect(response_returned).not_to be_success
    end
    it 'With code 400' do
      expect(response_returned).to have_http_status(400)
    end
  end

  describe 'UNEXISTING FILTER aids/ineligible' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/ineligible', params: {   
          "filters"                     => "unexisting_filter",
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/ineligible", "foo@bar.com")
    end
    it 'Returns a unsuccessful answer' do
      expect(response_returned).not_to be_success
    end
    it 'With code 400' do
      expect(response_returned).to have_http_status(400)
    end
  end

  describe 'Nominal aids/uncertain' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        # Filter_empty helps to show that we can require multiple filters, even un-needed ones.
        filter_empty = create(:filter, name: 'filter-empty')
        # The filter targeted
        filter_targeted = create(:filter, name: 'filter-targeted')
        # A filter not targeted, and not required
        filter_untargeted = create(:filter, name: 'filter-untargeted')
        # Aid that should be retrieved
        create(:aid, :aid_adult_or_spectacle, name: "Aide Adulte ou Spectacle Filtre", short_description: "adult and spectacle with right filter", filters:[filter_targeted], contract_type: create(:contract_type, :contract_type_1))    
        # Aid that should not be retrieved despite it is uncertain : the filter is not targeted
        create(:aid, :aid_adult, name: "Aide Adulte", short_description: "adult with wrong filter", filters:[filter_untargeted])    
        # Aid that should not be retrieved despite correct filter : it is not uncertain
        create(:aid, :aid_adult_and_spectacle, name: "Aide Adulte et Spectacle", filters:[filter_targeted])    
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/uncertain', params: {   
          "spectacle"               => "false",
          "disabled"                => "true",
          "executive"               => "true", 
          "diploma"                 => "level_3",
          "category"                => "other_categories",
          "inscription_period"      => "less_than_a_year",
          "allocation_type"         => "ASS_AER_APS_ASFNE",
          "monthly_allocation_value"=> "1230",
          "location_citycode"       => "02004",
          "filters"                 => "filter-empty,filter-targeted"
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/uncertain", "foo@bar.com")
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns uncertain, filtered aids only, and the calculated asker' do
      expect(json_returned).to eq(
        {
          "input" => {
            "asker"=> {
              "spectacle"=>"false", 
              "disabled"=>"true", 
              "executive" => "true",
              "diploma"=>"level_3", 
              "category"=>"other_categories", 
              "inscription_period"=>"less_than_a_year", 
              "zrr"=>"false", 
              "allocation_type"=>"ASS_AER_APS_ASFNE", 
              "monthly_allocation_value"=>"1230", 
              "location_citycode"=>"02004"
            }, 
            "filters"=>"filter-empty,filter-targeted"
          },
          "aids" => [{
              "name"=>"Aide Adulte ou Spectacle Filtre", 
              "slug"=>"aide-adulte-ou-spectacle-filtre", 
              "short_description"=>"a short description", 
              "filters"=>[{"slug"=>"filter-targeted"}], 
              "custom_filters"=>[], 
              "need_filters"=>[], 
              "contract_type"=>"n1"
            }]
        }
      )
    end
  end

  describe 'FUNCTIONAL ERROR aids/uncertain' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/uncertain', params: {   
          "age"                     => "142",
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/uncertain", "foo@bar.com")
    end
    it 'Returns a unsuccessful answer' do
      expect(response_returned).not_to be_success
    end
    it 'With code 400' do
      expect(response_returned).to have_http_status(400)
    end
  end

  describe 'UNEXISTING FILTER aids/uncertain' do
    response_returned = nil
    json_returned = nil
    track_layer = nil
    before do
      if response_returned == nil
        filter_empty = create(:filter, name: 'filter-empty')
        track_layer = spy('HttpService')
        TrackApiCallService.set_instance(track_layer)
        get '/api/v1/aids/uncertain', params: {   
          "filters"                     => "filter-empty,unexisting_filter",
        }, headers: authenticated_header 
        json_returned = JSON.parse(response.body)
        response_returned = response
      end
    end
    after do
      TrackApiCallService.set_instance(nil)
    end
    it 'Is tracked' do
      expect(track_layer).to have_received(:for_endpoint).with("/api/v1/aids/uncertain", "foo@bar.com")
    end
    it 'Returns a unsuccessful answer' do
      expect(response_returned).not_to be_success
    end
    it 'With code 400' do
      expect(response_returned).to have_http_status(400)
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




end
