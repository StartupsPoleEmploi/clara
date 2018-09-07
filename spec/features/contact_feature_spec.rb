require 'rails_helper'

feature 'Contact' do 


  scenario 'Contact form is displayed when accessing url directly' do 
    # given
    visit root_path
    expect(page).not_to have_css('.c-contact-card')
    # when
    visit contact_index_path
    # then
    expect(page).to have_css('.c-contact-card')
  end

  scenario 'Contact form can be accessed from welcome page' do 
    # given
    visit root_path
    # when
    click_on "Nous contacter"
    # then
    expect(page).to have_css('.c-contact-card')
  end

  scenario 'Nominal' do 
    # given
    visit contact_index_path
    # when
    find('#first_name').set('Francis')
    find('#last_name').set('Drake')
    find('#email').set('francis@drake.com')
    find("#region").select("Bretagne")
    find("#youare").select("Un particulier")
    find("#askfor").select("Apporter une information pour modifier un contenu")
    find('#send_message').click
    # then
    save_and_open_page
  end

  scenario 'After a successful attempt, cannot send sth again'
  scenario 'After a successful attempt, back button means back to welcome page'
  scenario 'If Honeypot if filled, the form fails to be validated'
  scenario 'If request object does not exists, origin is marked as unknown'
  scenario 'If request object is weird, origin is marked as bad-origin'
  scenario 'Email is required'
  scenario 'Email, when exists, is to be properly formatted'
  scenario "Question's placeholder warns from individual queries"
  
end
