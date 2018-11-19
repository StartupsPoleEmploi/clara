require 'rails_helper'
require 'spec_helper'

feature 'ConfidentialitySpec' do 

  scenario 'User can read things about cookies and confidentiality' do
    visit confidentiality_index_path
    expect(page).to have_title("Cookies et politique de confidentialité")
  end

end
