class WelcomeController < ApplicationController

  def index
    service = ContractTypeService.new
    clean_asker_params
    view_params = Rails.cache.fetch("view_data_for_welcome_page") {
      {
        nb_of_active_aids:  Aid.activated.count,
        type_aides:         service.hashify_category_aides,
        type_dispositifs:   service.hashify_category_dispositifs,
        slug_of_creation:   service.slug_of_creation_reprise_entreprise,
        slug_of_amob:       service.slug_of_amob,
        slug_of_alternance: service.slug_of_alternance,
        slug_of_project:    service.slug_of_projet_pro,        
      }
    }
    hydrate_view(view_params)
  end

  def start_wizard
    clean_asker_params
    my_redirect_to QuestionManager.new.getNextPath
  end

  
  def accept_all_cookies
    session[:cookie] = {
      "analytics" => "authorize_statistic",
      "hotjar" => "authorize_navigation",
    }
  end


  def terms
  end

  private
  def clean_asker_params
    session.delete :asker
  end

end
