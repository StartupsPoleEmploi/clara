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
      asker_called = Asker.new(v_harki: "oui", v_handicap: "oui", v_detenu: "oui", v_protection_internationale: "oui", v_diplome: "niveau_1", v_category: "cat_12345", v_duree_d_inscription: "plus_d_un_an", v_allocation_type: "RPS_RFPA_RFF_pensionretraite", v_allocation_value_min: 1242, v_age: "42", v_location_street_number: "9 BIS", v_location_route: "Boulevard d'Alsace", v_location_citycode: "59350")
      
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
      get '/api/v1/aids/eligible', { headers: authenticated_header, params: {harki: true, disabled: true, ex_invict: true, international_protection: true, diploma: "level_1", category: "categories_12345", inscription_period: "more_than_a_year", allocation_type: "RPS_RFPA_RFF_PENSION", monthly_allocation_value: 1242, age: 42, location_street_number: "9 BIS", location_route: "Boulevard d'Alsace", location_citycode: "59350"} } 
      expect(hydratation_layer).to have_received(:from_citycode!).with(asker_called)
    end

  end

  describe 'aids/detail/:aid_slug' do
    response_returned = nil
    json_returned = nil
    before do
      create(:aid, :aid_qpv_and_zrr, name: "Aide Qpv ET Zrr")    
      get '/api/v1/aids/detail/aide-qpv-et-zrr', {headers: authenticated_header} 
      json_returned = JSON.parse(response.body)
      response_returned = response
    end
    it 'Returns a successful answer' do
      expect(response_returned).to be_success
    end
    it 'With code 200' do
      expect(response_returned).to have_http_status(200)
    end
    it 'Returns detail of an aid' do
      expect(json_returned["aid"]).not_to eq nil
      expect(json_returned["aid"]["name"]).to eq 'Aide Qpv ET Zrr'
    end
  end

  describe 'aids/eligible' do
    response_returned = nil
    json_returned = nil
    before do
      _stub_qpv_with_INSIDE_QPV
      _stub_zrr_with_INSIDE_ZRR
      _stub_ban_with_correct_values
      create(:aid, :aid_qpv_and_zrr, name: "Aide Qpv ET Zrr")    
      get '/api/v1/aids/eligible', { headers: authenticated_header, params: {location_stree_number: "9 BIS", location_label:"Boulevard d'Alsace", location_citycode: "59350"} } 
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
    it 'Returns all eligible aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'Aide Qpv ET Zrr'
    end
  end

  describe 'aids/ineligible' do
    response_returned = nil
    json_returned = nil
    before do
      _stub_qpv_with_OUTSIDE_QPV # !! outside... thus the aid is NOT eligible
      _stub_zrr_with_INSIDE_ZRR
      _stub_ban_with_correct_values
      create(:aid, :aid_qpv_and_zrr, name: "Aide Qpv ET Zrr")    
      get '/api/v1/aids/ineligible', { headers: authenticated_header, params: {location_stree_number: "9 BIS", location_label:"Boulevard d'Alsace", location_citycode: "59350"} } 
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
    it 'Returns all ineligible aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'Aide Qpv ET Zrr'
    end
  end

  describe 'aids/uncertain' do
    response_returned = nil
    json_returned = nil
    before do
      _stub_qpv_with_UNDEFINED_QPV # !! undefined... thus the aid is uncertain
      _stub_zrr_with_INSIDE_ZRR
      _stub_ban_with_correct_values
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
    it 'Returns all uncertain aids' do
      expect(json_returned["aids"].size).to eq 1
      expect(json_returned["aids"][0]["name"]).to eq 'Aide Qpv ET Zrr'
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
