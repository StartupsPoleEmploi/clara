class WelcomeController < ApplicationController

  caches_page :index unless Rails.env.development?
  skip_before_action :verify_authenticity_token, :only => [:index, :start_wizard]

  def index
    pp '------------session[:cookie]-----------'
    pp session[:cookie]
    pp ''
    service = ContractTypeService.new
    clean_asker_params
    hydrate_view({
      nb_of_active_aids:  Aid.activated.count,
      type_aides:         service.hashify_category_aides,
      type_dispositifs:   service.hashify_category_dispositifs,
      slug_of_creation:   service.slug_of_creation_reprise_entreprise,
      slug_of_amob:       service.slug_of_amob,
      slug_of_alternance: service.slug_of_alternance,
      slug_of_project:    service.slug_of_projet_pro,
    })
  end

  def start_wizard
    clean_asker_params
    my_redirect_to QuestionManager.new.getNextPath
  end

  def terms
  end

  def accept_all_cookies
    session[:cookie] = {"disable_statistic"=>"0", "disable_navigation"=>"0"}
    p '- - - - - - - - - - - - - - session[:cookie]- - - - - - - - - - - - - - - -' 
    pp session[:cookie]
    p ''

  end

  private
  def clean_asker_params
    session.delete :asker
  end

end
