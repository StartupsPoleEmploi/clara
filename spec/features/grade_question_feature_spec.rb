require 'rails_helper'


feature 'grade question' do 

  input_1 = nil
  input_2 = nil
  input_3 = nil
  input_4 = nil
  input_5 = nil
  input_6 = nil
  all_inputs = nil


  before(:each) do
    visit new_grade_question_path
    input_1 = find('input#niveau_1')
    input_2 = find('input#niveau_2')
    input_3 = find('input#niveau_3')
    input_4 = find('input#niveau_4')
    input_5 = find('input#niveau_5')
    input_6 = find('input#niveau_infra_5')
    all_inputs = [input_1, input_2, input_3, input_4, input_5, input_6]
  end

  scenario 'By default radio inputs are empty' do 

    # given

    # when

    # then
    expect_all_unchecked(all_inputs)
    expect(page).not_to have_css('label.is-error')

  end

  scenario 'User can go back to previous question' do 

    # given
    # when
    find('.js-previous').click
    # then
    expect(current_path).to eq new_age_question_path
  end

  scenario 'By default session do not have a v_diplome' do 
    # given
    # when
    # then
    expect(current_path).to eq new_grade_question_path
    has_niveau_4_in_session(page, false)
  end

  scenario 'If user validates without any checked checkboxes, user stay on page with an error message' do 

    # given
    expect_all_unchecked(all_inputs)

    # when
    find('.js-next').click
    
    # then
    expect(current_path).to eq new_grade_question_path
    expect(page).to have_css('label.is-error')
    expect(page).to have_css('fieldset.is-error')
  end
  
  scenario 'If user check a radiobutton and visit another page, the radiobutton chosen is still displayed' do 

    # given
    expect_all_unchecked(all_inputs)
    page.choose('niveau_4')
    expect_all_unchecked(all_inputs - [input_4])
    expect(input_4).to be_checked
    
    # when
    visit new_age_question_path
    visit new_grade_question_path
    
    # then
    expect_all_unchecked(all_inputs - [input_4])
    expect(input_4).to be_checked
    expect(current_path).to eq new_grade_question_path
  end

  scenario 'If user check a radiobutton and go next, user go to next question' do 

    # given
    expect(current_path).to eq new_grade_question_path
    expect_all_unchecked(all_inputs)
    page.choose('niveau_4')
    expect_all_unchecked(all_inputs - [input_4])
    expect(input_4).to be_checked

    # when
    find('.js-next').click

    # then
    expect(current_path).to eq new_address_question_path
    has_niveau_4_in_session(page, true)
  end

private
  
  def has_niveau_4_in_session(page, actually_have)
    session_hash = page.get_rack_session
    asker_obj = session_hash['asker']
    if actually_have
      expect(asker_obj).to include '"v_diplome":"niveau_4"'
    else
      expect(asker_obj).not_to include '"v_diplome":"niveau_4"'
    end
  end

  
end
