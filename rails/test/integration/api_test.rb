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

  test "API : aid-slug, refused if not authenticated" do
    #given
    #when
    get api_v1_aid_slug_path('aaa')
    #then
    assert_response 401
  end

  test "API : aid-slug, when authenticated" do
    #given
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    aid = Aid.create!(name: "aaa", contract_type: contract, ordre_affichage: 3)
    #when
    get api_v1_aid_slug_path('aaa'), headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :success
    assert_equal ({'aid'=>{'name'=>'aaa', 'slug'=>'aaa'}}), JSON.parse(response.body)
  end
  
  test "API : aid-slug, not found" do
    #given
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    aid = Aid.create!(name: "aaa", contract_type: contract, ordre_affichage: 3)
    #when
    get api_v1_aid_slug_path('zzz'), headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :not_found
    assert_equal ({"error"=>"not-found"}), JSON.parse(response.body)
  end
  

  test "API : eligible, refused if not authenticated" do
    #given
    #when
    get api_v1_aids_eligible_path
    #then
    assert_response 401
  end

  test "API : eligible, when authenticated" do
    #given
    _create_realistic_aid
    #when
    get api_v1_aids_eligible_path(age: 22), headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :success
    assert_equal ({'input'=>{'asker'=>{'age' => '22'}}, 'aids'=>[{'name'=>'aaa', 'slug'=>'aaa', 'filters'=>[], 'contract_type'=>'mobilite'}]}), JSON.parse(response.body)
  end

  test "API : eligible, but error as if authenticated" do
    #given
    _create_realistic_aid
    #when
    get api_v1_aids_eligible_path(age: 0), headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :bad_request
    assert_equal({"age"=>["doit être supérieur ou égal à 16"]}, JSON.parse(response.body))
  end

  test "API : ineligible, refused if not authenticated" do
    #given
    #when
    get api_v1_aids_ineligible_path
    #then
    assert_response 401
  end

  test "API : ineligible, when authenticated" do
    #given
    _create_realistic_aid
    #when
    get api_v1_aids_ineligible_path(age: 17), headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :success
    assert_equal ({'input'=>{'asker'=>{'age' => '17'}}, 'aids'=>[{'name'=>'aaa', 'slug'=>'aaa', 'filters'=>[], 'contract_type'=>'mobilite'}]}), JSON.parse(response.body)
  end

  test "API : ineligible, but error as if authenticated" do
    #given
    _create_realistic_aid
    #when
    get api_v1_aids_ineligible_path(age: -17), headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :bad_request
    assert_equal({"age"=>["doit être supérieur ou égal à 16"]}, JSON.parse(response.body))
  end

  test "API : uncertain, refused if not authenticated" do
    #given
    #when
    get api_v1_aids_uncertain_path
    #then
    assert_response 401
  end

  test "API : uncertain, when authenticated" do
    #given
    _create_realistic_aid
    #when
    get api_v1_aids_uncertain_path(spectacle: 'true'), headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :success
    assert_equal ({'input'=>{'asker'=>{'spectacle' => 'true'}}, 'aids'=>[{'name'=>'aaa', 'slug'=>'aaa', 'filters'=>[], 'contract_type'=>'mobilite'}]}), JSON.parse(response.body)
  end

  test "API : uncertain, but error as if authenticated" do
    #given
    _create_realistic_aid
    #when
    get api_v1_aids_uncertain_path(spectacle: 'foo'), headers: {:Authorization => "Bearer #{_jwt}"}
    #then
    assert_response :bad_request
    assert_equal({"spectacle"=>["foo n'est pas une valeur parmis celles possibles (true, false)"]}, JSON.parse(response.body))
  end

  def _create_realistic_aid
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    rule = Rule.create!({name: "r_majorite", value_eligible: "18", variable: variable_age, description: "descr", kind: "simple", operator_kind: "more_than"})
    aid = Aid.create!(name: "aaa", contract_type: contract, rule: rule, ordre_affichage: 3, what: 'x', how_and_when: 'y', how_much: 'z')
  end

  def _jwt
    api_user = ApiUser.create!(email:"a@b.c", password: "p")
    post api_v1_api_user_token_path, params: { auth: {email: "a@b.c", password: "p"}}
    JSON.parse(response.body)['jwt']
  end

end
