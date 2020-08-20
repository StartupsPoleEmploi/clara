require 'test_helper'

class ApiTest < ActionDispatch::IntegrationTest

  test "API : ping" do
    #given
    #when
    get api_v1_ping_path
    #then
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 'ok', json_response['status']
  end

  test "API : successful auth" do
    #given
    #when
    json_token = _jwt
    #then
    assert_equal true, _jwt.is_a?(String) && _jwt.size > 42
  end

  test "API : filters, refused if not authenticated" do
    #given
    #when
    get api_v1_filters_path 
    #then
    assert_response 401
  end

  test "API : filters, when authenticated" do
    #given
    Filter.create!(name: "Se déplacer")
    #when
    get api_v1_filters_path, headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :success
    assert_equal ({"filters"=>[{"name" => "Se déplacer", "slug" => "se-deplacer"}]}), JSON.parse(response.body)
  end

  def _jwt
    api_user = ApiUser.create!(email:"a@b.c", password: "p")
    post api_v1_api_user_token_path, params: { auth: {email: "a@b.c", password: "p"}}
    JSON.parse(response.body)['jwt']
  end

end
