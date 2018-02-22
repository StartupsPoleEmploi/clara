require 'rails_helper'

feature 'A.R.E question' do 

  NOT_A_VALID_ARE = 'this_is_text_not_number'
  A_VALID_ARE = '888'
  INPUT_MIN = 'input#inputmin'

  scenario 'By default the input field are empty' do 

    # given
    
    # when
    visit new_are_question_path

    # then
    expect(find(INPUT_MIN).value).to eq nil
    session_hash = page.get_rack_session
    asker_obj = session_hash['asker']
    expect(asker_obj).not_to include "v_allocation_value_min: #{A_VALID_ARE}"
  end

  scenario 'If user validate an empty field, user stay on page with an error message' do 

    # given
    visit new_are_question_path
    find(INPUT_MIN).set('')
    expect(have_no_selector(:css, 'label.is-error'))
    
    # when
    find('.js-next').click

    # then
    expect(current_path).to eq new_are_question_path
    expect(have_selector(:css, 'label.is-error'))

  end
  
  scenario 'If user validates an invalid A.R.E value, user stay on page with entered value and error message' do 


    # given
    visit new_are_question_path
    find(INPUT_MIN).set(NOT_A_VALID_ARE)
    expect(have_no_selector(:css, 'label.is-error'))
    
    # when
    find('.js-next').click

    # then
    expect(current_path).to eq new_are_question_path
    find(INPUT_MIN)
    # expect(find(INPUT_MIN).value).to eq NOT_A_VALID_ARE
    expect(have_selector(:css, 'label.is-error'))

  end

  scenario 'When user validates a valid ARE, and come back to the ARE page, the previous ARE is restored into the input' do 

    # given
    visit new_are_question_path
    find(INPUT_MIN).set(A_VALID_ARE)
    
    # when
    find('.js-next').click
    expect(current_path).not_to eq new_are_question_path
    visit new_are_question_path

    # then
    expect(find(INPUT_MIN).value).to eq A_VALID_ARE

  end

end
