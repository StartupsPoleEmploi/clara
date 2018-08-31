require 'rails_helper'

feature 'inscription question' do 


  scenario 'By default, question about inscription is displayed' do 
    # given
    # when
    visit new_inscription_question_path
    # then
    expect(find('.c-question-title').text).to eq "Depuis combien de temps êtes-vous inscrit(e) à Pôle emploi ?"
  end

  scenario 'User can go back to previous question' do 
    # given
    visit new_inscription_question_path
    # when
    find('.js-previous').click
    # then
    expect(current_path).to eq root_path
  end

  scenario 'User can go to next question after filling form' do 
    # given
    visit new_inscription_question_path
    # when
    page.choose('moins_d_un_an')
    find('.js-next').click
    # then
    expect(current_path).to eq new_category_question_path
  end

  scenario 'User cannot go to next question without filling form' do 
    # given
    visit new_inscription_question_path
    # when
    find('.js-next').click
    # then
    expect(current_path).to eq new_inscription_question_path
  end

  scenario 'Error is displayed if user goes next without filling form' do 
    # given
    visit new_inscription_question_path
    expect(find_all('.c-error-in-form .is-error').length).to eq 0
    # when
    find('.js-next').click
    # then
    expect(find_all('.c-error-in-form .is-error').length).to eq 1
  end

    
end
