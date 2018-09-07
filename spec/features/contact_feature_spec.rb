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

  context 'Nominal' do
    env_stubber = final_path = invite_email = result_page = last_path = nil
    before do
      if env_stubber == nil
        #setup
        env_stubber = self.class::StubEnv.new("env@ara_email_user", "env@ara_email_destination")
        visit contact_index_path
        #act
        find('#first_name').set('Francis')
        find('#last_name').set('Drake')
        find('#email').set('francis@drake.com')
        find("#region").select("Bretagne")
        find("#youare").select("Un particulier")
        find("#askfor").select("Apporter une information pour modifier un contenu")
        find("#question").set("Mais pourquoi une question ?")
        find('#send_message').click
        #feed for verification
        result_page = Nokogiri::HTML(page.html)
        last_path = current_path
        invite_email = ActionMailer::Base.deliveries.last
      end    
    end
    after do
      env_stubber.unstubb_env
    end
    scenario 'Message subjet is "Demande de contact via le site clara"' do
      invite_email.tap do |mail|
        expect(mail.subject).to eq('Demande de contact via le site clara')
      end
    end
    scenario 'Message is actually sent from ENV["ARA_EMAIL_USER"]' do
      invite_email.tap do |mail|
        expect(mail.from).to eq(["env@ara_email_user"])
      end
    end
    scenario 'Message is actually sent to ENV["ARA_EMAIL_DESTINATION"]' do
      invite_email.tap do |mail|
        expect(mail.to).to eq(["env@ara_email_destination"])
      end
    end
    scenario 'Message body has first_name' do
      elt = Capybara.string(invite_email.body.encoded).find("#first_name").text
      expect(elt).to eq("Francis")
    end
    scenario 'Message body has last_name' do
      elt = Capybara.string(invite_email.body.encoded).find("#last_name").text
      expect(elt).to eq("Drake")
    end
    scenario 'Message body has email' do
      elt = Capybara.string(invite_email.body.encoded).find("#email").text
      expect(elt).to eq("francis@drake.com")
    end
    scenario 'Message body has region' do
      elt = Capybara.string(invite_email.body.encoded).find("#region").text
      expect(elt).to eq("BRE")
    end
    scenario 'Message body has youare' do
      elt = Capybara.string(invite_email.body.encoded).find("#youare").text
      expect(elt).to eq("particulier")
    end
    scenario 'Contact form is no more displayed' do
      expect(result_page.css('.c-contact-form').count).to eq 0
    end
    scenario 'User is sent to /contact_sent' do
      expect(last_path).to eq contact_sent_index_path
    end
    scenario 'A successful message is displayed' do
      # See https://stackoverflow.com/a/15324291/2595513
      msg = "Votre message a été envoyé avec succès."
      expect(result_page.at("p:contains('#{msg}')").text.strip).to eq msg
    end
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
