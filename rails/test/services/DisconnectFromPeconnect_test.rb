require "test_helper"

class DisconnectFromPeconnectTest < ActiveSupport::TestCase

  test ".call clear the session, and renders json with the redirection url if required by the params" do
    #given
    request = fake(host: 'host')
    session = fake(id_token: 'token', clear: 'ok')
    params = fake(json: 'truthy')
    # expectations
    expect(session).to receive(:clear).once
    expect_any_instance_of(UrlAfterDisconnect).to receive(:call).with('token', 'host').and_return("http://redirected.to")
    #when
    res = DisconnectFromPeconnect.new.call(request, session, params)
    #then
    assert_equal("render", res[:method])
    assert_equal({:json=>{:redirection_url=>"http://redirected.to"}}, res[:arg])
  end

  test ".call clear the session, and redirects to page if json param is false" do
    #given
    request = fake(host: 'host')
    session = fake(id_token: 'token', clear: 'ok')
    params = fake(json: false)
    # expectations
    expect(session).to receive(:clear).once
    expect_any_instance_of(UrlAfterDisconnect).to receive(:call).with('token', 'host').and_return("http://redirected.to")
    #when
    res = DisconnectFromPeconnect.new.call(request, session, params)
    #then
    assert_equal("redirect_to", res[:method])
    assert_equal("http://redirected.to", res[:arg])
  end

end
