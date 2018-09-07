require 'rails_helper'

feature 'Contact' do 


  scenario 'Contact form is displayed when accessing url directly' do 
    # given
    # when
    visit contact_index_path
    # then
    expect(current_path).to eq contact_index_path
  end

  scenario 'Contact form can be accessed from welcome page' do 
    # given
    visit root_path
    # when
    click_on "Nous contacter"
    # then
    expect(page).to have_title('Nous contacter')
    expect(page).to have_css('.c-contact-card')
  end

  
end
