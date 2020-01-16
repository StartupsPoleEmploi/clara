require 'rails_helper'

feature 'category question' do 

  input_cat_1 = nil
  input_autres_cat = nil

  before(:each) do
    visit new_category_question_path
    input_cat_1 = find('input#cat_12345')
    input_autres_cat = find('input#autres_cat')
  end

  scenario 'By default radio inputs are empty' do 

    # given
    
    # when

    # then
    expect(input_cat_1).not_to be_checked
    expect(input_autres_cat).not_to be_checked
    expect(page).not_to have_css('label.is-error')

  end

  scenario 'User can go back to previous question' do 

    # given
    # when
    find('.js-previous').click
    # then
    expect(current_path).to eq new_inscription_question_path
  end

  scenario 'If user validates without any checked checkboxes, user stay on page with an error message' do 

    # given
    expect(input_cat_1).not_to be_checked
    expect(input_autres_cat).not_to be_checked

    # when
    find('.js-next').click
    
    # then
    expect(current_path).to eq new_category_question_path
    expect(page).to have_css('label.is-error')
  end
  
  scenario 'If user check a radiobutton and go back to the page, the radiobutton chosen is still displayed' do 

    # given
    expect(input_autres_cat).not_to be_checked
    expect(input_cat_1).not_to be_checked
    page.choose('autres_cat')
    expect(input_autres_cat).to be_checked
    expect(input_cat_1).not_to be_checked

    # when
    find('.js-next').click
    expect(current_path).not_to eq new_category_question_path
    visit new_category_question_path

    # then
    expect(input_autres_cat).to be_checked
    expect(input_cat_1).not_to be_checked
    expect(current_path).to eq new_category_question_path
  end
  
end
