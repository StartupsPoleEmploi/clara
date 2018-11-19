require 'rails_helper'
require 'spec_helper'

feature 'ConfidentialitySpec' do 

  scenario 'User can read things about cookies and confidentiality' do
    visit confidentiality_index_path
    expect(page).to have_title("Cookies et politique de confidentialité")
  end

  scenario 'Confidentiality page has 2 back buttons' do
    visit confidentiality_index_path
    expect(page).to have_selector(".c-confidentiality-back", count: 2)
  end

  scenario 'Confidentiality page has a breadcrumb' do
    visit confidentiality_index_path
    expect(page).to have_selector(".c-breadcrumb", count: 1)
  end

  scenario 'Browsers links have target=_blank' do
    visit confidentiality_index_path
    expect(find(".c-confidentiality__browserlink--chrome")['target']).to eq "_blank"
    expect(find(".c-confidentiality__browserlink--firefox")['target']).to eq "_blank"
    expect(find(".c-confidentiality__browserlink--ie")['target']).to eq "_blank"
    expect(find(".c-confidentiality__browserlink--safari")['target']).to eq "_blank"
  end

  scenario 'There is an access from the welcome page' do
    visit root_path
    click_link "Cookies et politique de confidentialité"
    expect(current_path).to eq confidentiality_index_path    
  end

  scenario 'Back buttons leads to previous page' do
    # Given
    visit new_other_question_path
    click_link "Cookies et politique de confidentialité"
    expect(current_path).to eq confidentiality_index_path    
    
    # When
    first(".c-confidentiality-back").click

    # Then
    expect(current_path).to eq confidentiality_index_path

  end

end
