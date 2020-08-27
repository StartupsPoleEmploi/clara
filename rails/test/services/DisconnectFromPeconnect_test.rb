require "test_helper"

class DisconnectFromPeconnectTest < ActiveSupport::TestCase

  test ".call clear the session, and renders json with the redirection url if required by the params" do
    #given
    request = OpenStruct.new(host: 'myhost')
    session = OpenStruct.new(id_token: 'my_id_token', clear: 'ok')
    params = OpenStruct.new(json: 'truthy')
    # expectations
    expect(session).to receive(:clear).once
    expect_any_instance_of(UrlAfterDisconnect).to receive(:call).and_return("http://redirected.to")
    #when
    res = DisconnectFromPeconnect.new.call(request, session, params)
    #then
    assert_equal("render", res[:method])
    assert_equal({:json=>{:redirection_url=>"http://redirected.to"}}, res[:arg])
  end

end
