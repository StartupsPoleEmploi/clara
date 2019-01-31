require 'rails_helper'

feature 'admin' do 

  before(:each) do 
    ENV["ARA_AUTH_ADMIN_USERS"] = "correct@user.com"
  end 
  after(:each) do 
    ENV["ARA_AUTH_ADMIN_USERS"] = nil
  end 

  describe 'Go to the BackOffice' do
    
    scenario 'with an authorized user' do
      OmniAuth.config.add_mock(:google_oauth2, 
        {:uid => '12345', info: {email: 'correct@user.com'}, credentials: {token: 'tolkien'}})
      create(:variable, :age)
      create(:filter, name: 'filter_name')

      visit admin_root_path
      expect(page).to have_selector('h1', text: 'Aides')

      click_link 'Se déconnecter'
    end
    scenario 'with invalid credentials' do 
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      visit admin_root_path
      expect(current_path).to eq root_path
    end
    scenario 'with unauthorized user' do 
      OmniAuth.config.add_mock(:google_oauth2, 
        {:uid => '12345', info: {email: 'wrong@user.com'}, credentials: {token: 'tolkien'}})
      visit admin_root_path
      expect(current_path).to eq root_path
    end
  end

  
end
