require 'rails_helper'


feature 'allocation question' do 

  input_1 = nil
  input_2 = nil
  input_3 = nil
  input_4 = nil
  input_5 = nil
  input_6 = nil
  all_inputs = nil

  FIRST_OPTION = 'ARE_ASP'

  before(:each) do
    visit new_allocation_question_path
    input_1 = find("input##{FIRST_OPTION}")
    input_2 = find('input#ASS_AER_APS_AS-FNE')
    input_3 = find('input#RPS_RFPA_RFF_pensionretraite')
    input_4 = find('input#RSA')
    input_5 = find('input#AAH')
    input_6 = find('input#pas_indemnise')
    all_inputs = [input_1, input_2, input_3, input_4, input_5, input_6]
  end

  scenario 'By default : radio inputs are empty, no allocation stored into session' do 

    # given

    # when

    # then
    expect_all_unchecked(all_inputs)
    expect(page).not_to have_css('label.is-error')
    session_hash = page.get_rack_session
    asker_obj = session_hash['asker']
    expect(asker_obj).not_to include "\"v_allocation_type\":\"ARE_ASP\""
  end

  scenario 'User can go back to previous question' do 

    # given
    # when
    find('.js-previous').click
    # then
    expect(current_path).to eq new_category_question_path
  end

  scenario 'If user validates without any checked checkboxes, user stay on page with an error message' do 

    # given
    expect_all_unchecked(all_inputs)

    # when
    find('.js-next').click
    
    # then
    expect(current_path).to eq new_allocation_question_path
    expect(page).to have_css('label.is-error')
    expect(page).to have_css('fieldset.is-error')
  end

  # Unknown Capybara::RackTest::Errors::StaleElementReferenceError  
  # scenario 'If user check a radiobutton and visit another page, the radiobutton chosen is still displayed' do 

  #   # given
  #   expect_all_unchecked(all_inputs)
  #   page.choose(FIRST_OPTION)
  #   expect_all_unchecked(all_inputs - [input_1])
  #   expect(input_1).to be_checked
    
  #   # when
  #   visit welcome_index_path
  #   visit new_inscription_question_path
    
  #   # then
  #   expect_all_unchecked(all_inputs - [input_1])
  #   expect(input_1).to be_checked
  #   expect(current_path).to eq new_inscription_question_path
  # end

  scenario 'Nominal case : the user choose a radiobutton, data must be saved into session' do 

    # given
    expect_all_unchecked(all_inputs)
    page.choose(FIRST_OPTION)
    expect_all_unchecked(all_inputs - [input_1])
    expect(input_1).to be_checked

    # when
    find('.js-next').click

    # then
    session_hash = page.get_rack_session
    asker_obj = session_hash['asker']
    expect(asker_obj).to include "\"v_allocation_type\":\"ARE_ASP\""

  end


private


  
end
