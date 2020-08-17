require 'test_helper'

class ConnectToSessionTest < ActionDispatch::IntegrationTest

  test "connect to session : refused if unexisting user" do
    post session_url, params: { session: { email: 'fake@email.com', password: 'any' }}
    assert_response :unauthorized
  end

  test "connect to session : accepted if existing user" do
    user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
    post session_url, params: { session: { email: user.email, password: user.password }}
    assert_response :found
  end

end
