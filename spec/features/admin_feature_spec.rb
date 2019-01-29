require 'rails_helper'

feature 'admin' do 

  before(:each) do 
    ENV["ARA_AUTH_ADMIN_USERS"] = "pouet@pouet.com"
  end 
  after(:each) do 
    ENV["ARA_AUTH_ADMIN_USERS"] = nil
  end 

  describe 'Visit all the admin models' do
    
    scenario 'with an authorized user' do
      OmniAuth.config.add_mock(:google_oauth2, {:uid => '12345', info: {email: 'pouet@pouet.com'}, credentials: {token: 'tolkien'}})
      create(:variable, :age)
      create(:filter, name: 'filter_name')

      visit admin_root_path
      expect(page).to have_selector('h1', text: 'Aides')

      # Create aids
      click_link 'Création aid'
      fill_in('Nom', with: "Agepi")
      fill_in('Résumé', with: 'Petite description')
      fill_in('Description', with: 'La longue description de l\'aide')

      click_button 'Créer un(e) Aid'
      expect(page).to have_selector('.flash-error')

      # See filters
      click_link 'Filtres'
      expect(page).to have_selector('.cell-data.cell-data--string', text: "filter_name")

      # See detail
      # will click on ID to open detail
      find('.cell-data--number .action-show').click
      expect(current_path).to eq admin_filter_path("filter_name")

      click_link 'Se déconnecter'
    end
    scenario 'with invalid credentials' do 
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      visit admin_root_path
      expect(current_path).to eq root_path
    end
    scenario 'with unauthorized user' do 
      OmniAuth.config.add_mock(:google_oauth2, {:uid => '12345', info: {email: 'wrong@pouet.com'}, credentials: {token: 'tolkien'}})
      visit admin_root_path
      expect(current_path).to eq root_path
    end
  end

  
end
