class WelcomeController < ApplicationController

  def index
    clean_asker_params
    view_params = Rails.cache.fetch("view_data_for_welcome_page") {
      {
        nb_of_active_aids:  Aid.activated.count,
        type_aides:         ContractType.aides.map{|e| e.attributes},
        type_dispositifs:   ContractType.dispositifs.map{|e| e.attributes},
        slug_of_creation:   ContractType.find_by(slug: "aide-a-la-creation-ou-reprise-d-entreprise"),
        slug_of_amob:       ContractType.find_by(slug: "aide-a-la-mobilite"),
        slug_of_alternance: ContractType.find_by(slug: "contrat-en-alternance"),
        slug_of_project:    ContractType.find_by(slug: "aide-a-la-definition-du-projet-professionnel"),        
      }
    }
    hydrate_view(view_params)
  end

  def start_wizard
    clean_asker_params
    my_redirect_to QuestionManager.new.getNextPath
  end

  def accept_all_cookies
    CookiePreference.new(session).accept_all_cookies
  end

  def terms
  end

  def accessibility
  end

  private
  def clean_asker_params
    session.delete :asker
  end



  



end
