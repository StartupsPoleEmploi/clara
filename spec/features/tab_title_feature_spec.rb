require 'rails_helper'
require 'spec_helper'

feature 'TabTitle' do 

  scenario 'Display a correct title for the home page' do
    visit root_path
    expect(page).to have_title "Clara | Découvrez les aides de retour à l’emploi - un service Pôle emploi"
  end
  scenario 'Display a correct title for the age page' do
    visit new_age_question_path
    expect(page).to have_title "Votre âge | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct title for the contact page' do
    visit contact_index_path
    expect(page).to have_title "Nous contacter | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct title for the cookies page' do
    visit edit_cooky_path("preference")
    expect(page).to have_title "Gestion des cookies | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct title for the aides page' do
    visit aides_path
    expect(page).to have_title "Découvrez toutes les aides et mesures de retour à l'emploi | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct title for the type page' do    
    visit type_path(create(:contract_type, :contract_type_1))
    expect(page).to have_title "n1 | Clara – un service Pôle emploi"
  end

end
