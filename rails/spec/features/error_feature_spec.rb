require 'rails_helper'
require 'spec_helper'

feature 'ErrorSpec' do 


  scenario 'Displays an error when page is not found' do
    visit errors_not_found_path
    expect(page).to have_title('Erreur 404')
  end

  scenario 'When page is not found, page has a link to home' do
    visit errors_not_found_path
    expect(page).to have_link("Revenir à l'accueil", href: root_path)
  end

  scenario 'Displays an error when server has an error' do
    visit errors_internal_server_error_path
    expect(page).to have_title('Erreur 500')
  end

  scenario 'When server has an error, page has a link to home' do
    visit errors_not_found_path
    expect(page).to have_link("Revenir à l'accueil", href: root_path)
  end
end
