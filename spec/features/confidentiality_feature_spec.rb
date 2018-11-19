require 'rails_helper'
require 'spec_helper'

feature 'ConfidentialitySpec' do 

  scenario 'User can read things about cookies and confidentiality' do
    visit confidentiality_index_path
    expect(page).to have_title("Cookies et politique de confidentialité")
  end

  scenario 'Confidentiality page has 2 back button' do
    visit confidentiality_index_path
    expect(page).to have_selector(".c-confidentiality-back", count: 2)
  end

  scenario 'Confidentiality page has a breadcrumb' do
    visit confidentiality_index_path
    expect(page).to have_selector(".c-breadcrumb", count: 1)
  end

  scenario 'Browsers links have target=_blank'
  scenario 'There is an access from the welcome page'

end
