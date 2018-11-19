require 'rails_helper'
require 'spec_helper'

feature 'ConfidentialitySpec' do 

  scenario 'User can read things about cookies and confidentiality' do
    visit confidentiality_index_path
    expect(page).to have_title("Cookies et politique de confidentialité")
  end

  scenario 'confidentiality page has 2 back button' do
    visit confidentiality_index_path
    expect(page).to have_selector(".c-confidentiality-backbutton", count: 2)
  end

  scenario 'confidentiality page has a breadcrumb' do
    visit confidentiality_index_path
    expect(page).to have_selector(".c-confidentiality-backbutton", count: 2)
  end

end
