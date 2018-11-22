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

  context 'Nominal' do
    # env_stubber = invite_email = result_page = last_path = nil

    around do |example|
      ClimateControl.modify ARA_EMAIL_USER: 'env@ara_email_user' do
        ClimateControl.modify ARA_EMAIL_DESTINATION: 'env@ara_email_destination' do
         example.run
        end
      end
    end

    let(:suts) do
        visit contact_index_path
        #act
        find('#first_name').set('Francis')
        find('#last_name').set('Drake')
        find('#email').set('francis@drake.com')
        find("#region").select("Bretagne")
        choose("Un particulier")
        choose("Apporter une information pour modifier un contenu")
        find("#question").set("Mais pourquoi une question ?")
        find('#send_message').click
        #feed for verification
        {
          result_page: Nokogiri::HTML(page.html),
          last_path: current_path,
          invite_email: ActionMailer::Base.deliveries.last,
        }
    end

    scenario 'Message subjet is "Demande de contact via le site clara"' do
      suts[:invite_email].tap do |mail|
        expect(mail.subject).to eq('Demande de contact via le site Clara')
      end
    end
    scenario 'Message is actually sent from ENV["ARA_EMAIL_USER"]' do
      suts[:invite_email].tap do |mail|
        expect(mail.from).to eq(["env@ara_email_user"])
      end
    end
    scenario 'Message is actually sent to ENV["ARA_EMAIL_DESTINATION"]' do
      suts[:invite_email].tap do |mail|
        expect(mail.to).to eq(["env@ara_email_destination"])
      end
    end
    scenario 'Message body has first_name' do
      elt = Capybara.string(suts[:invite_email].body.encoded).find("#first_name").text
      expect(elt).to eq("Francis")
    end
    scenario 'Message body has last_name' do
      elt = Capybara.string(suts[:invite_email].body.encoded).find("#last_name").text
      expect(elt).to eq("Drake")
    end
    scenario 'Message body has email' do
      elt = Capybara.string(suts[:invite_email].body.encoded).find("#email").text
      expect(elt).to eq("francis@drake.com")
    end
    scenario 'Message body has region' do
      elt = Capybara.string(suts[:invite_email].body.encoded).find("#region").text
      expect(elt).to eq("BRE")
    end
    scenario 'Message body has youare' do
      elt = Capybara.string(suts[:invite_email].body.encoded).find("#youare").text
      expect(elt).to eq("particulier")
    end
    scenario 'Message body has askfor' do
      elt = Capybara.string(suts[:invite_email].body.encoded).find("#askfor").text
      expect(elt).to eq("modifier")
    end
    scenario 'Message body has question' do
      elt = Capybara.string(suts[:invite_email].body.encoded).find("#question").text
      expect(elt).to eq("Mais pourquoi une question ?")
    end
    scenario 'Contact form is no more displayed' do
      expect(suts[:result_page].css('.c-contact-form').count).to eq 0
    end
    scenario 'User is sent to /contact_sent' do
      expect(suts[:last_path]).to eq contact_sent_index_path
    end
    scenario 'A successful message is displayed' do
      # See https://stackoverflow.com/a/15324291/2595513
      msg = "Votre message a bien été envoyé. Nos équipes reviendront vers vous dans les meilleurs délais (les questions plus complexes peuvent prendre plus de temps)."
      expect(suts[:result_page].at("p:contains('#{msg}')").text.strip).to eq msg
    end
  end


  scenario 'First name is required' do
    #given
    visit contact_index_path
    expect(page).not_to have_css('#first_name.is-error')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('#first_name.is-error')
  end
  scenario 'Last name is required' do
    #given
    visit contact_index_path
    expect(page).not_to have_css('#last_name.is-error')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('#last_name.is-error')
  end
  scenario 'Email is required' do
    #given
    visit contact_index_path
    expect(page).not_to have_css('#email.is-error')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('#email.is-error')
  end
  scenario 'Email, when exists, is to be properly formatted' do
    #given
    visit contact_index_path
    find('#email').set('francis')
    expect(page).not_to have_css('#email.is-error')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('#email.is-error')    
  end

  scenario 'Region is required' do
    #given
    visit contact_index_path
    expect(page).not_to have_css('#region.is-error')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('#region.is-error')
  end
  scenario 'Youare is required' do
    #given
    visit contact_index_path
    expect(page).not_to have_css('#youare.is-error')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('#youare.is-error')
  end
  scenario 'Askfor is required' do
    #given
    visit contact_index_path
    expect(page).not_to have_css('#askfor.is-error')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('#askfor.is-error')
  end
  scenario 'Question is required' do
    #given
    visit contact_index_path
    expect(page).not_to have_css('#question.is-error')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('#question.is-error')
  end
  scenario 'Multiple fields are missing, error message is displayed on top of the page' do
    #given
    visit contact_index_path
    find('#email').set('francis@drake.com')
    find("#region").select("Bretagne")
    choose("Un particulier")
    choose("Apporter une information pour modifier un contenu")
    find("#question").set("Mais pourquoi une question ?")
    expect(page).not_to have_css('.is-error')
    expect(page).not_to have_css('ul.c-contact-errors-list li')
    #when
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path
    expect(page).to have_css('.is-error', :count => 2)
    expect(find('.c-contact-errors-title').text).to eq "Une ou plusieurs erreurs ci-dessous ont empêché la validation du formulaire"
  end

  
  scenario 'If Honeypot if filled, the form fails to be validated' do
    #given
    visit contact_index_path

    expect(page).not_to have_css('.is-error')
    find('#first_name').set('Francis')
    find('#last_name').set('Drake')
    find('#email').set('francis@drake.com')
    find("#region").select("Bretagne")
    choose("Un particulier")
    choose("Apporter une information pour modifier un contenu")
    find("#question").set("Mais pourquoi une question ?")
    #when
    find("#honey").set("anything, really")
    find('#send_message').click
    #then
    expect(current_path).to eq contact_index_path

  end

  scenario "Question's placeholder warns from individual queries" do
    #given
    #when
    visit contact_index_path
    #then
    expect(find('#question')['placeholder']).to eq "Ce formulaire de contact n’est pas destiné à étudier les situations individuelles."
  end
  
end
