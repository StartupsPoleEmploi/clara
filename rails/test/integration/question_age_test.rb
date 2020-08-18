require 'test_helper'

class QuestionAreTest < ActionDispatch::IntegrationTest
  
  test "Question AGE, by default age is nil" do
    #given
    #when
    get new_age_question_path
    #then
    assert_response :ok
    assert_select 'input#age', 1
    assert_select 'input#age[value]', 0
  end
  
  test "Question AGE, age is extracted from asker if already here" do
    #given
    allow_any_instance_of(AgeService).to receive(:new_and_download).and_return(AgeForm.new(number_of_years: '42'))
    #when
    get new_age_question_path
    #then
    assert_response :ok
    assert_select 'input#age', 1
    assert_select 'input#age[value]', 1
    assert_select 'input#age[value=?]', '42'
  end

  test "Question AGE, user submits a valid AGE" do
    #given
    #when
    post age_questions_path, params: {"age_form"=>{"number_of_years"=>"42"}}
    #then
    assert_response :redirect
    assert_no_match /age/, response.redirect_url
  end

  test "Question AGE, user submits an invalid AGE" do
    #given
    #when
    post age_questions_path, params: {"age_form"=>{"number_of_years"=>"invalid"}}
    #then
    assert_response :redirect
    assert_match /age/, response.redirect_url
    assert_equal ["n'est pas un nombre", "L'âge doit être supérieur ou égal à 16 ans"], flash[:error] 
  end


end
