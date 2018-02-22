require 'rails_helper'

feature 'age question' do 

  A_VALID_AGE = '45'
  NOT_A_VALID_AGE = 'not_a_valid_age'
  INPUT_AGE = 'input#age'

  scenario 'By default the input field is empty' do 

    # given
    
    # when
    visit new_age_question_path

    # then
    expect(find(INPUT_AGE).value).to eq nil
    session_hash = page.get_rack_session
    asker_obj = session_hash['asker']
    expect(asker_obj).not_to include "v_age: #{A_VALID_AGE}"

  end

  scenario 'If user validates an empty field, user stay on page with an error message' do 

    # given
    visit new_age_question_path
    find(INPUT_AGE).set('')
    expect(have_no_selector(:css, 'label.is-error'))
    
    # when
    find('.js-next').click
    

    # then
    expect(current_path).to eq new_age_question_path
    expect(have_selector(:css, 'label.is-error'))

  end
  
  scenario 'If user validates an invalid age value, user stay on page with entered value and error message' do 

    # given
    visit new_age_question_path
    find(INPUT_AGE).set(NOT_A_VALID_AGE)
    expect(have_no_selector(:css, 'label.is-error'))
    
    # when
    find('.js-next').click
    

    # then
    expect(current_path).to eq new_age_question_path
    expect(have_selector(:css, 'label.is-error'))
    # expect(find(INPUT_AGE).value).to eq NOT_A_VALID_AGE

  end

  scenario 'When user validates a valid age, and come back to the age page, the previous age is restored into the input' do 

    # given
    visit new_age_question_path
    find(INPUT_AGE).set(A_VALID_AGE)
    
    # when
    find('.js-next').click
    expect(current_path).not_to eq new_age_question_path
    visit new_age_question_path

    # then
    expect(find(INPUT_AGE).value).to eq A_VALID_AGE

  end


  scenario 'If user goes back, he/she quit the age page' do 
    # given
    visit new_age_question_path
    
    # when
    find('.js-previous').click
    
    # then
    expect(current_path).not_to eq new_age_question_path
  end
  
end
