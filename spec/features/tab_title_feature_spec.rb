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
    expected_content = "Êtes-vous actuellement dans l'une des situations suivantes ?"
    visit new_category_question_path
    meta_description = find(:css, "meta[name='description']", :visible => false)
    expect(meta_description[:content]).to eq expected_content
  end
  scenario 'Display a correct title for the allocation page' do
    visit new_allocation_question_path
    expect(page).to have_title "Vos allocations | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the allocation page' do
    expected_content = "Quelle allocation percevez-vous actuellement ?"
    visit new_allocation_question_path
    expect(page).to have_css "meta[name='description'][content='#{expected_content}']", :visible => false
  end
  scenario 'Display a correct title for the are page' do
    visit new_are_question_path
    expect(page).to have_title "Votre montant d'allocation | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the are page' do
    expected_content = "Quel est le montant de cette allocation ?"
    visit new_are_question_path
    expect(page).to have_css "meta[name='description'][content='#{expected_content}']", :visible => false
  end
  scenario 'Display a correct title for the are page' do
    visit new_are_question_path
    expect(page).to have_title "Votre montant d'allocation | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the are page' do
    expected_content = "Quel est le montant de cette allocation ?"
    visit new_are_question_path
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
  scenario 'Display a correct title for the grade page' do
    visit new_grade_question_path
    expect(page).to have_title "Votre diplôme le plus élevé | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the grade page' do
    expected_content = "Quel est le diplôme le plus élevé que vous ayez obtenu ?"
    visit new_grade_question_path
    expect(page).to have_css "meta[name='description'][content='#{expected_content}']", :visible => false
  end
  scenario 'Display a correct title for the address page' do
    visit new_address_question_path
    expect(page).to have_title "Votre adresse | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the address page' do
    expected_content = "Quel est votre code postal de votre lieu de résidence ?"
    visit new_address_question_path
    expect(page).to have_css "meta[name='description'][content='#{expected_content}']", :visible => false
  end
  scenario 'Display a correct title for the other page' do
    visit new_other_question_path
    expect(page).to have_title "Situation particulière | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the other page' do
    expected_content = "Êtes-vous dans l'une des situations suivantes ?"
    visit new_other_question_path
    meta_description = find(:css, "meta[name='description']", :visible => false, :count => 1)
    expect(meta_description[:content]).to eq expected_content
  end



  scenario 'Display a correct title for the contact page' do
    visit contact_index_path
    expect(page).to have_title "Nous contacter | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the contact page' do
    expected_content = "Notre service délivre un premier niveau d’information. Ce formulaire de contact n’est pas destiné à étudier les situations individuelles."
    visit contact_index_path
    meta_description = find(:css, "meta[name='description']", :visible => false, :count => 1)
    expect(meta_description[:content]).to eq expected_content
  end



  scenario 'Display a correct title for the cookies page' do
    visit edit_cooky_path("preference")
    expect(page).to have_title "Gestion des cookies | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the cookie page' do
    expected_content = "En activant les cookies, votre navigateur retient certaines informations de visite."
    visit edit_cooky_path("preference")
    meta_description = find(:css, "meta[name='description']", :visible => false, :count => 1)
    expect(meta_description[:content]).to eq expected_content
  end



  scenario 'Display a correct title for the aides page' do
    visit aides_path
    expect(page).to have_title "Découvrez toutes les aides et mesures de retour à l'emploi | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the aides page' do
    expected_content = "Découvrez toutes les aides et mesures de retour à l'emploi"
    visit aides_path
    meta_description = find(:css, "meta[name='description']", :visible => false, :count => 1)
    expect(meta_description[:content]).to eq expected_content
  end


  scenario 'Display a correct title for the detail page' do
    aid = create(:aid, :aid_adult_or_spectacle, name: "ze_name_for_adult_or_spectacle")
    visit detail_path(aid.slug)
    expect(page).to have_title "ze_name_for_adult_or_spectacle | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the detail page' do
    expected_content = "Cette aide vise à faciliter les déplacements des personnes handicapées salariées"
    aid = create(:aid, :aid_not_spectacle)
    visit detail_path(aid.slug)
    meta_description = find(:css, "meta[name='description']", :visible => false, :count => 1)
    expect(meta_description[:content]).to eq expected_content
  end


  scenario 'Display a correct title for the type page' do    
    visit type_path(create(:contract_type, :contract_type_1))
    expect(page).to have_title "n1 | Clara – un service Pôle emploi"
  end
  scenario 'Display a correct description for the type page' do
    expected_content = "contract_type_1_description"
    c1 = create(:contract_type, :contract_type_1, description: "contract_type_1_description")
    visit type_path(c1.slug)
    meta_description = find(:css, "meta[name='description']", :visible => false, :count => 1)
    expect(meta_description[:content]).to eq expected_content
  end

  context 'Noindex' do
    before do
      req_str = "https://api-adresse.data.gouv.fr/search/?citycode=79351&limit=20&q=rue"
      WebMock.stub_request(:get,req_str).to_return(status: 200, body: "", headers: {})
    end
    def count_noindex
      page.all("meta[name='robots'][content='noindex']", :visible => false).count
    end
    scenario 'Result page : Display meta noindex when there is a user' do    
      asker = create(:asker, :full_user_input)
      visit aides_path + '?for_id=' + TranslateB64AskerService.new.into_b64(asker)
      expect(count_noindex).to eq(1)
    end
    scenario 'Result page : Do not display meta noindex when there is no user' do    
      visit aides_path
      expect(count_noindex).to eq(0)
    end
    scenario 'Any other page : Do not display meta noindex' do    
      visit root_path
      expect(count_noindex).to eq(0)
    end    
  end




end
