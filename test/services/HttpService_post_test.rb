require "test_helper"

class HttpServicePostTest < ActiveSupport::TestCase  

  def setup
    WebMock.stub_request(:post, _fake_url).to_return(status: 200, body: 'ok', headers: {})
  end

  def _fake_url
    "https://qpvzrr.herokuapp.com:8080/setqpv/"
  end

  def _fake_uri
    URI.parse(URI.escape(_fake_url))
  end

  test 'send a valid POST HTTP request : Returns "ok" if remote service return "ok"' do    
      scheme = "https"
      host = "qpvzrr.herokuapp.com"
      port = 8080
      path = "/setqpv/"
      json_params = {'num_adresse' => 11, 'nom_voie' => 'rue des trucs', 'code_postal' => '68190', 'nom_commune' => 'Ensisheim'}
      headers  = {"Content-Type"=>"application/json", "Accept"=>"application/json"}
      assert_equal(true, 
        HttpService
          .get_instance
          .post(scheme, host, port, path, json_params, headers)
          .kind_of?(Net::HTTPSuccess))
  end

  test 'send a valid POST (form) HTTP request : Returns "ok" if remote service return "ok"' do    
      json_params = {'num_adresse' => 11, 'nom_voie' => 'rue des trucs', 'code_postal' => '68190', 'nom_commune' => 'Ensisheim'}

      assert_equal(true, 
        HttpService
          .get_instance
          .post_form(_fake_uri, json_params)
          .kind_of?(Net::HTTPSuccess))
  end

  test 'send a invalid POST HTTP request : Returns "timeout" if any error occurs' do    
    assert_equal("timeout", 
      HttpService.get_instance.post('scheme', 'host', 'port', 'path', {}, {}))
  end

end
