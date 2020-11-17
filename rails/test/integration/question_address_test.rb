require 'test_helper'

class QuestionAddressTest < ActionDispatch::IntegrationTest
  
  test "Question address, by default address input is empty" do
    #given
    #when
    get new_address_question_path
    #then
    assert_response :ok
    assert_select 'input#search', 1
    assert_select 'input#search[value]', 0
  end
  
  test "Question address, address is extracted from asker if already here" do
    #given
    allow_any_instance_of(RequireAsker).to receive(:call).and_return(Asker.new(v_location_label: '43000 Ceyssac', v_location_city: 'Ceyssac', v_location_zipcode: '43000', v_location_citycode: '43045', v_location_country: 'France'))
    
    #when
    get new_address_question_path
    #then
    assert_response :ok
    assert_select 'input#search', 1
    assert_select 'input#search[value]', 1
    assert_select 'input#search[value=?]', '43000 Ceyssac'
  end

  test "Question address, user submits a valid address" do
    #given
    #when
    post address_questions_path, params: {
      "address_form"=>
      {"label"=>"43000 Ceyssac",
        "city"=>"Ceyssac", 
        "zipcode"=>"43000", 
        "country"=>"France", 
        "citycode"=>"43045"}, 
      }
    #then
    assert_response :redirect
    assert_no_match /address/, response.redirect_url
    assert_equal true, IsValidJson.new.call(session[:asker])
    assert_equal '43000 Ceyssac', JSON.parse(session[:asker])['v_location_label']
    assert_equal 'Ceyssac', JSON.parse(session[:asker])['v_location_city']
    assert_equal '43000', JSON.parse(session[:asker])['v_location_zipcode']
    assert_equal '43045', JSON.parse(session[:asker])['v_location_citycode']
    assert_equal 'France', JSON.parse(session[:asker])['v_location_country']
  end

  test "Question address, user submits an invalid address" do
    #given
    #when
    post address_questions_path, params: {"address_form"=>{"invalid"=>"property"}}
    #then
    assert_response :redirect
    assert_match /address/, response.redirect_url
    assert_equal ['Le code postal est manquant'], flash[:error] 
  end


end
