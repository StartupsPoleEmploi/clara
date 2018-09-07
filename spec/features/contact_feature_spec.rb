require 'rails_helper'

feature 'Contact' do 

  # around do |example|
  #   ClimateControl.modify ARA_EMAIL_USER: 'ara@email.user.com' do
  #     example.run
  #   end
  # end

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
    env_stubber = self.class::StubEnv.new("clara@email.from", "clara@email.to")

    visit contact_index_path
    # when
    find('#first_name').set('Francis')
    find('#last_name').set('Drake')
    find('#email').set('francis@drake.com')
    find("#region").select("Bretagne")
    find("#youare").select("Un particulier")
    find("#askfor").select("Apporter une information pour modifier un contenu")
    find("#question").set("Mais pourquoi une question ?")
    find('#send_message').click
    # then
    invite_email = ActionMailer::Base.deliveries.last
    p '- - - - - - - - - - - - - - invite_email - - - - - - - - - - - - - - - -' 
    pp invite_email
    p ''
    env_stubber.unstubb_env
    save_and_open_page
  end

  class self::StubEnv

    def initialize(ara_email_user, ara_email_destination)
      @previous_ara_email_user = ENV["ARA_EMAIL_USER"]
      ENV["ARA_EMAIL_USER"] = ara_email_user
      @previous_ara_email_destination = ENV["ARA_EMAIL_DESTINATION"]
      ENV["ARA_EMAIL_DESTINATION"] = ara_email_destination
    end
    def unstubb_env
      ENV["ARA_EMAIL_USER"]        = @previous_ara_email_user
      ENV["ARA_EMAIL_DESTINATION"] = @previous_ara_email_destination
    end
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
