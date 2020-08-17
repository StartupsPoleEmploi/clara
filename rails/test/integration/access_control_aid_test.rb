require 'test_helper'

class AccessControlAidTest < ActionDispatch::IntegrationTest

  test "Un contributeur peut lister les aides" do
    #given
    contributeur = User.create(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #when
    get admin_aids_path
    #then
    assert_response :ok
  end
    
end
