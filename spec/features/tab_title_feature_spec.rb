require 'rails_helper'
require 'spec_helper'

feature 'TabTitle' do 

  scenario 'Display a correct title for the home page' do
    visit root_path
    expect(page).to have_title "Clara | Découvrez les aides de retour à l’emploi - un service Pôle emploi"
  end
  scenario 'Display a correct description for the home page' do
    expected_content = "Découvrez les aides et mesures qui vont accélérer votre reprise d\\\'emploi"
    visit root_path
    # See https://stackoverflow.com/a/30582389/2595513
    expect(page).to have_css "meta[name='description'][content='#{expected_content}']", :visible => false
  end

  scenario 'Display a correct title for the age page' do
    visit new_age_question_path
    expect(page).to have_title "Votre âge | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the age page' do
    expected_content = "Quel est votre âge ?"
    visit new_age_question_path
    expect(page).to have_css "meta[name='description'][content='#{expected_content}']", :visible => false
  end
  scenario 'Display a correct title for the inscription page' do
    visit new_inscription_question_path
    expect(page).to have_title "Votre inscription à Pôle emploi | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the inscription page' do
    expected_content = "Depuis combien de temps êtes-vous inscrit(e) à Pôle emploi ?"
    visit new_inscription_question_path
    expect(page).to have_css "meta[name='description'][content='#{expected_content}']", :visible => false
  end
  scenario 'Display a correct title for the category page' do
    visit new_category_question_path
    expect(page).to have_title "Votre catégorie de demandeur d'emploi | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the category page' do
    expected_content = "Depuis combien de temps êtes-vous inscrit(e) à Pôle emploi ?"
    visit new_category_question_path
    expect(page).to have_css "meta[name='description'][content='#{expected_content}']", :visible => false
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
