require 'test_helper'

class PeconnectCallbackTest < ActionDispatch::IntegrationTest

  test "callback of peconnect : redirect to home if users cancel" do
    #given
    #when
    get peconnect_callback_path(state: 'any')
    #then
    assert_redirected_to root_url
  end

  test "callback of peconnect : accept callback if request params are here" do
    #given
    allow_any_instance_of(BuildCallbackHash).to receive(:call).and_return({asker: Asker.new, meta: {}, filters: []})
    #when
    get peconnect_callback_path(state: 'any', code: 'other')
    #then
    assert_response :ok
    assert_routing '/peconnect_callback', controller: 'peconnect', action: 'callback'
  end

end
