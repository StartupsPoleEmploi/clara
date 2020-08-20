require 'test_helper'

class QuestionGradeTest < ActionDispatch::IntegrationTest
  
  test "Question grade, by default value is nil" do
    #given
    #when
    get new_grade_question_path
    #then
    assert_response :ok
    assert_select 'input#niveau_2', 1
    assert_select 'input#niveau_2[checked]', 0
  end
  
  test "Question grade, grade is extracted from asker if already here" do
    #given
    allow_any_instance_of(GetPreviousGradeForm).to receive(:call).and_return(GradeForm.new(value: 'niveau_2'))
    #when
    get new_grade_question_path
    #then
    assert_response :ok
    assert_select 'input#niveau_2', 1
    assert_select 'input#niveau_2[checked]', 1
  end

  test "Question grade, user submits a valid grade" do
    #given
    #when
    post grade_questions_path, params: {"grade_form"=>{"value"=>"niveau_2"}}
    #then
    assert_response :redirect
    assert_no_match /grade/, response.redirect_url
  end

  test "Question grade, user submits an invalid grade" do
    #given
    #when
    post grade_questions_path, params: {"grade_form"=>{"nothing"=>""}}
    #then
    assert_response :redirect
    assert_match /grade/, response.redirect_url
    assert_equal ["doit être renseigné(e)"], flash[:error] 
  end


end
