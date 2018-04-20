require 'rails_helper'

feature 'logo' do 


  scenario 'If I click on the logo in a question page, I go back to home' do 

    # given
    visit new_age_question_path
    expect(current_path).to eq new_age_question_path
    # when
    find('.c-logozone').click
    # then
    expect(current_path).to eq root_path

  end
  
end
