require "test_helper"

class HttpServiceGetTest < ActiveSupport::TestCase  

  def setup
    get_str = "http://fakeurl.com"
    WebMock.stub_request(:get, get_str).to_return(status: 200, body: 'ok', headers: {})
  end

  test 'send a valid GET HTTP request : Returns "ok" if remote service return "ok"' do    
    escaped_address = URI.escape("http://fakeurl.com") 
    uri = URI.parse(escaped_address)
    assert_equal("ok", HttpService.get_instance.get(uri))
  end

  test 'send a invalid GET HTTP request : Returns "timeout" if any error occurs' do    
    assert_equal("timeout", HttpService.get_instance.get("invalid_string"))
  end

end
