require 'rails_helper'

describe HttpService do


  describe " | For testing purpose" do
    before(:each) do
      http_layer = instance_double("HttpService")
      allow(http_layer).to receive(:get).and_return("unexisting_get_value")
      allow(http_layer).to receive(:post).and_return("unexisting_post_value")
      HttpService.set_instance(http_layer)
    end
    after(:each) do
      HttpService.set_instance(nil)
    end
    it ' | GET Can be stubbed easily' do
      sut = HttpService.get_instance
      output = sut.get('http://any_url.com')
      expect(output).to eq('unexisting_get_value')
    end
    it ' | GET Can support multiple call and return the same result' do
      sut = HttpService.get_instance
      3.times do 
        output = sut.get('http://any_url.com')
        expect(output).to eq('unexisting_get_value')
      end
    end
    it ' | POST Can be stubbed easily' do
      sut = HttpService.get_instance
      output = sut.post('scheme', 'host', 'port', 'path', 'json_params', 'headers')
      expect(output).to eq('unexisting_post_value')
    end
  end

  describe " | send a valid GET HTTP request" do    
    before do
      get_str = "http://fakeurl.com"
      WebMock.stub_request(:get, get_str).to_return(status: 200, body: 'ok', headers: {})
    end
    it ' | Returns "ok" if remote service return "ok"' do
      escaped_address = URI.escape("http://fakeurl.com") 
      uri = URI.parse(escaped_address)
      expect(HttpService.get_instance.get(uri)).to eq "ok"
    end
  end

  describe " | send a invalid GET HTTP request" do    
    it ' | Returns "timeout" if any error occurs' do
      expect(HttpService.get_instance.get("invalid_string")).to eq "timeout"
    end
  end

  describe " | send a valid POST HTTP request" do    
    scheme = "https"
    host = "qpvzrr.herokuapp.com"
    port = 8080
    path = "/setqpv/"
    json_params = {'num_adresse' => 11, 'nom_voie' => 'rue des trucs', 'code_postal' => '68190', 'nom_commune' => 'Ensisheim'}
    headers  = {"Content-Type"=>"application/json", "Accept"=>"application/json"}
    before do
      WebMock.stub_request(:post, "https://qpvzrr.herokuapp.com:8080/setqpv/").to_return(status: 200, body: 'ok', headers: {})
    end
    it ' | Returns "ok" if remote service return "ok"' do
      expect(HttpService.get_instance.post(scheme, host, port, path, json_params, headers).kind_of? Net::HTTPSuccess).to eq true
    end
  end

  describe " | send a invalid POST HTTP request" do    
    it ' | Returns "timeout" if any error occurs' do
      expect(HttpService.get_instance.post('scheme', 'host', 'port', 'path', {}, {})).to eq "timeout"
    end
  end


end
