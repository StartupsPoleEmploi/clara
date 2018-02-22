require 'rails_helper'

feature 'Page terms of service' do 

  scenario 'Display terms of service' do 
    visit conditions_generales_d_utilisation_path
    expect(page).to have_content("Conditions d’utilisation")
  end
  
end
