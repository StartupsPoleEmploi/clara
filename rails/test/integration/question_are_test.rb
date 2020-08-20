require 'test_helper'

class QuestionAreTest < ActionDispatch::IntegrationTest
  
  test "Question ARE, by default montant is nil" do
    #given
    #when
    get new_are_question_path
    #then
    assert_response :ok
    assert_select 'input#montant', 1
    assert_select 'input#montant[value]', 0
  end
  
  test "Question ARE, montant is extracted from asker if already into session" do
    #given
    allow_any_instance_of(GetPreviousAreValue).to receive(:call).and_return('42')
    #when
    get new_are_question_path
    #then
    assert_response :ok
    assert_select 'input#montant', 1
    assert_select 'input#montant[value]', 1
    assert_select 'input#montant[value=?]', '42'
  end

  test "Question ARE, user submits a valid ARE" do
    #given
    #when
    post are_questions_path, params: {"are_form"=>{"minimum_income"=>"42"}}
    #then
    assert_response :redirect
    assert_no_match /are/, response.redirect_url
  end

  test "Question ARE, user submits an invalid ARE" do
    #given
    #when
    post are_questions_path, params: {"are_form"=>{"minimum_income"=>"invalid"}}
    #then
    assert_response :redirect
    assert_match /are/, response.redirect_url
    assert_equal ["n'est pas un nombre"], flash[:error] 
  end


end
