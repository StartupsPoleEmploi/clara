require 'test_helper'

class QuestionAllocTest < ActionDispatch::IntegrationTest
  
  test "Question alloc, by default value is nil" do
    #given
    #when
    get new_allocation_question_path
    #then
    assert_response :ok
    assert_select 'input#ARE_ASP', 1
    assert_select 'input#ARE_ASP[checked]', 0
  end
  
  test "Question alloc, alloc is extracted from asker if already here" do
    #given
    allow_any_instance_of(AllocationService).to receive(:new_and_download).and_return(AllocationForm.new(type: 'ARE_ASP'))
    #when
    get new_allocation_question_path
    #then
    assert_response :ok
    assert_select 'input#ARE_ASP', 1
    assert_select 'input#ARE_ASP[checked]', 1
  end

  test "Question alloc, user submits a valid alloc" do
    #given
    #when
    post allocation_questions_path, params: {"allocation_form"=>{"type"=>"ARE_ASP"}}
    #then
    assert_response :redirect
    assert_no_match /allocation/, response.redirect_url
  end

  test "Question alloc, user submits an invalid alloc" do
    #given
    #when
    post allocation_questions_path, params: {"allocation_form"=>{"nothing"=>""}}
    #then
    assert_response :redirect
    assert_match /allocation/, response.redirect_url
    assert_equal ["doit être renseigné(e)"], flash[:error] 
  end


end
